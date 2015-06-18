require 'csv'
require_relative 'parser'
require_relative 'merchant_repository'
require_relative 'merchant'
require_relative 'transaction_repository'
require_relative 'transaction'
require_relative 'customer_repository'
require_relative 'customer'
require_relative 'item_repository'
require_relative 'item'
require_relative 'invoice_item_repository'
require_relative 'invoice_item'
require_relative 'invoice_repository'
require_relative 'invoice'

class SalesEngine

  attr_accessor :invoice_item_repository, :merchant_repository, :customer_repository,
                :item_repository, :data_directory, :invoice_repository, :transaction_repository

  def initialize(data_directory="./test/fixtures")
    @data_directory = data_directory
  end


  def startup
    create_merchant_repository(get_data("#{data_directory}/merchants.csv"))
    create_customer_repository(get_data("#{data_directory}/customers.csv"))
    create_invoice_item_repository(get_data("#{data_directory}/invoice_items.csv"))
    create_invoice_repository(get_data("#{data_directory}/invoices.csv"))
    create_item_repository(get_data("#{data_directory}/items.csv"))
    create_transaction_repository(get_data("#{data_directory}/transactions.csv"))
  end

  def get_data(file_name)
    CSV.open "#{file_name}", headers: true, header_converters: :symbol
  end

  def create_merchant_repository(merchant_data)
    @merchant_repository = MerchantRepository.new(merchant_data, self)
  end

  def create_customer_repository(customer_data)
    @customer_repository = CustomerRepository.new(customer_data, self)
  end

  def create_invoice_item_repository(invoice_item_data)
    @invoice_item_repository = InvoiceItemRepository.new(invoice_item_data, self)
  end

  def create_invoice_repository(invoice_data)
    @invoice_repository = InvoiceRepository.new(invoice_data, self)
  end

  def create_item_repository(item_data)
    @item_repository = ItemRepository.new(item_data, self)
  end

  def create_transaction_repository(transaction_data)
    @transaction_repository = TransactionRepository.new(transaction_data, self)
  end

  # relationships

  def find_items_for_merchant(merchant_id)
    item_repository.find_all_items_by_merchant_id(merchant_id)
  end

end

# e = SalesEngine.new
# e.startup
# williams = e.merchant_repository.find_all_merchants_by_name("Williamson Group")
# williams.each { |merch| puts merch.id }
