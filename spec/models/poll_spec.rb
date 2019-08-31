require "rails_helper"

RSpec.describe Poll, type: :model do
  fixtures :articles, :polls
  let(:article) {
    obj = articles(:article)
    obj.featured = true
    obj
  }
  let(:poll) { polls(:poll) }

  it "limits length of prompt" do
    long_string = "0" * 200
    poll.prompt_markdown = long_string
    expect(poll).not_to be_valid
  end

  it "creates options from input" do
    # F2F: This spec should `after_create`
    poll = create(:poll, article_id: article.id, poll_options_input_array: %w[hello goodbye heyheyhey])
    expect(poll.poll_options.size).to eq(3)
  end
end
