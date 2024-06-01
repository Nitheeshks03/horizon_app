# frozen_string_literal: true

module Products
  class FetchService
    attr_reader :params

    def initialize(params)
      @params = params
    end

    def call!
      products = Product.joins(:category).select(:name, :code, :description, :price, "categories.name as category_name").order(id: :desc)
      filter_products(products)
    end

    private

    def filter_products(products)
      filter_params = params.permit(:search_key, :category_id)
      filter_params.each do |column_name, value|
        case column_name
        when "search_key"
          products = products.where("name LIKE ? OR code LIKE?", value)
        when "category_id"
          products = products.where(category: value)
        else
          products
        end
      end
      products
    end
  end
end
