class people::jabley(
  $node_version = '4.2.4',
) {

  class { 'vagrant':
    version => '1.7.4',
    completion => true,
  }

  vagrant::plugin { 'vagrant-cachier': }
  vagrant::plugin { 'vagrant-dns': }
  vagrant::plugin { 'vagrant-hostmanager': }
#  vagrant::plugin { 'vagrant-vmware-fusion': }

  # All my SSH belong
  ssh_config::fragment {"user":
    content => template('people/jabley/ssh_config'),
  }

#  class { 'git': version => '2.6.3' }

  class { 'nodejs::global': version => $node_version }

  nodejs::version { '0.12.0': }
  nodejs::version { '0.10.36': }
  nodejs::version { '0.8.28': }

  npm_module { "json for node ${node_version}":
      module       => 'json',
      version      => '~> 9.0.3',
      node_version => $node_version,
  }

  npm_module { "grunt-cli for node ${node_version}":
      module       => 'grunt-cli',
      version      => '~> 0.1.13',
      node_version => $node_version,
  }

  npm_module { "gulp for node ${node_version}":
      module       => 'gulp',
      version      => '~> 3.9.0',
      node_version => $node_version,
  }

  npm_module { "keybase-installer for node ${node_version}":
      module       => 'keybase-installer',
      version      => '~> 1.0.3',
      ensure       => absent,
      node_version => $node_version,
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

  $goenv = "${home_projects}/alext/goenv"

  repository { $goenv:
    before  => Repository[$dotfiles],
    ensure  => 'v0.0.7',
    source  => 'alext/goenv',
    require => File[$home_projects],
    notify  => Exec['link-goenv'],
  }

  exec { 'link-goenv':
    command     => "ln -s ${home_projects}/alext/goenv ${home}/.goenv",
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

  homebrew::tap { 'olleolleolle/homebrew-adr-tools': }
  homebrew::tap { 'caskroom/versions': }
  homebrew::tap { 'cloudfoundry/tap': }
  homebrew::tap { 'steeve/delve': }

  package { 'java':
    provider => 'brewcask',
  } -> package {
    [
      'ec2-api-tools',
      'maven',
      'scala',
      'sbt',
      'android-sdk',
    ]:
    ensure   => latest,
    provider => 'homebrew',
  }

  Package['go'] -> exec { 'install_go_tools':
   environment => ["GOPATH=${home}/gocode"],
    command => 'go get golang.org/x/tools/cmd/cover \
                && go get golang.org/x/tools/cmd/godoc \
                && go get golang.org/x/tools/cmd/present \
                && go get golang.org/x/tools/cmd/goimports \
                && go get github.com/bradfitz/http2/h2i \
                && go get github.com/jabley/train/cmd/train \
                && go get github.com/golang/lint/golint \
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
