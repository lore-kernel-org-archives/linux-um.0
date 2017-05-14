Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <thomas@m3y3r.de>) id 1d9v4Z-0008LX-KQ
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 14 May 2017 15:04:39 +0000
Received: from www17.your-server.de ([213.133.104.17])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1d9v4Y-0000jm-DO
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 14 May 2017 15:04:39 +0000
Received: from [95.222.29.91] (helo=localhost.localdomain)
	by www17.your-server.de with esmtpsa
	(TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256) (Exim 4.85_2)
	(envelope-from <thomas@m3y3r.de>) id 1d9v4S-0003s2-Ag
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 14 May 2017 17:04:32 +0200
Message-ID: <1494774234.13299.6.camel@m3y3r.de>
From: Thomas Meyer <thomas@m3y3r.de>
Date: Sun, 14 May 2017 17:03:54 +0200
Mime-Version: 1.0
Subject: [uml-devel] [PATCH 3/3] um: Add kerneldoc for userspace_tramp() and
 start_userspace()
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============6477856367412019934=="
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>


--===============6477856367412019934==
Content-Type: multipart/alternative; boundary="=-s+bYGRwGZxoUIFMYq70B"


--=-s+bYGRwGZxoUIFMYq70B
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Also use correct function name spelling (stub_segv_handler) for better
grepping

Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
---
 arch/um/os-Linux/skas/process.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-
Linux/skas/process.c
index 03b3c4c..4530867 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -108,7 +108,7 @@ static void get_skas_faultinfo(int pid, struct
faultinfo *fi)
 	wait_stub_done(pid);
 
 	/*
-	 * faultinfo is prepared by the stub-segv-handler at start of
+	 * faultinfo is prepared by the stub_segv_handler at start of
 	 * the stub stack page. We just have to copy it.
 	 */
 	memcpy(fi, (void *)current_stub_stack(), sizeof(*fi));
