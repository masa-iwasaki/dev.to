require "rails_helper"

RSpec.describe HtmlVariant, type: :model do
  fixtures :html_variants
  let(:html_variant) {
    obj = html_variants(:html_variant)
    obj.approved = true
    obj.published = true
    obj.save!
    obj
  }

  it { is_expected.to validate_uniqueness_of(:name) }
  it { is_expected.to validate_presence_of(:html) }
  it { is_expected.to belong_to(:user).optional }

  it "calculates success rate" do
    HtmlVariantTrial.create!(html_variant_id: html_variant.id)
    HtmlVariantTrial.create!(html_variant_id: html_variant.id)
    HtmlVariantTrial.create!(html_variant_id: html_variant.id)
    HtmlVariantTrial.create!(html_variant_id: html_variant.id)
    HtmlVariantSuccess.create!(html_variant_id: html_variant.id)
    html_variant.calculate_success_rate!
    expect(html_variant.success_rate).to eq(0.025)
  end

  it "finds for test without tag" do
    html_variant.save!
    expect(HtmlVariant.find_for_test.id).to eq(html_variant.id)
  end
  it "finds for test with tag given" do
    html_variant.target_tag = "hello"
    html_variant.save!
    expect(HtmlVariant.find_for_test(["hello"]).id).to eq(html_variant.id)
  end
  it "does not find if different tag targeted" do
    html_variant.target_tag = "different_tag_yolo"
    html_variant.save!
    expect(HtmlVariant.find_for_test(["hello"])).to eq(nil)
  end
  it "finds if no tag targeted and tag given" do
    html_variant.save!
    expect(HtmlVariant.find_for_test(["hello"]).id).to eq(html_variant.id)
  end
  it "creates an html variant with img in it" do
    html_variant = html_variants(:html_variant)
    html_variant.approved = false
    html_variant.published = true
    html_variant.html = "<div><img src='https://devimages.com/image.jpg' /></div>"
    html_variant.save!
    expect(html_variant.html).to include("cloudinary")
  end
end
