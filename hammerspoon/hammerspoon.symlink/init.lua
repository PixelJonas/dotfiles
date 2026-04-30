-- Camera → Home Assistant webhook bridge.
-- Posts to CAMERA_ON_WEBHOOK / CAMERA_OFF_WEBHOOK whenever any camera
-- transitions in/out of use. URLs live in ~/.localrc (not the repo).

local function readLocalrc()
  local env = {}
  local path = os.getenv("HOME") .. "/.localrc"
  local f = io.open(path, "r")
  if not f then return env end
  for line in f:lines() do
    local k, v = line:match('^%s*export%s+([%w_]+)="(.-)"%s*$')
    if k then env[k] = v end
  end
  f:close()
  return env
end

local localrc = readLocalrc()
local ON_URL  = localrc.CAMERA_ON_WEBHOOK
local OFF_URL = localrc.CAMERA_OFF_WEBHOOK

if not ON_URL or ON_URL == "" or not OFF_URL or OFF_URL == "" then
  hs.alert.show("Camera-light: webhook URLs missing in ~/.localrc")
end

local function post(url, label)
  if not url or url == "" then return end
  hs.http.asyncPost(url, "{}", { ["Content-Type"] = "application/json" },
    function(status, body)
      if status < 200 or status >= 300 then
        print(string.format("[camera-light] %s webhook failed: %s %s",
          label, tostring(status), body or ""))
      end
    end)
end

local cameraInUseCount = 0

local function onPropertyChange(camera, prop)
  if prop ~= "isInUse" and prop ~= "gone" and prop ~= "used" then return end

  local total = 0
  for _, cam in ipairs(hs.camera.allCameras()) do
    if cam:isInUse() then total = total + 1 end
  end

  if total > 0 and cameraInUseCount == 0 then
    post(ON_URL, "on")
  elseif total == 0 and cameraInUseCount > 0 then
    post(OFF_URL, "off")
  end
  cameraInUseCount = total
end

local function attachWatcher(camera)
  camera:setPropertyWatcherCallback(onPropertyChange)
  camera:startPropertyWatcher()
end

for _, camera in ipairs(hs.camera.allCameras()) do
  attachWatcher(camera)
end

hs.camera.watcher.new(function(camera, event)
  if event == "Added" then attachWatcher(camera) end
end):start()

print("[camera-light] watcher started")
