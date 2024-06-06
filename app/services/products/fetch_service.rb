# frozen_string_literal: true

module Products
  class FetchService
    attr_reader :params

    def initialize(params)
      @params = params
    end

    def call!
      products = Product.joins(:category).select(:id, :name, :code, :description, :price, "categories.name as category_name").order(id: :desc)
      products = filter_products(products)
      paginate(products)
    end

    private

    def paginate(records)
      records.page(params[:page]).per(10)
    end

    def filter_products(products)
      filter_params = params.permit(:search_key, :category)
      filter_params.each do |column_name, value|
        case column_name
        when "search_key"
          products = products.where("(products.name ILIKE ?) OR (products.code ILIKE ?)", "%#{value}%", "%#{value}%")
        when "category"
          products = products.where(category: value)
        else
          products
        end
      end
      products
    end
  end
end
