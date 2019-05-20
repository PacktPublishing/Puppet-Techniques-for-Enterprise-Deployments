require 'rubygems'
require 'json'
require 'net/http'
require 'uri'

puppetdb_report_endpoint = "http://localhost:8080/pdb/query/v4/reports"
puppetdb_uri = URI.parse(puppetdb_report_endpoint)

puppetdb_reports = Net::HTTP.get_response(puppetdb_uri)
puppetdb_reports_json = JSON.parse(puppetdb_reports.body)

puts puppetdb_reports_json
