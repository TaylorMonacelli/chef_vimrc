name 'chef_vimrc'
maintainer 'Taylor Monacelli'
maintainer_email 'taylormonacelli@gmail.com'
license 'All Rights Reserved'
description 'Installs/Configures chef_vimrc'
long_description 'Installs/Configures chef_vimrc'
version '0.1.0'
chef_version '>= 12.1' if respond_to?(:chef_version)
supports 'ubuntu'
supports 'windows'
issues_url 'https://github.com/taylormonacelli/chef_vimrc/issues'
source_url 'https://github.com/taylormonacelli/chef_vimrc'
license 'Apache-2.0'

depends 'chocolatey'
depends 'windows'
depends 'vim'
