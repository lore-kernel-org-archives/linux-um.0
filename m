Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C8Nwr-0001g3-9s for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 17 Sep 2004 11:59:09 -0700
Received: from plam.fujitsu-siemens.com ([217.115.66.9])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1C8Nwp-0003Vm-43 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 17 Sep 2004 11:59:08 -0700
Received: from trolli.pdb.fsc.net ([172.25.96.53])
	by plam.fujitsu-siemens.com (8.11.3/8.11.3) with ESMTP id i8HIx3t28905
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 17 Sep 2004 20:59:03 +0200
Received: from abgzex6e.abg.fsc.net (abgzex6e.abg.fsc.net [172.25.159.230])
	by trolli.pdb.fsc.net (8.11.6/8.11.6) with ESMTP id i8HIx3r08050
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 17 Sep 2004 20:59:03 +0200
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C49CE3.876DBDE7"
Subject: FW: [uml-devel] Minor problems with interrupted systemcalls
Message-ID: <8B6FF516CBA0194AB0996705076B02520F7C34@ABGEX01E.abg.fsc.net>
From: "Stroesser, Bodo" <Bodo.Stroesser@fujitsu-siemens.com>
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
Date: Fri, 17 Sep 2004 20:24:11 +0200
To: user-mode-linux-devel@lists.sourceforge.net

This is a multi-part message in MIME format.

------_=_NextPart_001_01C49CE3.876DBDE7
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

Once again due to a typo: the correct text is "NO systemcall restart is
done", instead of  "do systemcall restart is done"

Sorry

Bodo

=20

If a program is traced or debugged, in 2.6.x interrupted systemcalls
with the results -ERESTARTxxxxxxx are not handled correctly, do
systemcall restart is done.

Here is a patch that should fix the problem. The patch is tested on
2.6.6 in tt and skas modes. It applies to 2.6.8.1, but I've not tested
yet.

Hope, this helps.

=20

Bodo

=20

=20

=20

=20

--- uml_orig/arch/um/kernel/signal_kern.c 2004-08-05 18:36:24.000000000
+0200

+++ uml/arch/um/kernel/signal_kern.c      2004-09-17 15:03:30.441065600
+0200

