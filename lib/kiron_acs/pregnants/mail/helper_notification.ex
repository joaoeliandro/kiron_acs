defmodule KironAcs.Pregnants.Mail.HelperNotification do
  alias KironAcs.Mailer
  alias KironAcs.Pregnants.Get, as: PregnantGet
  alias KironAcs.Pregnants.Mail.HelperMail
  alias KironAcs.{Agent, Pregnant}

  def send(%{"id" => id, "title" => title, "description" => description}) do
    {:ok, %Pregnant{full_name: name, email: email, agent: %Agent{} = agent}} = PregnantGet.get_by_id_preload(id)

    send_email(name, agent.email, email, title, description)

    {:ok, "Help request sent!"}
  end

  defp send_email(name, to_mail, from_mail, title, description) do
    name
    |> HelperMail.create(to_mail, from_mail, title, description)
    |> Mailer.deliver_later!()
  end
end
