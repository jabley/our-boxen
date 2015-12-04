class people::jabley(
  $node_version = '0.10.36',
) {

  include brewcask

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

  homebrew::tap { 'homebrew/science': }

  homebrew::tap { 'homebrew/binary': }
  package { 'packer': }

  class { 'nodejs::global': version => $node_version }

  nodejs::version { '0.12.0': }
  nodejs::version { '0.8.26': ensure => absent }

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

  exec { 'install_go_tools':
   environment => ["GOPATH=${home}/gocode"],
    command => 'go get golang.org/x/tools/cmd/cover \
                && go get golang.org/x/tools/cmd/godoc \
                && go get golang.org/x/tools/cmd/present \
                && go get golang.org/x/tools/cmd/vet \
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
}
