require "spec_helper"

describe Gallery do
  context "artist signed in" do
    let(:gallery) { create(:gallery, private: false) }

    before :each do
      gallery
      visit galleries_path
    end

    describe ".index" do
      it "shows the galleries" do
        expect(page).to have_content(gallery.title)
      end
    end

    describe ".show" do
      before :each do
        click_link "View"
      end

      it "show the gallery" do
        expect(page).to have_content(gallery.description)
      end
    end
  end


  context "artist signed in" do
    let(:user) { create(:user, artist: true) }

    before :each do
      visit "/login"

      within(page.all('form')[0]) do
        fill_in "user_email", :with => user.email
        fill_in "user_password", :with => "password"
      end
      page.all("input[type=submit][value='Sign In']")[0].click
    end

    describe ".new + .create" do
      before :each do
        click_link "New"

        within(page.all('form')[0]) do
          fill_in "gallery_title", :with => "Gal"
          fill_in "gallery_description", :with => "Desc"
        end
        page.all("input[type=submit][value='Save']")[0].click
      end

      it "creates a gallery" do
        expect(page).to have_content("Gallery created, but is still private!")
      end
    end

    describe ".edit + .update" do
      let(:gallery) { create(:gallery, artist: user) }

      before :each do
        gallery
        click_link "Edit Galleries"
        click_link "Edit"

        within(page.all('form')[0]) do
          fill_in "gallery_title", :with => "Gallery"
          fill_in "gallery_description", :with => "Description"
        end
        page.all("input[type=submit][value='Save']")[0].click
      end

      it "updates a gallery" do
        expect(page).to have_content("Gallery updated")
      end
    end

    describe ".publish" do
      let(:gallery) { create(:gallery, artist: user) }

      before :each do
        gallery
        click_link "Edit Galleries"
        click_link "Publish"
      end

      it "publishes a gallery" do
        expect(page).to have_content("Gallery published")
      end
    end

    describe ".unpublish" do
      let(:gallery) { create(:gallery, artist: user, private: false) }

      before :each do
        gallery
        click_link "Edit Galleries"
        click_link "Unpublish"
      end

      it "unpublishes a gallery" do
        expect(page).to have_content("Gallery unpublished")
      end
    end

    describe ".destroy" do
      let(:gallery) { create(:gallery, artist: user) }

      before :each do
        gallery
        click_link "Edit Galleries"
        click_link "Delete"
      end

      it "deletes a gallery" do
        expect(page).to have_content("Gallery destroyed")
      end
    end
  end
end
