# module Spree
#   class HomeController < Spree::StoreController
#     helper 'spree/products'
#     respond_to :html

#     def index
#       @searcher = build_searcher(params.merge(include_images: true))
#       @products = @searcher.retrieve_products
#       @products = @products.includes(:possible_promotions) if @products.respond_to?(:includes)
#       @taxonomies = Spree::Taxonomy.includes(root: :children)
#       @discounts = helpers.get_discounts.sample
#       @ads = helpers.get_ads.sample
#       @ads['base64'] = Base64.encode64(open("#{ENV['ADS_ROUTE']}:#{ENV['ADS_PORT']}/banners/#{@ads['path']}").read).gsub("\n", '')
#     end
#   end
# end

module Spree
  class HomeController < Spree::StoreController
    helper 'spree/products'
    respond_to :html

    def index
      @searcher = build_searcher(params.merge(include_images: true))
      @products = @searcher.retrieve_products
      @products = @products.includes(:possible_promotions) if @products.respond_to?(:includes)
      @taxonomies = Spree::Taxonomy.includes(root: :children)
     # @discounts 예외처리 추가
      begin
        @discounts = helpers.get_discounts.sample
        if @discounts.nil?
          raise "할인 정보를 불러올 수 없습니다."
        end
      rescue StandardError => e
        Rails.logger.error "할인 정보를 불러오는 중 오류가 발생했습니다: #{e.message}"
        @discounts = nil
      end

      begin
        @ads = helpers.get_ads.sample
        if @ads && @ads['path']
          banner_path = "#{ENV['ADS_ROUTE']}:#{ENV['ADS_PORT']}/banners/#{@ads['path']}"
          @ads['base64'] = Base64.encode64(open(banner_path).read).gsub("\n", '')
        end
      rescue StandardError => e
        Rails.logger.error "광고를 불러오는 중 오류가 발생했습니다: #{e.message}"
        @ads = nil
      end
    end
  end
end
