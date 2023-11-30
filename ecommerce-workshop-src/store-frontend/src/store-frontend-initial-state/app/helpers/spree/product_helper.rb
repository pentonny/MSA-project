# module Spree
#     module ProductHelper
#         def get_ads
#             @ads = JSON.parse(Net::HTTP.get_response(URI("#{ENV['ADS_ROUTE']}:#{ENV['ADS_PORT']}/ads")).body)
#           end
#     end

# end

module Spree
    module ProductHelper
      def get_ads
        begin
          # Net::HTTP.get_response 호출을 시도합니다.
          response = Net::HTTP.get_response(URI("#{ENV['ADS_ROUTE']}:#{ENV['ADS_PORT']}/ads"))
          # 응답이 성공적으로 받아진 경우, JSON 파싱을 시도합니다.
          @ads = JSON.parse(response.body)
        rescue StandardError => e
          # HTTP 요청 중에 발생한 예외를 캐치합니다.
          # 이 부분에서 로깅을 하거나, 에러 메시지를 설정할 수 있습니다.
          Rails.logger.error "광고를 가져오는 중에 오류가 발생했습니다: #{e.message}"
          # 예외가 발생했을 때 @ads를 nil이나 다른 기본값으로 설정할 수 있습니다.
          @ads = nil
        end
      end
    end
  end
  