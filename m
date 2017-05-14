Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <thomas@m3y3r.de>) id 1d9v4d-0006of-8z
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 14 May 2017 15:04:43 +0000
Received: from www17.your-server.de ([213.133.104.17])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1d9v4c-0001D6-EH
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 14 May 2017 15:04:43 +0000
Received: from [95.222.29.91] (helo=localhost.localdomain)
	by www17.your-server.de with esmtpsa
	(TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256) (Exim 4.85_2)
	(envelope-from <thomas@m3y3r.de>) id 1d9v4V-0003sO-TT
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 14 May 2017 17:04:35 +0200
Message-ID: <1494774193.13299.4.camel@m3y3r.de>
From: Thomas Meyer <thomas@m3y3r.de>
Date: Sun, 14 May 2017 17:03:13 +0200
Mime-Version: 1.0
Subject: [uml-devel] [PATCH 1/3] um: stub-data.h: remove superfluous include
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============5545827532600076823=="
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>


--===============5545827532600076823==
Content-Type: multipart/alternative; boundary="=-UEggL6SwuXofVixdZ3Ro"


--=-UEggL6SwuXofVixdZ3Ro
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
---
 arch/um/include/shared/skas/stub-data.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/um/include/shared/skas/stub-data.h
b/arch/um/include/shared/skas/stub-data.h
index a9deece..13f404e 100644
--- a/arch/um/include/shared/skas/stub-data.h
+++ b/arch/um/include/shared/skas/stub-data.h
@@ -8,8 +8,6 @@
 #ifndef __STUB_DATA_H
 #define __STUB_DATA_H
 
