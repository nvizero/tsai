class CreateVerifyTypeMains < ActiveRecord::Migration
  def change
    create_table :verify_type_mains do |t|
      t.string :title
      t.text :content

      t.timestamps
    end
  end
end
