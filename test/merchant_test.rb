require_relative 'test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_engine'
require_relative '../lib/merchant_repository'
require_relative '../lib/merchant'

class MerchantTest < Minitest::Test
  def test_it_has_a_name
    merchant_data = {id: 1, name: "Walmart"}
    merchant_repository = "MERCHANT REPOSITORY"

    merchant = Merchant.new(merchant_data, merchant_repository)
    assert_equal "Walmart", merchant.name
  end

  def test_it_returns_a_list_of_items_with_the_same_merchant_id

    sales_engine = SalesEngine.new

    sales_engine.create_item_repository([
                {id: 10, merchant_id: 1},
                {id: 20, merchant_id: 2},
                {id: 30, merchant_id: 3},
                {id: 40, merchant_id: 1},
                {id: 50, merchant_id: 9},
                                        ])

    merchant_repo = sales_engine.create_merchant_repository([
                {id: 1},
                {id: 2},
                {id: 3},
                {id: 4},
                {id: 5},
                            ])

    merchant = Merchant.new({id: 1}, merchant_repo)

    items = merchant.items
        # merchant_repo.find_items_for_merchant(merchant.id)

    assert_equal [10, 40], items.map { |item| item.id }
  end

  def test_it_returns_a_collection_of_invoices_associated_with_a_merchant
    sales_engine = SalesEngine.new

    sales_engine.create_invoice_repository([
        {id: 10, merchant_id: 1},
        {id: 20, merchant_id: 2},
        {id: 30, merchant_id: 1},
        {id: 40, merchant_id: 3},
        {id: 50, merchant_id: 1},
    ])

    merchant_repo = sales_engine.create_merchant_repository([
    {id: 1},
    {id: 2},
    {id: 3},
    {id: 4},
    {id: 5},
    ])

    merchant = Merchant.new({id: 1}, merchant_repo)

    invoices = merchant.invoices
        # merchant_repo.find_invoices_for_merchant(merchant.id)

    assert_equal [10, 30, 50], invoices.map { |invoice| invoice.id}
  end

end
