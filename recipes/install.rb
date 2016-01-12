case node['platform_family']
when 'debian'
  package node['maxscale']['apt']['package']
end
