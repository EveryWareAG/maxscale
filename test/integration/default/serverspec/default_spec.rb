require 'spec_helper'

describe service('maxscale') do
  it { should be_enabled }
  it { should be_running }
end

describe port(6603) do
  it { should be_listening.on('127.0.0.1').with('tcp') }
end

describe command('sudo -i maxadmin show services'), sudo: false do
  its(:stdout) { should match 'galera_rw_service' }
end
