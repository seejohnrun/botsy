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

That's all there is to it!
