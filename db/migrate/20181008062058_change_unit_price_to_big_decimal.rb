class ChangeUnitPriceToBigDecimal < ActiveRecord::Migration[5.1]
  def change
    change_column :items, :unit_price, :decimal, precision: 14, scale: 2
    change_column :invoice_items, :unit_price, :decimal, precision: 14, scale: 2
  end
end
