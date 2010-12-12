class SshPubkeysController < ApplicationController
  before_filter :account_management_enabled?
  before_filter :assign_user
  before_filter :find_pubkey, :only => [:edit, :update, :destroy]
  before_filter :new_pubkey, :only => [:new, :create]

  def new
  end

  def create
    @ssh_pubkey.pubkey = params[:ssh_pubkey][:pubkey]

    respond_to do |format|
      if @ssh_pubkey.save
        flash[:notice] = _('SSH public Key succesfully added.')
        format.html { redirect_to account_path }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @ssh_pubkey.errors, :status => :unprocessable_entity }
      end
    end
  end

  def edit
  end
  def update
    @ssh_pubkey.pubkey = params[:ssh_pubkey][:pubkey]

    respond_to do |format|
      if @ssh_pubkey.save
        flash[:notice] = _('SSH public Key succesfully updated.')
        format.html { redirect_to account_path }
      else
       format.html { render :action => "edit" }
       format.xml  { render :xml => @ssh_pubkey.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @ssh_pubkey.destroy

    respond_to do |format|
      if @ssh_pubkey.errors.empty?
        flash[:notice] = _('SSH Public Key was successfully deleted.')
        format.html { redirect_to account_path }
        format.xml { head :ok }
      else
        flash[:error] = [_('SSH Public Key could not be deleted. Following error(s) occurred') + ':'] + @ssh_pubkey.errors.full_messages
        format.html { redirect_to account_path }
        format.xml  { render :xml => @ssh_pubkey.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  protected

  def find_pubkey
    @ssh_pubkey = SshPubkey.find(params[:id])
  end
  def new_pubkey
    @ssh_pubkey = SshPubkey.new(:user_id => @user.id)
  end
  def assign_user
    @user = User.current
  end
  def account_management_enabled?
    return configured?(:account_management) || raise_unknown_action_error
  end
  def user_is_public?
  end
  
  private
  
  def configured?(option, value = true)
    config[option] == value
  end

  def config
    RetroCM[:general][:user_management]
  end

  def raise_unknown_action_error
    raise ::ActionController::UnknownAction, 'Action is hidden', caller
  end
end
