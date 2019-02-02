# Slack Dark Theme

A darker, more contrasty, Slack theme.

# Preview

![Screenshot](https://user-images.githubusercontent.com/806101/27455546-826b3d88-5752-11e7-8a6b-87285b90eb3e.png)

# Installing into Slack

Find your Slack's application directory.

* Windows: `%homepath%\AppData\Local\slack\`
* Mac: `/Applications/Slack.app/Contents/`
* Linux: `/usr/lib/slack/` (Debian-based)


## Bash Script Install (Mac/Linux)

First, make this file executable with the following command:
```bash
chmod 700 makeSlackDark.sh
```

Next, execute the script:
```bash
./makeSlackDark.sh
```


## Windows Script Install

```batch
git clone https://github.com/d-fay/slack-black-theme
cd slack-black-theme
makeSlackDark.bat
```
Then restart Slack

## Manual Install

Open up the most recent version (e.g. `app-3.1.1`) then open
`resources\app.asar.unpacked\src\static\index.js`
and
`resources\app.asar.unpacked\src\static\ssb-interop.js`

At the very bottom, add

```js
// First make sure the wrapper app is loaded
document.addEventListener("DOMContentLoaded", function() {

   // Then get its webviews
   let webviews = document.querySelectorAll(".TeamView webview");

   // Fetch our CSS in parallel ahead of time
   const cssPath = 'https://cdn.rawgit.com/widget-/slack-black-theme/master/custom.css';
   let cssPromise = fetch(cssPath).then(response => response.text());

   let customCustomCSS = `
   :root {
      /* Modify these to change your theme colors: */
      --primary: #61AFEF;
      --text: #ABB2BF;
      --background: #282C34;
      --background-elevated: #3B4048;
   }
   div.c-message.c-message--light.c-message--hover
   {
   color: #fff !important;
    background-color: #3B4048 !important;
   }

   div.c-virtual_list__scroll_container {
    background-color: #282C34 !important;
   }
   .p-message_pane .c-message_list:not(.c-virtual_list--scrollbar), .p-message_pane .c-message_list.c-virtual_list--scrollbar > .c-scrollbar__hider {
    z-index: 0;
   }

   div.comment.special_formatting_quote.content,.comment_body{
    color: #ABB2BF !important;
   }

   div.c-message:hover {
    background-color: #3B4048 !important;
   }

   div.c-message_attachment.c-message_attachment{
    color: #7c7b7b !important;
   }

   span.c-message_attachment__pretext{
    color: #7c7b7b !important;
   }

   hr.c-message_list__day_divider__line{
    background: #abb2bf !important;
   }

   div.c-message_list__day_divider__label__pill{
    background: #abb2bf !important;
   }   

   span.c-message__body,
   a.c-message__sender_link,
   span.c-message_attachment__media_trigger.c-message_attachment__media_trigger--caption,
   div.p-message_pane__foreword__description span
   {
       color: #afafaf !important;
   }

   pre.special_formatting{
     background-color: #222 !important;
     color: #8f8f8f !important;
     border: solid;
     border-width: 1 px !important;
    
   }

   span.c-message_kit__text{
     color: #afafaf !important;
   }

   span.c-channel_name__text{
    color: #afafaf !important;
   }

   span.p-threads_flexpane__separator_count{
    color: #afafaf !important;
   }

   span.c-label__text{
    color: #afafaf !important;
   }

   div.p-flexpane_header.p-threads_flexpane__header{
    color: #afafaf !important;
    background: #282C34 !important;
   }

   div..p-threads_footer__input.p-message_input_field{
    background: #282C34 !important;
   }
  
   button.p-threads_footer__input--legacy.p-message_input_plus{
    background: #282C34 !important;
   }

   div#client_body:not(.onboarding):not(.feature_global_nav_layout):before{
    background: transparent;    
   }

   div#client_body::before, #client_body:not(.onboarding):before{
    border-bottom: transparent !important;
   }

    `

   // Insert a style tag into the wrapper view
   cssPromise.then(css => {
      let s = document.createElement('style');
      s.type = 'text/css';
      s.innerHTML = css + customCustomCSS;
      document.head.appendChild(s);
   });

   // Wait for each webview to load
   webviews.forEach(webview => {
      webview.addEventListener('ipc-message', message => {
         if (message.channel == 'didFinishLoading')
            // Finally add the CSS into the webview
            cssPromise.then(css => {
               let script = `
                     let s = document.createElement('style');
                     s.type = 'text/css';
                     s.id = 'slack-custom-css';
                     s.innerHTML = \`${css + customCustomCSS}\`;
                     document.head.appendChild(s);
                     `
               webview.executeJavaScript(script);
            })
      });
   });
});
```

Notice that you can edit any of the theme colors using the custom CSS (for
the already-custom theme.) Also, you can put any CSS URL you want here,
so you don't necessarily need to create an entire fork to change some small styles.

That's it! Restart Slack and see how well it works.

NB: You'll have to do this every time Slack updates.

# Color Schemes

Here's some example color variations you might like.

## One Dark (_Default_)
![One Dark](https://user-images.githubusercontent.com/806101/27455546-826b3d88-5752-11e7-8a6b-87285b90eb3e.png)
```
--primary: #61AFEF;
--text: #ABB2BF;
--background: #282C34;
--background-elevated: #3B4048;
```

## Blackest
![Default](https://cloud.githubusercontent.com/assets/7691630/24120350/4cbb643e-0d82-11e7-8353-5d4eb65dfd6a.png)
```
--primary: #09F;
--text: #CCC;
--background: #080808;
--background-elevated: #222;
```

## Low Contrast
![Low Contrast](https://cloud.githubusercontent.com/assets/7691630/24120352/4ccdedf2-0d82-11e7-8ff7-c88e48b8e917.png)
```
--primary: #CCC;
--text: #999;
--background: #222;
--background-elevated: #444;
```

## Navy
![Navy](https://cloud.githubusercontent.com/assets/7691630/24120353/4cd08c4c-0d82-11e7-851a-4c62340456ad.png)
```
--primary: #FFF;
--text: #CCC;
--background: #225;
--background-elevated: #114;
```

# Development

`git clone` the project and `cd` into it.

Change the CSS URL to `const cssPath = 'http://localhost:8080/custom.css';`

Run a static webserver of some sort on port 8080:

```bash
npm install -g static
static .
```

In addition to running the required modifications, you will likely want to add auto-reloading:

```js
const cssPath = 'http://localhost:8080/custom.css';
const localCssPath = '/Users/bryankeller/Code/slack-black-theme/custom.css';

window.reloadCss = function() {
   const webviews = document.querySelectorAll(".TeamView webview");
   fetch(cssPath + '?zz=' + Date.now(), {cache: "no-store"}) // qs hack to prevent cache
      .then(response => response.text())
      .then(css => {
         console.log(css.slice(0,50));
         webviews.forEach(webview =>
            webview.executeJavaScript(`
               (function() {
                  let styleElement = document.querySelector('style#slack-custom-css');
                  styleElement.innerHTML = \`${css}\`;
               })();
            `)
         )
      });
};

fs.watchFile(localCssPath, reloadCss);
```

Instead of launching Slack normally, you'll need to enable developer mode to be able to inspect things.

* Mac: `export SLACK_DEVELOPER_MENU=true; open -a /Applications/Slack.app`

* Linux: (todo)

* Windows: (todo)

# License

Apache 2.0
