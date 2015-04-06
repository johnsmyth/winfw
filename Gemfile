source 'https://rubygems.org'

group :lint do
    gem 'foodcritic'
    gem 'rubocop'
end

group :development do
  gem "test-kitchen", :git => 'https://github.com/test-kitchen/test-kitchen.git', :branch => 'v1.4.0.rc.1' #
  gem 'kitchen-vagrant', git: 'https://github.com/test-kitchen/kitchen-vagrant.git'  #, :branch => 'windows-guest-support'
  gem "berkshelf"
  #gem "vagrant-wrapper", ">= 2.0"
  gem 'winrm-transport', '~> 1.0'
end
