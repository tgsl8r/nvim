-- Require plugin categories here
-- Select individual plugins in category dirs init.lua

require('lazy').setup({
    require 'usr.plugins.colour',
    require 'usr.plugins.utils',
    require 'usr.plugins.ui'
})
