# frozen_string_literal: true

require 'uri'

# Removes the version from a gist URL:
# https://gist.githubusercontent.com/exegeteio/d5b60958ee4615e839354a6ee2ead5c7/raw/b2aab565424a5f0aefe810f6b3dafaef01f6f8e3/number-two.css
# Becomes...
# https://gist.githubusercontent.com/exegeteio/d5b60958ee4615e839354a6ee2ead5c7/raw/number-two.css
class UserGistDeversionJob < ApplicationJob
  queue_as :default

  @@gist_urls = %w[
    gist.githubusercontent.com
  ]

  def perform(user_id)
    user = User.find(user_id)
    user.custom_css = deversion_gist_url(user.custom_css)
    user.save if user.changed?
  end

  private

  def deversion_gist_url(url)
    uri = URI.parse(url)
    return url unless @@gist_urls.include? uri.host

    (_, username, gist_id, raw, _gist_version, gist_filename) = uri.path.split('/')
    return url unless gist_filename.present?

    ["https://#{uri.host}", username, gist_id, raw, gist_filename].join('/')
  end
end