@@ -132,19 +132,18 @@

 {

      siginfo_t info;

      struct k_sigaction *ka;

-     int err, sig;

+     int sig;

=20

      if (!oldset)

            oldset =3D &current->blocked;

=20

      sig =3D get_signal_to_deliver(&info, regs, NULL);

-     if(sig =3D=3D 0)

-           return(0);

-

-     /* Whee!  Actually deliver the signal.  */

-     ka =3D &current->sighand->action[sig -1 ];

-     err =3D handle_signal(regs, sig, ka, &info, oldset, error);

-     if(!err) return(1);

+     if(sig > 0) {

+           /* Whee!  Actually deliver the signal.  */

+           ka =3D &current->sighand->action[sig -1 ];

+           handle_signal(regs, sig, ka, &info, oldset, error);

+           return(1);

+     }

=20

      /* Did we come from a system call? */

      if(PT_REGS_SYSCALL_NR(regs) >=3D 0){

--- uml_orig/arch/um/kernel/skas/process.c      2004-08-05
18:36:24.000000000 +0200

+++ uml/arch/um/kernel/skas/process.c     2004-09-17 17:35:09.236250499
+0200

@@ -63,7 +63,7 @@

=20

      syscall_nr =3D PT_SYSCALL_NR(regs->skas.regs);

      UPT_SYSCALL_NR(regs) =3D syscall_nr;

-     if(syscall_nr < 1){

+     if(syscall_nr < 0){

            relay_signal(SIGTRAP, regs);

            return;

      }

--- uml_orig/arch/um/kernel/skas/syscall_user.c 2004-08-05
18:36:24.000000000 +0200

+++ uml/arch/um/kernel/skas/syscall_user.c      2004-09-17
18:52:50.655271683 +0200

@@ -10,10 +10,6 @@

 #include "sysdep/ptrace.h"

 #include "sysdep/sigcontext.h"

=20

-/* XXX Bogus */

-#define ERESTARTSYS    512

-#define ERESTARTNOINTR 513

-#define ERESTARTNOHAND 514

=20

 void handle_syscall(union uml_pt_regs *regs)

 {

@@ -26,9 +22,6 @@

      result =3D execute_syscall(regs);

=20

      REGS_SET_SYSCALL_RETURN(regs->skas.regs, result);

-     if((result =3D=3D -ERESTARTNOHAND) || (result =3D=3D -ERESTARTSYS) =
||=20

-        (result =3D=3D -ERESTARTNOINTR))

-           do_signal(result);

=20

      syscall_trace(regs, 0);

      record_syscall_end(index, result);

--- uml_orig/arch/um/kernel/tt/syscall_user.c   2004-08-05
18:36:24.000000000 +0200

+++ uml/arch/um/kernel/tt/syscall_user.c  2004-09-17 18:52:41.978671390
+0200

@@ -17,10 +17,6 @@

 #include "syscall_user.h"

 #include "tt.h"

=20

-/* XXX Bogus */

-#define ERESTARTSYS    512

-#define ERESTARTNOINTR 513

-#define ERESTARTNOHAND 514

=20

 void syscall_handler_tt(int sig, union uml_pt_regs *regs)

 {

@@ -42,9 +38,6 @@

      UPT_SC(regs) =3D sc;

=20

      SC_SET_SYSCALL_RETURN(sc, result);

-     if((result =3D=3D -ERESTARTNOHAND) || (result =3D=3D -ERESTARTSYS) =
||=20

-        (result =3D=3D -ERESTARTNOINTR))

-           do_signal(result);

=20

      syscall_trace(regs, 0);

      record_syscall_end(index, result);

@@ -63,7 +56,7 @@

      regs =3D TASK_REGS(task);

      UPT_SYSCALL_NR(regs) =3D syscall;

=20

-     if(syscall < 1) return(0);

+     if(syscall < 0) return(0);

=20

      if((syscall !=3D __NR_sigreturn) &&

         ((unsigned long *) PT_IP(proc_regs) >=3D &_stext) &&=20

=20


------_=_NextPart_001_01C49CE3.876DBDE7
Content-Type: text/html;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
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
	{mso-style-type:personal;
	font-family:Arial;
	color:windowtext;}
span.E-MailFormatvorlage18
	{mso-style-type:personal-reply;
	font-family:Arial;
	color:navy;}
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

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:Arial;color:navy'>Once again due =
to a typo:
the correct text is &#8222;NO systemcall restart is done&#8220;, instead =
of &nbsp;&#8220;do
systemcall restart is done&#8221;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:Arial;color:navy'>Sorry<o:p></o:p><=
/span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:Arial;color:navy'>Bodo<o:p></o:p></=
span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
lang=3DEN-GB
style=3D'font-size:12.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>If a program is traced or debugged, in 2.6.x
interrupted systemcalls with the results &#8211;ERESTARTxxxxxxx are not =
handled
correctly, <font color=3Dnavy><span =
style=3D'color:navy'>do</span></font>
systemcall restart is done.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>Here is a patch that should fix the problem. =
The
patch is tested on 2.6.6 in tt and skas modes. It applies to 2.6.8.1, =
but
I&#8217;ve not tested yet.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>Hope, this helps.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>Bodo<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>---
uml_orig/arch/um/kernel/signal_kern.c 2004-08-05 18:36:24.000000000 =
+0200<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>+++
uml/arch/um/kernel/signal_kern.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
2004-09-17
15:03:30.441065600 +0200<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>@@ -132,19 +132,18 =
@@<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;{<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
siginfo_t info;<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
struct k_sigaction *ka;<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>-&nbsp;&nbsp;&nbsp;&nbsp;
int err, sig;<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>+&nbsp;&nbsp;&nbsp;&nbsp;
int sig;<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
if (!oldset)<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
oldset =3D &amp;current-&gt;blocked;<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
sig =3D get_signal_to_deliver(&amp;info, regs, =
NULL);<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>-&nbsp;&nbsp;&nbsp;&nbsp;
if(sig =3D=3D 0)<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
return(0);<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>-<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>-&nbsp;&nbsp;&nbsp;&nbsp;
/* Whee!&nbsp; Actually deliver the signal.&nbsp; =
*/<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>-&nbsp;&nbsp;&nbsp;&nbsp;
ka =3D &amp;current-&gt;sighand-&gt;action[sig -1 =
];<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>-&nbsp;&nbsp;&nbsp;&nbsp;
err =3D handle_signal(regs, sig, ka, &amp;info, oldset, =
error);<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>-&nbsp;&nbsp;&nbsp;&nbsp;
if(!err) return(1);<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>+&nbsp;&nbsp;&nbsp;&nbsp;
if(sig &gt; 0) {<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
/* Whee!&nbsp; Actually deliver the signal.&nbsp; =
*/<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
ka =3D &amp;current-&gt;sighand-&gt;action[sig -1 =
];<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
handle_signal(regs, sig, ka, &amp;info, oldset, =
error);<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
return(1);<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>+&nbsp;&nbsp;&nbsp;&nbsp;
}<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
/* Did we come from a system call? */<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
if(PT_REGS_SYSCALL_NR(regs) &gt;=3D 0){<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>--- =
uml_orig/arch/um/kernel/skas/process.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
2004-08-05 18:36:24.000000000 +0200<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>+++
uml/arch/um/kernel/skas/process.c&nbsp;&nbsp;&nbsp;&nbsp; 2004-09-17
17:35:09.236250499 +0200<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'>@@ =
-63,7 +63,7 @@<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
syscall_nr =3D =
PT_SYSCALL_NR(regs-&gt;skas.regs);<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
UPT_SYSCALL_NR(regs) =3D syscall_nr;<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>-&nbsp;&nbsp;&nbsp;&nbsp;
if(syscall_nr &lt; 1){<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>+&nbsp;&nbsp;&nbsp;&nbsp;
if(syscall_nr &lt; 0){<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
relay_signal(SIGTRAP, regs);<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
return;<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></font><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>}<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>---
uml_orig/arch/um/kernel/skas/syscall_user.c 2004-08-05 =
18:36:24.000000000 +0200<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>+++
uml/arch/um/kernel/skas/syscall_user.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
2004-09-17
18:52:50.655271683 +0200<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'>@@ =
-10,10 +10,6
@@<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;#include
&quot;sysdep/ptrace.h&quot;<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;#include
&quot;sysdep/sigcontext.h&quot;<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>-/* XXX Bogus =
*/<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>-#define
ERESTARTSYS&nbsp;&nbsp;&nbsp; 512<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>-#define =
ERESTARTNOINTR 513<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>-#define =
ERESTARTNOHAND 514<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;void
handle_syscall(union uml_pt_regs *regs)<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;{<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'>@@ =
-26,9 +22,6 @@<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
result =3D execute_syscall(regs);<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
REGS_SET_SYSCALL_RETURN(regs-&gt;skas.regs, =
result);<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>-&nbsp;&nbsp;&nbsp;&nbsp;
if((result =3D=3D -ERESTARTNOHAND) || (result =3D=3D -ERESTARTSYS) || =
<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>-&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp; (result =3D=3D =
-ERESTARTNOINTR))<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
do_signal(result);<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
syscall_trace(regs, 0);<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
record_syscall_end(index, result);<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>---
uml_orig/arch/um/kernel/tt/syscall_user.c&nbsp;&nbsp; 2004-08-05
18:36:24.000000000 +0200<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>+++
uml/arch/um/kernel/tt/syscall_user.c&nbsp; 2004-09-17 18:52:41.978671390 =
+0200<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'>@@ =
-17,10 +17,6
@@<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;#include
&quot;syscall_user.h&quot;<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;#include
&quot;tt.h&quot;<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'>-/* =
XXX Bogus */<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>-#define
ERESTARTSYS&nbsp;&nbsp;&nbsp; 512<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>-#define
ERESTARTNOINTR 513<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>-#define
ERESTARTNOHAND 514<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;void
syscall_handler_tt(int sig, union uml_pt_regs =
*regs)<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;{<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'>@@ =
-42,9 +38,6 @@<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
UPT_SC(regs) =3D sc;<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
SC_SET_SYSCALL_RETURN(sc, result);<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>-&nbsp;&nbsp;&nbsp;&nbsp;
if((result =3D=3D -ERESTARTNOHAND) || (result =3D=3D -ERESTARTSYS) || =
<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>-&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp; (result =3D=3D =
-ERESTARTNOINTR))<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
do_signal(result);<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
syscall_trace(regs, 0);<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
record_syscall_end(index, result);<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'>@@ =
-63,7 +56,7 @@<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
regs =3D TASK_REGS(task);<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
UPT_SYSCALL_NR(regs) =3D syscall;<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>-&nbsp;&nbsp;&nbsp;&nbsp;
if(syscall &lt; 1) return(0);<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>+&nbsp;&nbsp;&nbsp;&nbsp;
if(syscall &lt; 0) return(0);<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
if((syscall !=3D __NR_sigreturn) &amp;&amp;<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp; ((unsigned long *) PT_IP(proc_regs) &gt;=3D &amp;_stext) =
&amp;&amp; <o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C49CE3.876DBDE7--


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
