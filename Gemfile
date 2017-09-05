# This gemfile provides additional gems for testing and releasing this cookbook
# It is meant to be installed on top of ChefDK which provides the majority
# of the necessary gems for testing this cookbook
#
# Run 'chef exec bundle install' to install these dependencies

source 'https://rubygems.org'

gem 'community_cookbook_releaser'
gem 'stove'
gem 'tomlrb'
gem 'berkshelf'
gem 'chef', '~> 12.0'
gem 'chefspec'
gem 'cookstyle'
gem 'foodcritic'

group :integration do
  gem 'kitchen-dokken'
  gem 'kitchen-localhost'
  gem 'kitchen-vagrant'
  gem 'test-kitchen'
  gem 'winrm-fs'
end
