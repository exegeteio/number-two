class ChatMessageJob < ApplicationJob
  queue_as :default

  BANNED_USERS = %w[pretzelrocks nightbot b3_bot].freeze

  def perform(args)
    args['avatar'] = avatar_for args['user']
    unless BANNED_USERS.include? args['user'].downcase
      ActionCable.server.broadcast(
        "chat_overlay_messages_#{args['channel']}",
        render(args)
      )
    end
  end

  private

  def avatar_for(username)
    Rails.cache.fetch("avatar/#{username}", expires_in: 12.hours) do
      Rails.logger.debug "Cache miss for #{username}."
      $TWITCH.get_users(login: username).data[0].profile_image_url
    end
  end

  def render(args)
    ApplicationController.new.render_to_string(
      partial: 'messages/chat',
      locals: get_locals(args)
    )
  end

  def get_locals(args)
    {
      id: args['id'],
      avatar: args['avatar'],
      highlighted: args['highlighted'],
      message: process_emotes(args['message'], args['messageEmotes']),
      user_color: args['userColor'],
      user: args['user']
    }
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
