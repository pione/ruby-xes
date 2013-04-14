# ruby-xes

ruby-xes is a Ruby library for generating XES event log.

## Installation

    $ gem install ruby-xes

## Usage

```ruby
require 'xes'

XES::Document.new.tap do |doc|
  doc.log = XES::Log.new.tap do |log|
    log.traces << XES::Trace.new.tap do |trace|
      trace.events << XES::Event.new.tap do |event|
        event.attributes << XES.string("concept:name", "test")
      end
    end
  end
end.format
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Licence

ruby-xes is free software distributed under MIT licence.

## Links

* [XES](http://www.xes-standard.org/start)
* [PIONE project homepage](http://pione.github.io/)
    * [repository on github](https://github.com/pione/pione)
