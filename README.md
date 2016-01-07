hash_sieve
=========

Strains unwanted hash attributes from enumerable objects, a template object forms the Sieve.

Status
------

[![Build Status](https://travis-ci.org/MYOB-Technology/hash_sieve.png)](https://travis-ci.org/MYOB-Technology/hash_sieve)
[![Code Climate](https://codeclimate.com/github/MYOB-Technology/hash_sieve/badges/gpa.svg)](https://codeclimate.com/github/MYOB-Technology/hash_sieve)
[![Test Coverage](https://codeclimate.com/github/MYOB-Technology/hash_sieve/badges/coverage.svg)](https://codeclimate.com/github/MYOB-Technology/hash_sieve/coverage)

Motivation
----------

Born out of verifying a JSON payload is a superset of an expected payload.

Usage
------

```ruby

strained_hash = HashSieve.strain(
  {
    entry_i_need: "important value",
    entry_i_dont_need: "unimportant value"
  },
  template: { entry_i_need: "" }
)

# strained_hash contains { entry_i_need: "important value" }

```

Note that ```hash_sieve``` will also traverse ```Enumerable```s such as ```Array```s and ```Set```s.

Installation
------------

In your Gemfile include:

```ruby
    gem 'hash_sieve'
```

Requirements
------------

* Ruby >= 1.9.3