@@ -175,6 +175,21 @@ static void handle_trap(int pid, struct
uml_pt_regs *regs,
 
 extern char __syscall_stub_start[];
 
+/**
+ * userspace_tramp() - userspace trampoline
+ * @stack:	pointer to the new userspace stack page, can be
NULL, if? FIXME:
+ *
+ * The userspace trampoline is used to setup a new userspace process
in start_userspace() after it was clone()'ed.
+ * This function will run on a temporary stack page.
+ * It ptrace()'es itself, then
+ * Two pages are mapped into the userspace address space:
+ * - STUB_CODE (with EXEC), which contains the skas stub code
+ * - STUB_DATA (with R/W), which contains a data page that is used to
transfer certain data between the UML userspace process and the UML
kernel.
+ * Also for the userspace process a SIGSEGV handler is installed to
catch pagefaults in the userspace process.
+ * And last the process stops itself to give control to the UML kernel
for this userspace process.
+ *
+ * Return: Always zero, otherwise the current userspace process is
ended with non null exit() call
+ */
 static int userspace_tramp(void *stack)
 {
 	void *addr;
@@ -236,12 +251,24 @@ static int userspace_tramp(void *stack)
 
 int userspace_pid[NR_CPUS];
 
+/**
+ * start_userspace() - prepare a new userspace process
+ * @stub_stack:	pointer to the stub stack. Can be NULL, if?
FIXME:
+ *
+ * Setups a new temporary stack page that is used while
userspace_tramp() runs
+ * Clones the kernel process into a new userspace process, with FDs
only.
+ *
+ * Return: When positive: the process id of the new userspace process,
+ *         when negative: an error number.
+ * FIXME: can PIDs become negative?!
+ */
 int start_userspace(unsigned long stub_stack)
 {
 	void *stack;
 	unsigned long sp;
 	int pid, status, n, flags, err;
 
+	/* setup a temporary stack page */
 	stack = mmap(NULL, UM_KERN_PAGE_SIZE,
 		     PROT_READ | PROT_WRITE | PROT_EXEC,
 		     MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
@@ -252,10 +279,12 @@ int start_userspace(unsigned long stub_stack)
 		return err;
 	}
 
+	/* set stack pointer to the end of the stack page, so it can
grow downwards */
 	sp = (unsigned long) stack + UM_KERN_PAGE_SIZE - sizeof(void
*);
 
 	flags = CLONE_FILES | SIGCHLD;
 
+	/* clone into new userspace process */
 	pid = clone(userspace_tramp, (void *) sp, flags, (void *)
stub_stack);
 	if (pid < 0) {
 		err = -errno;
--=-s+bYGRwGZxoUIFMYq70B
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
-marker"></span>Also use correct function name spelling (stub_segv_handler)=
 for better<span data-hidden-space=3D""></span><br class=3D"-x-evo-wrap-br"=
>grepping</div><div data-evo-paragraph=3D"" class=3D"" style=3D"width: 71ch=
;"><br></div><div data-evo-paragraph=3D"" class=3D"" style=3D"width: 71ch;"=
>Signed-off-by: Thomas Meyer &lt;<a href=3D"mailto:thomas@m3y3r.de">thomas@=
m3y3r.de</a>&gt;</div><div data-evo-paragraph=3D"" class=3D"" style=3D"widt=
h: 71ch;">---</div><div data-evo-paragraph=3D"" class=3D"" style=3D"width: =
71ch;">&nbsp;arch/um/os-Linux/skas/process.c | 31 +++++++++++++++++++++++++=
+++++-</div><div data-evo-paragraph=3D"" class=3D"" style=3D"width: 71ch;">=
&nbsp;1 file changed, 30 insertions(+), 1 deletion(-)</div><div data-evo-pa=
ragraph=3D"" class=3D"" style=3D"width: 71ch;"><br></div><div data-evo-para=
graph=3D"" class=3D"" style=3D"width: 71ch;">diff --git a/arch/um/os-Linux/=
skas/process.c b/arch/um/os-<br class=3D"-x-evo-wrap-br">Linux/skas/process=
.c</div><div data-evo-paragraph=3D"" class=3D"" style=3D"width: 71ch;">inde=
x 03b3c4c..4530867 100644</div><div data-evo-paragraph=3D"" class=3D"" styl=
e=3D"width: 71ch;">--- a/arch/um/os-Linux/skas/process.c</div><div data-evo=
-paragraph=3D"" class=3D"" style=3D"width: 71ch;">+++ b/arch/um/os-Linux/sk=
as/process.c</div><div data-evo-paragraph=3D"" class=3D"" style=3D"width: 7=
1ch;">@@ -108,7 +108,7 @@ static void get_skas_faultinfo(int pid, struct<sp=
an data-hidden-space=3D""></span><br class=3D"-x-evo-wrap-br">faultinfo *fi=
)</div><div data-evo-paragraph=3D"" class=3D"" style=3D"width: 71ch;">&nbsp=
;<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>wait_stub=
_done(pid);</div><div data-evo-paragraph=3D"" class=3D"" style=3D"width: 71=
ch;">&nbsp;</div><div data-evo-paragraph=3D"" class=3D"" style=3D"width: 71=
ch;">&nbsp;<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span=
>/*</div><div data-evo-paragraph=3D"" class=3D"" style=3D"width: 71ch;">-<s=
pan class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>&nbsp;* faul=
tinfo is prepared by the stub-segv-handler at start of</div><div data-evo-p=
aragraph=3D"" class=3D"" style=3D"width: 71ch;">+<span class=3D"Apple-tab-s=
pan" style=3D"white-space:pre">	</span>&nbsp;* faultinfo is prepared by the=
 stub_segv_handler at start of</div><div data-evo-paragraph=3D"" class=3D""=
 style=3D"width: 71ch;">&nbsp;<span class=3D"Apple-tab-span" style=3D"white=
-space:pre">	</span>&nbsp;* the stub stack page. We just have to copy it.</=
div><div data-evo-paragraph=3D"" class=3D"" style=3D"width: 71ch;">&nbsp;<s=
pan class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>&nbsp;*/</di=
v><div data-evo-paragraph=3D"" class=3D"" style=3D"width: 71ch;">&nbsp;<spa=
n class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>memcpy(fi, (vo=
id *)current_stub_stack(), sizeof(*fi));</div><div data-evo-paragraph=3D"" =
class=3D"" style=3D"width: 71ch;">@@ -175,6 +175,21 @@ static void handle_t=
rap(int pid, struct<span data-hidden-space=3D""></span><br class=3D"-x-evo-=
wrap-br">uml_pt_regs *regs,</div><div data-evo-paragraph=3D"" class=3D"" st=
yle=3D"width: 71ch;">&nbsp;</div><div data-evo-paragraph=3D"" class=3D"" st=
yle=3D"width: 71ch;">&nbsp;extern char __syscall_stub_start[];</div><div da=
ta-evo-paragraph=3D"" class=3D"" style=3D"width: 71ch;">&nbsp;</div><div da=
ta-evo-paragraph=3D"" class=3D"" style=3D"width: 71ch;">+/**</div><div data=
-evo-paragraph=3D"" class=3D"" style=3D"width: 71ch;">+ * userspace_tramp()=
 - userspace trampoline</div><div data-evo-paragraph=3D"" class=3D"" style=
=3D"width: 71ch;">+ * @stack:<span class=3D"Apple-tab-span" style=3D"white-=
space:pre">	</span>pointer to the new userspace stack page, can be<span dat=
a-hidden-space=3D""></span><br class=3D"-x-evo-wrap-br">NULL, if? FIXME:</d=
iv><div data-evo-paragraph=3D"" class=3D"" style=3D"width: 71ch;">+ *</div>=
<div data-evo-paragraph=3D"" class=3D"" style=3D"width: 71ch;">+ * The user=
space trampoline is used to setup a new userspace process<span data-hidden-=
space=3D""></span><br class=3D"-x-evo-wrap-br">in start_userspace() after i=
t was clone()'ed.</div><div data-evo-paragraph=3D"" class=3D"" style=3D"wid=
th: 71ch;">+ * This function will run on a temporary stack page.</div><div =
data-evo-paragraph=3D"" class=3D"" style=3D"width: 71ch;">+ * It ptrace()'e=
s itself, then</div><div data-evo-paragraph=3D"" class=3D"" style=3D"width:=
 71ch;">+ * Two pages are mapped into the userspace address space:</div><di=
v data-evo-paragraph=3D"" class=3D"" style=3D"width: 71ch;">+ * - STUB_CODE=
 (with EXEC), which contains the skas stub code</div><div data-evo-paragrap=
h=3D"" class=3D"" style=3D"width: 71ch;">+ * - STUB_DATA (with R/W), which =
contains a data page that is used to<span data-hidden-space=3D""></span><br=
 class=3D"-x-evo-wrap-br">transfer certain data between the UML userspace p=
rocess and the UML<span data-hidden-space=3D""></span><br class=3D"-x-evo-w=
rap-br">kernel.</div><div data-evo-paragraph=3D"" class=3D"" style=3D"width=
: 71ch;">+ * Also for the userspace process a SIGSEGV handler is installed =
to<span data-hidden-space=3D""></span><br class=3D"-x-evo-wrap-br">catch pa=
gefaults in the userspace process.</div><div data-evo-paragraph=3D"" class=
=3D"" style=3D"width: 71ch;">+ * And last the process stops itself to give =
control to the UML kernel<span data-hidden-space=3D""></span><br class=3D"-=
x-evo-wrap-br">for this userspace process.</div><div data-evo-paragraph=3D"=
" class=3D"" style=3D"width: 71ch;">+ *</div><div data-evo-paragraph=3D"" c=
lass=3D"" style=3D"width: 71ch;">+ * Return: Always zero, otherwise the cur=
rent userspace process is<span data-hidden-space=3D""></span><br class=3D"-=
x-evo-wrap-br">ended with non null exit() call</div><div data-evo-paragraph=
=3D"" class=3D"" style=3D"width: 71ch;">+ */</div><div data-evo-paragraph=
=3D"" class=3D"" style=3D"width: 71ch;">&nbsp;static int userspace_tramp(vo=
id *stack)</div><div data-evo-paragraph=3D"" class=3D"" style=3D"width: 71c=
h;">&nbsp;{</div><div data-evo-paragraph=3D"" class=3D"" style=3D"width: 71=
ch;">&nbsp;<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span=
>void *addr;</div><div data-evo-paragraph=3D"" class=3D"" style=3D"width: 7=
1ch;">@@ -236,12 +251,24 @@ static int userspace_tramp(void *stack)</div><d=
iv data-evo-paragraph=3D"" class=3D"" style=3D"width: 71ch;">&nbsp;</div><d=
iv data-evo-paragraph=3D"" class=3D"" style=3D"width: 71ch;">&nbsp;int user=
space_pid[NR_CPUS];</div><div data-evo-paragraph=3D"" class=3D"" style=3D"w=
idth: 71ch;">&nbsp;</div><div data-evo-paragraph=3D"" class=3D"" style=3D"w=
idth: 71ch;">+/**</div><div data-evo-paragraph=3D"" class=3D"" style=3D"wid=
th: 71ch;">+ * start_userspace() - prepare a new userspace process</div><di=
v data-evo-paragraph=3D"" class=3D"" style=3D"width: 71ch;">+ * @stub_stack=
:<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>pointer t=
o the stub stack. Can be NULL, if?<span data-hidden-space=3D""></span><br c=
lass=3D"-x-evo-wrap-br">FIXME:</div><div data-evo-paragraph=3D"" class=3D""=
 style=3D"width: 71ch;">+ *</div><div data-evo-paragraph=3D"" class=3D"" st=
yle=3D"width: 71ch;">+ * Setups a new temporary stack page that is used whi=
le<span data-hidden-space=3D""></span><br class=3D"-x-evo-wrap-br">userspac=
e_tramp() runs</div><div data-evo-paragraph=3D"" class=3D"" style=3D"width:=
 71ch;">+ * Clones the kernel process into a new userspace process, with FD=
s<span data-hidden-space=3D""></span><br class=3D"-x-evo-wrap-br">only.</di=
v><div data-evo-paragraph=3D"" class=3D"" style=3D"width: 71ch;">+ *</div><=
div data-evo-paragraph=3D"" class=3D"" style=3D"width: 71ch;">+ * Return: W=
hen positive: the process id of the new userspace process,</div><div data-e=
vo-paragraph=3D"" class=3D"" style=3D"width: 71ch;">+ *&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;when negative: an error number.</div><div=
 data-evo-paragraph=3D"" class=3D"" style=3D"width: 71ch;">+ * FIXME: can P=
IDs become negative?!</div><div data-evo-paragraph=3D"" class=3D"" style=3D=
"width: 71ch;">+ */</div><div data-evo-paragraph=3D"" class=3D"" style=3D"w=
idth: 71ch;">&nbsp;int start_userspace(unsigned long stub_stack)</div><div =
data-evo-paragraph=3D"" class=3D"" style=3D"width: 71ch;">&nbsp;{</div><div=
 data-evo-paragraph=3D"" class=3D"" style=3D"width: 71ch;">&nbsp;<span clas=
s=3D"Apple-tab-span" style=3D"white-space:pre">	</span>void *stack;</div><d=
iv data-evo-paragraph=3D"" class=3D"" style=3D"width: 71ch;">&nbsp;<span cl=
ass=3D"Apple-tab-span" style=3D"white-space:pre">	</span>unsigned long sp;<=
/div><div data-evo-paragraph=3D"" class=3D"" style=3D"width: 71ch;">&nbsp;<=
span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>int pid, st=
atus, n, flags, err;</div><div data-evo-paragraph=3D"" class=3D"" style=3D"=
width: 71ch;">&nbsp;</div><div data-evo-paragraph=3D"" class=3D"" style=3D"=
width: 71ch;">+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</=
span>/* setup a temporary stack page */</div><div data-evo-paragraph=3D"" c=
lass=3D"" style=3D"width: 71ch;">&nbsp;<span class=3D"Apple-tab-span" style=
=3D"white-space:pre">	</span>stack =3D mmap(NULL, UM_KERN_PAGE_SIZE,</div><=
div data-evo-paragraph=3D"" class=3D"" style=3D"width: 71ch;">&nbsp;<span c=
lass=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span class=3D"Ap=
ple-tab-span" style=3D"white-space:pre">	</span>&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;PROT_READ | PROT_WRITE | PROT_EXEC,</div><div data-evo-paragraph=3D"" cl=
ass=3D"" style=3D"width: 71ch;">&nbsp;<span class=3D"Apple-tab-span" style=
=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" style=3D"white-=
space:pre">	</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;MAP_PRIVATE | MAP_ANONYMOU=
S, -1, 0);</div><div data-evo-paragraph=3D"" class=3D"" style=3D"width: 71c=
h;">@@ -252,10 +279,12 @@ int start_userspace(unsigned long stub_stack)</di=
v><div data-evo-paragraph=3D"" class=3D"" style=3D"width: 71ch;">&nbsp;<spa=
n class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span class=3D=
"Apple-tab-span" style=3D"white-space:pre">	</span>return err;</div><div da=
ta-evo-paragraph=3D"" class=3D"" style=3D"width: 71ch;">&nbsp;<span class=
=3D"Apple-tab-span" style=3D"white-space:pre">	</span>}</div><div data-evo-=
paragraph=3D"" class=3D"" style=3D"width: 71ch;">&nbsp;</div><div data-evo-=
paragraph=3D"" class=3D"" style=3D"width: 71ch;">+<span class=3D"Apple-tab-=
span" style=3D"white-space:pre">	</span>/* set stack pointer to the end of =
the stack page, so it can<span data-hidden-space=3D""></span><br class=3D"-=
x-evo-wrap-br">grow downwards */</div><div data-evo-paragraph=3D"" class=3D=
"" style=3D"width: 71ch;">&nbsp;<span class=3D"Apple-tab-span" style=3D"whi=
te-space:pre">	</span>sp =3D (unsigned long) stack + UM_KERN_PAGE_SIZE - si=
zeof(void<span data-hidden-space=3D""></span><br class=3D"-x-evo-wrap-br">*=
);</div><div data-evo-paragraph=3D"" class=3D"" style=3D"width: 71ch;">&nbs=
p;</div><div data-evo-paragraph=3D"" class=3D"" style=3D"width: 71ch;">&nbs=
p;<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>flags =
=3D CLONE_FILES | SIGCHLD;</div><div data-evo-paragraph=3D"" class=3D"" sty=
le=3D"width: 71ch;">&nbsp;</div><div data-evo-paragraph=3D"" class=3D"" sty=
le=3D"width: 71ch;">+<span class=3D"Apple-tab-span" style=3D"white-space:pr=
e">	</span>/* clone into new userspace process */</div><div data-evo-paragr=
aph=3D"" class=3D"" style=3D"width: 71ch;">&nbsp;<span class=3D"Apple-tab-s=
pan" style=3D"white-space:pre">	</span>pid =3D clone(userspace_tramp, (void=
 *) sp, flags, (void *)<span data-hidden-space=3D""></span><br class=3D"-x-=
evo-wrap-br">stub_stack);</div><div data-evo-paragraph=3D"" class=3D"" styl=
e=3D"width: 71ch;">&nbsp;<span class=3D"Apple-tab-span" style=3D"white-spac=
e:pre">	</span>if (pid &lt; 0) {</div><div data-evo-paragraph=3D"" class=3D=
"" style=3D"width: 71ch;">&nbsp;<span class=3D"Apple-tab-span" style=3D"whi=
te-space:pre">	</span><span class=3D"Apple-tab-span" style=3D"white-space:p=
re">	</span>err =3D -errno;</div><div class=3D"-x-evo-signature-wrapper"><s=
pan class=3D"-x-evo-signature" id=3D"none"></span></div></body></html>
--=-s+bYGRwGZxoUIFMYq70B--



--===============6477856367412019934==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
--===============6477856367412019934==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============6477856367412019934==--



