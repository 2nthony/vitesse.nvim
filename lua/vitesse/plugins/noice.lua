return function(opts)
  local colors = require("colorbuddy.init").colors
  local Group = require("colorbuddy.init").Group
  local groups = require("colorbuddy.init").groups

  Group.new("NoiceCmdlineIcon", colors.yellow)
  Group.new("NoiceCmdlinePopup", colors.yellow)
  Group.new("NoiceCmdlinePopupBorder", colors.yellow)
  Group.new("NoiceLspProgressTitle", colors.activeForeground)
  Group.new("NoiceLspProgressSpinner", colors.primary)
  Group.new("NoiceLspProgressClient", colors.primary)
  Group.new("NoiceFormatProgressTodo", colors.activeForeground)
  Group.new("NoiceMini", colors.baseForeground, opts.transparent_background and colors.none or colors.lowBackground)
  Group.new("NoiceVirtualText", groups.Search)
end
