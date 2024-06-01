# frozen_string_literal: true

class ProductsController < ApplicationController
  def new
  end

  def import
    products_file = params[:file]
    @products = []

    excel = Roo::Spreadsheet.open(products_file.tempfile.path)
    sheet = excel.sheet(0)

    sheet.each_with_index(headers: true) do |row, row_index|
      next if row_index.zero?

      product = build_product(row)
      @products << product
    end

    all_saved = @products.all?(&:save)

    if all_saved
      redirect_to root_path, notice: "Products imported successfully."
    else
      flash[:alert] = "Some products failed to save. Please check the input file and try again."
      redirect_to new_product_path
    end
  end

  def index
    @products = Products::FetchService.new(params).call!
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
    category = Category.find_or_create_by(name: name)
    category.id
  end
end
