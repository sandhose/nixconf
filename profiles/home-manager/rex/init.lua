-- tmux-style bindings behind a ctrl+a prefix.
--
-- Punctuation and digits are written as physical keys for a French AZERTY
-- layout, where digits are shifted and Rex has no names for ù, " and &.

rex.bind("ctrl+a>ctrl+a", "pane.send_key", { key = "ctrl+a" })

-- Tabs
rex.bind("ctrl+a>c", "client.tab.new")
rex.bind("ctrl+a>n", "client.tab.next")
rex.bind("ctrl+a>p", "client.tab.previous")
rex.bind("ctrl+a>shift+n", "client.tab.move", { direction = "forward" })
rex.bind("ctrl+a>shift+p", "client.tab.move", { direction = "backward" })
rex.bind("ctrl+a>,", "client.tab.rename")
-- &
rex.bind("ctrl+a>[Digit1]", "client.tab.close")
for index = 1, 9 do
  rex.bind("ctrl+a>shift+[Digit" .. index .. "]", "client.tab.goto", { index = index })
end

-- Panes
rex.bind("ctrl+a>s", "pane.split", { direction = "right" })
-- %
rex.bind("ctrl+a>shift+[Quote]", "pane.split", { direction = "right" })
-- "
rex.bind("ctrl+a>[Digit3]", "pane.split", { direction = "down" })
rex.bind("ctrl+a>left", "pane.focus", { direction = "left" })
rex.bind("ctrl+a>right", "pane.focus", { direction = "right" })
rex.bind("ctrl+a>up", "pane.focus", { direction = "up" })
rex.bind("ctrl+a>down", "pane.focus", { direction = "down" })
rex.bind("ctrl+a>o", "pane.focus_next")
rex.bind("ctrl+a>z", "pane.zoom")
rex.bind("ctrl+a>x", "pane.close")
rex.bind("ctrl+a>space", "pane.balance")
