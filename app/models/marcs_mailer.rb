class MarcsMailer < ActionMailer::Base

  def member_details_update(member)
    @member = member
    mail(
      subject: 'Member details to be updated',
      to: ENV['MARCS_REGISTRAR_EMAIL'],
      from: ENV['MARCS_EMAIL'],
      tag: 'details-updated-notification'
    )
  end

end