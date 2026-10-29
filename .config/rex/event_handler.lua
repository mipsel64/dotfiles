-- Started by init.lua with `rex do --all`, because the config file never gets events.
-- Add each new handler in its own do...end block.

-- Tab history for tab_last: the previous and current tab of each session.
do
  local path = rex.args.tab_history
  local loaded = {}
  local file = io.open(path, "r")
  if file then
    local ok, data = pcall(rex.json.decode, file:read("*a"))
    file:close()
    loaded = ok and type(data) == "table" and data or {}
  end
  local hist = {}

  local function save()
    local out = assert(io.open(path .. ".tmp", "w"))
    assert(out:write(assert(rex.json.encode(hist))))
    assert(out:close())
    assert(os.rename(path .. ".tmp", path))
  end

  for _, session in ipairs(rex.call("session.list").sessions) do
    local sid = session.session_id
    rex.session.attach { session_id = sid }
    local view = rex.session.view { session_id = sid }
    local cur = view.active_window_id
    local old = loaded[sid]
    if type(old) ~= "table" then old = {} end
    local prev = (old.cur ~= cur) and old.cur or old.prev
    local windows = {}
    for _, window in ipairs(view.windows) do
      windows[window.window_id] = true
    end
    if not windows[prev] then prev = nil end
    hist[sid] = { prev = prev, cur = cur }
  end

  rex.on("active_window_changed", function(_, ev)
    local old = (hist[ev.session_id] or {}).cur
    if old ~= ev.window_id then
      hist[ev.session_id] = { prev = old, cur = ev.window_id }
      save()
    end
  end)

  save()
end
