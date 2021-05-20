local galaxyline = require'galaxyline'
local colors = require'galaxyline.theme'.default
local condition = require'galaxyline.condition'

local section = galaxyline.section

galaxyline.short_line_list = {'NvimTree'}

local buffer_not_empty = function()
  if vim.fn.empty(vim.fn.expand('%:t')) ~= 1 then
    return true
  end
  return false
end

local colors = {
  b00 = '#181818', -- " black
  b01 = '#282828', --
  b02 = '#383838', --
  b03 = '#585858', --
  b04 = '#b8b8b8', --
  b05 = '#d8d8d8', --
  b06 = '#e8e8e8', --
  b07 = '#f8f8f8', -- " white

  b08 = '#ab4642', -- " red
  b09 = '#dc9656', -- " orange
  b0A = '#f7ca88', -- " yellow
  b0B = '#a1b56c', -- " green
  b0C = '#86c1b9', -- " teal
  b0D = '#7cafc2', -- " blue
  b0E = '#ba8baf', -- " pink
  b0F = '#a16946', -- " brown
}

local hi = function(name, fg, bg, style)
  style = style or 'NONE'
  vim.api.nvim_command('hi ' .. name .. ' guifg=' .. fg .. ' guibg=' .. bg .. ' gui=' .. style)
end

hi('ModeNormal',  colors.b00, colors.b0D, 'bold')
hi('ModeInsert',  colors.b01, colors.b0B, 'bold')
hi('ModeVisual',  colors.b00, colors.b09, 'bold')
hi('ModeReplace', colors.b00, colors.b08, 'bold')
hi('ModeSelect',  colors.b00, colors.b0F, 'bold')
hi('ModeMisc',    colors.b00, colors.b05, 'bold')

section.left[1] = {
  ViMode = {
    provider = function()
      local modes = {
        n      = {'NORMAL', 'ModeNormal'},
        i      = {'INSERT', 'ModeInsert'},
        v      = {'VISUAL', 'ModeVisual'},
        V      = {'V-LINE', 'ModeVisual'},
        [''] = {'VBLOCK', 'ModeVisual'},
        s      = {'SELECT', 'ModeSelect'},
        S      = {'S-LINE', 'ModeSelect'},
        [''] = {'SBLOCK', 'ModeSelect'},
        R      = {'REPLCE', 'ModeReplace'},
        c      = {'CMDLIN', 'ModeMisc'},
        r      = {'PROMPT', 'ModeMisc'},
        ['!']  = {'EXECUT', 'ModeMisc'},
        t      = {'TERMNL', 'ModeMisc'},
      }
      local mode = modes[string.sub(vim.fn.mode(), 1, 1)]
      vim.api.nvim_command('hi! link GalaxyViMode ' .. mode[2])
      return ' ' .. mode[1] .. ' ' -- TODO: spaces?
    end,
    separator = ' ',
  },
}

-- section.left[2] = {
--   FileSize = {
--     provider = 'FileSize',
--     condition = condition.buffer_not_empty,
--     highlight = {colors.fg,colors.bg}
--   }
-- }
section.left[2] ={
  FileIcon = {
    provider = 'FileIcon',
    condition = condition.buffer_not_empty,
    highlight = {require('galaxyline.provider_fileinfo').get_file_icon_color,colors.bg},
  },
}

section.left[3] = {
  FileName = {
    provider = 'FileName',
    condition = condition.buffer_not_empty,
    highlight = {colors.fg,colors.bg,'bold'}
  }
}

section.left[4] = {
  LineInfo = {
    provider = 'LineColumn',
    separator = ' ',
    separator_highlight = {'NONE',colors.bg},
    highlight = {colors.fg,colors.bg},
  },
}

section.left[5] = {
  PerCent = {
    provider = 'LinePercent',
    separator = ' ',
    separator_highlight = {'NONE',colors.bg},
    highlight = {colors.fg,colors.bg,'bold'},
  }
}

section.left[6] = {
  DiagnosticError = {
    provider = 'DiagnosticError',
    icon = '  ',
    highlight = {colors.red,colors.bg}
  }
}
section.left[7] = {
  DiagnosticWarn = {
    provider = 'DiagnosticWarn',
    icon = '  ',
    highlight = {colors.yellow,colors.bg},
  }
}

section.left[8] = {
  DiagnosticHint = {
    provider = 'DiagnosticHint',
    icon = '  ',
    highlight = {colors.cyan,colors.bg},
  }
}

section.left[9] = {
  DiagnosticInfo = {
    provider = 'DiagnosticInfo',
    icon = '  ',
    highlight = {colors.blue,colors.bg},
  }
}

section.short_line_left[1] = {
  Whitespace = { provider = 'WhiteSpace' },
}
section.short_line_left[2] = {
  BufferType = {
    provider = 'FileTypeName',
  }
}

section.short_line_right[1] = {
  BufferIcon = {
    provider= 'BufferIcon',
  }
}
section.short_line_right[2] = {
  Whitespace = { provider = 'WhiteSpace' },
}

galaxyline.load_galaxyline()
