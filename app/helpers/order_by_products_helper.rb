module OrderByProductsHelper

    def get_product_order code
         pos = ProductOrder.where(:code => code).first
         return pos
    end
end
