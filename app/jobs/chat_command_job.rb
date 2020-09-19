# Job for translating a chat command to a TwitchCommand call
# TwitchCommand call can then broadcast via ActionCAble
# whatever response is needed.
class ChatCommandJob < ApplicationJob
  queue_as :default

  def perform(args)
    args.transform_keys! { |k| k.underscore.to_sym }
    TwitchCommands.call(command: args[:command], locals: args)
  end
end
