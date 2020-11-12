# frozen_string_literal: true

# Class for reacting to changes in the Ask box.
class AskReflex < ApplicationReflex
  before_reflex :set_ask

  def promote
    Ask.where(status: :active, channel: current_user.username).update(status: :pending)
    @ask.active!
  end

  def recall
    @ask.pending!
  end

  def complete
    @ask.deleted!
  end

  def delete
    @ask.deleted!
  end

  private

  def set_ask
    @ask = Ask.find_by!(
      id: element['data-id'],
      channel: current_user.username
    )
  end
end
