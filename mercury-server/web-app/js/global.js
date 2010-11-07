
/*
 * Copyright 2006-2009 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *       http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

/* This function is used to open a pop-up window */
function openWindow(url, winTitle, winParams) {
    var win = window.open(url, winTitle, winParams);
    if(!win.opener) win.opener = self;
    win.focus();
}

function openCenterWindow(url, winTitle, winParams, width, height) {
    var left;
    var top;
    var screenWidth = screen.availWidth;
    var screenHeight = screen.availHeight;

    width = screenWidth - (screenWidth - width);
    height = screenHeight - (screenHeight - height);
    left = (screenWidth-width)/2;
    top = (screenHeight-height)/2;
    winParams += ",width=" + width + ",height=" + height + ",left=" + left + ",top=" + top;

    win = window.open(url, winTitle, winParams);
    if(!win.opener) win.opener = self;
    win.focus();
}


/* This function is used to set cookies */
function setCookie(name, value, expires, path, domain, secure) {
    document.cookie = name + "=" + escape(value) +
                      ((expires) ? "; expires=" + expires.toGMTString() : "") +
                      ((path) ? "; path=" + path : "") +
                      ((domain) ? "; domain=" + domain : "") + ((secure) ? "; secure" : "");
}

/* This function is used to get cookies */
function getCookie(name) {
    var prefix = name + "="
    var start = document.cookie.indexOf(prefix)

    if (start == -1) {
        return null;
    }

    var end = document.cookie.indexOf(";", start + prefix.length)
    if (end == -1) {
        end = document.cookie.length;
    }

    var value = document.cookie.substring(start + prefix.length, end)
    return unescape(value);
}

/* This function is used to delete cookies */
function deleteCookie(name, path, domain) {
    if (getCookie(name)) {
        document.cookie = name + "=" +
                          ((path) ? "; path=" + path : "") +
                          ((domain) ? "; domain=" + domain : "") +
                          "; expires=Thu, 01-Jan-70 00:00:01 GMT";
    }
}

function navigate(url) {
    document.location.href = url;
}
