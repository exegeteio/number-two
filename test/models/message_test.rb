# == Schema Information
#
# Table name: messages
#
#  id            :bigint           not null, primary key
#  channel       :string
#  content       :string
#  from_username :string
#  kind          :integer
#  status        :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  # TODO:  Look up how other people test simple models.
  # Do I need to test validation?
  test 'Sanity test' do
    assert messages(:chat).chat?
  end
end
