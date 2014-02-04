require 'rest-client'
require 'open-uri'
require 'nokogiri'


class DoGet


  POST_URL = "http://websro.correios.com.br/sro_bin/txect01$.QueryList"
  TRACKER_NO = "RB489735409HK"
  PARAMS = "P_ITEMCODE=&P_LINGUA=001&P_TESTE=&P_TIPO=001&P_COD_UNI=#{TRACKER_NO}&Z_ACTION=Search"

  LOCATION_COLUMNS = 3

  response = RestClient.post POST_URL, PARAMS

  details_table = Nokogiri::HTML(response).xpath("//table")

  json_response = {}

  details_table.xpath("//following::tr[2]").each do |row|

    columns = row.children
    if columns.size == LOCATION_COLUMNS


      date = columns[0].text
      location = columns[1].text
      situation = columns[2].text


      p "Data: #{date} | Local: #{location} | Situação: #{situation}"

    else
      details = columns[0].text

      p "Detalhe: #{details}"

    end

  end


=begin
 0 - Headers Data/Local/Situação
 1..x - Cada atualização + Situação
    0 - Local
    1 - detalhes

=end

end