browser.runtime.onMessage.addListener((request, sender, sendResponse) => {
    if (window.location.host != "12ft.io") {
        window.location.href = `https://12ft.io/proxy?q=${window.location.href}`;
    } else {
        let url = new URL(window.location.href);
        let normal_href = url.searchParams.get("q");
        window.location.href = normal_href;
    }
});
