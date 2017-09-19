class people::jabley::repos {

  # Try to configure SSH properly before cloning anything. Poor man's DAG?
  include people::jabley::ssh_known_hosts

  file {[
    "${people::jabley::home_projects}/adrianco",
    "${people::jabley::home_projects}/alphagov",
    "${people::jabley::home_projects}/brendangregg",
    "${people::jabley::home_projects}/camlistore",
    "${people::jabley::home_projects}/CausalityLtd",
    "${people::jabley::home_projects}/cdaniel",
    "${people::jabley::home_projects}/circonus-labs",
    "${people::jabley::home_projects}/clojure",
    "${people::jabley::home_projects}/cloudfoundry",
    "${people::jabley::home_projects}/coreos",
    "${people::jabley::home_projects}/davbo",
    "${people::jabley::home_projects}/docker",
    "${people::jabley::home_projects}/ebmdatalab",
    "${people::jabley::home_projects}/Financial-Times",
    "${people::jabley::home_projects}/fullstackio",
    "${people::jabley::home_projects}/golang",
    "${people::jabley::home_projects}/hashicorp",
    "${people::jabley::home_projects}/intermezzOS",
    "${people::jabley::home_projects}/jabley",
    "${people::jabley::home_projects}/jawher",
    "${people::jabley::home_projects}/kamalmarhubi",
    "${people::jabley::home_projects}/kevin-wayne",
    "${people::jabley::home_projects}/kisielk",
    "${people::jabley::home_projects}/MastodonC",
    "${people::jabley::home_projects}/mattbostock",
    "${people::jabley::home_projects}/MoarVM",
    "${people::jabley::home_projects}/mozilla-services",
    "${people::jabley::home_projects}/Netflix",
    "${people::jabley::home_projects}/nginx",
    "${people::jabley::home_projects}/npryce",
    "${people::jabley::home_projects}/omniti-labs",
    "${people::jabley::home_projects}/openregister",
    "${people::jabley::home_projects}/real-logic",
    "${people::jabley::home_projects}/robyoung",
    "${people::jabley::home_projects}/ruby",
    "${people::jabley::home_projects}/rust-lang",
    "${people::jabley::home_projects}/spf13",
    "${people::jabley::home_projects}/terraform-providers",
    "${people::jabley::home_projects}/twitter",
    "${people::jabley::home_projects}/uwiger",
    "${people::jabley::home_projects}/VividCortex",
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

  define gitlab($host = "gitlab.com", $ensure = 'present') {
    $dirs = split($title, '/')

    $dir = $dirs[0]
    $repo = $dirs[1]
    $source = $title

    repository { "${people::jabley::home_projects}/${title}":
        ensure  => $ensure,
        source  => "git@${host}:${source}",
        require => File["${people::jabley::home_projects}/${dir}"],
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
    'alphagov/cdn-acceptance-tests',
    'alphagov/govuk_frontend_toolkit',
    'alphagov/metadata-api',
    'alphagov/router',
    'brendangregg/FlameGraph',
    'CausalityLtd/ponyc',
    'cdaniel/atlas2',
    'cloudfoundry/cli',
    'MastodonC/nhs-prescription-analytics',
    'adrianco/spigo',
    'camlistore/camlistore',
    'circonus-labs/fq',
    'circonus-labs/libcircllhist',
    'circonus-labs/libmtev',
    'clojure/clojure',
    'coreos/coreos-vagrant',
    'davbo/cryptopals',
    'docker/docker.github.io',
    'ebmdatalab/openprescribing',
    'Financial-Times/ft-origami',
    'fullstackio/FlappySwift',
    'golang/go',
    'hashicorp/terraform',
    'intermezzOS/book',
    'jabley/PinDroid',
    'jabley/activerecord-import',
    'jabley/alternativebp.com',
    'jabley/anthology',
    'jabley/bcrypt-ruby',
    'jabley/bloog',
    'jabley/bob-walker',
    'jabley/BoilingFrogs',
    'jabley/brotli',
    'jabley/campfire-plugin',
    'jabley/capybara',
    'jabley/cf-metrics',
    'jabley/confnotes.club',
    'jabley/data-anonymization',
    'jabley/docker-networking-repro',
    'jabley/dockerfiles',
    'jabley/elasticsearch',
    'jabley/elephantdb',
    'jabley/faraday_middleware',
    'jabley/forcomp',
    'jabley/fpinscala-exercises',
    'jabley/FrameworkBenchmarks',
    'jabley/fptp',
    'jabley/ghcli',
    'jabley/gmail-britta',
    'jabley/gojsonschema',
    'jabley/golang-challenge-1',
    'jabley/gom',
    'jabley/government-service-design-manual',
    'jabley/HaskellMOOC',
    'jabley/hello-go-web',
    'jabley/homebrew',
    'jabley/httptraced',
    'jabley/jargone',
    'jabley/jamesabley.com',
    'jabley/markdown',
    'jabley/matasano-crypto-challenges',
    'jabley/monitoring-spike',
    'jabley/netty',
    'jabley/performance-node-frontend',
    'jabley/progfun',
    'jabley/project-status',
    'jabley/puppet-shelf',
    'jabley/puppet',
    'jabley/requests',
    'jabley/spdy',
    'jabley/stripe-ctf-2.0',
    'jabley/third_party.go',
    'jabley/train',
    'jawher/immanix',
    'kamalmarhubi/shell-workshop',
    'kevin-wayne/algs4',
    'kisielk/errcheck',
    'mattbostock/sshkeycheck',
    'MoarVM/MoarVM',
    'mozilla-services/heka',
    'Netflix/zuul',
    'nginx/nginx',
    'npryce/adr-tools',
    'omniti-labs/reconnoiter',
    'openregister/mint',
    'openregister/register',
    'real-logic/Aeron',
    'robyoung/http2play',
    'ruby/ruby',
    'rust-lang/rust',
    'spf13/hugo',
    'terraform-providers/terraform-provider-fastly',
    'twitter/finagle',
    'twitter/scala_school',
    'uwiger/pots',
    'VividCortex/go-database-sql-tutorial',
    ]:
  }
}
