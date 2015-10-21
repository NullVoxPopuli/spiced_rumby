module SpicedGracken
  module Notifier
    # This is the default notification implementation
    # - Uses Libnotify
    #
    #
    # Only use one notification and update continuously, so that
    # the notification area / tray doesn't become flooded by this app
    #
    # To write your own notifier, just override the show method in a
    # subclass of this class
    class Base

      # Notifier::Base is a singleton
      # Not all Notifiers need to be singletons,
      # but it doesn't really make sense to have more than one
      class << self
        delegate :show, to: :instance

        def instance
          @instance ||= new
        end
      end

      def show(*args)
        libnotify_message.update(*args) do |notify|
          yield(notify) if block_given?
        end
      end

      private

      def libnotify_message()
        @message ||= Libnotify.new do |notify|
          notify.summary    = SpicedGracken::NAME
          notify.body       = ""
          notify.timeout    = 1.5         # 1.5 (s), 1000 (ms), "2", nil, false
          notify.urgency    = :normal   # :low, :normal, :critical
          notify.append     = false       # default true - append onto existing notification
          notify.transient  = false        # default false - keep the notifications around after display
          # TODO: this will vary on each system - maybe package icons
          # with the gem
          notify.icon_path  = "/usr/share/icons/gnome/scalable/emblems/emblem-default.svg"
        end

        @message
      end
    end
  end
end
