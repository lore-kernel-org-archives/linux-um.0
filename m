Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C9UIu-0000w9-AU for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 20 Sep 2004 12:58:28 -0700
Received: from plam.fujitsu-siemens.com ([217.115.66.9])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1C9UIs-0006YY-K4 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 20 Sep 2004 12:58:28 -0700
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C49F4B.BE9AC0FC"
Message-ID: <8B6FF516CBA0194AB0996705076B02520F7C37@ABGEX01E.abg.fsc.net>
From: "Stroesser, Bodo" <Bodo.Stroesser@fujitsu-siemens.com>
Subject: [uml-devel] (no subject)
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Mon, 20 Sep 2004 21:55:14 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: BlaisorBlade <blaisorblade_spam@yahoo.it>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C49F4B.BE9AC0FC
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Today I tried testing interrupted systemcalls on UML 2.6.8.1-1 with the
incremental patches up to skas-flush-tlb. My host does not yet support
the new SYSEMU-ptrace.

In skas-mode, the uml system with this kernel doesn't boot! It panics
with the message:

=20

Kernel panic: handle_trap - failed to wait at end of syscall, errno =3D =
4,
status =3D 4479

=20

Tracking this down I saw that "errno =3D 4" from the message is
misleading! It's an old errno, the return value of waitpid() is the pid
of the user-thread. It seems to be stopped by SIGCHLD.

I do not understand exactly what happens, but the signal seems to be
generated while running handle_syscall() called from handle_trap().
Changing back to the sequence of calling waitpid() and handle_syscall()
as it has been before the sysemu-patch removed the problem.

=20

Here is my patch (I also changed the panic message to include "err" and
to print status in Hex):

=20

Bodo

=20

=20

--- tmp/linux-2.6.8.1/arch/um/kernel/skas/process.c     2004-09-17
19:20:15.000000000 +0200

+++ linux-2.6.8.1/arch/um/kernel/skas/process.c 2004-09-20
21:31:39.451946258 +0200

@@ -68,25 +68,25 @@

                return;

        }

=20

-       handle_syscall(regs);

-       if(use_sysemu)

-               return;

+       if(!use_sysemu) {

+               err =3D ptrace(PTRACE_POKEUSER, pid, =
PT_SYSCALL_NR_OFFSET,
__NR_getpid);

+               if(err < 0)

+                       panic("handle_trap - nullifying syscall failed,
errno =3D %d\n",

+                             errno);

=20

-       err =3D ptrace(PTRACE_POKEUSER, pid, PT_SYSCALL_NR_OFFSET,
__NR_getpid);

-       if(err < 0)

-               panic("handle_trap - nullifying syscall failed, errno =
=3D
%d\n",

-                     errno);

+               err =3D ptrace(PTRACE_SYSCALL, pid, 0, 0);

+               if(err < 0)

+                       panic("handle_trap - continuing to end of
syscall failed, "

+                             "errno =3D %d\n", errno);

=20

-       err =3D ptrace(PTRACE_SYSCALL, pid, 0, 0);

-       if(err < 0)

-               panic("handle_trap - continuing to end of syscall
failed, "

-                     "errno =3D %d\n", errno);

-

-       CATCH_EINTR(err =3D waitpid(pid, &status, WUNTRACED));

-       if((err < 0) || !WIFSTOPPED(status) ||

-          (WSTOPSIG(status) !=3D SIGTRAP))

-               panic("handle_trap - failed to wait at end of syscall, "

-                     "errno =3D %d, status =3D %d\n", errno, status);

+               CATCH_EINTR(err =3D waitpid(pid, &status, WUNTRACED));

+               if((err < 0) || !WIFSTOPPED(status) ||

+                  (WSTOPSIG(status) !=3D SIGTRAP))

+                       panic("handle_trap - failed to wait at end of
syscall, "

+                             "err =3D %d, errno =3D %d, status =3D =
%x\n",
err, errno, status);

+       }

+

+       handle_syscall(regs);

 }

=20

=20

=20


------_=_NextPart_001_01C49F4B.BE9AC0FC
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<style>
<!--
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:#606420;
	text-decoration:underline;}
span.E-MailFormatvorlage17
	{mso-style-type:personal-compose;
	font-family:Arial;
	color:windowtext;}
