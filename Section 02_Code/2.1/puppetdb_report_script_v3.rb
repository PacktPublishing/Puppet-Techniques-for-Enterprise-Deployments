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

puppet_report_csv_file = File.open("puppet_report.csv", "w")
puppet_report_csv_file.write("Node Name,Time received,Status,Total resources\n")

puppet_report_html_file = File.open("puppet_report.html", "w")
puppet_report_html_file.write("<html><body>\n")
puppet_report_html_file.write("<table border=1><tr><th>Node Name</th><th>Time received</th><th>Status</th><th>Total resources</th></tr>\n")

puppetdb_reports_json.each do |report|
  total_resources = report['metrics']['data'].find {|details| details['category']=='resources' and details['name']=='total'}['value']
  puppet_data = "#{report['certname']},#{report['receive_time']},#{report['status']},#{total_resources}\n"
  puppet_report_csv_file.write(puppet_data)
  puppet_report_html_file.write("<tr><th>#{report['certname']}</th><th>#{report['receive_time']}</th><th>#{report['status']}</th><th>#{total_resources}</th></tr>\n")
end

puppet_report_html_file.write("</table></body></html>\n")

puppet_report_csv_file.close
puppet_report_html_file.close
