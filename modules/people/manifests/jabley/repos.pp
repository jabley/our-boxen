class people::jabley::repos {

  file {[
    "${people::jabley::home_projects}/adrianco",
    "${people::jabley::home_projects}/alphagov",
    "${people::jabley::home_projects}/camlistore",
    "${people::jabley::home_projects}/CausalityLtd",
    "${people::jabley::home_projects}/circonus-labs",
    "${people::jabley::home_projects}/clojure",
    "${people::jabley::home_projects}/cloudfoundry",
    "${people::jabley::home_projects}/coreos",
    "${people::jabley::home_projects}/docker",
    "${people::jabley::home_projects}/ebmdatalab",
    "${people::jabley::home_projects}/Financial-Times",
    "${people::jabley::home_projects}/fullstackio",
    "${people::jabley::home_projects}/golang",
    "${people::jabley::home_projects}/intermezzOS",
    "${people::jabley::home_projects}/jabley",
    "${people::jabley::home_projects}/jawher",
    "${people::jabley::home_projects}/kamalmarhubi",
    "${people::jabley::home_projects}/kelseyhightower",
    "${people::jabley::home_projects}/kevin-wayne",
    "${people::jabley::home_projects}/MastodonC",
    "${people::jabley::home_projects}/mattbostock",
    "${people::jabley::home_projects}/moo",
    "${people::jabley::home_projects}/moo/ecom",
    "${people::jabley::home_projects}/moo/ilja",
    "${people::jabley::home_projects}/moo/jamesa",
    "${people::jabley::home_projects}/moo/moo",
    "${people::jabley::home_projects}/moo/ops",
    "${people::jabley::home_projects}/moo/platform-engineering",
    "${people::jabley::home_projects}/mozilla-services",
    "${people::jabley::home_projects}/Netflix",
    "${people::jabley::home_projects}/nginx",
    "${people::jabley::home_projects}/omniti-labs",
    "${people::jabley::home_projects}/openregister",
    "${people::jabley::home_projects}/real-logic",
    "${people::jabley::home_projects}/robyoung",
    "${people::jabley::home_projects}/rust-lang",
    "${people::jabley::home_projects}/spf13",
    "${people::jabley::home_projects}/twitter",
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

  define moo ($host = "gitlab.office.moo.com", $ensure = 'present') {
    $dirs = split($title, '/')

    $dir = $dirs[0]
    $repo = $dirs[1]
    $source = $title

    repository { "${people::jabley::home_projects}/moo/${title}":
        ensure  => $ensure,
        source  => "git@${host}:${source}",
        require => File["${people::jabley::home_projects}/moo/${dir}"],
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
    'CausalityLtd/ponyc',
    'cloudfoundry/cli',
    'MastodonC/nhs-prescription-analytics',
    'adrianco/spigo',
    'camlistore/camlistore',
    'circonus-labs/fq',
    'circonus-labs/libmtev',
    'clojure/clojure',
    'coreos/coreos-vagrant',
    'docker/docker.github.io',
    'ebmdatalab/openprescribing',
    'Financial-Times/ft-origami',
    'fullstackio/FlappySwift',
    'golang/go',
    'intermezzOS/book',
    'jabley/PinDroid',
    'jabley/activerecord-import',
    'jabley/alternativebp.com',
    'jabley/anthology',
    'jabley/bcrypt-ruby',
    'jabley/bloog',
    'jabley/bob-walker',
    'jabley/BoilingFrogs',
    'jabley/campfire-plugin',
    'jabley/capybara',
    'jabley/cf-metrics',
    'jabley/confnotes.club',
    'jabley/data-anonymization',
    'jabley/elasticsearch',
    'jabley/elephantdb',
    'jabley/faraday_middleware',
    'jabley/forcomp',
    'jabley/fpinscala-exercises',
    'jabley/FrameworkBenchmarks',
    'jabley/gmail-britta',
    'jabley/gojsonschema',
    'jabley/golang-challenge-1',
    'jabley/gom',
    'jabley/government-service-design-manual',
    'jabley/homebrew',
    'jabley/hello-go-web',
    'jabley/jargone',
    'jabley/jamesabley.com',
    'jabley/markdown',
    'jabley/matasano-crypto-challenges',
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
    'jawher/immanix',
    'kamalmarhubi/shell-workshop',
    'kelseyhightower/coreos-ops-tutorial',
    'kevin-wayne/algs4',
    'mattbostock/sshkeycheck',
    'mozilla-services/heka',
    'Netflix/zuul',
    'nginx/nginx',
    'omniti-labs/reconnoiter',
    'openregister/mint',
    'openregister/register',
    'real-logic/Aeron',
    'robyoung/http2play',
    'rust-lang/rust',
    'spf13/hugo',
    'twitter/finagle',
    'twitter/scala_school',
    'VividCortex/go-database-sql-tutorial',
    ]:
  }

  moo {[
      'ecom/cms',
      'ecom/cmsfe',
      'ilja/mock-cdn',
      'ilja/ngrok-java-container',
      'jamesa/cdn-docs',
      'moo/db',
      'moo/services',
      'moo/site',
      'ops/ansible',
      'ops/emo-debs',
      'ops/fastly-java-client',
      'platform-engineering/botnet',
      'platform-engineering/cdn-tests',
      'platform-engineering/common-ci-images',
      'platform-engineering/fastly-env-generator',
    ]:
  }
}
