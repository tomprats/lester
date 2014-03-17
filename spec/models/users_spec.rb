require "spec_helper"

describe User do
  let(:user) { create(:user) }

  describe ".name" do
    it "returns the user's name" do
      expect(user.name).to eq("#{user.first_name} #{user.last_name}")
    end
  end

  describe ".name?" do
    it "returns whether the user has a name" do
      expect(user.name?).to be_true
    end
  end

  describe ".admin?" do
    it "returns whether the user is an admin" do
      expect(user.admin?).to be_false
    end
  end
end
