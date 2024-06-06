var sold = [];
var bought;
var bought_card;


for (const button of document.getElementsByName("sell-button")) {
  button.addEventListener("click", handleClickSold);
}

for (const button of document.getElementsByName("buy-button")) {
  button.addEventListener("click", handleClickBought);
}

function handleClickSold(event) {
  let i = Number(event.target.attributes["data-index"].value);
  
  if(sold.includes(i)) {
    sold.splice(sold.indexOf(i), 1);
    event.target.classList.remove("border");
  }
  else {
    sold.push(i);
    event.target.classList.add("border");
  }
  updateForm()
}

function handleClickBought(event) {
  let i = Number(event.target.attributes["data-index"].value);
  if (i == -1) {
    return
  }

  if(event.target == bought_card) {
    bought_card.classList.remove("border");
    bought = null;
    bought_card = null;
  }
  else {
    if (bought_card) {
      bought_card.classList.remove("border");
    }

    bought = i;
    bought_card = event.target
    bought_card.classList.add("border");
  }
  updateForm()
}

function updateForm() {
  let form = document.getElementById("confirm-form");
  let button = document.getElementById("confirm-button");

  if (sold.length > 0 && bought != null) {
    button.removeAttribute("disabled");
  }
  else {
    button.setAttribute("disabled", "disabled");
    return
  }

  for (var i = 0; i < form.children.length;) {
    if (form.children[i].name == "bought" || form.children[i].name == "sold[]") {
      form.removeChild(form.children[i]);
      console.log("removed ^");
    }
    else {
      ++i;
    }
  }

  {
    var input = document.createElement("input");
    input.type = "hidden";
    input.name = "bought";
    input.value = bought;
    form.appendChild(input);
  }

  sold.forEach((v, i) => {
    var input = document.createElement("input");
    input.type = "hidden";
    input.name = "sold[]";
    input.value = v;
    form.appendChild(input);
  });
}