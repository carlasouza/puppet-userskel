# userskel

Manage the skeleton used by `useradd` for user creation.

It already comes with default content for `.bashrc`, `.bash_logout`, `.gemrc`, [`.gitignore_global`](https://gist.github.com/Swader/7844111) and `.profile` files inside `files/default/` directory of this module.

Modify, remove or add more files at `files/default` as desired, or create new collections by creating a subfolder at `files/`. It will look for `files/$name` as skel source. If non existent, the `default` directory will be used as source.

# Examples

Prevent any created user to ssh to your server

    userskel { 'server':
      shell             => '/bin/nologin',
      create_mail_spool => 'yes'
    }

Change the default shell to zsh

    userskel { 'desktop':
      shell => '/bin/zsh',
      group => '1001'
    }

# Support

Please log tickets and issues at the [Project site](http://github.com/carlasouza/puppet-userskel)

# Author

Carla Souza <contact@carlasouza.com>

# License

Copyright 2014 Carla Souza. License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>. This is free software: you are free to change and redistribute it. There is NO WARRANTY, to the extent permitted by law.
