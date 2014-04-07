require 'rest-client'
require 'nokogiri'
require 'json'

module Correios

  POST_URL = "http://websro.correios.com.br/sro_bin/txect01$.QueryList"

  def self.get tracker_no

    params = "P_ITEMCODE=&P_LINGUA=001&P_TESTE=&P_TIPO=001&P_COD_UNI=#{tracker_no}&Z_ACTION=Search"

    response = RestClient.post POST_URL, params
    details_table = Nokogiri::HTML(response).xpath("//table//following::tr[2]")

    json_response = {:tracker_no => tracker_no, :info => []}

    info = {}
    details_table.each do |row|
      columns = row.children
      if columns.size == 3
        info = {}
        info = {:date => columns[0].text, :location => columns[1].text, :situation => columns[2].text}
        json_response[:info].push info
      else
        info[:details] = columns[0].text
      end
    end
   json_response.to_json.split.join(" ")
  end

end
