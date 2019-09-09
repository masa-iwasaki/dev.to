require "rails_helper"

RSpec.describe Mention, type: :model do
  fixtures :users_for_mention_spec,
    :articles_for_mention_spec,
    :comments_for_mention_spec,
    :mentions_for_mention_spec

  let(:user) { users_for_mention_spec(:user) }
  let(:article) { articles_for_mention_spec(:article) }
  let(:comment) { comments_for_mention_spec(:comment) }

  it "calls on Mentions::CreateAllJob" do
    described_class.create_all(comment) do
      expect(Mentions::CreateAllJob).to have_received(:perform_later).with(comment.id, "Comment")
    end
  end

  it "creates a valid mention" do
    expect(create(:mention)).to be_valid
  end

  it "doesn't raise undefined method for NilClass on valid?" do
    expect(Mention.new.valid?).to eq(false)
  end
end
