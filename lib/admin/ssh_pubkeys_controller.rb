class Admin::SshPubkeysController < Admin::UsersController
  def new
    @ssh_pubkey = SshPubkey.new(:user_id => params[:user_id])

    respond_to do |format|
      format.html
      format.xml { render :xml => @ssh_pubkey }
    end
  end
  def create
    @ssh_pubkey = SshPubkey.new(:user_id => params[:user_id], :pubkey => params[:ssh_pubkey][:pubkey])

    respond_to do |format|
      if @ssh_pubkey.save
        flash[:notice] = _('SSH public Key succesfully added.')
        format.html { redirect_to admin_users_path }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @ssh_pubkey.errors, :status => :unprocessable_entity }
      end
    end
  end
  def delete
  end
end
