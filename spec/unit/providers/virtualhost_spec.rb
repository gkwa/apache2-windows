require 'spec_helper'

describe 'fixturecookbook::default' do
  # let(:chef_run) { ChefSpec::Runner.new(step_into: ['my_lwrp']).converge('foo::default') }

  it 'writes out a virtualhost template' do
    # expect(chef_run).to install_package('foo')
    pending 'need to determine where to put fixture cookbooks'
  end
end
