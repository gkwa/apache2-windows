name             'apache2-windows'
maintainer       'Chef Software, Inc.'
maintainer_email 'cookbooks@chef.io'
license          'Apache-2.0'
description      'Installs and configures Apache on Microsoft Windows platforms.'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.0.0'

supports         'windows'

source_url       'https://github.com/chef-cookbooks/apache2-windows'
issues_url       'https://github.com/chef-cookbooks/apache2-windows/issues'
chef_version     '>= 12.6' if respond_to?(:chef_version)

depends 'vcruntime'
