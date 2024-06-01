# frozen_string_literal: true

module Products
  class ImportProductsService
    attr_reader :params, :imported_products

    def initialize(params)
      @params = params
      initialize_record
    end

    def initialize_record
      @product = Product.new
      @imported_products = []
    end
  end
end
