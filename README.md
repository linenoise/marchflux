Marchflux
=========

A geohraphically relevant social media filter


Overview
--------

Marchflux is a ruby application that contextualizes social media data by geographic and topical markers.  It integrates with with mapping systems to display these data along with any embedded media available.

It does this through two components:

* The web server (`config.ru` and `app.rb`) gives you the ability to dynamically configure hashtags and users to follow, and provide basic training to the system on what kinds of things go in which kinds of contexts.
* The fluxer (`fluxer.rb`) runs in the background, pulling in social media data, analyzing it, and dispatching it to the configured channels.

This is designed to run in the terminal on Linux or Mac OSX.  It *might* run on windows (through [Cygwin](http://cygwin.com/), most likely).


Installation
------------

First, you'll want to have [Ruby Version Manager](http://beginrescueend.com) installed and ready to run.  Next, you'll want to [download this repository](http://github.com/danndalf/marchflux/zipball/master) and extract it into its own directory.  Once you're in that directory:

	$ rvm install 1.9.3
	$ rvm gemset create marchflux
	$ gem install bundler
	$ bundle install

This will get the necessary Ruby modules in place.


Running the server
------------------

When you're ready to roll, go ahead and start the server with:

	$ thin start -p 8666 -a 127.0.0.1

This will load a web server on your computer at [http://127.0.0.1:8666](http://127.0.0.1:8666) with the marchflux interface ready to configure.

The other way to start thin is with a configuration file:

  $ thin start -C thin.conf

Most likely, you'll want to configure options to store in your config file:

	$ thin config -C thin.con [options]

To see all of the available options for configuration, just type:

	$ thin -h

Which will give you a dump of all the possible options.

Running the fluxer
------------------

Before you can run the fluxer, you'll need to tell it how to talk to twitter.  You will need to go to [Twitter's developer site](http://dev.twitter.com) and register a read-only application.  Once you have your `consumer_key`, `consumer_secret`, `oauth_token`, and `oauth_token_secret`, you'll need to create a file called `authentication.yml` to hold this.  A sample called `authentication.yml.sample` has been provided to help get the formatting right.  It should look something like this:

```yaml
consumer_key: 'your_consumer_key_here'
consumer_secret: 'your_consumer_secret_here'
oauth_token: 'your_oauth_token_here'
oauth_token_secret: 'your_oauth_token_secret_here'
```

Before continuing, you'll at least want to set it unreadable to other users on your system:

	$ chmod go-rwx authentication.yml

Once those keys are in the ignition, start up the fluxer:

	$ bundle exec ruby fluxer.rb

License
=======

GNU General Public License, version 3

	Marcflux - A geohraphically relevant social media filter

	Copyright (c) 2012 Dann Stayskal and Jill Ada Burrows

	This program is free software: you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation, either version 3 of the License, or
	(at your option) any later version.

	This program is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with this program.  If not, see <http://www.gnu.org/licenses/>.