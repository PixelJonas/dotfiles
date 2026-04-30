# Hammerspoon — Camera → Home Assistant bridge

[Hammerspoon](https://www.hammerspoon.org/) config that watches the Mac's
cameras and POSTs to a Home Assistant webhook whenever any camera transitions
in or out of use. I use it to turn an Elgato key light on/off automatically
when a Zoom/Meet/FaceTime call starts.

## Layout

| Path | What it is |
| --- | --- |
| [hammerspoon.symlink/init.lua](hammerspoon.symlink/init.lua) | The actual config. The dotfiles bootstrap symlinks `hammerspoon.symlink/` → `~/.hammerspoon/`. |
| [hammerspoon.symlink/Spoons/](hammerspoon.symlink/Spoons/) | Reserved for any Spoons (currently empty). |
| [homeassistant-automations.yaml](homeassistant-automations.yaml) | Companion HA automations that listen on the two webhooks. |

## How it works

1. On launch, [init.lua](hammerspoon.symlink/init.lua) reads two webhook URLs
   from `~/.localrc` (kept out of the repo):
   - `CAMERA_ON_WEBHOOK`  — fired on the first camera coming into use.
   - `CAMERA_OFF_WEBHOOK` — fired when the last camera goes idle.
2. It enumerates every camera via `hs.camera.allCameras()` and attaches a
   per-device property watcher (`isInUse` / `gone` / `used`).
3. It also registers `hs.camera.setWatcherCallback` so that cameras hot-plugged
   after launch (e.g. an external webcam) get a watcher attached too.
4. On any property change it recomputes the total in-use count. The transition
   `0 → ≥1` triggers `CAMERA_ON_WEBHOOK`; `≥1 → 0` triggers `CAMERA_OFF_WEBHOOK`.
   Both posts are async with a JSON `{}` body.
5. Every step prints a `[camera-light] …` line via `print()`, visible in the
   Hammerspoon Console (or `~/.hammerspoon/Hammerspoon.log` if logging to file
   is enabled).

## Prerequisites

### Mac side

- **Hammerspoon** installed: `brew install --cask hammerspoon`, then launch it
  once and grant **Accessibility** permission in System Settings → Privacy.
- This repo's bootstrap (or `script/link-dotfiles`) has run, so
  `~/.hammerspoon` resolves to `hammerspoon.symlink/`.
- A `~/.localrc` file exists and contains:
  ```sh
  export CAMERA_ON_WEBHOOK="https://<your-ha-host>/api/webhook/mac_camera_on"
  export CAMERA_OFF_WEBHOOK="https://<your-ha-host>/api/webhook/mac_camera_off"
  ```
  The parser in `init.lua` only accepts the exact `export NAME="value"` form.

### Home Assistant side

- HA reachable from your Mac at the host you put in the webhook URLs (LAN or
  Nabu Casa / reverse proxy — both work; `local_only: false` is set in the
  sample automations so a public URL is fine).
- The two automations from
  [homeassistant-automations.yaml](homeassistant-automations.yaml) imported
  (paste into `automations.yaml` or recreate them via the UI) and automations
  reloaded. Webhook IDs must match: `mac_camera_on` / `mac_camera_off`.
- Adjust the `entity_id` (`light.elgato_office`) and the `person.jonas`
  presence condition for your setup.

## Reloading & debugging

- Reload the config after editing: `hs -c "hs.reload()"` or the menu-bar
  Hammerspoon icon → *Reload Config*.
- Open the Console (menu icon → *Console*) and toggle a camera — you should
  see `propertyChange …`, `inUse total=… (was …)`, `post(on/off) → …`, and the
  HTTP `result: status=200 …` line.
- If you see `found 0 camera(s) at startup`, the device watcher will still
  pick up cameras as they appear (`deviceWatcher event="Added" …`).
- If `propertyChange` never fires, check that Hammerspoon has the macOS
  privacy permissions it needs (Accessibility is enough; no Camera permission
  is required because the config only reads `isInUse`, it never opens the
  device).
