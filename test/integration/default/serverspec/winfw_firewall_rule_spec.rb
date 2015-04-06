require 'spec_helper'

describe 'Add Firewall Rule' do
  describe command('netsh advfirewall firewall show rule name=\'allow port 80 for inbound http\'' ) do
    its(:stdout) { should match /Ok\./mi }
  end
  describe command('netsh advfirewall firewall show rule name=\'allow port 443 for inbound https\'' ) do
    its(:stdout) { should match /Ok\./mi }
  end
  describe command('netsh advfirewall firewall show rule name=\'allow outbound ssh\'' ) do
    its(:stdout) { should match /Ok\./mi }
  end
  describe command('netsh advfirewall firewall show rule name=\'Block SQL Browser inbound traffic\'' ) do
    its(:stdout) { should match /Ok\./mi }
  end
end

describe 'delete Firewall Rule' do
  describe command('netsh advfirewall firewall show rule name=\'allow port 11180 for inbound http\'' ) do
    its(:stdout) { should match /No rules match/mi }
  end
  describe command('netsh advfirewall firewall show rule name=\'allow port 11443 for inbound https\'' ) do
    its(:stdout) { should match /No rules match/mi }
  end
end
