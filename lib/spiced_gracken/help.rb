module SpicedGracken
  module Help
    module_function

    def welcome(texts: {})
      text = %Q{

Welcome to Rum!
to begin, set your username!
  /config set alias <username>

then, start listening for remote connection:
you may need to open port 80 (or whatever is configured) in your machine or router's firewall
  /listen


to begin chatting:
  /chat

current configuration:
  #{texts[:configuration]}
}
      return text
    end
  end
end
