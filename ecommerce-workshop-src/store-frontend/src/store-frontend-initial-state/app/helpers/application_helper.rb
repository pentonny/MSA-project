# module ApplicationHelper
#     def get_ads
#         @ads = JSON.parse(Net::HTTP.get_response(URI("#{ENV['ADS_ROUTE']}:#{ENV['ADS_PORT']}/ads")).body)
#       end
  
# end


module ApplicationHelper
  def get_ads
    begin
      # HTTP 요청을 시도합니다.
      response = Net::HTTP.get_response(URI("#{ENV['ADS_ROUTE']}:#{ENV['ADS_PORT']}/ads"))
      # 응답이 성공적인 경우, JSON을 파싱합니다.
      @ads = JSON.parse(response.body)
    rescue StandardError => e
      # 예외가 발생한 경우, 여기서 처리합니다.
      # 로그를 기록하거나, @ads를 nil 또는 기본 값으로 설정할 수 있습니다.
      puts "광고를 가져오는데 실패했습니다: #{e.message}"
      @ads = nil
    end
  end
end
