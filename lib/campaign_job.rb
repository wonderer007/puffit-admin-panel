require 'xmpp4r'

class CampaignJob < Struct.new(:campaign_id)

  def perform



    campaign = Campaign.find(campaign_id)

    if campaign.message.messageable.class.name != "Text"
      return
    end

    Delayed::Worker.logger.debug("start campaign for #{campaign.name}")
    Delayed::Worker.logger.debug("username => #{ENV['XMPP_USER_NAME']}")

    jid = Jabber::JID.new('ruby@212.100.239.153/dailynews')
    @client = Jabber::Client.new(jid)
    @client.connect
    @client.auth('12345678')


    followers = User.last.followers
    followers.each do |follower|

      to_jid = Jabber::JID.new("#{follower}@212.100.239.153")
      message = Jabber::Message::new(to_jid, campaign.message.messageable.msg).set_type(:chat).set_id(Random.rand(1..1000))
      @client.send(message)

      Delayed::Worker.logger.debug("Message sent to #{to_jid}")

    end


    Delayed::Worker.logger.debug("#{campaign.name} successfully completed")
    campaign.status = true
    campaign.save
  end

end