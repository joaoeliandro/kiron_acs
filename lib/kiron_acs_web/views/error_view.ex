defmodule KironAcsWeb.ErrorView do
  use KironAcsWeb, :view

  alias Ecto.Changeset

  def template_not_found(template, _assigns) do
    %{
      errors: %{
        detail: Phoenix.Controller.status_message_from_template(template)
      }
    }
  end

  def render("error.json", %{result: %Changeset{} = changeset}) do
    %{message: translate_errors(changeset)}
  end

  def render("error.json", %{result: result}) do
    %{message: result}
  end

  defp translate_errors(changeset) do
    Changeset.traverse_errors(changeset, fn {message, opts} ->
      Enum.reduce(opts, message, fn {key, value}, acc ->
        String.replace(acc, "%{#{key}}", to_string(value))
      end)
    end)
  end
end
