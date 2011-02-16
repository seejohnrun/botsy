# Botsy.

Botsy is a Campfire chat bot similar to [evilbot](https://github.com/defunkt/evilbot) but a bit more generic and written in Ruby.  I love the idea, so I made my own to report coffee times in our chat room.

---

## Usage

    # respond to simple things
    Botsy::Bot.new(subdomain, token, room_id) do
      hear(/john/) do
        say 'who said my name?'
      end
    end

    # always have someone to have your back
    Botsy::Bot.new(subdomain, token, room_id) do
      hear(/^i love/i) do |data|
        say "#{data[:body]} too!"
      end
    end

    # have somone to share with
    Botsy::Bot.new(subdomain, token, room_id) do
      hear(/^botsy you are so (.+)/) do |data, mdata|
        say "i think you are #{mdata[1]} too"
      end
    end

## What is 'data'

    data[:room_id] # the room the message is from
    data[:created_at] # a string representation of the date the message was sent
    data[:body] # the body of the message that matched
    data[:id] # a unique id for this message
    data[:user_id] # the user id of the person who sent the message
    data[:type] # the type of message: TextMessage, SoundMessage, PasteMessage, etc

---

That's all there is to it!
