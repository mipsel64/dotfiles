return function(tab_history)
  rex.action {
    name = "tab_last",
    title = "Go to Last Tab",
    run = function(ctx)
      local file = io.open(tab_history, "r")
      if not file then
        return
      end
      local ok, data = pcall(rex.json.decode, file:read("*a"))
      file:close()
      if not ok or type(data) ~= "table" then
        return
      end
      local h = data[ctx.session_id]
      if type(h) ~= "table" or type(h.history) ~= "table" then
        return
      end
      local view, err = rex.session.view {}
      if not view then error(err, 0) end
      local open = {}
      for i, window in ipairs(view.windows) do
        open[window.window_id] = i
      end
      for i = #h.history, 1, -1 do
        local id = h.history[i]
        if id ~= view.active_window_id and open[id] then
          rex.client.queue("client.tab.goto", { index = open[id] })
          return
        end
      end
    end,
  }

  local function block_order(node, out)
    if node.block_id then
      out[#out + 1] = node.block_id
    elseif node.split then
      block_order(node.split.before, out)
      block_order(node.split.after, out)
    end
    return out
  end

  rex.action {
    name = "pane_swap",
    title = "Swap Pane",
    args = { delta = "integer" },
    run = function(ctx, args)
      local view, err = rex.session.view {}
      if not view then error(err, 0) end
      for _, window in ipairs(view.windows) do
        for _, layer in ipairs(window.layers) do
          local order = block_order(layer.layout or {}, {})
          for i, id in ipairs(order) do
            if id == ctx.block_id then
              if #order < 2 then return end
              local _, err = rex.session.swap_blocks {
                block_id = id,
                other_block_id = order[(i - 1 + args.delta) % #order + 1],
              }
              if err then error(err, 0) end
              return
            end
          end
        end
      end
    end,
  }
end
