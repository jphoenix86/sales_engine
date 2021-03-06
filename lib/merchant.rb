class Merchant
  attr_reader :merchant_data, :merchant_repository

  def initialize(merchant_data, merchant_repository)
    @merchant_data = merchant_data
    @merchant_repository = merchant_repository
  end

  def id
    merchant_data[:id].to_i
  end

  def name
    merchant_data[:name]
  end

  def created_at
    Date.parse(merchant_data[:created_at])
  end

  def updated_at
    Date.parse(merchant_data[:updated_at])
  end


  # relationships

  def items
    merchant_repository.find_items_for_merchant(id)
  end

  def invoices
    merchant_repository.find_invoices_for_merchant(id)
  end


  # business intelligenceeeee

  def revenue(date=nil)
    merchant_repository.find_revenue_for_merchant(id, date)

  end

  def favorite_customer
    merchant_repository.find_favorite_customer_for_merchant(id)
  end

  def customers_with_pending_invoices
    merchant_repository.find_customers_with_pending_invoices_for_merchant(id)
  end

end
