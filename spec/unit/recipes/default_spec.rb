require 'chef/exceptions'
require 'spec_helper'

describe 'apache2-windows::default' do
  describe 'when run on Linux' do
    let (:chef_run) do
      ChefSpec::ServerRunner.new(platform: 'centos', version: '6.8').converge(described_recipe)
    end

    it 'throws an exception' do
      expect do
        chef_run
      end.to raise_error(Chef::Exceptions::Application)
    end
  end

  describe 'when run on Windows' do
    let (:chef_run) do
      ChefSpec::ServerRunner.new(platform: 'windows', version: '2008R2')
    end

    before do
      chef_run.node.set['apache']['windows']['conf'] = 'c:\temp\totallybogus.conf'
    end

    it 'creates an httpd.conf' do
      chef_run.converge(described_recipe)
      expect(chef_run).to render_file('c:\temp\totallybogus.conf')
    end

    it 'notifies apache2 to restart when the template is modified' do
      chef_run.converge(described_recipe)
      resource = chef_run.template('c:\temp\totallybogus.conf')
      expect(resource).to notify('service[apache2]').to(:restart)
    end

    it 'enables and starts the service' do
      chef_run.converge(described_recipe)
      expect(chef_run).to enable_service('apache2')
      expect(chef_run).to start_service('apache2')
    end

    it 'updates httpd.conf with a port' do
      chef_run.node.set['apache']['windows']['listen_ports'] = %w(31337 666)
      chef_run.converge(described_recipe)
      expect(chef_run).to render_file('c:\temp\totallybogus.conf').with_content(/^Listen.*:31337$/)
      expect(chef_run).to render_file('c:\temp\totallybogus.conf').with_content(/^Listen.*:666$/)
    end

    it 'updates httpd.conf with bind addresses' do
      chef_run.node.set['apache']['windows']['listen_ports'] = %w(5678)
      chef_run.node.set['apache']['windows']['listen_addresses'] = %w(1.2.3.4)
      chef_run.converge(described_recipe)
      expect(chef_run).to render_file('c:\temp\totallybogus.conf').with_content(/^Listen 1.2.3.4:5678$/)
    end

    %w(autoindex default info languages manual mpm multilang-errordoc ssl userdir vhosts).each do |extra|
      describe "when including the #{extra} recipe" do
        before do
          chef_run.node.set['apache']['windows']['extras'] = [extra]
          chef_run.node.set['apache']['windows']['extras_dir'] = 'c:\foo'
          chef_run.node.set['apache']['windows']['extra']['vhosts']['dir'] = 'c:\vhosts'
          chef_run.converge(described_recipe)
        end

        it 'includes the recipe' do
          expect(chef_run).to include_recipe("apache2-windows::_extra_#{extra}")
        end

        it 'renders the extra config' do
          expect(chef_run).to render_file("c:\\foo/httpd-#{extra}.conf")
        end

        it 'updates the httpd.conf' do
          expect(chef_run).to render_file('c:\temp\totallybogus.conf').with_content("Include conf/extra/httpd-#{extra}.conf")
        end

        it 'restarts httpd' do
          resource = chef_run.template('c:\temp\totallybogus.conf')
          expect(resource).to notify('service[apache2]').to(:restart)
        end

        if extra == 'vhosts'
          it 'creates the vhosts directory' do
            expect(chef_run).to create_directory('c:\vhosts')
          end
          it 'includes the vhosts directory in the vhosts.conf' do
            # pending "doesn't work, need to investigate why"
            expect(chef_run).to render_file('c:\\foo/httpd-vhosts.conf').with_content('Include "c:\\vhosts/*.conf"')
          end
        end
      end
    end
  end
end
