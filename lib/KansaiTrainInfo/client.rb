# frozen_string_literal: true

require 'nokogiri'
require 'open-uri'

# module
module KansaiTrainInfo
  class << self
    LINES = {
      大阪環状線: [4, 2, 263],
      近鉄京都線: [6, 5, 288],
      阪急京都線: [8, 2, 306],
      御堂筋線: [10, 3, 321],
      烏丸線: [34, 2, 318],
      東西線: [34, 3, 319]
    }.freeze

    def get(route_array, url: false)
      messages = []

      route_array.each do |route|
        status_xpath = "//*[@id='mdAreaMajorLine']/div[#{LINES[route.to_sym][0]}]/table/tr[#{LINES[route.to_sym][1]}]/td[2]"
        detail_url = "https://transit.yahoo.co.jp/traininfo/detail/#{LINES[route.to_sym][2]}/0/"
        state = kansai_doc.xpath(status_xpath).first.text
        messages << message(route, state, url, detail_url)
      end

      messages
    end

    # search HTML in pages
    def kansai_doc
      charset = nil
      url = 'https://transit.yahoo.co.jp/traininfo/area/6/'

      html = open(url) do |f|
        charset = f.charset
        f.read
      end

      Nokogiri::HTML.parse(html, nil, charset)
    end

    # get infomation
    def description(detail_url)
      charset = nil
      detail_html = URI.parse(detail_url).open do |f|
        charset = f.charset
        f.read
      end
      detail_doc = Nokogiri::HTML.parse(detail_html, nil, charset)
      detail_doc.xpath('//*[@id="mdServiceStatus"]/dl/dd/p').first.text
    end

    # show logic
    def message(route, state, url, detail_url)
      state.slice!('[○]')
      state.slice!('[!]')

      puts "#{route}は#{state}です" if state == '平常運転'

      message = case state
                when '運転状況'
                  "#{route}は#{state}に変更があります。"
                when '列車遅延'
                  "#{route}は#{state}があります。"
                when '運転見合わせ'
                  "#{route}は#{state}しています。"
                end

      show_message = "#{message} #{description(detail_url)}"

      url ? show_message + detail_url : show_message
    end

    def help
      print "利用可能な路線："
      print "\n"
      print "\n"
      print "大阪環状線、近鉄京都線、阪急京都線, 御堂筋線, 烏丸線, 東西線"
      print "\n"
    end
  end
end
