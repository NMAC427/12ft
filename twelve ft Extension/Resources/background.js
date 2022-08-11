// Common

function onError(error) {
    console.error(`Error: ${error}`);
}

function sendMessageToTabs(tabs) {
    for (let tab of tabs) {
        browser.tabs.sendMessage(tab.id, null)
        .then((response) => {
            console.log("Message from the content script:");
            console.log(response.response);
        }).catch(onError);
    }
}

function bypass_paywall() {
    browser.tabs.query({
        currentWindow: true,
        active: true
    })
    .then(sendMessageToTabs)
    .catch(onError);
}

// Listeners

browser.commands.onCommand.addListener((command) => {
    if (command === "bypass-paywall") {
        bypass_paywall();
    }
});

browser.browserAction.onClicked.addListener(() => {
    bypass_paywall();
})
