class author_primary (

) {

  service { 'aem-aem':
    ensure => 'running',
    enable => true,
  } ->
  aem_aem { 'Wait until login page is ready':
    ensure  => login_page_is_ready,
  }

}

include author_primary
