require 'bunny'
require 'json'

class FlashApi

  def set_bot_token token
    self.start_connection
    @token = token
    @q = @ch.queue(@token, :no_ack => true, :durable => true)
    @x = @ch.default_exchange
  end

  def start_connection
    @connection = Bunny.new
    @connection.start
    @ch = @connection.create_channel
  end


  def recieve_command callback
    @q.subscribe(:block => true) do |di, props, payload|
      @global_token = props.reply_to
      data = JSON.parse(payload)
      sender_token = data['queue']
      message = data['body']
      callback.call(sender_token, message)
    end
  end

  def push_answer reciever_id, message
    obj_to_send = {:text => message, :reply_to => reciever_id}

    @x.publish(obj_to_send.to_json, :routing_key => @global_token)
  end

end
