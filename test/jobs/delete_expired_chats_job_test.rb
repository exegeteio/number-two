require 'test_helper'

class DeleteExpiredChatsJobTest < ActiveJob::TestCase
  test 'deletes all expired Messages' do
    chat = messages(:chat)
    chat.touch
    travel Message.chat_timeout + 1.second
    DeleteExpiredChatsJob.perform_now
    assert_not_includes Message.all.pluck(:id), chat.id
  end
end
