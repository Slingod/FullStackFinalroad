function toggleMenu() {
    const navLinks = document.getElementById("navLinks");
    navLinks.style.display = navLinks.style.display === "flex" ? "none" : "flex";
}
const isLoggedIn = <%= user_signed_in? ? 'true' : 'false' %>;

document.addEventListener("DOMContentLoaded", () => {
    const loginBtn = document.getElementById("login-btn");
    const signupBtn = document.getElementById("signup-btn");
    const logoutForm = document.getElementById("logout-form");

    if (isLoggedIn) {
        loginBtn.style.display = "none";
        signupBtn.style.display = "none";
        logoutForm.style.display = "block";
    } else {
        loginBtn.style.display = "inline-block";
        signupBtn.style.display = "inline-block";
        logoutForm.style.display = "none";
    }
});