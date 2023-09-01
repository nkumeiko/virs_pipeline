class CreateVehicles < ActiveRecord::Migration[7.0]
  def change
    create_table :vehicles, id: false, primary_key: :id do |t|
      t.bigint :id, null: false
      t.date :latest_inspection_date, null: false
      t.references :organistaion, null: false
      t.integer :inspection_period_id, null: false
      t.boolean :inspection_passed

      t.timestamps
    end
  end
end
