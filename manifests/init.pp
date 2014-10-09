# == Define: userskel
#
# Manage the skeleton used by useradd for user creation.
#
# === Examples
#
#  userskel { 'server':
#    shell             => '/bin/nologin',
#    create_mail_spool => 'yes'
#  }
#
#  userskel { 'desktop':
#    shell => '/bin/zsh',
#    group => '1001'
#  }
#
# === Authors
#
# Carla Souza <contact@carlasouza.com>

define userskel (
  $group             = '100',
  $home              = '/home',
  $inactive          = -1,
  $expire            = '',
  $shell             = '/bin/bash',
  $skel_dir          = '/etc/skel',
  $create_mail_spool = 'no'
) {

  case $operatingsystem {
    'ArchLinux', 'Debian', 'Fedora', 'Ubuntu': {
      file {
        '/etc/default/useradd':
          content => template('userskel/useradd.erb');
        $skel_dir:
          ensure  => directory,
          path    => "$skel_dir",
          recurse => true,
          source  => [
            "puppet:///modules/userskel/$name",
            'puppet:///modules/userskel/default'
          ],
          owner   => 0,
          mode    => 0644
      }
    }
    default: {
      fail("[user_skel] Operating System '$::operatingsystem' not supported")
    }
  }
}