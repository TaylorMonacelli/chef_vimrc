include_recipe 'chef_vimrc::default'

%w(nvim vim).each do |whichvim|
  %w(plugindir).each do |mydir|
    directory node['chef_vimrc'][whichvim][mydir] do
      recursive true
    end
  end

  template "#{node['chef_vimrc'][whichvim]['basedir']}/#{node['chef_vimrc'][whichvim]['initfile']}" do
    source 'vimrc.erb'
    variables 'whichvim' => whichvim
  end

  if node['platform_family'] == 'windows'
    powershell_script 'Install and Update plugins' do
      code <<-'EOH'
      if(test-path('C:\\Program Files\\vim\\vim80\\vim.exe')){
        & 'C:\\Program Files\\vim\\vim80\\vim.exe' silent! +VimEnter +PlugInstall +qall
        & 'C:\\Program Files\\vim\\vim80\\vim.exe' silent! +VimEnter +PlugUpdate +qall
      }
      if(test-path('C:\\Program Files (x86)\\vim\\vim80\\vim.exe')){
        & 'C:\\Program Files (x86)\\vim\\vim80\\vim.exe' silent! +VimEnter +PlugInstall +qall
        & 'C:\\Program Files (x86)\\vim\\vim80\\vim.exe' silent! +VimEnter +PlugUpdate +qall
      }
      if(test-path('C:\\tools\\neovim\\Neovim\\bin\\nvim.exe')){
        & 'C:\\tools\\neovim\\Neovim\\bin\\nvim.exe' silent! +VimEnter +PlugInstall +qall
        & 'C:\\tools\\neovim\\Neovim\\bin\\nvim.exe' silent! +VimEnter +PlugUpdate +qall
      }
      EOH
      returns [0, 1]
    end
  else
    package 'at'
    bash "PlugInstall for #{whichvim}" do
      code <<-EOH
        echo "#{whichvim} +silent! +VimEnter +PlugInstall +qall" |at -M now + 1 minute
        EOH
    end
  end
end
