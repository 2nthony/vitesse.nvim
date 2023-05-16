return function(opts, value)
  local colors = require("colorbuddy.init").colors
  local Group = require("colorbuddy.init").Group
  local groups = require("colorbuddy.init").groups
  local link = require("vitesse.utils").highlight_link
  local normal = value.normal

  Group.new("TelescopeMatching", colors.orange, groups.Special, groups.Special, groups.Special)
  Group.new("TelescopeBorder", groups.FloatBorder) -- float border not quite dark enough, maybe that needs to change?
  Group.link("TelescopePromptBorder", groups.TelescopeBorder) -- active border lighter for clarity
  Group.new("TelescopeTitle", groups.Normal) -- separate them from the border a little, but not make them pop
  Group.new("TelescopePromptPrefix", groups.Normal) -- default is groups.Identifier
  Group.link("TelescopeSelection", groups.CursorLine)
  Group.new("TelescopeSelectionCaret", colors.cyan)

  if not opts.transparent_float_background then
    link("TelescopeNormal", "NormalFloat")
    Group.new("TelescopeBorder", colors.none, colors.none)
    Group.new("TelescopeSelection", colors.none, normal.float_bg:dark())
    if opts.telescope_border_follow_float_background then
      Group.new("TelescopeBorder", normal.float_bg, normal.float_bg)
    end
  end
end
