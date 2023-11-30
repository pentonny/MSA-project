# class DiscountsController < ApplicationController
#   def get
#     @discounts = Net::HTTP.get_response(URI("#{ENV['DISCOUNTS_ROUTE']}:#{ENV['DISCOUNTS_PORT']}/discount")).body
#     logger.info @discounts
#     render json: @discounts
#   end

#   def add
#   end
# end
class DiscountsController < ApplicationController
  def get
    begin
      @discounts = Net::HTTP.get_response(URI("#{ENV['DISCOUNTS_ROUTE']}:#{ENV['DISCOUNTS_PORT']}/discount")).body
      logger.info @discounts
    rescue StandardError => e
      logger.error "할인 정보를 불러오는 중 오류가 발생했습니다: #{e.message}"
      @discounts = nil
    end
    render json: @discounts
  end

  def add
  end
end