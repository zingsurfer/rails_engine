class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  # has_many :customers, through: :invoices

  validates_presence_of :name

  def self.search(params)
    if params[:name]
      find_by(name: params[:name])
    elsif params[:id]
      find_by(id: params[:id])
    elsif params[:created_at]
      find_by(created_at: (params[:created_at]).to_datetime)
    # elsif params[:updated_at]
    #   find_by(updated_at: params[:updated_at].to_datetime)
    end
  end
end
