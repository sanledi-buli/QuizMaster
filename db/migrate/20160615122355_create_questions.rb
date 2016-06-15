class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
    	t.text :content, null: false
    	t.text :answer, null: false
      t.timestamps null: false
    end
  end
end
