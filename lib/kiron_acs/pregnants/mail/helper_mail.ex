defmodule KironAcs.Pregnants.Mail.HelperMail do
  import Bamboo.Email

  def create(name, to_mail, from_mail, title, description) do
    new_email(
      to: to_mail,
      from: from_mail,
      subject: title,
      text_body: description,
      html_body: html(name, title, description)
    )
  end

  defp html(name, title, description) do
    "<h1>Solicitação de ajuda!</h1><h3>#{name} enviou a solicitação com as seguintes informações:</h3><p><strong>Assunto:</strong> #{title}</p><p><strong>Descrição:</strong> #{description}</p>"
  end
end
