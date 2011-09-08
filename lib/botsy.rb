require 'bundler/setup'
require 'net/https'
require 'json'
require 'yajl/http_stream'

module Botsy

  class Bot

    def self.fork(*args, &block)
      Kernel.fork { self.new(*args, &block) }
    end

    def initialize(subdomain, token, room_id, &block)
      @subdomain = subdomain
      @room_id = room_id
      @token = token
      @regexes = {}
      load_info
      join_room
      ascertain_meaning(&block)
      start_listening_forever
    end

    # Register a responder via a regex that will be evaluated on the body
    def hear(regex, &block)
      @regexes[regex] ||= []
      @regexes[regex] << block
    end

    # Submit an HTTPS request with the JSON content to the speak path
    def say(thing, type = 'TextMessage')
      request = Net::HTTP::Post.new("/room/#{@room_id}/speak.json", 'Content-Type' => 'application/json')
      request.body = "{\"message\":{\"type\":\"#{type}\",\"body\":\"#{thing}\"}}"
      request.basic_auth @token, 'x' 
      http = Net::HTTP.new("#{@subdomain}.campfirenow.com", 443)
      http.use_ssl = true
      http.request(request)
    end

    private

    def load_info
      request = Net::HTTP::Get.new('/users/me.json')
      request.basic_auth @token, 'x'
      http = Net::HTTP.new("#{@subdomain}.campfirenow.com", 443)
      http.use_ssl = true
      if data = http.request(request).body
        @me_info = Yajl::Parser::parse(data)['user']
      end
    end

    def join_room
      request = Net::HTTP::Post.new("/room/#{@room_id}/join.json")
      request.basic_auth @token, 'x'
      http = Net::HTTP.new("#{@subdomain}.campfirenow.com", 443)
      http.use_ssl = true
      http.request(request)
    end

    def ascertain_meaning(&block)
      instance_eval &block
    end

    def start_listening_forever
      while true # foreva means foreva bro
        start_listening_in
      end
    end

    def start_listening_in
      puts 'Botsy is putting his ear to the ground...'
      http = Net::HTTP.new('streaming.campfirenow.com', 443)
      http.use_ssl = true

      uri = URI.parse("http://#{@token}:x@streaming.campfirenow.com/room/#{@room_id}/live.json")
      item = nil
      Yajl::HttpStream.get(uri, :symbolize_keys => true) do |item|
        handle_item item
      end
    end

    def handle_item(item)
      return unless item[:body].is_a?(String) # skip empties for now
      return if @me_info && item[:user_id] == @me_info['id'] # don't repeat yourself, botsy
      @regexes.each do |regex, do_this|
        if mdata = item[:body].strip.match(regex)
          do_this.each { |d| d.call(item, mdata) }
        end
      end
    end

  end

end
