require "rails_helper"

RSpec.describe Collection, type: :model do
  fixtures :collections
  let(:collection) { collections(:collection) }

  describe "when a single article in collection is updated" do
    it "touches all articles in the collection" do
      random_article = collection.articles.sample
      expect { random_article.touch }.to(change { collection.articles.map(&:updated_at) })
    end
  end
end
