local leader = "ctrl+f"
local tab_history = os.getenv("TMPDIR") .. "rex-tab-history.json"

-- os.execute is disabled in Rex and the server's PATH has no rex, so check the known install places.
local function find_rex()
  for _, dir in ipairs({
    os.getenv("REX_BIN_DIR") or "",
    os.getenv("HOME") .. "/Library/Application Support/com.superlogical.rex/RexServer/Versions/Current/Rex Server.app/Contents/MacOS",
    "/opt/homebrew/bin",
    "/usr/local/bin",
  }) do
    local f = io.open(dir .. "/rex")
    if f then
      f:close()
      return dir .. "/rex"
    end
  end
  return nil
end
local rex_bin = find_rex()

local xdg_config_home = os.getenv("XDG_CONFIG_HOME") or (os.getenv("HOME") .. "/.config")
local rex_config = xdg_config_home .. "/rex"

local event_handler = rex_config .. "/event_handler.lua"

require("actions")(tab_history)
require("keys")(leader)

-- Restart the event handler on every load; the pattern needs --all so an editor with the file open is not killed.
rex.exec({ "/usr/bin/pkill", "-f", "--", "--all .*rex/event_handler.lua" })
if not rex_bin then
  rex.log("warn", "rex binary not found; event handler not started")
else
  local handle, err = rex.exec.start({ rex_bin, "do", "--autostart=false", "--all", event_handler, "tab_history=" .. tab_history },
    { detach = true, stdout = false, stderr = false })
  if not handle then
    rex.log("warn", "event handler not started: " .. tostring(err))
  end
end
