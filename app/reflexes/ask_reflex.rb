# frozen_string_literal: true

# Class for reacting to changes in the Ask box.
class AskReflex < ApplicationReflex
  before_reflex :set_ask
  after_reflex :update_asks

  def promote
    Ask.where(status: :active, channel: @ask.channel.downcase).update(status: :pending)
    @ask.active!
    cable_ready["current_ask_#{@ask.channel.downcase}"].inner_html(
      selector: '#ask_overlay',
      html: render(AskMessageComponent.new(ask: @ask))
    )
    cable_ready.broadcast
  end

  def recall
    @ask.pending!
    clear_overlay
  end

  def complete
    @ask.deleted!
    clear_overlay
  end

  def delete
    @ask.deleted!
  end

  private

  def clear_overlay
    cable_ready["current_ask_#{@ask.channel}"].inner_html(
      selector: '#ask_overlay',
      html: ''
    )
    cable_ready.broadcast
  end

  def update_asks
    morph '#ask_list', render(
      AskComponent.with_collection(Ask.pending.where(channel: @ask.channel.downcase))
    )
    cable_ready.broadcast
  end

  def set_ask
    @ask = Ask.find_by!(
      id: element['data-id'],
      channel: current_user.username
    )
  end
end
