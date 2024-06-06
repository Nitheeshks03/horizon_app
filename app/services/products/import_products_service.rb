# frozen_string_literal: true

module Products
  class ImportProductsService
    attr_reader :params

    def initialize(params)
      @params = params
    end

    def call!
      products_file = params[:file]
      @products = []
      errors = []

      excel = Roo::Spreadsheet.open(products_file.tempfile.path)
      sheet = excel.sheet(0)

      sheet.each_with_index(headers: true) do |row, row_index|
        next if row_index.zero?

        product = build_product(row)
        @products << product
      end

    all_save = true
    @products.each do |product|
      unless product.save
        all_save = false
        errors << "Failed to save product, #{product.name}: #{product.errors.full_messages.join(", ")}"
      end
    end

     
      {all_save: , errors:}
     
    end

    private

    def build_product(data)
      Product.new(
        name: data["Name"],
        code: data["Code"],
        description: data["Description"],
        category_id: find_or_create_category(data["Category"]),
        price: data["Price"],
      )
    end

    def find_or_create_category(name)
      category = Category.find_or_create_by(name: name)&.id
    end
  end
end
