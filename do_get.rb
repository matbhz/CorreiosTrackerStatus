require 'rest-client'

class DoGet


  POST_URL = 'http://websro.correios.com.br/sro_bin/txect01$.QueryList'
  TRACKER_NO = 'RB489735409HK'
  PARAMS_HASH = {:P_ITEMCODE => nil,
                 :P_LINGUA => 001,
                 :P_TESTE => nil,
                 :P_TIPO => 001,
                 :P_COD_UNI => 'RB489735409HK',
                 :Z_ACTION => 'Search'}


  response = RestClient.post POST_URL, PARAMS_HASH


  p response


end