require "rails_helper"

RSpec.describe Vehicle do
  describe "associations" do
    it { should belong_to(:organization).class_name('Organization') }
  end
end