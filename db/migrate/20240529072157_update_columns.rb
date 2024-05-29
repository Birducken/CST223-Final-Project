class UpdateColumns < ActiveRecord::Migration[7.1]
  def change
    rename_column :games, :collectors, :private_sales
    rename_column :games, :market, :public_sales
  end
end
