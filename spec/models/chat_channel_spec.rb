require "rails_helper"

RSpec.describe ChatChannel, type: :model do
  fixtures :users, :chat_channels

  let(:chat_channel) { chat_channels(:chat_channel) }
  let(:message) { chat_channels(:chat_channel_1) }

  it { is_expected.to have_many(:messages) }
  it { is_expected.to validate_presence_of(:channel_type) }

  it "clears chat" do
    allow(Pusher).to receive(:trigger)
    chat_channel.clear_channel
    expect(chat_channel.messages.size).to eq(0)
  end

  it "creates channel with users" do
    chat_channel = ChatChannel.create_with_users([users(:user_1), users(:user_2)])
    expect(chat_channel.users.size).to eq(2)
    expect(chat_channel.has_member?(users(:user_1))).to eq(true)
  end

  it "lists active memberships" do
    chat_channel = ChatChannel.create_with_users([users(:user_1), users(:user_2)])
    expect(chat_channel.active_users.size).to eq(2)
    expect(chat_channel.channel_users.size).to eq(2)
  end

  it "decreases active users if one leaves" do
    chat_channel = ChatChannel.create_with_users([users(:user_1), users(:user_2)])
    ChatChannelMembership.last.update(status: "left_channel")
    expect(chat_channel.active_users.size).to eq(1)
    expect(chat_channel.channel_users.size).to eq(1)
  end
end
