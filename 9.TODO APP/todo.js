let itemsCount = document.getElementById("todoCount");
document.addEventListener("DOMContentLoaded", () => {
  todoItems = localStorage.getItem("todos");
  if (todoItems == null) {
    todoItems = [];
  } else {
    todoItems = JSON.parse(todoItems);
    todoItems.forEach(renderTodo);
    renderCount(todoItems);
  }
});

const form = document.querySelector(".todo-form");
form.addEventListener("submit", (e) => {
  e.preventDefault();
  let input = document.querySelector("#todo_input");
  const text = input.value.trim();
  if (text != "") {
    addtodo(text);
    input.value = "";
    input.focus();
  }
});

const addtodo = (text) => {
  const todo = {
    text,
    checked: false,
    id: Date.now(),
  };
  todoItems.push(todo);
  localStorage.setItem("todos", JSON.stringify(todoItems));
  renderCount(todoItems);
  renderTodo(todo);
};

const renderTodo = (todo) => {
  const todolist = document.querySelector(".todo-list");
  const item = document.querySelector(`[data-key='${todo.id}']`);

  const isChecked = todo.checked ? "done" : "";
  let node = document.createElement("li");
  node.setAttribute("class", `todo-item ${isChecked}`);
  node.setAttribute("data-key", todo.id);
  node.innerHTML = `
  <input id=check-${todo.id} type="checkbox" class="js-tick" ${
    isChecked ? "checked" : ""
  }/>
  <span class="content">${todo.text}</span>
  <img src="editing.png" class="edit-todo btn-todo">
  <img src="x-button.png" class="delete-todo btn-todo">
    `;
  if (item) {
    todolist.replaceChild(node, item);
  } else {
    todolist.appendChild(node);
  }
};

const renderCount = (todoItems) => {
  console.log(todoItems);
  remainingItems = todoItems.reduce((acc, item) => {
    if (item.checked == false) {
      return acc + 1;
    } else {
      return acc;
    }
  }, 0);
  itemsCount.innerText = `You have ${remainingItems} task remaining out of ${todoItems.length} total tasks.`;
};

const list = document.querySelector(".todo-list");
list.addEventListener("click", (e) => {
  if (e.target.classList.contains("delete-todo")) {
    const itemKey = e.target.parentElement.dataset.key;
    e.target.parentElement.remove();
    todoItems = todoItems.filter((item) => item.id != itemKey);
    localStorage.setItem("todos", JSON.stringify(todoItems));
    renderCount(todoItems);
  }

  if (e.target.classList.contains("js-tick")) {
    const itemKey = e.target.parentElement.dataset.key;
    const itemIndex = todoItems.findIndex((item) => item.id == itemKey);
    todoItems[itemIndex].checked = !todoItems[itemIndex].checked;
    localStorage.setItem("todos", JSON.stringify(todoItems));
    renderCount(todoItems);
    renderTodo(todoItems[itemIndex]);
  }

  if (e.target.classList.contains("edit-todo")) {
    const itemKey = e.target.parentElement.dataset.key;
    const text = e.target.parentElement.children[1].textContent;
    e.target.parentElement.innerHTML = `
      <input type="text" name="todo" class="todoinput edittodo" value="${text}" id=${itemKey}>
        <input type="submit" value="Save" class="update">

        `;
    let iteminput = document.getElementById(itemKey);
    iteminput.setSelectionRange(iteminput.value.length, iteminput.value.length);
    iteminput.focus();
  }

  if (e.target.classList.contains("update")) {
    const itemKey = e.target.previousElementSibling.id;
    const itemIndex = todoItems.findIndex((item) => item.id == itemKey);
    const updatedValue = e.target.previousElementSibling.value;
    e.target.parentElement.innerHTML = `
    <input id=${itemKey} type="checkbox" class="js-tick" ${
      todoItems[itemIndex].checked ? "checked" : ""
    }/>
  <span class="content">${updatedValue}</span>
  <img src="editing.png" class="edit-todo btn-todo">
  <img src="x-button.png" class="delete-todo btn-todo">
    `;

    todoItems[itemIndex].text = updatedValue;
    localStorage.setItem("todos", JSON.stringify(todoItems));
  }
});


document.querySelector('.filter').addEventListener('click', (e) => {
  const id = e.target.id;
  console.log(e.target);
  console.log(id);
  if (id) {
    document.querySelector('.on').classList.remove('on');
    document.getElementById(id).classList.add('on');
    document.querySelector('.todo-list').className = `todo-list ${id}`;
  }
})