# Marathon Service Ports Usage UI

this is a webserver that render a marathon service ports usage table to user.

## Usage

```bash
$ git clone git@github.com:agate/marathon-service-ports-usage-ui.git
$ cd marathon-service-ports-usage-ui
$ bundle install
$ env MARATHON_DOMAIN=your.marathon.domain \
      PORT_RANGE_FROM=10000 \
      PORT_RANGE_TO=20000 \
      bundle exec ruby main.rb
```
