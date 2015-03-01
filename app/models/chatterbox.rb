###
# Chatterbox is an interface for talking to external chat services
###
class Chatterbox

  def self.tell(message)
    @chatterbox = Chatterbox.new
    @chatterbox.tell message
  end

  def tell(message)
    unless notifier.nil?
      message = message + " [#{Rails.env}]" unless Rails.env.production?
      notifier.ping message
    else
      Rails.logger.debug "Chatterbox notifier does not exist, message was not sent"
    end
  end

  def notifier
    @@notifier ||= Slack::Notifier.new ENV['SLACK_TEAM_NAME'], ENV['SLACK_WEBHOOK_TOKEN'] unless ['SLACK_TEAM_NAME'] && ENV['SLACK_WEBHOOK_TOKEN'].blank?
  end

end