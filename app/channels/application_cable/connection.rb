module ApplicationCable
  class Connection < ActionCable::Connection::Base
    attr_accessor :current_user

    def connect
      self.current_user = find_verified_user
    end

    private

    def find_verified_user
      if (verified_user = User.find_by(username: cookies.encrypted[:username]))
        verified_user
      else
        reject_unauthorized_connection
      end
    end
  end
end
