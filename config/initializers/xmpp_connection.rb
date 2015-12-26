require 'xmpp4r'

JID = Jabber::JID.new("#{ENV['XMPP_USER_NAME']}@#{ENV['XMPP_HOST']}/#{ENV['XMPP_RESOURCE']}")
@XMPP = Jabber::Client.new(JID)
@XMPP.connect
@XMPP.auth(ENV['XMPP_USER_PASSWORD'])