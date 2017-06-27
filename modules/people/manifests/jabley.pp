class people::jabley(
) {

  include vagrant

  vagrant::plugin { 'vagrant-cachier': }
  vagrant::plugin { 'vagrant-dns': }
  vagrant::plugin { 'vagrant-hostmanager': }

  # All my SSH belong
  ssh_config::fragment {"user":
    content => template('people/jabley/ssh_config'),
  }

  $home = "/Users/${::luser}"
  $home_projects = "${home}/Projects"

  file { "$home_projects":
    ensure => directory,
  }

  file { "${::luser}-fabricrc":
    path    => "$home/.fabricrc",
    ensure  => 'file',
    content => 'user = jabley',
  }

  $dotfiles = "${home_projects}/jabley/homedir"

  repository { $dotfiles:
    source  => 'jabley/homedir',
    require => File[$home_projects],
    notify  => Exec['jabley-make-homedir'],
  }

  exec { 'jabley-make-homedir':
    command     => "cd ${dotfiles} && make",
    refreshonly => true,
  }

  include people::jabley::repos

#  $emacs = "${home_projects}/emacs-d"
#
#  repository { $emacs:
#    source  => 'jabley/emacs-d',
#    require => File[$home_projects],
#    notify  => Exec['jabley-make-emacs-d'],
#  }
#
#  exec { 'jabley-make-emacs-d':
#    command     => "cd ${emacs} && make",
#    refreshonly => true,
#  }

  homebrew::tap { 'caskroom/versions': }
  homebrew::tap { 'cloudfoundry/tap': }
  homebrew::tap { 'go-delve/delve': }

 include mas

  package { 'java':
    provider => 'brewcask',
  } -> package {
    [
      'ec2-api-tools',
      'maven',
      'scala',
      'sbt',
    ]:
    ensure   => latest,
    provider => 'homebrew',
  }

  package { 'delve':
    ensure          => present,
    install_options => [
      '--HEAD'
      ],
    provider        => homebrew
  }

  package { 'curl':
    ensure          => present,
    install_options => [
      '--with-nghttp2',
    ],
    provider        => homebrew,
  }

  package { 'lastpass-cli':
    ensure          => present,
    install_options => [
      '--with-pinentry',
    ],
    provider        => homebrew,
  }

  Package['go'] -> exec { 'install_go_tools':
   environment => ["GOPATH=${home}/gocode"],
    command => 'go get golang.org/x/tools/cmd/cover \
                && go get golang.org/x/tools/cmd/godoc \
                && go get golang.org/x/tools/cmd/present \
                && go get golang.org/x/tools/cmd/goimports \
                && go get github.com/bradfitz/http2/h2i \
                && go get github.com/dvyukov/go-fuzz/go-fuzz \
                && go get github.com/dvyukov/go-fuzz/go-fuzz-build \
                && go get github.com/jabley/train/cmd/train \
                && go get github.com/golang/lint/golint \
                && (go get -u golang.org/x/blog || true)
                '
  }

  # Settings from puppet-osx
  class { 'osx::dock::position':
    position => 'left'
    }
  osx::recovery_message { 'If found, please call +447796 692 786': }

#  sysctl::set { 'kern.maxfiles':
#    value => '16384'
#  }
#  sysctl::set { 'kern.maxfilesperproc':
#    value => '16384'
#  }

  # Temporary workplace to remove packages from all machines.
  package { [
      'nasm',
      'qemu',
      'xorriso',
    ]:
    ensure => absent,
  }

  # dirty way of ensuring that installer can install things like gpgtools
  sudoers { 'installer':
    users    => $::boxen_user,
    hosts    => 'ALL',
    commands => [
      '(ALL) SETENV:NOPASSWD: /usr/sbin/installer',
    ],
    type     => 'user_spec',
  }
}
