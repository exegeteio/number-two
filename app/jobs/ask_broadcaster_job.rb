class AskBroadcasterJob < ApplicationJob
  include CableReady::Broadcaster
  queue_as :default

  def perform(ask)
    cable_ready["ask_messages_#{ask.channel}"].remove(
      selector: "#ask-#{ask.id}"
    )
    cable_ready["ask_messages_#{ask.channel}"].insert_adjacent_html(
      selector: '#ask_list',
      html: renderer.render(AskComponent.new(ask: ask))
    )
    cable_ready.broadcast
  end
end
