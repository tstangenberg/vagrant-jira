define append_if_no_such_line($file, $line, $refreshonly = 'false') {
   exec { "/bin/echo '$line' >> '$file'":
      unless      => "/bin/grep -Fxqe '$line' '$file'",
      path        => "/bin",
      refreshonly => $refreshonly,
   }
}

class jira {
  include java

  $jira-archive = "http://www.atlassian.com/software/jira/downloads/binary/atlassian-jira-6.1.1.tar.gz"
  $jira-app = "/vagrant/atlassian-jira-6.1.1-standalone"
  $jira-home = "/vagrant/jira-home"
  $jira-start = "$jira-app/bin/start-jira.sh"

  exec {
    "download_jira":
    command => "curl -L $jira-archive | tar zx",
    cwd => "/vagrant",
    user => "vagrant",
    path    => "/usr/bin/:/bin/",
    logoutput => true,
    timeout => 0,
    creates => "$jira-app",
  }

 exec {
    "create_jira_home":
    command => "mkdir -p $jira-home",
    cwd => "/vagrant",
    user => "vagrant",
    path    => "/usr/bin/:/bin/",
    require => Exec["download_jira"],
    logoutput => true,
    creates => "$jira-home",    
  }

  exec {
    "start_jira_in_background":
    environment => "JIRA_HOME=$jira-home",
    command => "$jira-start &",
    cwd => "/vagrant",
    user => "vagrant",
    path    => "/usr/bin/:/bin/",
    require => [ Package["java"],
                 Exec["create_jira_home"] ],
    logoutput => true,
  }

  append_if_no_such_line { motd:
    file => "/etc/motd",
    line => "Run jira with: JIRA_HOME=$jira-home $jira-start",
    require => Exec["start_jira_in_background"],
  }

}
include jira


include apt

# this repo is needed vor collectd version 5.3
apt::ppa { "ppa:vbulax/collectd5": }

exec { "apt-update":
  command => '/usr/bin/apt-get update',
  user => root,
  require => Apt::Ppa["ppa:vbulax/collectd5"],
}


class { '::collectd':
  require => Exec["apt-update"]
}

include collectd

class { 'collectd::plugin::write_graphite':
  graphitehost => '10.0.2.2',
}
