# frozen_string_literal: true

# Class for processing twitch messages.
class TwitchMessage
  def self.avatar_for(username)
    Rails.cache.fetch("avatar/#{username}", expires_in: 12.hours) do
      Rails.logger.debug "Cache miss for #{username}."
      $TWITCH.get_users(login: username).data.first.profile_image_url
    end
  end

  def self.process_emotes(message, emotes)
    return sanitize(message) unless emotes.present?

    subsitutions = emote_substitutions(message, emotes)
    message = sanitize(message)
    subsitutions.each do |text, img|
      message.gsub!(text, img)
    end
    message
  end

  def self.emote_substitutions(message, emotes)
    substitutions = {}
    emotes.each do |emote_id, locations|
      locations.each do |loc|
        b, e = loc.split('-').collect(&:to_i)
        emote = message[b, (e - b + 1)]
        substitutions[emote] = emote_url(emote_id, emote)
      end
    end
    substitutions
  end

  def self.emote_url(emote_id, emote)
    "<img src='https://static-cdn.jtvnw.net/emoticons/v2/#{emote_id}/default/dark/2.0' title='#{emote}' />".html_safe
  end

  def self.sanitize(str)
    @sanitizer ||= Rails::Html::FullSanitizer.new
    @sanitizer.sanitize(str)
  end
end
