hash_sieve
=========

Strains unwanted hash attributes from enumerable objects, a template object forms the Sieve.

Status
------

[![Build Status](https://travis-ci.org/MYOB-Technology/hash_sieve.png)](https://travis-ci.org/MYOB-Technology/hash_sieve)
[![Gem Version](https://badge.fury.io/rb/hash_sieve.png)](http://badge.fury.io/rb/hash_sieve)
[![Code Climate](https://codeclimate.com/github/MYOB-Technology/hash_sieve/badges/gpa.svg)](https://codeclimate.com/github/MYOB-Technology/hash_sieve)
[![Test Coverage](https://codeclimate.com/github/MYOB-Technology/hash_sieve/badges/coverage.svg)](https://codeclimate.com/github/MYOB-Technology/hash_sieve/coverage)
[![Dependency Status](https://gemnasium.com/MYOB-Technology/hash_sieve.png)](https://gemnasium.com/MYOB-Technology/hash_sieve)

Motivation
----------

Born out of verifying a JSON payload is a superset of an expected payload.

Usage
------

```ruby

strained_hash = HashSieve.strain(
  {
    needed:     "important value",
    not_needed: "unimportant value"
  },
  template: { needed: "" }
)

# strained_hash contains { needed: "important value" }
```

```hash_sieve``` supports ```strain```ing and traversing ```Enumerable```s such as ```Array```s and ```Set```s.

```ruby
strained_array = HashSieve.strain(
  [
    {
      needed_array: [
        {
          needed_string: "important value"
        }
      ],
      not_needed: "unimportant value"
    }
  ],
  template: [ { needed_array: [ { needed_string: "" } ] } ]
)

# strained_array contains [ { needed_array: [ { needed_string: "important value" } ] } ]
```

Installation
------------

In your Gemfile include:

```ruby
    gem 'hash_sieve'
```

Requirements
------------

* Ruby >= 1.9.3
