require 'rubygems'
require 'bundler'

Bundler.require

MARATHON_DOMAIN = ENV['MARATHON_DOMAIN']
PORT_RANGE_FROM = ENV['PORT_RANGE_FROM'].to_i
PORT_RANGE_TO = ENV['PORT_RANGE_TO'].to_i
PORT_RANGE = PORT_RANGE_FROM...PORT_RANGE_TO

def owner(detail)
  if detail[:owner]
    if detail[:team]
      "#{detail[:owner]}@#{detail[:team]}"
    else
      detail[:owner]
    end
  else
    if detail[:team]
      "@#{detail[:team]}"
    end
  end
end

def ports
  arr_ports = []
  hash_ports = {}
  apps_json = RestClient.get("http://#{MARATHON_DOMAIN}/v2/apps")
  apps = JSON.parse(apps_json)['apps']
  apps.each do |app|
    (app['container']['docker']['portMappings'] || []).each do |m|
      port = m['servicePort']
      arr_ports[port] ||= []
      item = {
        id: app['id'],
        team: (app['labels'] || {})['team'],
        owner: (app['labels'] || {})['owner'],
      }
      item[:display_owner] = owner(item)
      arr_ports[port] << item
    end
  end

  PORT_RANGE.each do |p|
    hash_ports[p] = arr_ports[p]
  end

  hash_ports
end

set :views, settings.root + '/views'

get '/' do
  @ports = ports
  haml :index
end

get '/zz/health' do
  'OK'
end
