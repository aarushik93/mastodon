# frozen_string_literal: true

class Admin::AccountDeletionWorker
  include Sidekiq::Worker

  sidekiq_options queue: 'pull', lock: :until_executed

  def perform(account_id)
    DeleteAccountService.new.call(Account.find(account_id), reserve_username: false, reserve_email: false)
  rescue ActiveRecord::RecordNotFound
    true
  end
end
