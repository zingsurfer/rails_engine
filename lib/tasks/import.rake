require 'csv'

namespace :import do
  desc "All"
  task all: [:clean_slate, :merchant, :customer, :invoice, :item, :invoice_item, :transaction]

  desc "Remove existing data for a clean slate prior to import"
  task clean_slate: :environment do
    Merchant.destroy_all
    Customer.destroy_all
    Invoice.destroy_all
    Item.destroy_all
    InvoiceItem.destroy_all
    Transaction.destroy_all
  end

  desc "Import merchants from CSV file"
  task merchant: :environment do
    CSV.foreach('./db/csv/merchants.csv', headers: true, header_converters: :symbol) do |merchant|
      merchant_hash = { id: merchant[:id],
        name: merchant[:name],
        created_at: merchant[:created_at],
        updated_at: merchant[:updated_at]
      }
      Merchant.create!(merchant_hash)
    end
    puts "Created #{Merchant.count} merchants!"
  end

  desc "Import customers from CSV file"
  task customer: :environment do
    CSV.foreach('./db/csv/customers.csv', headers: true, header_converters: :symbol) do |customer|
      customer_hash = { id: customer[:id],
        first_name: customer[:first_name],
        last_name: customer[:last_name],
        created_at: customer[:created_at],
        updated_at: customer[:updated_at]
      }
      Customer.create!(customer_hash)
    end
    puts "Created #{Customer.count} customers!"
  end

  desc "Import invoices from CSV file"
  task invoice: :environment do
    CSV.foreach('./db/csv/invoices.csv', headers: true, header_converters: :symbol) do |invoice|
      invoice_hash = { id: invoice[:id],
        customer_id: invoice[:customer_id],
        merchant_id: invoice[:merchant_id],
        status: invoice[:status],
        created_at: invoice[:created_at],
        updated_at: invoice[:updated_at]
      }
      Invoice.create!(invoice_hash)
    end
    puts "Created #{Invoice.count} invoices!"
  end

  desc "Import items from CSV file"
  task item: :environment do
    CSV.foreach('./db/csv/items.csv', headers: true, header_converters: :symbol) do |item|
      item_hash = { id: item[:id],
        name: item[:name],
        description: item[:description],
        unit_price: item[:unit_price].to_f/100,
        merchant_id: item[:merchant_id],
        created_at: item[:created_at],
        updated_at: item[:updated_at]
      }
      Item.create!(item_hash)
    end
    puts "Created #{Item.count} items!"
  end

  desc "Import invoice items from CSV file"
  task invoice_item: :environment do
    CSV.foreach('./db/csv/invoice_items.csv', headers: true, header_converters: :symbol) do |invoice_item|
      invoice_item_hash = { id: invoice_item[:id],
        item_id: invoice_item[:item_id],
        invoice_id: invoice_item[:invoice_id],
        quantity: invoice_item[:quantity],
        unit_price: invoice_item[:unit_price].to_f/100,
        created_at: invoice_item[:created_at],
        updated_at: invoice_item[:updated_at]
      }
      InvoiceItem.create!(invoice_item_hash)
    end
    puts "Created #{InvoiceItem.count} invoice items!"
  end

  desc "Import transactions from CSV file"
  task transaction: :environment do
    CSV.foreach('./db/csv/transactions.csv', headers: true, header_converters: :symbol) do |transaction|
      transaction_hash = { id: transaction[:id],
                           invoice_id: transaction[:invoice_id],
                           credit_card_number: transaction[:credit_card_number],
                           credit_card_expiration_date: transaction[:experiation_date],
                           result: transaction[:result],
                           created_at: transaction[:created_at],
                           updated_at: transaction[:updated_at]
                          }
      Transaction.create!(transaction_hash)
    end
    puts "Created #{Transaction.count} transactions!"
  end

end
