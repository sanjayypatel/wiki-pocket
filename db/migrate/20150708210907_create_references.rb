class CreateReferences < ActiveRecord::Migration
  def change
    create_table :references do |t|
      t.references :wiki, index: true, foreign_key: true
      t.references :link, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
