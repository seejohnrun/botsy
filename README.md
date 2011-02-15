# Botsy.

Botsy is a Campfire chat bot similar to [evilbot](https://github.com/defunkt/evilbot) but a bit more generic and written in Ruby.  I love the idea, so I made my own to report coffee times in our chat room.

---

## Usage

    Botsy::Bot.new(subdomain, token, room_id) do
      hear(/john/) do
        say 'who said my name?'
      end
    end

That's all there is to it!
