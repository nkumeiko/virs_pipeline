require "rails_helper"

RSpec.describe Vehicle do
  describe "associations" do
    it { should belong_to(:organisation).class_name('Organisation') }
  end
end