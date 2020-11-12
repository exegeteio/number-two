# Class for rendering and rebroadcasting chat.
class ChatMessageJob < ApplicationJob
  queue_as :default

  BANNED_USERS = %w[pretzelrocks nightbot b3_bot].freeze

  def perform(id, channel, message, message_emotes, username, user_color)
    return if BANNED_USERS.include? username.downcase

    ChatBroadcasterJob.perform_later(
      channel,
      renderer.render(
        ChatMessageComponent.new(
          id: id,
          message: process_emotes(message, message_emotes),
          user: username,
          avatar_url: avatar_for(username),
          user_color: user_color
        )
      )
    )

  end

  private

  def avatar_for(username)
    Rails.cache.fetch("avatar/#{username}", expires_in: 12.hours) do
      Rails.logger.debug "Cache miss for #{username}."
      $TWITCH.get_users(login: username).data.first.profile_image_url
    end
  end

  def process_emotes(message, emotes)
    substitutions = {}
    return message unless emotes.present?

    emotes.each do |emote_id, locations|
      locations.each do |loc|
        b, e = loc.split('-').collect(&:to_i)
        emote = message[b, (e - b + 1)]
        substitutions[emote] = emote_url(emote_id, emote)
      end
    end

    substitutions.each do |text, img|
      message.gsub!(text, img)
    end
    message
  end

  def emote_url(emote_id, emote)
    "<img src='https://static-cdn.jtvnw.net/emoticons/v2/#{emote_id}/default/dark/2.0' title='#{emote}' />".html_safe
  end
end
