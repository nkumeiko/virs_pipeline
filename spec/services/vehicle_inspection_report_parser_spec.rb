require "rails_helper"

RSpec.describe VehicleInspectionReportParser do 
  subject(:call) do
    described_class.new(file_path: file.path).call
  end

  let(:file_content) do 
    <<~CSV
      vehicle_id|inspection_date|vehicle_org_id|org_name|inspection_period_id|inspection_passed
      2811|2020-02-06|1920|Economotor|102|
      2811|2020-02-07|1920|Economotor|102|FALSE
      4021|2020-02-10|1920|Economotor New|102|TRUE
      1508|2020-02-12|7732|Mina Fleet Trucks|102|TRUE
      4919|2020-02-14|2265|"Cars ""R"" Us"|102|FALSE
    CSV
  end

  let(:file) do 
    file = Tempfile.new(["vir_", ".csv"])
    file.write(file_content)
    file.rewind
    file
  end

  after do 
    file.close
    file.unlink
  end

  it "creates correct records" do
    expect { call }
      .to change(Vehicle, :count).by(4)
      .and change(Organisation, :count).by(3)

    expect(Vehicle.find(2811)).to have_attributes(
      inspection_passed: false
    )

    expect(Organisation.find(1920)).to have_attributes(
      name: "Economotor New"
    )
  end
end