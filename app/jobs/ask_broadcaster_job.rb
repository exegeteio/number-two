class AskBroadcasterJob < ApplicationJob
  include CableReady::Broadcaster
  queue_as :default

  def perform(ask)
    cable_ready["ask_messages_#{ask.channel}"].morph(
      selector: '#ask_list',
      children_only: true,
      html: renderer.render(AskComponent.with_collection(Ask.pending.where(channel: ask.channel)))
    )
    cable_ready["current_ask_#{ask.channel}"].inner_html(
      selector: '#ask_overlay',
      html: if Ask.active.present?
              renderer.render(AskMessageComponent.new(ask: Ask.active.first))
            end
    )
    cable_ready.broadcast
  end
end
