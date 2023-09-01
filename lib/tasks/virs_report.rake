namespace :virs_report do
  desc "Three organizations with the highest proportion of vehicles that failed their last adjudicated inspection"
  task generate: :environment do    
    Dir["./reports/vir_*.csv"].sort.each do |file_name|
      VehicleInspectionReportParser.new(file_path: file_name).call
    end
    virs_report_data = TopFailingReportGenerator.new.call    
    VehicleInspectionReportWriter.new(file_path: "virs_report.tsv", data: virs_report_data).call
  end
end