require "spec_helper"

describe User do
  before :each do
    visit "/login"
  end

  describe ".signin" do
    let(:user) { create(:user) }

    context "valid credentials" do
      before :each do
        within(page.all('form')[0]) do
          fill_in "user_email", :with => user.email
          fill_in "user_password", :with => "password"
        end
        page.all("input[type=submit][value='Sign In']")[0].click
      end

      it "signs a user in" do
        expect(page).to have_content "Logout"
      end
    end

    context "invalid credentials" do
      before :each do
        within(page.all('form')[0]) do
          fill_in "user_email", :with => user.email
          fill_in "user_password", :with => "incorrect password"
        end
        page.all("input[type=submit][value='Sign In']")[0].click
      end

      it "deoesn't sign a user in" do
        expect(page).to have_content "Unable to sign in"
      end
    end
  end

  describe ".logout" do
    let(:user) { create(:user) }

    before :each do
      within(page.all('form')[0]) do
        fill_in "user_email", :with => user.email
        fill_in "user_password", :with => "password"
      end
      page.all("input[type=submit][value='Sign In']")[0].click

      click_link "Logout"
    end

    it "logs a user out" do
      expect(current_path).to eq("/login")
    end
  end

  describe ".signup" do
    context "valid user" do
      before :each do
        within(page.all('form')[1]) do
          fill_in "user_first_name", :with => "Tom"
          fill_in "user_last_name", :with => "Prats"
          fill_in "user_email", :with => "tom@tomprats.com"
          fill_in "user_password", :with => "password"
          fill_in "user_password_confirmation", :with => "password"
        end
        page.all("input[type=submit][value='Sign Up']")[0].click
      end

      it "signs a user up" do
        expect(page).to have_content "Logout"
      end
    end

    context "duplicate user" do
      before :each do
        create(:user, email: "tom@tomprats.com")

        within(page.all('form')[1]) do
          fill_in "user_first_name", :with => "Tom"
          fill_in "user_last_name", :with => "Prats"
          fill_in "user_email", :with => "tom@tomprats.com"
          fill_in "user_password", :with => "password"
          fill_in "user_password_confirmation", :with => "password"
        end
        page.all("input[type=submit][value='Sign Up']")[0].click
      end

      it "doesn't sign a user up" do
        expect(page).to have_content "Unable to sign up"
      end
    end

    context "different passwords" do
      before :each do
        within(page.all('form')[1]) do
          fill_in "user_first_name", :with => "Tom"
          fill_in "user_last_name", :with => "Prats"
          fill_in "user_email", :with => "tom@tomprats.com"
          fill_in "user_password", :with => "password"
          fill_in "user_password_confirmation", :with => "other password"
        end
        page.all("input[type=submit][value='Sign Up']")[0].click
      end

      it "doesn't sign a user up" do
        expect(page).to have_content "Passwords don't match"
      end
    end
  end
end
