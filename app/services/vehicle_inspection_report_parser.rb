require "csv"
require "date"

class VehicleInspectionReportParser
  extend Dry::Initializer

  option :file_path

  def call
    CSV.foreach(file_path, headers: true, col_sep: "|") do |row|
      update_organization(row)
      update_vehicle(row)
    end

    Rails.logger.info "File #{file_path} has been parsed"
  end

  def update_organization(row)
    inspection_date = Date.parse(row["inspection_date"])
    organisation = Organisation.find_or_initialize_by(id: row["vehicle_org_id"])
      
    if organisation.new_record? || organisation.latest_inspection_date <= inspection_date
      organisation.update(
        name: row["org_name"],
        latest_inspection_date: inspection_date
      )
    end
  end

  def update_vehicle(row)
    inspection_date = Date.parse(row["inspection_date"])
    vehicle = Vehicle.find_or_initialize_by(id: row["vehicle_id"])
    
    if vehicle.new_record? || (vehicle.latest_inspection_date <= inspection_date && row["inspection_passed"].present?)
      vehicle.update(
        latest_inspection_date: inspection_date,
        organisation_id: row["vehicle_org_id"],
        inspection_period_id: row["inspection_period_id"],
        inspection_passed: row["inspection_passed"]
      )
    end
  end
end