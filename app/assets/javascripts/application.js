document.addEventListener("DOMContentLoaded", () => {
    const flashMessages = document.querySelectorAll(".flash");
    flashMessages.forEach((flash) => {
      setTimeout(() => {
        flash.classList.add("fade-out");
      }, 5000); // 5 second before fade out
    });
  });
  