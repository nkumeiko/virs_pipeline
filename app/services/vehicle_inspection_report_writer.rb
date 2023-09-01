require "csv"

class VehicleInspectionReportWriter
  extend Dry::Initializer

  option :file_path
  option :data

  def call
    CSV.open("#{file_path}", "w", headers: true, col_sep: "\t") do |csv|
      csv << ["org_name", "tot_v", "failed_v"]
      data.each do |row|
        csv << [row["org_name"], row["tot_v"], row["failed_v"]]
      end
    end
  end
end