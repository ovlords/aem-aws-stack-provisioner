class publish (

) {

  class { 'aem_resources::puppet_aem_resources_set_config':
    conf_dir => '/etc/puppetlabs/puppet/',
    protocol => 'http',
    host     => 'localhost',
    port     => 4503,
    debug    => true,
  } ->
  service { 'aem-aem':
    ensure => 'running',
    enable => true,
  } ->
  aem_aem { 'Wait until login page is ready':
    ensure  => login_page_is_ready,
  }

}

include publish
