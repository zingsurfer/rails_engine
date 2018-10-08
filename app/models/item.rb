class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  validates_presence_of :name,
                        :description,
                        :unit_price,
                        :created_at,
                        :updated_at,
                        :merchant_id
                        
  def self.best_sell_day(item_id)
    select("transactions.created_at AS date, sum(invoice_items.quantity * invoice_items.unit_price) AS revenue")
      .joins(invoices: :transactions)
      .where(items: { id: item_id }, transactions: {result: "success"} )
      .group("transactions.created_at")
      .order("revenue DESC")
      .limit(1)
  end
end
