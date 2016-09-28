class CreateFirstmodels < ActiveRecord::Migration[5.0]
  def change
    create_table :firstmodels do |t|
      t.column :name, :string
    end
  end
end
