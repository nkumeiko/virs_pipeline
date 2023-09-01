require "rails_helper"

RSpec.describe TopFailingReportGenerator do 
  subject(:call) do
    described_class.new.call
  end

  let!(:org_1) { create :organization }
  let!(:org_2) { create :organization }
  let!(:org_3) { create :organization }
  let!(:org_4) { create :organization }

  let!(:org_1_passed_vehicles) { create_list :vehicle, 10, :passed, organization: org_1 }
  let!(:org_1_failed_vehicles) { create_list :vehicle, 9, :failed, organization: org_1 }

  let!(:org_2_passed_vehicles) { create_list :vehicle, 10, :passed, organization: org_2 }
  let!(:org_2_failed_vehicles) { create_list :vehicle, 8, :failed, organization: org_2 }

  let!(:org_3_passed_vehicles) { create_list :vehicle, 10, :passed, organization: org_3 }
  let!(:org_3_failed_vehicles) { create_list :vehicle, 7, :failed, organization: org_3 }

  let!(:org_4_passed_vehicles) { create_list :vehicle, 10, :passed, organization: org_4 }
  let!(:org_4_failed_vehicles) { create_list :vehicle, 6, :failed, organization: org_4 }

  it "returns correct records" do 
    expect(call).to match([
      have_attributes(
        org_name: org_1.name,
        failed_v: 9,
        tot_v: 19
      ),
      have_attributes(
        org_name: org_2.name,
        failed_v: 8,
        tot_v: 18
      ),
      have_attributes(
        org_name: org_3.name,
        failed_v: 7,
        tot_v: 17
      ),
    ])
  end
end