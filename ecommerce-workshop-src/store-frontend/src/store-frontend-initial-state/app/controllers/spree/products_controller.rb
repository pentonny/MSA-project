module Spree
  class ProductsController < Spree::StoreController
    before_action :load_product, only: :show
    before_action :load_taxon, only: :index

    helper 'spree/taxons'

    respond_to :html

    def index
      @searcher = build_searcher(params.merge(include_images: true))
      @products = @searcher.retrieve_products
      @products = @products.includes(:possible_promotions) if @products.respond_to?(:includes)
      @taxonomies = load_taxonomies
    end

    def show
      @variants = @product.variants_including_master.
                  spree_base_scopes.
                  active(current_currency).
                  includes([:option_values, :images])
      @product_properties = @product.product_properties.includes(:property)
      @taxon = params[:taxon_id].present? ? Spree::Taxon.find(params[:taxon_id]) : @product.taxons.first
      redirect_if_legacy_path

      begin
        @ads = helpers.get_ads.sample
        if @ads.present? && @ads['path'].present?
          banner_path = URI("#{ENV['ADS_ROUTE']}:#{ENV['ADS_PORT']}/banners/#{@ads['path']}")
          @ads['base64'] = Base64.encode64(open(banner_path).read).gsub("\n", '')
        end
      rescue StandardError => e
        Rails.logger.error "광고를 불러오는데 오류가 발생했습니다: #{e.message}"
        @ads = nil
      end

      # @ads = helpers.get_ads.sample
      # @ads['base64'] = Base64.encode64(open("#{ENV['ADS_ROUTE']}:#{ENV['ADS_PORT']}/banners/#{@ads['path']}").read).gsub("\n", '')
    end

    private

    def accurate_title
      if @product
        @product.meta_title.blank? ? @product.name : @product.meta_title
      else
        super
      end
    end

    def load_product
      @products = if try_spree_current_user.try(:has_spree_role?, 'admin')
                    Product.with_deleted
                  else
                    Product.active(current_currency)
                  end

      @product = @products.includes(:variants_including_master, variant_images: :viewable).
                 friendly.distinct(false).find(params[:id])
    end

    def load_taxon
      @taxon = Spree::Taxon.find(params[:taxon]) if params[:taxon].present?
    end

    def redirect_if_legacy_path
      # If an old id or a numeric id was used to find the record,
      # we should do a 301 redirect that uses the current friendly id.
      if params[:id] != @product.friendly_id
        params[:id] = @product.friendly_id
        params.permit!
        redirect_to url_for(params), status: :moved_permanently
      end
    end

    def load_taxonomies
      Spree::Taxonomy.includes(root: :children)
    end
  end
end
