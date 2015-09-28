module SpicedGracken
  module Display

    module_function

    # delegate :start, :add_line,
    #   :info, :warning, :alert, :success, :chat, :whisper,
    #   :present_message, to: :current

    # TODO: Delegate doesn't work on modules?
    def start(*args); current.start(*args); end
    def add_line(*args); current.add_line(*args); end
    def info(*args); current.info(*args); end
    def warning(*args); current.warning(*args); end
    def alert(*args); current.alert(*args); end
    def success(*args); current.success(*args); end
    def chat(*args); current.chat(*args); end
    def whisper(*args); current.whisper(*args); end
    def present_message(*args); current.present_message(*args); end

    # TODO: break these out in to their own Logger class, and not
    # on the display object
    def fatal(*args); current.fatal(*args); end
    def debug(*args); current.debug(*args); end
    def error(*args); current.error(*args); end




    def current
      SpicedGracken.ui
    end

  end
end
