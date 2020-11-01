module ApplicationCable
  class Channel < ActionCable::Channel::Base
    private

    def broadcast_to?(channel)
      if connection.current_user.username == channel
        true
      else
        Rails.logger.warn(
          "[#{self.class}] Unable to verify channel #{channel} for user #{connection.current_user.username}"
        )
        false
      end
    end
  end
end
