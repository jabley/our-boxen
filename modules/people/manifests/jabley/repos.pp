class people::jabley::repos {

  file {[
    "${people::jabley::home_projects}/adrianco",
    "${people::jabley::home_projects}/camlistore",
    "${people::jabley::home_projects}/CausalityLtd",
    "${people::jabley::home_projects}/circonus-labs",
    "${people::jabley::home_projects}/clojure",
    "${people::jabley::home_projects}/coreos",
    "${people::jabley::home_projects}/DigitalInnovation",
    "${people::jabley::home_projects}/ebmdatalab",
    "${people::jabley::home_projects}/fullstackio",
    "${people::jabley::home_projects}/jabley",
    "${people::jabley::home_projects}/kelseyhightower",
    "${people::jabley::home_projects}/MastodonC",
    "${people::jabley::home_projects}/mattbostock",
    "${people::jabley::home_projects}/mozilla-services",
    "${people::jabley::home_projects}/nginx",
    "${people::jabley::home_projects}/omniti-labs",
    "${people::jabley::home_projects}/openregister",
    "${people::jabley::home_projects}/real-logic",
    "${people::jabley::home_projects}/robyoung",
    "${people::jabley::home_projects}/rust-lang",
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
    'CausalityLtd/ponyc',
    'DigitalInnovation/API-AuthServer',
    'DigitalInnovation/boss-click-and-collect',
    'DigitalInnovation/boss-click-and-collect-admin',
    'DigitalInnovation/boss-lockers-admin',
    'DigitalInnovation/boss-sppd-engine',
    'DigitalInnovation/boss-sppd-webapp',
    'DigitalInnovation/boss-stocklocator-automation',
    'DigitalInnovation/boss-stocklocator',
    'DigitalInnovation/fear-core',
    'DigitalInnovation/fear-core-app',
    'DigitalInnovation/fear-core-serve',
    'DigitalInnovation/fear-core-tasks',
    'DigitalInnovation/fear-core-ui',
    'DigitalInnovation/fear-sdk',
    'DigitalInnovation/MCP-Proxy',
    'DigitalInnovation/NORTH-loyalty-services',
    'DigitalInnovation/shop-commerce',
    'DigitalInnovation/shop-UX',
    'DigitalInnovation/react-pdp-prototype',
    'MastodonC/nhs-prescription-analytics',
    'adrianco/spigo',
    'camlistore/camlistore',
    'circonus-labs/fq',
    'circonus-labs/libmtev',
    'clojure/clojure',
    'coreos/coreos-vagrant',
    'ebmdatalab/openprescribing',
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
    'kelseyhightower/coreos-ops-tutorial',
    'mattbostock/sshkeycheck',
    'mozilla-services/heka',
    'nginx/nginx',
    'omniti-labs/reconnoiter',
    'openregister/register',
    'real-logic/Aeron',
    'robyoung/http2play',
    'rust-lang/rust',
    ]:
  }
}
