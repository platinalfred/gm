!function(t){t.fn.priceFormat=function(n){var n=t.extend(!0,{},t.fn.priceFormat.defaults,n);return window.ctrl_down=!1,metaKey=!1,t(window).bind("keyup keydown",function(t){return window.ctrl_down=t.ctrlKey,!0}),t(this).bind("keyup keydown",function(t){return metaKey=t.metaKey,!0}),this.each(function(){function r(t){p.is("input")?p.val(t):p.html(t),p.trigger("pricechange")}function i(){return d=p.is("input")?p.val():p.html()}function e(t){for(var n="",r=0;r<t.length;r++)char_=t.charAt(r),0==n.length&&0==char_&&(char_=!1),char_&&char_.match(m)&&(y?n.length<y&&(n+=char_):n+=char_);return n}function a(t){for(;t.length<b+1;)t="0"+t;return t}function o(n,r){if(!r&&(""===n||n==o("0",!0))&&K)return"";var i=a(e(n)),c="",f=0;0==b&&(_="",u="");var u=i.substr(i.length-b,b),l=i.substr(0,i.length-b);if(i=O?l+_+u:"0"!==l?l+_+u:_+u,w||""!=t.trim(w)){for(var s=l.length;s>0;s--)char_=l.substr(s-1,1),f++,f%3==0&&(char_=w+char_),c=char_+c;c.substr(0,1)==w&&(c=c.substring(1,c.length)),i=0==b?c:c+_+u}return!k||0==l&&0==u||(i=n.indexOf("-")!=-1&&n.indexOf("+")<n.indexOf("-")?"-"+i:F?"+"+i:""+i),v&&(i=v+i),g&&(i+=g),i}function c(t){var n=t.keyCode?t.keyCode:t.which,i=String.fromCharCode(n),e=!1,a=d,c=o(a+i);(n>=48&&n<=57||n>=96&&n<=105)&&(e=!0),192==n&&(e=!0),8==n&&(e=!0),9==n&&(e=!0),13==n&&(e=!0),46==n&&(e=!0),37==n&&(e=!0),39==n&&(e=!0),!k||189!=n&&109!=n&&173!=n||(e=!0),!F||187!=n&&107!=n&&61!=n||(e=!0),n>=16&&n<=20&&(e=!0),27==n&&(e=!0),n>=33&&n<=40&&(e=!0),n>=44&&n<=46&&(e=!0),(window.ctrl_down||metaKey)&&(86==n&&(e=!0),67==n&&(e=!0),88==n&&(e=!0),82==n&&(e=!0),84==n&&(e=!0),76==n&&(e=!0),87==n&&(e=!0),81==n&&(e=!0),78==n&&(e=!0),65==n&&(e=!0)),e||(t.preventDefault(),t.stopPropagation(),a!=c&&r(c))}function f(){var t=i(),n=o(t);t!=n&&r(n);var e=o("0",!0);n==e&&"0"!=t&&K&&r("")}function u(){p.val(v+i())}function l(){p.val(i()+g)}function s(){if(""!=t.trim(v)&&x){var n=i().split(v);r(n[1])}}function h(){if(""!=t.trim(g)&&S){var n=i().split(g);r(n[0])}}var p=t(this),d="",m=/[0-9]/;d=p.is("input")?p.val():p.html();var v=n.prefix,g=n.suffix,_=n.centsSeparator,w=n.thousandsSeparator,y=n.limit,b=n.centsLimit,x=n.clearPrefix,S=n.clearSuffix,k=n.allowNegative,F=n.insertPlusSign,K=n.clearOnEmpty,O=n.leadingZero;F&&(k=!0),p.bind("keydown.price_format",c),p.bind("keyup.price_format",f),p.bind("focusout.price_format",f),x&&(p.bind("focusout.price_format",function(){s()}),p.bind("focusin.price_format",function(){u()})),S&&(p.bind("focusout.price_format",function(){h()}),p.bind("focusin.price_format",function(){l()})),i().length>0&&(f(),s(),h())})},t.fn.unpriceFormat=function(){return t(this).unbind(".price_format")},t.fn.unmask=function(){var n,r="";n=t(this).is("input")?t(this).val()||[]:t(this).html();for(var i=0;i<n.length;i++)isNaN(n[i])&&"-"!=n[i]||(r+=n[i]);return r},t.fn.priceToFloat=function(){return t(this).is("input")?field=t(this).val()||[]:field=t(this).html(),parseFloat(field.replace(/[^0-9\-\.]/g,""))},t.fn.priceFormat.defaults={prefix:"UGX ",suffix:"",centsSeparator:".",thousandsSeparator:",",limit:!1,centsLimit:2,clearPrefix:!1,clearSufix:!1,allowNegative:!1,insertPlusSign:!1,clearOnEmpty:!1,leadingZero:!0}}(jQuery);