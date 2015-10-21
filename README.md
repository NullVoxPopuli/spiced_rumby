# Spiced Gracken [![Build Status](https://travis-ci.org/NullVoxPopuli/spiced_gracken.svg)](https://travis-ci.org/NullVoxPopuli/spiced_gracken) [![Code Climate](https://codeclimate.com/github/NullVoxPopuli/spiced_gracken/badges/gpa.svg)](https://codeclimate.com/github/NullVoxPopuli/spiced_gracken) [![Test Coverage](https://codeclimate.com/github/NullVoxPopuli/spiced_gracken/badges/coverage.svg)](https://codeclimate.com/github/NullVoxPopuli/spiced_gracken/coverage)
A ruby gem that acts as a [mesh-chat](https://github.com/neuravion/mesh-chat) client.

![Screenshot](http://i.imgur.com/Y88P4mw.png)
# Installation

```bash
gem install spiced_gracken
```

# Usage

```bash
$ irb
```
```ruby
require 'spiced_gracken'
SpicedGracken.start
```

Or, if you just download the zip / clone the repo:

```bash
bundle install # to install ruby dependencies
./run # for bash interface (the picture on the right, above)
./run ui # for curses interface (the picture on the left above)
```

# Dependencies

For sending messages
```bash
sudo apt-get install libcurl3 libcurl3-gnutls libcurl4-openssl-dev
```
See [the ruby curl bindings installation](https://github.com/taf2/curb#installation) for non Ubuntu OSes.

For encryption and RSA key generation
```bash
sudo apt-get install openssl
```
