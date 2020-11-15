# frozen_string_literal: true

module ApplicationCable
  class Connection < ActionCable::Connection::Base
    attr_accessor :current_user

    def connect
      self.current_user = find_verified_user
    end

    private

    def find_verified_user
      User.find_by(username: cookies.encrypted[:username]) || nil
    end
  end
end
