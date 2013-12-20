name             "webapp"
maintainer       "Daniel Jabbour"
maintainer_email "sayhi@amoe.ba"
license          "MIT"
description      "Deploy a web application (Ruby on Rails or NodeJS) using industry best practices. Used with Amoeba Deploy Tools."
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1.0"

recipe           "webapp", "Default webapp recipe"

depends 'nginx'
depends 'nodejs'
depends 'postgresql'
depends 'redisio'

# Note: These deps come from Github, and must be imported
# via your Cheffile
depends 'rvm'
depends 'unicorn'
depends 'monit'