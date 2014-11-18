class ContactsController < ApplicationController
  # GET /contacts
  # GET /contacts.json
  def index
    p session[:user].id if !session[:user].nil?
    p "99999"
    @contacts = Contact.where("user_id=?",session[:user].id ) if !session[:user].nil?

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @contacts }
    end
  end

  # GET /contacts/1
  # GET /contacts/1.json
  def show
    @contact = Contact.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @contact }
    end
  end

  # GET /contacts/new
  # GET /contacts/new.json
  def new
    @contact = Contact.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @contact }
    end
  end

  # GET /contacts/1/edit
  def edit
    @contact = Contact.find(params[:id])
  end

  # POST /contacts
  # POST /contacts.json
  def create
     @contact = Contact.new
     old_user=User.where("email=?",params[:contact][:contact_email]).last
     @contact.user_id=session[:user].id
     @contact.contact_email=params[:contact][:contact_email]
     @contact.contact_name=params[:contact][:contact_name]
     @contact.app_user_id= old_user.id if !old_user.nil?
     @contact.contact_from= "myapp" 
     @contact.contact_type= old_user ? "member" : "non_member"
    respond_to do |format|
      if @contact.save
        format.html { redirect_to @contact, notice: 'Contact was successfully created.' }
        format.json { render json: @contact, status: :created, location: @contact }
      else
        format.html { render action: "new" }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /contacts/1
  # PUT /contacts/1.json
  def update
    @contact = Contact.find(params[:id])

    respond_to do |format|
      if @contact.update_attributes(params[:contact])
        format.html { redirect_to @contact, notice: 'Contact was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contacts/1
  # DELETE /contacts/1.json
  def destroy
    @contact = Contact.find(params[:id])
    @contact.destroy

    respond_to do |format|
      format.html { redirect_to contacts_url }
      format.json { head :no_content }
    end
  end

  def facebook_contact_list
    @contacts = request.env['omnicontacts.contacts']
    @user_contacts = request.env['omnicontacts.user']
    #code= request.env['omnicontacts.access_token']
    #@code= request.env["QUERY_STRING"]
    #@code= request.env['omniauth.auth']
  end


  def contact_list
    @contacts = request.env['omnicontacts.contacts']
  end

   def add_contact_success
    if !params[:subList].nil?
      contact_type = cookies[:from]
      @c_old =[]
      @c_id =[]
      @sublist = []
      @sublist << params[:subList]
      @s_value = params[:subList].count
      @cuser = User.where("id = ? ", params[:user_id]).last
      @pre_con=Contact.where("user_id = ? ", params[:user_id])
      params[:subList].each do |co|
        @val = co.split("^")
        @old_email = User.find_by_email(@val[0])
        @old_contact = Contact.find_by_contact_email_and_user_id(@val[0],params[:user_id])
        @sameuser = params[:user_email]==@val[0]
        if !@old_contact && !@sameuser
          @friend = Contact.new
          @friend.contact_email =@val[0]
          @friend.contact_name =@val[1]
          @friend.user_id = params[:user_id]
          @friend.contact_from = "gmail"
          @friend.contact_type= @old_email ? "member" : "non_member"
          @friend.app_user_id = @old_email.user_id if !@old_email.nil? && !@old_email.user_id.nil?
          @friend.save
          p @friend
        else
          @c_old << @old_contact
        end
        #group_old_email= @c_old.collect{|f|f["contact_email"]}.join(',')
        @g1 =@c_old.count
        @group = @s_value - @g1
      end
      @cur_con=Contact.find(:all,:conditions=>["user_id = ? ", params[:user_id]])
      @rm_con=@cur_con - @pre_con if !@cur_con.nil? && !@pre_con.nil?
      @contact=@rm_con + @c_old
      @contact.each do |c|
        @c_id<< c.id if !c.nil?
      end
      cookies[:all_con]=@c_id
      respond_to do |format|
        session[:user] = @cuser
        format.html {render :template => 'contacts/add_contact_success', :layout => false}
      end
    end
  end
end
