class CreateOrganisations < ActiveRecord::Migration[7.0]
  def change
    create_table :organisations, id: false, primary_key: :id do |t|
      t.bigint :id, null: false
      t.string :name, null: false
      t.date :latest_inspection_date, null: false

      t.timestamps
    end
  end
end