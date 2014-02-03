dir = File.expand_path(File.dirname(__FILE__))
$LOAD_PATH.unshift File.join(dir, "lib")

# Don"t want puppet getting the command line arguments for rake or autotest
ARGV.clear

require "bundler/setup"
require "puppet"
require "facter"
require "mocha"
require "rspec"
require "rspec/expectations"

require "puppetlabs_spec_helper/module_spec_helper"

RSpec.configure do |config|
  config.before :each do
    Facter::Util::Loader.any_instance.stubs(:load_all)
    Facter.clear
    Facter.clear_messages
  end
end
