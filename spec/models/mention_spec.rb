require "rails_helper"

RSpec.describe Mention, type: :model do
  fixtures :users, :articles, :comments, :mentions

  let(:user) { users(:user) }
  let(:article) { articles(:article) }
  let(:comment) { comments(:comment) }

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
