require "rails_helper"

RSpec.describe DisplayAd, type: :model do
  fixtures :organizations, :display_ads
  let(:display_ad) { display_ads(:display_ad) }
  let(:organization) { organizations(:organization) }

  it { is_expected.to validate_presence_of(:organization_id) }
  it { is_expected.to validate_presence_of(:placement_area) }
  it { is_expected.to validate_presence_of(:body_markdown) }

  it "generates processed_html before save" do
    display_ad.save!
    expect(display_ad.processed_html).to eq("Hello <em>hey</em> Hey hey")
  end
  it "only disallows unacceptable placement_area" do
    display_ad.placement_area = "tsdsdsdds"
    expect(display_ad).not_to be_valid
  end
  it "allows sidebar_right" do
    display_ad.placement_area = "sidebar_right"
    expect(display_ad).to be_valid
  end
  it "allows sidebar_left" do
    display_ad.placement_area = "sidebar_left"
    expect(display_ad).to be_valid
  end
end
