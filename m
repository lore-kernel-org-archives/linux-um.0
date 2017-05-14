Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <thomas@m3y3r.de>) id 1d9v4X-0008LB-3b
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 14 May 2017 15:04:37 +0000
Received: from www17.your-server.de ([213.133.104.17])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1d9v4V-0000jD-AZ
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 14 May 2017 15:04:37 +0000
Received: from [95.222.29.91] (helo=localhost.localdomain)
	by www17.your-server.de with esmtpsa
	(TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256) (Exim 4.85_2)
	(envelope-from <thomas@m3y3r.de>) id 1d9v4O-0003r3-QR
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 14 May 2017 17:04:28 +0200
Message-ID: <1494774209.13299.5.camel@m3y3r.de>
From: Thomas Meyer <thomas@m3y3r.de>
Date: Sun, 14 May 2017 17:03:30 +0200
Mime-Version: 1.0
Subject: [uml-devel] [PATCH 2/3] um: Add kerneldoc for segv_handler
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============5991173170565579929=="
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>


--===============5991173170565579929==
Content-Type: multipart/alternative; boundary="=-nlQBpO2yzmtsWlqpTHFb"


--=-nlQBpO2yzmtsWlqpTHFb
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
---
 arch/um/kernel/trap.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/um/kernel/trap.c b/arch/um/kernel/trap.c
index 5915887..4e6fcb3 100644
--- a/arch/um/kernel/trap.c
+++ b/arch/um/kernel/trap.c
@@ -183,6 +183,16 @@ void fatal_sigsegv(void)
 	os_dump_core();
 }
 
+/**
+ * segv_handler() - the SIGSEGV handler
+ * @sig:	the signal number
+ * @unused_si:	the signal info struct; unused in this handler
+ * @regs:	the ptrace register information
+ *
+ * The handler first extracts the faultinfo from the UML ptrace regs
struct.
+ * If the userfault did not happen in an UML userspace process,
bad_segv is called.
+ * Otherwise the signal did happen in a cloned userspace process,
handle it.
+ */
 void segv_handler(int sig, struct siginfo *unused_si, struct
uml_pt_regs *regs)
 {
 	struct faultinfo * fi = UPT_FAULTINFO(regs);
--=-nlQBpO2yzmtsWlqpTHFb
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
2e3436" link=3D"#2a76c6" vlink=3D"#2e3436" data-evo-draft=3D""><div data-ev=
o-paragraph=3D"" class=3D"" style=3D"width: 71ch;"><span id=3D"-x-evo-selec=
tion-start-marker" data-anchor=3D""></span><span id=3D"-x-evo-selection-end=
-marker"></span>Signed-off-by: Thomas Meyer &lt;<a href=3D"mailto:thomas@m3=
y3r.de">thomas@m3y3r.de</a>&gt;</div><div data-evo-paragraph=3D"" class=3D"=
" style=3D"width: 71ch;">---</div><div data-evo-paragraph=3D"" class=3D"" s=
tyle=3D"width: 71ch;">&nbsp;arch/um/kernel/trap.c | 10 ++++++++++</div><div=
 data-evo-paragraph=3D"" class=3D"" style=3D"width: 71ch;">&nbsp;1 file cha=
nged, 10 insertions(+)</div><div data-evo-paragraph=3D"" class=3D"" style=
=3D"width: 71ch;"><br></div><div data-evo-paragraph=3D"" class=3D"" style=
=3D"width: 71ch;">diff --git a/arch/um/kernel/trap.c b/arch/um/kernel/trap.=
c</div><div data-evo-paragraph=3D"" class=3D"" style=3D"width: 71ch;">index=
 5915887..4e6fcb3 100644</div><div data-evo-paragraph=3D"" class=3D"" style=
=3D"width: 71ch;">--- a/arch/um/kernel/trap.c</div><div data-evo-paragraph=
=3D"" class=3D"" style=3D"width: 71ch;">+++ b/arch/um/kernel/trap.c</div><d=
iv data-evo-paragraph=3D"" class=3D"" style=3D"width: 71ch;">@@ -183,6 +183=
,16 @@ void fatal_sigsegv(void)</div><div data-evo-paragraph=3D"" class=3D"=
" style=3D"width: 71ch;">&nbsp;<span class=3D"Apple-tab-span" style=3D"whit=
e-space:pre">	</span>os_dump_core();</div><div data-evo-paragraph=3D"" clas=
s=3D"" style=3D"width: 71ch;">&nbsp;}</div><div data-evo-paragraph=3D"" cla=
ss=3D"" style=3D"width: 71ch;">&nbsp;</div><div data-evo-paragraph=3D"" cla=
ss=3D"" style=3D"width: 71ch;">+/**</div><div data-evo-paragraph=3D"" class=
=3D"" style=3D"width: 71ch;">+ * segv_handler() - the SIGSEGV handler</div>=
<div data-evo-paragraph=3D"" class=3D"" style=3D"width: 71ch;">+ * @sig:<sp=
an class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>the signal nu=
mber</div><div data-evo-paragraph=3D"" class=3D"" style=3D"width: 71ch;">+ =
* @unused_si:<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</sp=
an>the signal info struct; unused in this handler</div><div data-evo-paragr=
aph=3D"" class=3D"" style=3D"width: 71ch;">+ * @regs:<span class=3D"Apple-t=
ab-span" style=3D"white-space:pre">	</span>the ptrace register information<=
/div><div data-evo-paragraph=3D"" class=3D"" style=3D"width: 71ch;">+ *</di=
v><div data-evo-paragraph=3D"" class=3D"" style=3D"width: 71ch;">+ * The ha=
ndler first extracts the faultinfo from the UML ptrace regs<span data-hidde=
n-space=3D""></span><br class=3D"-x-evo-wrap-br">struct.</div><div data-evo=
-paragraph=3D"" class=3D"" style=3D"width: 71ch;">+ * If the userfault did =
not happen in an UML userspace process,<span data-hidden-space=3D""></span>=
<br class=3D"-x-evo-wrap-br">bad_segv is called.</div><div data-evo-paragra=
ph=3D"" class=3D"" style=3D"width: 71ch;">+ * Otherwise the signal did happ=
en in a cloned userspace process,<span data-hidden-space=3D""></span><br cl=
ass=3D"-x-evo-wrap-br">handle it.</div><div data-evo-paragraph=3D"" class=
=3D"" style=3D"width: 71ch;">+ */</div><div data-evo-paragraph=3D"" class=
=3D"" style=3D"width: 71ch;">&nbsp;void segv_handler(int sig, struct siginf=
o *unused_si, struct<span data-hidden-space=3D""></span><br class=3D"-x-evo=
-wrap-br">uml_pt_regs *regs)</div><div data-evo-paragraph=3D"" class=3D"" s=
tyle=3D"width: 71ch;">&nbsp;{</div><div data-evo-paragraph=3D"" class=3D"" =
style=3D"width: 71ch;">&nbsp;<span class=3D"Apple-tab-span" style=3D"white-=
space:pre">	</span>struct faultinfo * fi =3D UPT_FAULTINFO(regs);</div><div=
 class=3D"-x-evo-signature-wrapper"><span class=3D"-x-evo-signature" id=3D"=
none"></span></div></body></html>
--=-nlQBpO2yzmtsWlqpTHFb--



--===============5991173170565579929==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
--===============5991173170565579929==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============5991173170565579929==--



