class people::jabley::repos {

  # Try to configure SSH properly before cloning anything. Poor man's DAG?
  include people::jabley::ssh_known_hosts

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
    "${people::jabley::home_projects}/hashicorp",
    "${people::jabley::home_projects}/intermezzOS",
    "${people::jabley::home_projects}/jabley",
    "${people::jabley::home_projects}/jawher",
    "${people::jabley::home_projects}/kamalmarhubi",
    "${people::jabley::home_projects}/kevin-wayne",
    "${people::jabley::home_projects}/MastodonC",
    "${people::jabley::home_projects}/mattbostock",
    "${people::jabley::home_projects}/moo-print-ops",
    "${people::jabley::home_projects}/moo",
    "${people::jabley::home_projects}/moo/chrise",
    "${people::jabley::home_projects}/moo/claudio",
    "${people::jabley::home_projects}/moo/create",
    "${people::jabley::home_projects}/moo/docker",
    "${people::jabley::home_projects}/moo/ecom",
    "${people::jabley::home_projects}/moo/ilja",
    "${people::jabley::home_projects}/moo/jamesa",
    "${people::jabley::home_projects}/moo/m4b",
    "${people::jabley::home_projects}/moo/miguel",
    "${people::jabley::home_projects}/moo/money",
    "${people::jabley::home_projects}/moo/moo",
    "${people::jabley::home_projects}/moo/moods-react",
    "${people::jabley::home_projects}/moo/ops",
    "${people::jabley::home_projects}/moo/pixel",
    "${people::jabley::home_projects}/moo/platform-engineering",
    "${people::jabley::home_projects}/moo/pro-upload",
    "${people::jabley::home_projects}/moo/python-infrastructure",
    "${people::jabley::home_projects}/moo/testers-guild",
    "${people::jabley::home_projects}/mozilla-services",
    "${people::jabley::home_projects}/Netflix",
    "${people::jabley::home_projects}/nginx",
    "${people::jabley::home_projects}/npryce",
    "${people::jabley::home_projects}/omniti-labs",
    "${people::jabley::home_projects}/openregister",
    "${people::jabley::home_projects}/real-logic",
    "${people::jabley::home_projects}/robyoung",
    "${people::jabley::home_projects}/rust-lang",
    "${people::jabley::home_projects}/spf13",
    "${people::jabley::home_projects}/terraform-providers",
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
    'circonus-labs/libcircllhist',
    'circonus-labs/libmtev',
    'clojure/clojure',
    'coreos/coreos-vagrant',
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
    'mattbostock/sshkeycheck',
    'mozilla-services/heka',
    'Netflix/zuul',
    'nginx/nginx',
    'npryce/adr-tools',
    'omniti-labs/reconnoiter',
    'openregister/mint',
    'openregister/register',
    'real-logic/Aeron',
    'robyoung/http2play',
    'rust-lang/rust',
    'spf13/hugo',
    'terraform-providers/terraform-provider-fastly',
    'twitter/finagle',
    'twitter/scala_school',
    'VividCortex/go-database-sql-tutorial',
    ]:
  }

  gitlab {[
      'moo-print-ops/runbooks',
    ]:
  }

  moo {[
      'chrise/pro-upload',
      'claudio/catalyst-framework',
      'claudio/fastly-logs',
      'create/buildhub',
      'create/config',
      'create/dtadmin',
      'create/dtapi',
      'create/houdini',
      'create/imagestore',
      'create/warhol',
      'docker/moo-java-gradle',
      'ecom/cms',
      'ecom/cmsfe',
      'ilja/mock-cdn',
      'ilja/ngrok-java-container',
      'jamesa/cdn-docs',
      'jamesa/helloworld',
      'jamesa/stackpoint',
      'm4b/mbs-platform-api',
      'miguel/objectstore-benchmark',
      'money/site-automated-testing',
      'moo/db',
      'moo/services',
      'moo/services-common',
      'moo/site',
      'moods-react/moods-react',
      'ops/ansible',
      'ops/emo-debs',
      'ops/fastly-java-client',
      'ops/filestore-s3-migration-updated-moostored-proxy',
      'ops/moo-main-flows-load-tests',
      'ops/moobernetes',
      'ops/moostored-s3-go',
      'ops/prometheus-dev',
      'ops/runbooks',
      'ops/s3filesyncd',
      'ops/systems-svn-archive',
      'ops/terraform',
      'ops/xymon',
      'pixel/bascule',
      'platform-engineering/ab-testing-vcl-generator',
      'platform-engineering/botnet',
      'platform-engineering/cdn-tests',
      'platform-engineering/common-ci-images',
      'platform-engineering/fastly-manager',
      'platform-engineering/filestore-java-client',
      'platform-engineering/moo-metrics',
      'platform-engineering/moo-parent-pom',
      'platform-engineering/mootil',
      'pro-upload/pro-upload',
      'python-infrastructure/filestore-client',
      'testers-guild/gatling-workshop',
      'testers-guild/moo-smoke-tests',
    ]:
  }
}
