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
    .merge(Transaction.success)
    .where(items: { id: item_id })
    .group("transactions.created_at")
    .order("revenue DESC")
    .limit(1)
  end

  def self.most_revenue(quantity = nil)
    select("items.*, sum(invoice_items.quantity * invoice_items.unit_price) As revenue")
    .joins(invoices: :transactions)
    .merge(Transaction.success)
    .group(:id)
    .order("revenue DESC")
    .limit(quantity)
  end

  def self.most_items(quantity = nil)
    select("items.*, sum(invoice_items.quantity) AS quantity_sold")
    .joins(invoices: :transactions)
    .merge(Transaction.success)
    .group(:id)
    .order("quantity_sold DESC")
    .limit(quantity)
  end
end
