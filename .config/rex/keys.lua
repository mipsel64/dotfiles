return function(leader)
  local function leader_bind(key, action, args)
    rex.bind(leader .. ">" .. key, action, args)
  end

  rex.bind("shift+cmd+,", "client.config.reload")

  leader_bind("ctrl+v", "pane.split", { direction = "right" })
  leader_bind("ctrl+s", "pane.split", { direction = "down" })
  leader_bind("shift+1", "pane.move_to_new_tab")
  leader_bind("shift+'", "pane.split", { direction = "down" })
  leader_bind("shift+5", "pane.split", { direction = "right" })
  leader_bind("shift+8", "pane.split.auto")
  leader_bind("shift+2", "pane.float")
  leader_bind("shift+e", "pane.balance")
  leader_bind("o", "pane.focus_next")

  leader_bind("ctrl+h", "pane.focus.left")
  leader_bind("ctrl+j", "pane.focus.down")
  leader_bind("ctrl+k", "pane.focus.up")
  leader_bind("ctrl+l", "pane.focus.right")

  for _, dir in ipairs({ "up", "down", "left", "right" }) do
    leader_bind(dir, "pane.focus." .. dir)
    leader_bind("alt+" .. dir, "pane.resize", { direction = dir })
    leader_bind("ctrl+" .. dir, "pane.resize", { direction = dir, amount = 1 })
  end

  leader_bind("c", "client.tab.new")
  leader_bind("n", "client.tab.next")
  leader_bind("p", "client.tab.previous")
  leader_bind("shift+4", "session.rename")
  leader_bind("shift+7", "client.tab.close")
  leader_bind("shift+9", "session.previous")
  leader_bind("shift+0", "session.next")
  leader_bind(",", "client.tab.rename")
  leader_bind("shift+;", "client.palette.toggle")
  leader_bind("shift+/", "client.palette.toggle")
  leader_bind("shift+c", "client.settings")
  leader_bind("f", "client.find.open")
  leader_bind("s", "session.switch")
  leader_bind("w", "session.switch")

  leader_bind("l", "tab_last")
  leader_bind("shift+[", "pane_swap", { delta = -1 })
  leader_bind("shift+]", "pane_swap", { delta = 1 })
  leader_bind(leader, "tab_last")
  for i = 1, 9 do
    leader_bind(i, "client.tab.goto", { index = i })
  end

  leader_bind("z", "pane.zoom")
  leader_bind("x", "pane.close")
  leader_bind("r", "client.config.reload")
end
