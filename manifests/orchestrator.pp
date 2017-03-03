class orchestrator (
  $base_dir,
) {
  Archive {
    checksum_verify => false,
  }
  include aem_orchestrator

  file { "${base_dir}/aem-tools/":
    ensure => directory,
    mode   => '0775',
    owner  => 'root',
    group  => 'root',
  } ->
  file { "${base_dir}/aem-tools/stack-offline-snapshot-message.json":
    ensure  => present,
    content => epp("${base_dir}/aem-aws-stack-provisioner/templates/aem-tools/stack-offline-snapshot-message.json.epp", {
      'stack_prefix' => "${::stackprefix}"
    }),
    mode    => '0775',
    owner   => 'root',
    group   => 'root',
  } ->
  file { "${base_dir}/aem-tools/stack-offline-snapshot.sh":
    ensure  => present,
    content => epp("${base_dir}/aem-aws-stack-provisioner/templates/aem-tools/stack-offline-snapshot.sh.epp", {
      'sns_topic_arn' => "${::stack_manager_sns_topic_arn}",
    }),
    mode    => '0775',
    owner   => 'root',
    group   => 'root',
  } ->
  cron { 'nightly-stack-offline-snapshot':
    command => "${base_dir}/aem-tools/stack-offline-snapshot.sh",
    user    => 'root',
    hour    => 1,
    minute  => 0,
  }

}

include orchestrator
