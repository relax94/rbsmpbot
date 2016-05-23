#require 'bunny'
require_relative './flash_api'


@flash = FlashApi.new
@flash.set_bot_token '570be3b861017fbc2705bbd6'




def recieveMessage replyId, message

  puts "income message #{message}"
  case message.to_s
    when '%start'
      @flash.push_answer replyId, 'Hi ... i am started'
    when '%stop'
      @flash.push_answer replyId, 'Bye bye ... see you later )'
    when '%title'
      @flash.push_answer replyId, 'Ok ... i will do this task for you'
    else
      @flash.push_answer replyId, 'Unknow command !'
  end
end

@flash.recieve_command method(:recieveMessage)


