require "csv"

class TopFailingReportGenerator
  extend Dry::Initializer

  LIMIT = 3

  OrganizationRecord = Struct.new(
    :org_name,
    :failed_v,
    :tot_v,
    keyword_init: true
  )

  def call
    Vehicle.joins(:organization)
      .select(
        'organizations.name as org_name', 
        'count(case when inspection_passed = false then 1 else null end) as failed_v', 
        'count(*) as tot_v',
        '1.0 * count(case when inspection_passed = false then 1 else null end) / count(*) as failed_proportion'
      )
      .group('organization_id', 'organizations.name')
      .order('failed_proportion desc, failed_v desc, organizations.name asc')
      .limit(LIMIT)
      .map { |r| OrganizationRecord.new(r.attributes.except('id', 'failed_proportion')) }
  end
end