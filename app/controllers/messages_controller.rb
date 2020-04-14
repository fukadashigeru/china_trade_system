class MessagesController < ApplicationController
  def create
    @topic = Topic.find(params[:topic_id])
    @company_user = current_company_user
    message = @topic.messages.build(message_params).tap do |message|
      message.company_user = @company_user
    end
    if message.save
      redirect_to topic_path(@topic, before_page_type: params[:before_page_type])
    end
  end

  def message_params
    params.require(:message).permit(:content)
  end
end
