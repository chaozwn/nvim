-- 自动安装 Packer.nvim
-- 插件安装目录
-- ~/.local/share/nvim/site/pack/packer/
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local paccker_bootstrap
if fn.empty(fn.glob(install_path)) > 0 then
  vim.notify("正在安装Pakcer.nvim，请稍后...")
  paccker_bootstrap = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    -- "https://gitcode.net/mirrors/wbthomason/packer.nvim",
    install_path,
  })

  -- https://github.com/wbthomason/packer.nvim/issues/750
  local rtp_addition = vim.fn.stdpath("data") .. "/site/pack/*/start/*"
  if not string.find(vim.o.runtimepath, rtp_addition) then
    vim.o.runtimepath = rtp_addition .. "," .. vim.o.runtimepath
  end
  vim.notify("Pakcer.nvim 安装完毕")
end

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  vim.notify("没有安装 packer.nvim")
  return
end

packer.startup({
  function(use)
    -- Packer 可以升级自己
    use("wbthomason/packer.nvim")

    --------------------- 中文help doc ----------------
    -- 中文help doc
    use { 'yianwillis/vimcdoc', event = "CmdLineEnter" }

    --------------------- 颜色主题 --------------------
    -- tokyonight
    use("folke/tokyonight.nvim")
    -- OceanicNext
    use("mhartington/oceanic-next")
    -- gruvbox
    use({
      "ellisonleao/gruvbox.nvim",
      requires = { "rktjmp/lush.nvim" },
    })
    -- zephyr
    -- use("glepnir/zephyr-nvim")
    -- nord
    use("shaunsingh/nord.nvim")
    -- onedark
    use("ful1e5/onedark.nvim")
    -- nightfox
    use("EdenEast/nightfox.nvim")


    -------------------------- 插件集合 -------------------------------------------

    -- nvim-tree, 提供左边的文件树
    use({
      "kyazdani42/nvim-tree.lua",
      requires = "kyazdani42/nvim-web-devicons",
    })
    -- bufferline
    --  vim-bbye 依赖，因为这个插件安装后会增加一个 :Bdelete 命令，相比内置的 :bdelete, 它删除 buffer 的同时，并不会搞乱布局 。 待会儿我们会配置 Bdelete 为关闭 Tab 的命令。
    use({
      "akinsho/bufferline.nvim",
      requires = { "kyazdani42/nvim-web-devicons", "moll/vim-bbye" },
    })
    -- lualine
    use({
      "nvim-lualine/lualine.nvim",
      requires = { "kyazdani42/nvim-web-devicons" },
    })
    use("arkav/lualine-lsp-progress")


    ------------------------- 快速搜索文件 --------------------------------------
    -- telescope
    use({
      "nvim-telescope/telescope.nvim",
      requires = {
        { "nvim-lua/plenary.nvim" },
        { "nvim-telescope/telescope-ui-select.nvim" },
        { "ahmedkhalf/project.nvim" },
        {
          'nvim-telescope/telescope-fzf-native.nvim',
          run =
          'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
        },
        { "nvim-telescope/telescope-symbols.nvim" },
        { 'GustavoKatel/telescope-asynctasks.nvim' },
        { "LinArcX/telescope-env.nvim" }
      },
    })

    ------------------------ 启动界面 -------------------------------------------
    -- dashboard-nvim,功能实现关联ahmedkhalf/project.nvim
    use({
      "glepnir/dashboard-nvim",
      requires = { 'nvim-tree/nvim-web-devicons' },
    })


    ----------------------- 代码高亮 --------------------------------------------
    -- treesitter
    use({
      "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate",
      requires = {
        "p00f/nvim-ts-rainbow",
        "windwp/nvim-ts-autotag",
        "yioneko/nvim-yati",
        'nvim-treesitter/nvim-treesitter-context'
      },
    })


    ----------------------- 代码注释插件 --------------------------------------------
    -- Comment
    use("numToStr/Comment.nvim")

    ----------------------- 缩进之间插入空白线 --------------------------------------------
    -- indent-blankline
    use("lukas-reineke/indent-blankline.nvim")

    ----------------------- 快速修改包含或者删除一个字符 --------------------------------------------
    -- surround
    use({ "kylechui/nvim-surround", tag = "*" })

    ----------------------- 终端插件 --------------------------------------------
    use({ "akinsho/toggleterm.nvim" })

    ----------------------- 多光标插件 --------------------------------------------
    use({ "mg979/vim-visual-multi", branch = 'master' })

    ----------------------- 自动保存 --------------------------------------
    -- use("Pocco81/auto-save.nvim")

    ----------------------- 替换和交换插件 --------------------------------
    use("gbprod/substitute.nvim")

    ----------------------- 移动插件 --------------------------------------
    use("ggandor/leap.nvim")
    use("ggandor/flit.nvim")

    ----------------------- 安装coc ---------------------------------------
    use({ "neoclide/coc.nvim", branch = 'release' })

    ----------------------- Todo Comment ----------------------------------
    use({ "folke/todo-comments.nvim", requires = "nvim-lua/plenary.nvim" })

    if paccker_bootstrap then
      packer.sync()
    end
  end,
  config = {
    -- 锁定插件版本在snapshots目录
    -- snapshot_path = require("packer.util").join_paths(vim.fn.stdpath("config"), "snapshots"),
    -- 这里锁定插件版本在v1，不会继续更新插件
    -- snapshot = "v1",

    -- 最大并发数
    max_jobs = 16,
    -- 自定义源
    git = {
      -- default_url_format = "https://hub.fastgit.xyz/%s",
      -- default_url_format = "https://mirror.ghproxy.com/https://github.com/%s",
      -- default_url_format = "https://gitcode.net/mirrors/%s",
      -- default_url_format = "https://gitclone.com/github.com/%s",
    },
    display = {
      -- 使用浮动窗口显示
      open_fn = function()
        return require("packer.util").float({ border = "single" })
      end,
    },
  },
})
