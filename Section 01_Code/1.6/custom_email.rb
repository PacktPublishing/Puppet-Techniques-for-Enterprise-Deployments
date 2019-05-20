require 'puppet'
require 'net/smtp'

Puppet::Reports.register_report(:custom_email) do
  desc "Send all received logs to the configured custom email address"

  def process
    email_config_file = File.join([File.dirname(Puppet.settings[:config]),'report_email_settings.yaml'])
    email_config = YAML.load_file(email_config_file)
    report = self.to_yaml

    mail_body = "To: #{email_config['to_name']} <#{email_config['to_address']}>\nFrom: #{email_config['from_name']} <#{email_config['from_address']}>\nSubject: Puppet run report for #{self.host}\n\nPuppet run result for node #{self.host}:\n\nStatus : #{self.status}\nRun type : #{self.kind}\n\nLogs :\n\n#{report}"

    smtp = Net::SMTP.new email_config['smtp_server'], 587
        smtp.enable_starttls
        smtp.start(email_config['smtp_domain'], email_config['smtp_username'], email_config['smtp_password'], :plain) do
        smtp.send_message(mail_body, email_config['from_address'], email_config['to_address'])
    end
  end
end
