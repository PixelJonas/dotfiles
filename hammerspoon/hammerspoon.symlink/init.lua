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

local function log(fmt, ...)
  print(string.format("[camera-light] " .. fmt, ...))
end

local function maskUrl(url)
  if not url or url == "" then return "<empty>" end
  return url:sub(1, 30) .. "…(" .. tostring(#url) .. " chars)"
end

local localrc = readLocalrc()
local ON_URL  = localrc.CAMERA_ON_WEBHOOK
local OFF_URL = localrc.CAMERA_OFF_WEBHOOK

log("ON_URL=%s  OFF_URL=%s", maskUrl(ON_URL), maskUrl(OFF_URL))

if not ON_URL or ON_URL == "" or not OFF_URL or OFF_URL == "" then
  hs.alert.show("Camera-light: webhook URLs missing in ~/.localrc")
end

local function post(url, label)
  if not url or url == "" then
    log("post(%s) skipped: url empty", label)
    return
  end
  log("post(%s) → %s", label, maskUrl(url))
  hs.http.asyncPost(url, "{}", { ["Content-Type"] = "application/json" },
    function(status, body)
      log("post(%s) result: status=%s body=%s",
        label, tostring(status), tostring(body or ""):sub(1, 200))
    end)
end

local cameraInUseCount = 0

local function onPropertyChange(camera, prop)
  local name = (camera and camera.name and camera:name()) or "?"
  log("propertyChange camera=%q prop=%q", name, tostring(prop))

  if prop ~= "isInUse" and prop ~= "gone" and prop ~= "used" then return end

  local total = 0
  for _, cam in ipairs(hs.camera.allCameras()) do
    if cam:isInUse() then total = total + 1 end
  end
  log("inUse total=%d (was %d)", total, cameraInUseCount)

  if total > 0 and cameraInUseCount == 0 then
    post(ON_URL, "on")
  elseif total == 0 and cameraInUseCount > 0 then
    post(OFF_URL, "off")
  end
  cameraInUseCount = total
end

local function attachWatcher(camera)
  log("attachWatcher camera=%q inUse=%s",
    camera:name(), tostring(camera:isInUse()))
  camera:setPropertyWatcherCallback(onPropertyChange)
  camera:startPropertyWatcher()
end

local cams = hs.camera.allCameras()
log("found %d camera(s) at startup", #cams)
for _, camera in ipairs(cams) do
  attachWatcher(camera)
end

hs.camera.setWatcherCallback(function(camera, event)
  log("deviceWatcher event=%q camera=%q",
    tostring(event), (camera and camera:name()) or "?")
  if event == "Added" then attachWatcher(camera) end
end)
hs.camera.startWatcher()

log("watcher started")
