# Job for translating a chat command to a TwitchCommand call
# TwitchCommand call can then broadcast via ActionCAble
# whatever response is needed.
class ChatCommandJob < ApplicationJob
  queue_as :default

  def perform(args, user)
    args.transform_keys! { |k| k.underscore.to_sym }
    TwitchCommands.call(command: args[:command], user: user, locals: args)
  end
end
