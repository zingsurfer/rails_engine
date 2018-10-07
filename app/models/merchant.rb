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

  def self.revenue_on_date(date, merchant_id)
    select("merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) AS revenue")
      .joins(invoices: [:invoice_items, :transactions])
      .where(merchants: {id: merchant_id}, transactions: {result: 'success'}, invoices: {created_at: date.to_date.beginning_of_day..date.to_date.end_of_day})
      .group(:id)
      .first
  end

  def self.total_revenue(date)
    select("sum(invoice_items.quantity * invoice_items.unit_price) AS revenue")
    .joins(invoices: [:invoice_items, :transactions])
    .where(transactions: {result: "success"}, invoices: {created_at: date.to_date.beginning_of_day..date.to_date.end_of_day})
  end
end
