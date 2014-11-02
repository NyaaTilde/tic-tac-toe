Installation
============

Tic-Tac-Toe is built on top of the Ruby on Rails web framework and PostgreSQL,
a relational database management system. These instructions will guide you 
through the installation of those dependencies.

The instructions will assume that you're running on Debian or a Debian-based
operating system.

The required installation steps will vary for other POSIX-compatible operating
systems, although they should be similar. Consult your operating system's
manual.

PostgreSQL
----------

Tic-Tac-Toe depends on PostgreSQL version 9.3 at minimum.

    # apt-get install postgresql libpq-dev

Ruby Version Manager
--------------------

    # apt-get install build-essential curl
    $ gpg --keyserver hkp://keys.gnupg.net --recv-keys D39DC0E3
    $ \curl -sSL https://get.rvm.io | bash -s stable

The Ruby Version Manager should now be installed. You may need to reload your
shell if it does not seem to be working.

    $ rvm --version

Ruby
----

    $ rvm install 2.1.4
    $ rvm use 2.1.4 --default

Contgratulations! You've successfully installed all the necessary system
dependencies. On to configuration!

Configuration
=============

Tic-Tac-Toe is conveyed as a source distribution. Fetch it and install the
required Gems.

    $ git clone git@github.com:NyaaTilde/tic-tac-toe.git && cd tic-tac-toe
    $ bundle install

This will install Ruby on Rails and other required Ruby gems.

Rails Environment
-----------------

The environment variable RAILS_ENV should be set to either 'production' or
'development'. How to set environment variables is dependant on your deployment
method.

    $ export RAILS_ENV='production'

Database Configuration
----------------------

Replace the generic names '__database__' and '__user__' with more preferable
names.

    # su - postgres
    postgres$ psql
    psql> CREATE USER __user__ PASSWORD '__password__';
    psql> CREATE DATABASE __database__ OWNER = __user__;

If you intend to use Tic-Tac-Toe in a development environment:

    psql> CREATE DATABASE __database_dev__ OWNER = __user__;
    psql> CREATE DATABASE __database_test__ OWNER = __user__;

The database URLs are configured as environment variables.

    $ export DATABASE_URL='postgresql://__user__:__password__@localhost/__database__'

The environment variables TEST_DATABASE_URL and DEV_DATABASE_URL are also used
when running in a development environment.

Note that the test user must have the CREATEDB permission on the database.

    psql> ALTER ROLE __user__ WITH CREATEDB;

Once the database has been properly set up, the database schema has to be
loaded and seeded with some initial data.

    $ rake db:migrate
    $ rake db:seed

Session Secret Key
------------------

All session data are signed with a secret key in order to prevent malicious
attempts at modifying the session data.

Generate a new secret key and set the SECRET_KEY_BASE environment variable.

    $ export SECRET_KEY_BASE=$(rake secret)

It is of utmost importance that the keys are never shared with anyone. Do not
distribute your keys!

Testing
=======

You can run all available tests.

    $ rake test

For further information on running individual tests, see:
<http://edgeguides.rubyonrails.org/testing.html#rake-tasks-for-running-your-tests>

Development
===========

Rails comes with a self-contained web server useful for local development.

    $ rails server

If the Rails environment has been set to development, changes to the source
are automatically reflected by the running server.

If you wish to test the Rails server in a production environment, the rake
assets need to be compiled first.

    $ rake assets:precompile

A server running in production mode requires an explicit restart.

    $ touch tmp/restart.txt

Deployment
==========

A production environment of Tic-Tac-Toe is deployed on Heroku. Rake targets are
provided to ease deployment.

It is advised that deployment is done from your integration server. Make sure
it is up-to-date and that all tests pass.

    $ git checkout master && git pull
    $ rake

Deployment to the staging server is only a single command away. The Rake task
executes all the necessary steps for deployment.

    $ rake deploy_staging

Once the acceptance tests are complete and succesful, you're ready to deploy to
production.

    $ rake deploy_production

When something goes wrong!
--------------------------

You've deployed to production and wreaked havoc! Shame on you!

But fear not, you can rollback to a previous known-working deployment.
Depending on where the havoc was wreaked, execute either of these appropriate
commands:

    $ rake deploy:staging_rollback
    $ rake deploy:production_rollback
