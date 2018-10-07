class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  has_many :customers, through: :invoices

  validates_presence_of :name

  def self.most_revenue(quantity = nil)
    select("merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) AS revenue")
    .joins(invoices: [:transactions, :invoice_items])
    .where(transactions: {result: "success"})
    .group(:id)
    .order("revenue DESC")
    .limit(quantity)
  end

  def self.most_items(quantity = nil)
    select("merchants.*, sum(invoice_items.quantity) AS sold_items")
    .joins(invoices: [:invoice_items, :transactions])
    .where(transactions: {result: "success"})
    .group(:id)
    .order("sold_items DESC")
    .limit(quantity)
  end

  def self.favorite_merchant(customer_id)
    joins(invoices: :transactions)
    .merge(Transaction.success)
    .where(invoices: {customer_id: customer_id})
    .group(:id)
    .order(id: :desc)
    .first
  end
end
