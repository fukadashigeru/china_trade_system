class MessagesController < ApplicationController
  def create
    @topic = Topic.find(params[:topic_id])
    @company_user = current_user.company_users.find_by(company: current_company)
    message = @topic.messages.build(message_params).tap do |message|
      message.company_user = @company_user
    end
    if message.save
      redirect_to japanese_retailer_topic_path(@topic)
    end
  end

  def message_params
    params.require(:message).permit(:content)
  end
end
