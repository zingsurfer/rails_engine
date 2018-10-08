class Customer < ApplicationRecord
  validates_presence_of :first_name, :last_name, :updated_at, :created_at

  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :merchants, through: :invoices

  def self.favorite_customer(merchant_id)
    joins(invoices: :transactions)
    .merge(Transaction.success)
    .where(invoices: {merchant_id: merchant_id})
    .group(:id)
    .order(id: :desc)
    .first
  end
end
