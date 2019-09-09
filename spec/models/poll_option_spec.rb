require "rails_helper"

RSpec.describe PollOption, type: :model do
  fixtures :articles, :polls
  let(:article) { articles(:article) }
  let(:poll) { polls(:poll) }

  it "allows up to 128 markdown characters" do
    poll_option = PollOption.create(markdown: "0" * 30, poll_id: poll.id)
    expect(poll_option).to be_valid
  end
  it "disallows over 128 markdown characters" do
    poll_option = PollOption.create(markdown: "0" * 200, poll_id: poll.id)
    expect(poll_option).not_to be_valid
  end
end
