# == Class: user-skel
#
# Full description of class user-skel here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if it
#   has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should not be used in preference to class parameters  as of
#   Puppet 2.6.)
#
# === Examples
#
#  class { user-skel:
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ]
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2013 Your name here, unless otherwise noted.
#
class user {

  define skel (
                $shell             = '/bin/sh',
                $home              = '/home',
                $group             = '',
                $inactive          = -1,
                $expire            = '',
                $skel_dir          = '/etc/skel',
                $create_mail_spool = 'yes',
                $dot_files         = ['.bashrc', '.bash_logout', '.profile']
  ) {

  case $::operatingsystem {

    'debian', 'ubuntu': {
      file {
        '/etc/default/useradd':
          content => template('useradd.erb');
        $skel_dir:
          ensure => 'directory',
          purge  => true;
        $dot_files:
          ensure => file,
          path   => "$skel_dir/$name",
          source => "puppet:///modules/user_skel/$name",
          owner  => 0,
          mode   => 0644
      }
    }
    default: {
      warn "[user_skel] Operating System '$::operatingsystem' not supported"
    }

  }

}
}

user::skel {'default':
  shell => '/bin/bash'
}
