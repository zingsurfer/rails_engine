class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  # has_many :customers, through: :invoices

  validates_presence_of :name

  def self.most_revenue(quantity = 5)
    select("merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) AS revenue")
    .joins(invoices: [:transactions, :invoice_items])
    .where(transactions: {result: "success"})
    .group(:id).order("revenue DESC")
    .limit(quantity)
  end
end
