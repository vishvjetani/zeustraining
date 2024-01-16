document.addEventListener("DOMContentLoaded", () => {
  fetch("./scripts/courses.json")
    .then((courses) => {
      if (!courses.ok) {
        throw new Error(`HTTP error! Status: ${response.status}`);
      }
      return courses.json();
    })
    .then((data) => {
      renderQuantumDashboard(data);
    })
    .catch((error) => {
      console.error("Error loading the JSON file:", error);
    });

  fetch("./scripts/alerts.json")
    .then((alerts) => {
      if (!alerts.ok) {
        throw new Error(`HTTP error! Status: ${response.status}`);
      }
      return alerts.json();
    })
    .then((data) => {
      renderAlerts(data);
    })
    .catch((error) => {
      console.error("Error loading the JSON file:", error);
    });

  fetch("./scripts/announcements.json")
    .then((announcements) => {
      if (!announcements.ok) {
        throw new Error(`HTTP error! Status: ${response.status}`);
      }
      return announcements.json();
    })
    .then((data) => {
      renderAnnouncements(data);
    })
    .catch((error) => {
      console.error("Error loading the JSON file:", error);
    });
});

const renderQuantumDashboard = (courses) => {
  let mainContent = document.getElementsByClassName("main")[0];
  console.log(courses);
  for (let course of courses) {
    let coursedetails = `
                <div class="container bordercontainer">
                    <div><img src=${course.image} class="course-icon"></div>
                    <div class="contentdiv">
                        <p class="containerheader">${course.name}</p>
                        <p><span class="subject">${
                          course.subject
                        } </span> | Grade ${
      course.grade.mainGrade
    } <span class="extra">+2</span></p>
                        ${
                          course.syllabus
                            ? `<p><span class="digit">${course.syllabus.units}</span> Units <span class="digit">${course.syllabus.lessons}</span> Lessons <span
                                class="digit">${course.syllabus.topics}</span> Topics</p>`
                            : ""
                        }
                        <select>
                        ${course.class.all.map(
                          (courseclass) =>
                            `<option value=${courseclass} ${
                              courseclass == course.class.selected
                                ? `selected`
                                : ``
                            }
                                >${courseclass}</option>`
                        )}
                        </select>
                        <p>${
                          course.noofstudents
                            ? `${course.noofstudents} +  Students`
                            : ``
                        }
                            
                        ${
                          course.date
                            ? ` |  ${course.date[0]} - ${course.date[1]}`
                            : ""
                        }</p>
                    </div>
                    <div>
                        <img src="images/favourite.svg" class="favourite">
                    </div>
                </div>
                <div class="container iconcontainer">
                    <span><img src="images/preview.svg"></span>
                    <span><img src="images/manage course.svg"></span>
                    <span><img src="images/grade submissions.svg"></span>
                    <span><img src="images/reports.svg"></span>
                </div>
            `;
    let mainContainer = document.createElement("div");
    mainContainer.innerHTML = coursedetails;
    mainContainer.classList.add("main_container");
    mainContent.appendChild(mainContainer);
  }
}

const renderAlerts = (alerts) => {
  let alertPreview = document.getElementsByClassName("alert-preview")[0];

  document.getElementById("noofalerts").innerHTML = alerts.length;
  console.log(alerts);

  for (let alert of alerts) {
    let alertdetails = `
                            <p class="alert_title">${alert.title}</p>
                            ${
                              alert.course
                                ? `<p>Course : <span class="alert-highlight">${alert.course}</span></p>`
                                : ""
                            }
                            ${
                              alert.class
                                ? `<p>Class : <span class="alert-highlight">${alert.class}</span></p>`
                                : ""
                            }
                            <p class="time">${alert.date} at ${alert.time}</p>
                         `;
    let alertContainer = document.createElement("div");
    alertContainer.innerHTML = alertdetails;
    alertContainer.classList.add("alert-box");
    alertPreview.appendChild(alertContainer);
  }
}

const renderAnnouncements= (announcements) => {
    console.log(announcements);
    let announcementPreview = document.getElementsByClassName("announcement-preview")[0];

    for (let announcement of announcements) { 
      let announcementdetails = `
       <p>PA: ${announcement.PA}</p>
                  <p>${announcement.message}</p>
                  <p class="instruction">
                      <span>${announcement.files} files are attached</span> <span>${announcement.date} at ${announcement.time}</span>
        </p>
      `;
      let announcementContainer = document.createElement("div");
      announcementContainer.innerHTML = announcementdetails;
      announcementContainer.classList.add("announcement-box");
      announcementPreview.appendChild(announcementContainer);
  }
  

}