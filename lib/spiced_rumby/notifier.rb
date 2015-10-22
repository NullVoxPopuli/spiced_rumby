module SpicedRumby
  # Inherit from base to obtain singletonness
  #
  # Meshchat uses singletons for notifications, because an OS
  # generally only has one notification system
  class Notifier < MeshChat::Notifier::Base

    # this is the only method that needs to be overwritten
    def show(*args)
      libnotify_message.update(*args) do |notify|
        yield(notify) if block_given?
      end
    end

    private

    def icon_path
      unless @icon_path
        relative_path = 'vendor/icons/ic_chat_bubble_black_24dp.png'
        current_directory = Dir.pwd # should be the gem root
        @icon_path = current_directory + '/' + relative_path
      end

      @icon_path
    end

    def libnotify_message()
      @message ||= Libnotify.new do |notify|
        notify.summary    = MeshChat::NAME
        notify.body       = ""
        notify.timeout    = 1.5         # 1.5 (s), 1000 (ms), "2", nil, false
        notify.urgency    = :normal   # :low, :normal, :critical
        notify.append     = false       # default true - append onto existing notification
        notify.transient  = false        # default false - keep the notifications around after display
        # TODO: this will vary on each system - maybe package icons
        # with the gem
        notify.icon_path  = icon_path
      end

      @message
    end
  end
end