@page Section1
	{size:595.3pt 841.9pt;
	margin:70.85pt 70.85pt 2.0cm 70.85pt;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DDE link=3Dblue vlink=3D"#606420">

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:"Courier New"'>Today I tried =
testing
interrupted systemcalls on UML 2.6.8.1-1 with the incremental patches up =
to skas-flush-tlb.
My host does not yet support the new =
SYSEMU-ptrace.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:"Courier New"'>In skas-mode, the =
uml system
with this kernel doesn&#8217;t boot! It panics with the =
message:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:"Courier =
New"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:"Courier New"'>Kernel panic: =
handle_trap -
failed to wait at end of syscall, errno =3D 4, status =3D =
4479<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:"Courier =
New"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:"Courier New"'>Tracking this down =
I saw
that &#8220;errno =3D 4&#8221; from the message is misleading! =
It&#8217;s an old
errno, the return value of waitpid() is the pid of the user-thread. It =
seems to
be stopped by SIGCHLD.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:"Courier New"'>I do not understand =
exactly what
happens, but the signal seems to be generated while running =
handle_syscall()
called from handle_trap(). Changing back to the sequence of calling =
waitpid()
and handle_syscall() as it has been before the sysemu-patch removed the
problem.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:"Courier =
New"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:"Courier New"'>Here is my patch (I =
also changed
the panic message to include &#8220;err&#8221; and to print status in =
Hex):<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:"Courier =
New"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>Bodo<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:"Courier =
New"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:"Courier =
New"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>---
tmp/linux-2.6.8.1/arch/um/kernel/skas/process.c&nbsp;&nbsp;&nbsp;&nbsp;
2004-09-17 19:20:15.000000000 +0200<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>+++ =
linux-2.6.8.1/arch/um/kernel/skas/process.c
2004-09-20 21:31:39.451946258 +0200<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:"Courier New"'>@@ -68,25 +68,25 =
@@<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;
return;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
}<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:"Courier =
New"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
handle_syscall(regs);<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
if(use_sysemu)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;
return;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
if(!use_sysemu) {<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;
err =3D ptrace(PTRACE_POKEUSER, pid, PT_SYSCALL_NR_OFFSET, =
__NR_getpid);<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;
if(err &lt; 0)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
panic(&quot;handle_trap - nullifying syscall failed, errno =3D =
%d\n&quot;,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
errno);<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:"Courier =
New"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
err =3D ptrace(PTRACE_POKEUSER, pid, PT_SYSCALL_NR_OFFSET, =
__NR_getpid);<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
if(err &lt; 0)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;
panic(&quot;handle_trap - nullifying syscall failed, errno =3D =
%d\n&quot;,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
errno);<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;
err =3D ptrace(PTRACE_SYSCALL, pid, 0, 0);<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;
if(err &lt; 0)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
panic(&quot;handle_trap - continuing to end of syscall failed, =
&quot;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&quot;errno =3D %d\n&quot;, errno);<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:"Courier =
New"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
err =3D ptrace(PTRACE_SYSCALL, pid, 0, 0);<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
if(err &lt; 0)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;
panic(&quot;handle_trap - continuing to end of syscall failed, =
&quot;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&quot;errno =3D %d\n&quot;, errno);<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>-<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
CATCH_EINTR(err =3D waitpid(pid, &amp;status, =
WUNTRACED));<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
if((err &lt; 0) || !WIFSTOPPED(status) ||<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
(WSTOPSIG(status) !=3D SIGTRAP))<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;
panic(&quot;handle_trap - failed to wait at end of syscall, =
&quot;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&quot;errno =3D %d, status =3D %d\n&quot;, errno, =
status);<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;
CATCH_EINTR(err =3D waitpid(pid, &amp;status, =
WUNTRACED));<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;
if((err &lt; 0) || !WIFSTOPPED(status) ||<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
(WSTOPSIG(status) !=3D SIGTRAP))<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
panic(&quot;handle_trap - failed to wait at end of syscall, =
&quot;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&quot;err =3D %d, errno =3D %d, status =3D %x\n&quot;, err, errno, =
status);<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
}<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>+<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
handle_syscall(regs);<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;}<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C49F4B.BE9AC0FC--


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
