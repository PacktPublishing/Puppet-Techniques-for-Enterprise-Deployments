require 'rubygems'
require 'json'
require 'net/http'
require 'uri'

puppetdb_report_endpoint = "http://localhost:8080/pdb/query/v4/reports"
puppetdb_uri = URI.parse(puppetdb_report_endpoint)

puppetdb_query = {:query => '["~", "certname",' + '"' "\.local" + '"' ']'}
puppetdb_uri.query = URI.encode_www_form(puppetdb_query)

puppetdb_reports = Net::HTTP.get_response(puppetdb_uri)
puppetdb_reports_json = JSON.parse(puppetdb_reports.body)

puppetdb_reports_json.each do |report|
  total_resources = report['metrics']['data'].find {|details| details['category']=='resources' and details['name']=='total'}['value']
  puppet_data = "#{report['certname']},#{report['receive_time']},#{report['status']},#{total_resources}\n"
  puts puppet_data
end
