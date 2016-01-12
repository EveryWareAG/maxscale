case node['platform_family']
when 'debian'
  include_recipe 'apt'

  apt_repository 'maxscale' do
    uri node['maxscale']['apt']['uri']
    arch node['maxscale']['apt']['arch']
    distribution node['lsb']['codename']
    components node['maxscale']['apt']['components']
    key node['maxscale']['apt']['key']
  end
end
