require 'spec_helper'

describe 'maxscale::default' do
  describe 'Ubuntu 14.04' do
    before(:each) do
      stub_command(/maxadmin \-pmariadb add user maxadmin.*/).and_return(false)
      stub_command("grep \"/etc/default/maxscale\" /etc/init.d/maxscale").and_return(false)
    end
    let(:chef_run) do
      env_options = { platform: 'ubuntu', version: '14.04' }
      ChefSpec::SoloRunner.new(env_options).converge(described_recipe)
    end

    it 'sets up an apt repository for `maxscale`' do
      expect(chef_run).to add_apt_repository('maxscale')
    end

    it 'install maxscale package' do
      expect(chef_run).to install_package('maxscale')
    end

    it 'create maxscale config' do
      expect(chef_run).to create_template('/etc/maxscale.cnf')
    end

    it 'enable maxscale service' do
      expect(chef_run).to enable_service('maxscale')
    end

    it 'start maxscale service' do
      expect(chef_run).to start_service('maxscale')
    end
  end
end
