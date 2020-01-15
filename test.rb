require 'webrick'

server = WEBrick::HTTPServer.new({
  # DocumentRootはドメインが入る
  :DocumentRoot => '.',
  # CGIInterpreterは翻訳するプログラマの場所を示す
  :CGIInterpreter => WEBrick::HTTPServlet::CGIHandler::Ruby,
  # Portは出入り口を示す
  :Port => '3000',
})
['INT', 'TERM'].each {|signal|
  Signal.trap(signal){ server.shutdown }
}

server.mount('/test', WEBrick::HTTPServlet::ERBHandler, 'test.html.erb')

server.mount('/kadai', WEBrick::HTTPServlet::ERBHandler, 'kadai.html.erb')


server.mount('/indicate.cgi', WEBrick::HTTPServlet::CGIHandler, 'indicate.rb')

server.mount('/goya.cgi', WEBrick::HTTPServlet::CGIHandler, 'goya.rb')


server.mount('/false_goya.cgi', WEBrick::HTTPServlet::CGIHandler, 'false_goya.rb')

server.start
　
