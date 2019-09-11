defmodule TutorialAppWeb.CMS.PageView do
  use TutorialAppWeb, :view

  alias TutorialApp.CMS

  def author_name(%CMS.Page{author: author}) do
    author.user.name
  end
end
