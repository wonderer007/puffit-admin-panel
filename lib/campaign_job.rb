require 'xmpp4r'

class CampaignJob < Struct.new(:campaign_id)

  def perform

    campaign = Campaign.find(campaign_id)

    if campaign.message.messageable.class.name != "Text"
      campaign.status = true
      campaign.end_time = Time.now()
      campaign.save
      return
    end

    Delayed::Worker.logger.debug("start campaign for #{campaign.name}")
    Delayed::Worker.logger.debug("username => #{ENV['XMPP_USER_NAME']}")

    props = REXML::Element.new("properties")
    props.add_attribute("xmlns", "http://www.jivesoftware.com/xmlns/xmpp/properties")

    name  = REXML::Element.new("name").add_text("name")
    value = REXML::Element.new("value").add_text("haider")
    value.add_attribute("type", "string")
    prop = REXML::Element.new("property")
    prop.add_element(name)
    prop.add_element(value)
    props.add_element(prop)

    name  = REXML::Element.new("name").add_text("primaryId")
    value = REXML::Element.new("value").add_text("45")
    value.add_attribute("type", "string")
    prop = REXML::Element.new("property")
    prop.add_element(name)
    prop.add_element(value)
    props.add_element(prop)

    name  = REXML::Element.new("name").add_text("type")
    value = REXML::Element.new("value").add_text("text")
    value.add_attribute("type", "string")
    prop = REXML::Element.new("property")
    prop.add_element(name)
    prop.add_element(value)
    props.add_element(prop)




    jid = Jabber::JID.new('ruby@212.100.239.153/dailynews')
    @client = Jabber::Client.new(jid)
    @client.connect
    @client.auth('12345678')


    followers = User.last.followers

    followers.each do |follower|

      to_jid = Jabber::JID.new("#{follower}@212.100.239.153")
      message = Jabber::Message::new(to_jid, campaign.message.messageable.msg).set_type(:chat).set_id(Random.rand(1..1000))
      message.to_s
      message.add_element(props)
      Delayed::Worker.logger.debug("#{message.to_s}")
      @client.send(message)
      campaign.delivery_reports.new(phone_number: follower, status: true)
      Delayed::Worker.logger.debug("Message sent to #{to_jid}")

    end

    Delayed::Worker.logger.debug("#{campaign.name} successfully completed")
    campaign.status = true
    campaign.end_time = Time.now()
    campaign.save
  end

end