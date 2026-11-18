-- Rex configuration, migrated from tmux, Ghostty and zellij.

-- Runs an action, then leaves every mode. Used for the zellij bindings that
-- run an action and then switch back to the resting (locked) mode.
rex.action{
  name  = "then_normal",
  title = "Run an action and return to normal mode",
  args  = { action = "string", args = "object?" },
  run   = function(ctx, args)
    rex.client.queue(args.action, args.args or {})
    rex.client.queue("client.mode.exit_all")
  end,
}

---------------------------------------------------------------------------
-- tmux and Ghostty: ctrl+a prefix
---------------------------------------------------------------------------

rex.bind("ctrl+a>ctrl+a", "pane.send_key", { key = "ctrl+a" })
rex.bind("ctrl+a>c", "client.tab.new")
rex.bind("ctrl+a>n", "client.tab.next")
rex.bind("ctrl+a>p", "client.tab.previous")
rex.bind("ctrl+a>s", "pane.split", { direction = "right" })
rex.bind("ctrl+a>shift+'", "pane.split", { direction = "down" })
rex.bind("ctrl+a>left", "pane.focus", { direction = "left" })
rex.bind("ctrl+a>right", "pane.focus", { direction = "right" })
rex.bind("ctrl+a>up", "pane.focus", { direction = "up" })
rex.bind("ctrl+a>down", "pane.focus", { direction = "down" })
rex.bind("ctrl+a>z", "pane.zoom")
rex.bind("ctrl+a>space", "pane.balance")

---------------------------------------------------------------------------
-- zellij
--
-- zellij rests in its locked mode (default_mode "locked"), so locked is Rex
-- with no mode active. zellij's normal mode, reached with ctrl+g, is the Rex
-- mode "unlock"; from there p, t, r, m, s and o enter the other modes.
---------------------------------------------------------------------------

local function switch(key, mode)
  rex.bind(key, "client.mode.enter", { name = mode })
end

local function lock(key)
  rex.bind(key, "client.mode.exit_all")
end

local function once(key, action, args)
  rex.bind(key, "then_normal", { action = action, args = args })
end

local directions = {
  left = { "left", "h" },
  down = { "down", "j" },
  up = { "up", "k" },
  right = { "right", "l" },
}

-- locked
switch("ctrl+g", "unlock")

-- shared_among "normal" "locked"
for _, prefix in ipairs({ "", "unlock/" }) do
  for direction, keys in pairs(directions) do
    for _, key in ipairs(keys) do
      rex.bind(prefix .. "alt+" .. key, "pane.focus", { direction = direction })
    end
  end
  rex.bind(prefix .. "alt+i", "client.tab.move", { direction = "backward" })
  rex.bind(prefix .. "alt+o", "client.tab.move", { direction = "forward" })
  rex.bind(prefix .. "alt+n", "pane.split", { direction = "auto" })
end

-- Keys the shared_except and shared_among blocks give each mode: ctrl+g,
-- enter and esc return to locked, and letters switch to another mode.
local mode_switches = {
  unlock  = { m = "move", o = "session", t = "tab", s = "scroll", p = "pane", r = "resize" },
  pane    = { m = "move", o = "session", t = "tab", s = "scroll" },
  tab     = { m = "move", o = "session", p = "pane" },
  resize  = { m = "move", o = "session", t = "tab", s = "scroll", p = "pane" },
  move    = { o = "session", t = "tab", s = "scroll", r = "resize" },
  scroll  = { m = "move", o = "session", t = "tab", p = "pane", r = "resize" },
  session = { m = "move", t = "tab", s = "scroll", r = "resize" },
}

for mode, switches in pairs(mode_switches) do
  lock(mode .. "/ctrl+g")
  lock(mode .. "/enter")
  lock(mode .. "/esc")
  for key, target in pairs(switches) do
    switch(mode .. "/" .. key, target)
  end
end

-- pane
for direction, keys in pairs(directions) do
  for _, key in ipairs(keys) do
    rex.bind("pane/" .. key, "pane.focus", { direction = direction })
  end
end
once("pane/c", "pane.rename")
once("pane/d", "pane.split", { direction = "down" })
once("pane/f", "pane.zoom")
once("pane/n", "pane.split", { direction = "auto" })
switch("pane/p", "unlock")
once("pane/r", "pane.split", { direction = "right" })
once("pane/x", "pane.close")
rex.bind("pane/tab", "pane.focus_next")

-- tab
for _, key in ipairs({ "left", "up", "h", "k" }) do
  rex.bind("tab/" .. key, "client.tab.previous")
end
for _, key in ipairs({ "down", "right", "j", "l" }) do
  rex.bind("tab/" .. key, "client.tab.next")
end
for index = 1, 9 do
  once("tab/" .. index, "client.tab.goto", { index = index })
end
once("tab/b", "pane.move_to_new_tab")
once("tab/n", "client.tab.new")
once("tab/r", "client.tab.rename")
switch("tab/t", "unlock")
once("tab/x", "client.tab.close")

-- resize
for direction, keys in pairs(directions) do
  for _, key in ipairs(keys) do
    rex.bind("resize/" .. key, "pane.resize", { direction = direction })
  end
end
switch("resize/r", "unlock")

-- move
for direction, keys in pairs(directions) do
  for _, key in ipairs(keys) do
    rex.bind("move/" .. key, "pane.move", { direction = direction })
  end
end
switch("move/m", "unlock")

-- scroll
for direction, keys in pairs(directions) do
  for _, key in ipairs(keys) do
    once("scroll/alt+" .. key, "pane.focus", { direction = direction })
  end
end
switch("scroll/s", "unlock")

-- session
switch("session/o", "unlock")

-- zellij ignores unbound keys in these modes.
for mode in pairs(mode_switches) do
  rex.mode(mode, { exclusive = true })
end
