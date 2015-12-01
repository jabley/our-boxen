class people::jabley::repos {

  file {[
    "${people::jabley::home_projects}/MastodonC",
    "${people::jabley::home_projects}/camlistore",
    "${people::jabley::home_projects}/circonus-labs",
    "${people::jabley::home_projects}/clojure",
    "${people::jabley::home_projects}/coreos",
    "${people::jabley::home_projects}/etsy",
    "${people::jabley::home_projects}/fullstackio",
    "${people::jabley::home_projects}/jabley",
    "${people::jabley::home_projects}/jberkel",
    "${people::jabley::home_projects}/joyent",
    "${people::jabley::home_projects}/kelseyhightower",
    "${people::jabley::home_projects}/mattbostock",
    "${people::jabley::home_projects}/mitchellh",
    "${people::jabley::home_projects}/mozilla-services",
    "${people::jabley::home_projects}/mustache",
    "${people::jabley::home_projects}/mysociety",
    "${people::jabley::home_projects}/nex3",
    "${people::jabley::home_projects}/nginx",
    "${people::jabley::home_projects}/omniti-labs",
    "${people::jabley::home_projects}/openregister",
    "${people::jabley::home_projects}/real-logic",
    "${people::jabley::home_projects}/revel",
    "${people::jabley::home_projects}/robyoung",
    ]:
    ensure => directory,
  }

  define github ($host = "github.com", $ensure = "present", $path = undef) {
    $dirs = split($title, '/')

    $dir = $dirs[0]
    $repo = $dirs[1]
    $source = $title

    if $path {
        repository { "${people::jabley::home_projects}/${title}":
            ensure  => $ensure,
            source  => "git@${host}:${source}",
            path    => "${people::jabley::home_projects}/${dir}/${path}",
            require => File["${people::jabley::home_projects}/${dir}"],
        }        
    } else {
        repository { "${people::jabley::home_projects}/${title}":
            ensure  => $ensure,
            source  => "git@${host}:${source}",
            require => File["${people::jabley::home_projects}/${dir}"],
        }
    }
  }

  github {
    'jabley/mustache':
    path => 'go-mustache',
  }

  github {
    'jabley/progfun-2012':
    path => 'jabley-progfun-2012',
  }

  github {
    'jabley/spec':
    path => 'mustache-spec',
  }

  github {[
    'MastodonC/nhs-prescription-analytics',
    'camlistore/camlistore',
    'circonus-labs/fq',
    'circonus-labs/libmtev',
    'clojure/clojure',
    'coreos/coreos-vagrant',
    'fullstackio/FlappySwift',
    'jabley/PinDroid',
    'jabley/activerecord-import',
    'jabley/alternativebp.com',
    'jabley/anthology',
    'jabley/bcrypt-ruby',
    'jabley/bloog',
    'jabley/bob-walker',
    'jabley/campfire-plugin',
    'jabley/capybara',
    'jabley/confnotes.club',
    'jabley/data-anonymization',
    'jabley/elasticsearch',
    'jabley/elephantdb',
    'jabley/forcomp',
    'jabley/fpinscala-exercises',
    'jabley/gmail-britta',
    'jabley/gojsonschema',
    'jabley/golang-challenge-1',
    'jabley/gom',
    'jabley/homebrew',
    'jabley/jargone',
    'jabley/markdown',
    'jabley/netty',
    'jabley/performance-node-frontend',
    'jabley/progfun',
    'jabley/puppet-shelf',
    'jabley/puppet',
    'jabley/requests',
    'jabley/spdy',
    'jabley/stripe-ctf-2.0',
    'jabley/third_party.go',
    'jabley/train',
    'jberkel/sms-backup-plus',
    'kelseyhightower/coreos-ops-tutorial',
    'mattbostock/sshkeycheck',
    'mitchellh/vagrant',
    'mozilla-services/heka',
    'mustache/mustache',
    'nex3/sass',
    'nginx/nginx',
    'omniti-labs/reconnoiter',
    'openregister/register',
    'real-logic/Aeron',
    'revel/revel',
    'robyoung/http2play',
    ]:
  }
}
