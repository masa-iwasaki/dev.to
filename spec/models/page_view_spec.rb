require "rails_helper"

RSpec.describe PageView, type: :model do
  let(:article) { create(:article) }

  it { is_expected.to belong_to(:user).optional }
  it { is_expected.to belong_to(:article) }

  describe "#domain" do
    it "is automatically set when a new page view is created" do
      # F2F: Reloading page_view triggers updating Algolia search index
      #      and it requires an associated article.
      pv = create(:page_view, referrer: "http://example.com/page")
      expect(pv.reload.domain).to eq("example.com")
    end
  end

  describe "#path" do
    it "is automatically set when a new page view is created" do
      # F2F: Reloading page_view triggers updating Algolia search index
      #      and it requires an associated article.
      pv = create(:page_view, referrer: "http://example.com/page")
      expect(pv.reload.path).to eq("/page")
    end
  end
end
