name             "webapp"
maintainer       "Daniel Jabbour"
maintainer_email "sayhi@amoe.ba"
license          "MIT"
description      "Deploy a web application (Ruby on Rails or NodeJS) using industry best practices. Used with Amoeba Deploy Tools."
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1.7"

recipe           "webapp", "Default webapp recipe"

depends 'nginx', '2.2.0' # Fixed at 2.2.0 release since we're overriding it a bit
depends 'nodejs', '~> 1.3.0'
depends 'postgresql', '~> 3.3.4'
depends 'redisio', '~> 1.7.0'

# Note: These deps come from Github, and must be imported via your Cheffile (versions fixed to
# ensure Github version is used or a warning is thrown)
depends 'rvm', '~> 0.9.1' # must use version from github: 'fnichol/chef-rvm'
depends 'monit', '~> 1.5.0' # must use version from github: 'phlipper/chef-monit'
