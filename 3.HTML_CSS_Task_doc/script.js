document.getElementById("excercise").addEventListener("submit", (e) => {
  e.preventDefault();
  
  const name = document.forms["excerciseform"]["fname"].value.trim();
  const comments = document.forms["excerciseform"]["comments"].value.trim();
  const gender = document.forms["excerciseform"]["gender"].value;

  const nameerror = document.getElementById("nameerror");
  const commentserror = document.getElementById("commentserror");
  const gendererror = document.getElementById("gendererror");

  const nameempty = name === "";
  const commentsempty = comments === "";
  const genderempty = gender === "";

  nameerror.innerHTML = nameempty ? "Name field must not be empty" : "";
  commentserror.innerHTML = commentsempty ? "Comments field must not be empty" : "";
  gendererror.innerHTML = genderempty ? "Please select the gender" : "";

  if (nameempty || commentsempty || genderempty) {
    alert("All fields are compulsory");
    if (nameempty) {
      document.getElementById("fname").focus();
    } else if (commentsempty) {
      document.getElementById("comments").focus();
    } else {
      document.getElementById("male").focus();
    }
  } else {
    window.location.href = "submit.html";
  }
});
