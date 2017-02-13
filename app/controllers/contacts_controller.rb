class ContactsController < ApplicationController
  # GET /contact
  def show
    @contact = Contact.new
  end

  # POST /contact
  def create
    @contact = Contact.new(contact_params)
    @contact.ipaddr = request.env['HTTP_X_FORWARDED_FOR'] || request.remote_ip
    @contact.user = current_user if signed_in?
    @contact.save

    redirect_to contact_path, flash: { success: 'お問い合わせ頂きありがとうございます！数日以内に返答させて頂きます。' }
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :email, :text)
  end
end