-#include <time.h>
-
 struct stub_data {
 	unsigned long offset;
 	int fd;
--=-UEggL6SwuXofVixdZ3Ro
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<html><head><style id=3D"-x-evo-quote-style" type=3D"text/css">.-x-evo-quot=
ed { -webkit-user-select: none; }</style><style id=3D"-x-evo-style-a" type=
=3D"text/css">a { cursor: text; }</style><style id=3D"-x-evo-a-color-style"=
 type=3D"text/css">a { color: #2a76c6; }</style><style id=3D"-x-evo-a-color=
-style-visited" type=3D"text/css">a.-x-evo-visited-link { color: #2e3436; }=
</style><style id=3D"-x-evo-composer-sheet" media=3D"screen" type=3D"text/c=
ss">body {
  font-family: 'Monospace';
  font-size: 11pt;
  font-weight: 400;
  font-style: normal;
 -webkit-line-break: after-white-space;
 -webkit-font-smoothing: antialiased;
}
pre,code,.pre {
  font-family: 'Monospace';
  font-size: 11pt;
  font-weight: 400;
  font-style: normal;
}p,pre,code,address {
  margin: 0;
}
h1,h2,h3,h4,h5,h6 {
  margin-top: 0.2em;
  margin-bottom: 0.2em;
}
td:before {
 content: "=E2=80=8B";}
img {
  height: inherit;=20
  width: inherit;=20
}
span.-x-evo-resizable-wrapper:hover {
  outline: 1px dashed red;=20
  resize: both;=20
  overflow: hidden;=20
  display: inline-block;=20
}
td:hover {
  outline: 1px dotted red;
}
body[data-evo-plain-text] {
  font-family: Monospace;=20
}
body[data-evo-plain-text] img.-x-evo-smiley-img, body:not([data-evo-plain-t=
ext]) span.-x-evo-smiley-text {
  display: none=20
}
[data-evo-paragraph] {
  white-space: pre-wrap;=20
}
body[data-evo-plain-text] [data-evo-paragraph] {
  word-wrap: break-word;=20
  word-break: break-word;=20
}
.-x-evo-plaintext-table {
  border-collapse: collapse;
  width: 71ch;
}
.-x-evo-plaintext-table td {
  vertical-align: top;
}
td > * {
  display : inline-block;
}
body[data-evo-plain-text] ul {
  list-style: outside none;
  -webkit-padding-start: 3ch;=20
}
body[data-evo-plain-text] ul > li {
  list-style-position: outside;
  text-indent: -2ch;
}
body[data-evo-plain-text] ul > li::before {
  content: "*=C2=A0";
}
body[data-evo-plain-text] ul.-x-evo-indented {
  -webkit-padding-start: 3ch;=20
}
body:not([data-evo-plain-text]) ul > li.-x-evo-align-center,ol > li.-x-evo-=
align-center {
  list-style-position: inside;
}
body:not([data-evo-plain-text]) ul > li.-x-evo-align-right, ol > li.-x-evo-=
align-right {
  list-style-position: inside;
}
ol {
  -webkit-padding-start: 6ch;=20
}
ol.-x-evo-indented {
  -webkit-padding-start: 3ch;=20
}
.-x-evo-align-left {
  text-align: left;=20
}
.-x-evo-align-center {
  text-align: center;=20
}
.-x-evo-align-right {
  text-align: right;=20
}
ol,ul {
  -webkit-margin-before: 0em;=20
  -webkit-margin-after: 0em;=20
}
blockquote {
  -webkit-margin-before: 0em;=20
  -webkit-margin-after: 0em;=20
}
a {
  word-wrap: break-word;=20
  word-break: break-all;=20
}
blockquote[type=3Dcite] {
  padding: 0.0ex 0ex;
  margin: 0ex;
  -webkit-margin-start: 0em;=20
  -webkit-margin-end : 0em;=20
  color: #737373 !important;=20
}
.-x-evo-quote-character {
  color: rgb(114,159,207);
}
.-x-evo-quote-character+.-x-evo-quote-character{
  color: rgb(173,127,168);
}
.-x-evo-quote-character+.-x-evo-quote-character+.-x-evo-quote-character{
  color: rgb(138,226,52);
}
.-x-evo-quote-character+.-x-evo-quote-character+.-x-evo-quote-character+.-x=
-evo-quote-character{
  color: rgb(252,175,62);
}
.-x-evo-quote-character+.-x-evo-quote-character+.-x-evo-quote-character+.-x=
-evo-quote-character+.-x-evo-quote-character{
  color: rgb(233,185,110);
}
body:not([data-evo-plain-text]) blockquote[type=3Dcite] {
  padding: 0ch 1ch 0ch 1ch;
  margin: 0ch;
  border-width: 0px 2px 0px 2px;
  border-style: none solid none solid;
  border-radius: 2px;
}
body:not([data-evo-plain-text]) blockquote[type=3Dcite] {
  border-color: rgb(114,159,207);
}
body:not([data-evo-plain-text]) blockquote[type=3Dcite] blockquote[type=3Dc=
ite] {
  border-color: rgb(173,127,168);
}
body:not([data-evo-plain-text]) blockquote[type=3Dcite] blockquote[type=3Dc=
ite] blockquote[type=3Dcite] {
  border-color: rgb(138,226,52);
}
body:not([data-evo-plain-text]) blockquote[type=3Dcite] blockquote[type=3Dc=
ite] blockquote[type=3Dcite] blockquote[type=3Dcite] {
  border-color: rgb(252,175,62);
}
body:not([data-evo-plain-text]) blockquote[type=3Dcite] blockquote[type=3Dc=
ite] blockquote[type=3Dcite] blockquote[type=3Dcite] blockquote[type=3Dcite=
] {
  border-color: rgb(233,185,110);
}
</style></head><body data-evo-plain-text=3D"" bgcolor=3D"#ffffff" text=3D"#=
2e3436" link=3D"#2a76c6" vlink=3D"#2e3436" style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space;" data-evo-=
draft=3D""><div data-evo-paragraph=3D"" class=3D"" style=3D"width: 71ch;"><=
span id=3D"-x-evo-selection-start-marker" data-anchor=3D""></span><span id=
=3D"-x-evo-selection-end-marker"></span>Signed-off-by: Thomas Meyer &lt;<a =
href=3D"mailto:thomas@m3y3r.de">thomas@m3y3r.de</a>&gt;</div><div data-evo-=
paragraph=3D"" class=3D"" style=3D"width: 71ch;">---</div><div data-evo-par=
agraph=3D"" class=3D"" style=3D"width: 71ch;">&nbsp;arch/um/include/shared/=
skas/stub-data.h | 2 --</div><div data-evo-paragraph=3D"" class=3D"" style=
=3D"width: 71ch;">&nbsp;1 file changed, 2 deletions(-)</div><div data-evo-p=
aragraph=3D"" class=3D"" style=3D"width: 71ch;"><br></div><div data-evo-par=
agraph=3D"" class=3D"" style=3D"width: 71ch;">diff --git a/arch/um/include/=
shared/skas/stub-data.h<span data-hidden-space=3D""></span><br class=3D"-x-=
evo-wrap-br">b/arch/um/include/shared/skas/stub-data.h</div><div data-evo-p=
aragraph=3D"" class=3D"" style=3D"width: 71ch;">index a9deece..13f404e 1006=
44</div><div data-evo-paragraph=3D"" class=3D"" style=3D"width: 71ch;">--- =
a/arch/um/include/shared/skas/stub-data.h</div><div data-evo-paragraph=3D""=
 class=3D"" style=3D"width: 71ch;">+++ b/arch/um/include/shared/skas/stub-d=
ata.h</div><div data-evo-paragraph=3D"" class=3D"" style=3D"width: 71ch;">@=
@ -8,8 +8,6 @@</div><div data-evo-paragraph=3D"" class=3D"" style=3D"width:=
 71ch;">&nbsp;#ifndef __STUB_DATA_H</div><div data-evo-paragraph=3D"" class=
=3D"" style=3D"width: 71ch;">&nbsp;#define __STUB_DATA_H</div><div data-evo=
-paragraph=3D"" class=3D"" style=3D"width: 71ch;">&nbsp;</div><div data-evo=
-paragraph=3D"" class=3D"" style=3D"width: 71ch;">-#include &lt;time.h&gt;<=
/div><div data-evo-paragraph=3D"" class=3D"" style=3D"width: 71ch;">-</div>=
<div data-evo-paragraph=3D"" class=3D"" style=3D"width: 71ch;">&nbsp;struct=
 stub_data {</div><div data-evo-paragraph=3D"" class=3D"" style=3D"width: 7=
1ch;">&nbsp;<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</spa=
n>unsigned long offset;</div><div data-evo-paragraph=3D"" class=3D"" style=
=3D"width: 71ch;">&nbsp;<span class=3D"Apple-tab-span" style=3D"white-space=
:pre">	</span>int fd;</div><div class=3D"-x-evo-signature-wrapper"><span cl=
ass=3D"-x-evo-signature" id=3D"none"></span></div></body></html>
--=-UEggL6SwuXofVixdZ3Ro--



--===============5545827532600076823==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
--===============5545827532600076823==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============5545827532600076823==--



