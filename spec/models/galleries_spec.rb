require "spec_helper"

describe Gallery do
  let(:gallery) { create(:gallery, title: "Private") }
  let(:public_gallery) { create(:gallery, title: "Public", private: false) }

  describe ".private" do
    before :each do
      gallery
      public_gallery
    end

    it "returns the private albums" do
      expect(Gallery.private.count).to eq(1)
      expect(Gallery.private).to eq([gallery])
    end
  end

  describe ".public" do
    before :each do
      gallery
      public_gallery
    end

    it "returns the public albums" do
      expect(Gallery.public.count).to eq(1)
      expect(Gallery.public).to eq([public_gallery])
    end
  end

  describe ".private?" do
    it "returns whether the gallery is private" do
      expect(gallery.private?).to be_true
      expect(public_gallery.private?).to be_false
    end
  end

  describe ".public?" do
    it "returns whether the gallery is public" do
      expect(public_gallery.public?).to be_true
      expect(gallery.public?).to be_false
    end
  end

  describe ".cover" do
    context "with cover" do
      let(:gallery) { create(:gallery) }
      let(:cover) { create(:painting, gallery: gallery) }

      before :each do
        gallery.cover = cover
      end

      it "returns the gallery's cover" do
        expect(gallery.cover).to eq(cover)
      end
    end

    context "without cover" do
      let(:gallery) { create(:gallery) }
      let(:cover) { create(:painting, gallery: gallery) }

      before :each do
        cover
      end

      it "returns the gallery's cover" do
        expect(gallery.cover).to eq(cover)
      end
    end
  end
end
