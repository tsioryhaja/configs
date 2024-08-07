local cmp = require'cmp'
local lspkind = require'lspkind'

if not cmp then
  return
end

local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

cmp.setup(
{
	snippet = {
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body)
		end,
	},
	mapping = {
		['<C-Space>'] = cmp.mapping.complete(),
		['<CR>'] = cmp.mapping.confirm({ select = true }),
		['<Tab>'] = function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			else
				fallback()
			end
		end,
		['<S-Tab>'] = function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			else
				fallback()
			end
		end,
    ['<C-z>'] = function()
      print('here')
      if vim.fn['vsnip#available'](1) == 1 then
        print('starting feeding key')
        feedkey("<Plug>(vsnip-expand-or-jump)", "")
      end
    end
	},
	sources = {
		{ name = 'nvim_lsp' },
		{ name = 'vsnip' },
		{ name = 'buffer' },
    { name = 'nvim_lsp_signature_help' },
	},
	formatting = {
		format = lspkind.cmp_format({with_text = false, maxwidth = 50})
	},
})

vim.diagnostic.config({
  virtual_text = {
    prefix = ""
  }
})


local lsp_lines = require('lsp_lines')

if not lsp_lines then
  return
end
lsp_lines.setup()

-- vim.diagnostic.config({virtual_text = false})

local function toggleLspLines()
  if vim.diagnostic.config().virtual_text then
    vim.diagnostic.config({virtual_text = false})
  else
    vim.diagnostic.config({
      virtual_text = {
        prefix = ""
      }
    })
  end
  lsp_lines.toggle()
end

lsp_lines.toggle()

vim.keymap.set('n', '<A-b>', toggleLspLines, { desc = "Toggle lsp_lines" })

vim.cmd('smap <expr> <Tab> vsnip#jumpable(1) ? "<Plug>(vsnip-jump-next)" : "<Tab>"')
vim.cmd('smap <expr> <S-Tab> vsnip#jumpable(-1) ? "<Plug>(vsnip-jump-next)" : "<S-Tab>"')

