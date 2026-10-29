-- Started by init.lua with `rex do --all`, because the config file never gets events.
-- Add each new handler in its own do...end block.

-- Tab history for tab_last: most-recently activated open tabs per session.
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

  local function record(sid, cur, old)
    local view = rex.session.view { session_id = sid }
    local open = {}
    for _, window in ipairs(view.windows) do
      open[window.window_id] = true
    end

    local history = {}
    local seen = { [cur] = true }
    local function add(id)
      if open[id] and not seen[id] then
        history[#history + 1] = id
        seen[id] = true
      end
    end
    if type(old) == "table" and type(old.history) == "table" then
      for _, id in ipairs(old.history) do add(id) end
    end
    for _, window in ipairs(view.windows) do add(window.window_id) end
    history[#history + 1] = cur
    return { history = history }
  end

  for _, session in ipairs(rex.call("session.list").sessions) do
    local sid = session.session_id
    rex.session.attach { session_id = sid }
    local view = rex.session.view { session_id = sid }
    hist[sid] = record(sid, view.active_window_id, loaded[sid])
  end

  rex.on("active_window_changed", function(_, ev)
    local old = (hist[ev.session_id] or {}).history
    if not old or old[#old] ~= ev.window_id then
      hist[ev.session_id] = record(ev.session_id, ev.window_id, hist[ev.session_id])
      save()
    end
  end)

  save()
end
