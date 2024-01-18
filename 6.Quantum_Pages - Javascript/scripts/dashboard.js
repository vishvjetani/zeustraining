import fetchFunction from "./fetchfunction.js";

const toggleAlertandAnnouncement = (event) => {
  const checkbox = event.target;
  checkbox.disabled = true;
  const label = document.querySelector(`label[for="${checkbox.id}"]`);
  const boxName = checkbox.id;
  if (checkbox.id.substr(0, 5) == "alert") {
    document
      .getElementById(`alert_${boxName.charAt(boxName.length - 1)}`)
      .classList.remove("unread");
    document
      .getElementById(`alert_${boxName.charAt(boxName.length - 1)}`)
      .classList.add("read");
  } else {
    document
      .getElementById(`announcement_${boxName.charAt(boxName.length - 1)}`)
      .classList.remove("unread");
    document
      .getElementById(`announcement_${boxName.charAt(boxName.length - 1)}`)
      .classList.add("read");
  }
  const image = label.querySelector("img");
  image.src = "images/correct.png";
};

document.addEventListener("DOMContentLoaded", async () => {
  const courses =  await fetchFunction("./scripts/courses.json");
  renderQuantumDashboard(courses);

  const alerts = await fetchFunction("./scripts/alerts.json");
  renderAlerts(alerts);

  const announcements = await fetchFunction("./scripts/announcements.json");
  renderAnnouncements(announcements);

  const submenuItems = document.querySelectorAll(".has-submenu");

  submenuItems.forEach((item) => {
    const submenu = item.querySelector(".submenu");
    const caretbutton = item.querySelector(".caretbutton");
    const caretIcon = caretbutton.querySelector("img");

    caretbutton.addEventListener("click", (event) => {
      event.stopPropagation();
      console.log(caretIcon.style.transform);
      if (caretIcon.style.transform == "scale(-1, -1)") {
        caretIcon.style.transform = "none";
      } else {
        caretIcon.style.transform = "scale(-1, -1)";
      }
      submenu.classList.toggle("open");
    });

    document.addEventListener("click", () => {
      submenu.classList.remove("open");
    });
  });

  const checkboxesAlert = document.querySelectorAll(".alertcheck");
  checkboxesAlert.forEach((checkbox) => {
    checkbox.addEventListener("change", toggleAlertandAnnouncement);
  });

  const checkboxesAnnouncement =
    document.querySelectorAll(".announcementcheck");
  checkboxesAnnouncement.forEach((checkbox) => {
    checkbox.addEventListener("change", toggleAlertandAnnouncement);
  });
});

const renderQuantumDashboard = (courses) => {
  let mainContent = document.getElementsByClassName("main")[0];
  console.log(courses);
  for (let course of courses) {
    let coursedetails = `
                <div class="container bordercontainer">
                ${course.expired ? `<span class="expired">expired</span>` : ""}
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
};

const renderAlerts = (alerts) => {
  let alertContent = document.getElementsByClassName("alert-content")[0];
  let filteredAlerts = alerts.filter((alert) => alert["unread"] == true);
  let unreadCount = filteredAlerts.length;
  document.getElementById("noofalerts").innerHTML = unreadCount;
  let count = 0;
  for (let alert of alerts) {
    let alertdetails = `
    <div class="check">
    <p class="alert_title">${alert.title}</p>
   ${
     alert.unread
       ? `<input type="checkbox" id="alertcheckbox_${count}" class="hidden alertcheck">
      <label for="alertcheckbox_${count}"> 
        <img src="images/dnd.png" class="correct">
      </label>`
       : `<img src="images/correct.png" class="correct">`
   }

    </div>
                            ${
                              alert.course
                                ? `<p>Course : <span class="highlight">${alert.course}</span></p>`
                                : ""
                            }
                            ${
                              alert.class
                                ? `<p>Class : <span class="highlight">${alert.class}</span></p>`
                                : ""
                            }
                            <p class="time">${alert.date} at ${alert.time}</p>
                         `;
    let alertContainer = document.createElement("div");
    alertContainer.innerHTML = alertdetails;
    alertContainer.classList.add("alert-box");
    alert.unread
      ? alertContainer.classList.add("unread")
      : alertContainer.classList.add("read");
    alertContainer.id = `alert_${count}`;
    alertContent.appendChild(alertContainer);
    count++;
  }
};

const renderAnnouncements = (announcements) => {
  let announcementContent = document.getElementsByClassName(
    "announcement-content"
  )[0];
  let filteredAnnouncements = announcements.filter(
    (announcement) => announcement["unread"] == true
  );
  let unreadCount = filteredAnnouncements.length;
  document.getElementById("noofannouncements").innerHTML = unreadCount;
  let count = 0;
  for (let announcement of announcements) {
    let announcementdetails = `
      <div class="check">
      <p>PA: ${announcement.PA}</p>
      ${
        announcement.unread
          ? `<input type="checkbox" id="announcementcheckbox_${count}"  class="hidden announcementcheck">
      <label for="announcementcheckbox_${count}"> 
        <img src="images/dnd.png" class="correct">
      </label>`
          : `<img src="images/correct.png" class="correct">`
      }
      </div>
                  <p>${announcement.message}</p>
                  ${
                    announcement.course
                      ? `<p class="highlight">Course: ${announcement.course}</p>`
                      : ``
                  }
                 <p class="instruction">
                     ${
                       announcement.files
                         ? `<span class="announcement-file"><img src="images/attach-file.png" class="attach">${announcement.files} files are attached</span>`
                         : ``
                     } <span class="announcement-date">${
      announcement.date
    } at ${announcement.time}</span>
        </p>
      `;

    let announcementContainer = document.createElement("div");
    announcementContainer.innerHTML = announcementdetails;
    announcementContainer.classList.add("announcement-box");
    announcement.unread
      ? announcementContainer.classList.add("unread")
      : announcementContainer.classList.add("read");
    announcementContainer.id = `announcement_${count}`;
    announcementContent.appendChild(announcementContainer);
    count++;
  }
};
