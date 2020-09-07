class CreateDiettasks < ActiveRecord::Migration[5.2]
  def change
    create_table :diettasks do |t|
      t.string :content
      t.string :status, default: 'undone'
      t.references :user, foreign_key: true
      t.date :limit_date

      t.timestamps
    end
  end
end
