require 'httparty'

module GHS
  class << self

    URL = 'https://status.github.com/api/'

    #
    # Returns the current system status (one of good, minor, or major) and timestamp.
    #
    def status
      get_json('status.json')
    end

    #
    # Returns the last human communication, status, and timestamp.
    #
    def last_message
      get_json('last-message.json')
    end

    #
    # Returns the most recent human communications with status and timestamp.
    #
    def messages
      get_json('messages.json')
    end

    private

    def get_json(path)
      HTTParty.get([URL, path].join).parsed_response
    end

  end
end