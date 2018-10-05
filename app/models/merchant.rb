class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  # has_many :customers, through: :invoices

  validates_presence_of :name

  # def self.search(params)
  #   if params[:name]
  #     find_by(name: params[:name])
  #   elsif params[:id]
  #     find_by(id: params[:id])
  #   elsif params[:created_at]
  #     find_by(created_at: params[:created_at])
  #   elsif params[:updated_at]
  #     find_by(updated_at: params[:updated_at].to_datetime)
  #   end
  # end

  def self.most_revenue(quantity = 5)
    select("merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) AS revenue")
    .joins(invoices: [:transactions, :invoice_items])
    .where(transactions: {result: "success"})
    .group(:id).order("revenue DESC")
    .limit(quantity)
  end
end
