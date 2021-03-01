# frozen_string_literal: true

require 'test_helper'

class UserGistDeversionJobTest < ActiveJob::TestCase
  test 'does not effect already deversioned gist' do
    user = users(:with_deversioned_gist)
    original_url = user.custom_css
    UserGistDeversionJob.perform_now(user.id)
    assert_equal original_url, user.reload.custom_css
  end

  test 'removes versioned part of gist URL' do
    user = users(:with_gist)
    original_url = user.custom_css
    UserGistDeversionJob.perform_now(user.id)
    assert_not_equal original_url, user.reload.custom_css
    # This feels a bit hack-ish.  Accepting suggestions to do this better?
    assert_equal users(:with_deversioned_gist).custom_css, user.reload.custom_css
  end
end
