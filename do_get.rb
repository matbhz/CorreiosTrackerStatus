require 'rest-client'
require 'open-uri'
require 'nokogiri'


module Correios


  POST_URL = "http://websro.correios.com.br/sro_bin/txect01$.QueryList"
  TRACKER_NO = "RB489735409HK"
  PARAMS = "P_ITEMCODE=&P_LINGUA=001&P_TESTE=&P_TIPO=001&P_COD_UNI=#{TRACKER_NO}&Z_ACTION=Search"


  response = RestClient.post POST_URL, PARAMS

  details_table = Nokogiri::HTML(response).xpath("//table//following::tr[2]")

  json_response = { :tracker_no => TRACKER_NO, :info => [] }

  details_table.each do |row|

    columns = row.children
    if columns.size == 3

      date = columns[0].text
      location = columns[1].text
      situation = columns[2].text

      json_response[:info] << { :date => date, :location => location, :situation => situation}

    else
      details = columns[0].text

      json_response[:info] << {:details => details}

    end

  end

  json_response.to_json

end