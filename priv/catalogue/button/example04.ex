defmodule SurfaceBulma.Catalogue.Button.Example04 do
  use Surface.Catalogue.Example,
    subject: SurfaceBulma.Button,
    catalogue: SurfaceBulma.Catalogue,
    title: "Groups of Buttons"

  def render(assigns) do
    ~H"""
    <div class="buttons has-addons">
      <Button color="success" selected>Yes</Button>
      <Button>Maybe</Button>
      <Button>No</Button>
    </div>

    <div class="buttons has-addons is-centered">
      <Button>Yes</Button>
      <Button color="info" selected>Maybe</Button>
      <Button>No</Button>
    </div>

    <div class="buttons has-addons is-right">
      <Button>Yes</Button>
      <Button>Maybe</Button>
      <Button color="danger" selected>No</Button>
    </div>
    """
  end
end
