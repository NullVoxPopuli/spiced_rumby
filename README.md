# Spiced Rumby [![Build Status](https://travis-ci.org/NullVoxPopuli/spiced_rumby.svg)](https://travis-ci.org/NullVoxPopuli/spiced_rumby) [![Code Climate](https://codeclimate.com/github/NullVoxPopuli/spiced_rumby/badges/gpa.svg)](https://codeclimate.com/github/NullVoxPopuli/spiced_rumby) [![Test Coverage](https://codeclimate.com/github/NullVoxPopuli/spiced_rumby/badges/coverage.svg)](https://codeclimate.com/github/NullVoxPopuli/spiced_rumby/coverage)
A ruby gem that acts as a [mesh-chat](https://github.com/neuravion/mesh-chat) client.

## Update May 11, 2016
This gem is changing a bit to just be a GUI wrapper around the core functionality ([found here](https://github.com/NullVoxPopuli/meshchat)). I'm still looking in to whether or not I want to do a GTK3 Native app, or if I want to transpile everything into javascript to run on electrode. 

To get started with the 'core' component, 'Meshchat', just run `gem install meshchat`

----------------------------------------------------------------

![Screenshot](http://i.imgur.com/Y88P4mw.png)
# Installation

```bash
gem install spiced_rumby
```

# Usage

```bash
$ irb
```
```ruby
require 'spiced_rumby'
SpicedRumby.start
```

Or, if you just download the zip / clone the repo:

```bash
bundle install # to install ruby dependencies
./run # to run the fancy terminal-ui
./run bash # to run the debug / cli-native ui
```

# Dependencies

### Gems

[meshchat](https://github.com/NullVoxPopuli/meshchat) - the core of mesh chat communication / basic functionality
[libnotify](https://github.com/splattael/libnotify) - for notifications on unix systems.

### System

For sending messages
```bash
sudo apt-get install libcurl3 libcurl3-gnutls libcurl4-openssl-dev
```
See [the ruby curl bindings installation](https://github.com/taf2/curb#installation) for non Ubuntu OSes.

For encryption and RSA key generation
```bash
sudo apt-get install openssl
```

For the sqlite3 gem
```bash
sudo apt-get install libsqlite3-dev
```


# Credits
[Icon by Google](https://www.google.com/design/icons/)
