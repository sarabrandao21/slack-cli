require_relative "recipient"
require "dotenv"
Dotenv.load 



module SlackApp
  class Channel < Recipient
    
    
    
    attr_reader :topic, :member_count
    def initialize(slack_id, name, topic, member_count)
      super(slack_id, name)
      @topic = topic 
      @member_count = member_count
    end 
    
    def details
      tp self, "slack_id", "name", "topic", "member_count"
    end
    
    def self.list_all
      response =  SlackApp::Channel.get("https://slack.com/api/conversations.list")
      channels = []
      response["channels"].each do |channel|
        channels << self.new(
          channel["id"], 
          channel["name"], 
          channel["topic"]["value"], 
          channel["num_members"]
        )
      end 
      return channels 
    end 
  end 
end 
  
  