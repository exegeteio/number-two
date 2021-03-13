module ApplicationCable
  # Base class for connections over ActionCable.
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
      logger.add_tags 'ActionCable', current_user&.username
    end

    protected

    # this checks whether a user is authenticated with devise
    def find_verified_user
      env['warden'].user if env['warden'].user.present?
    end
  end
end
