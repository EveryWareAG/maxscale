include_recipe 'maxscale::repo'
include_recipe 'maxscale::install'
include_recipe 'maxscale::configure'

service 'maxscale' do
  supports reload: true, status: true, restart: true
  action [:enable, :start]
  subscribes :reload, 'template[/etc/maxscale.cnf]', :immediately
end

if node['maxscale']['root_maxadmin']
  file = '/root/.maxadmin'
  pw = ''
  pw << ::OpenSSL::Random.random_bytes(1).gsub(/\W/, '') while pw.length < 32

  template file do
    source 'root.maxadmin.erb'
    owner 'root'
    group 'root'
    mode '0600'
    variables(passwd: pw)
    only_if 'maxadmin -pmariadb add user maxadmin ' + pw
    sensitive true
  end

end
