Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BRgxR-00032s-FD for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 22 May 2004 17:35:17 -0700
Received: from pop.gmx.de ([213.165.64.20] helo=mail.gmx.net)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1BRgxQ-0003G6-Mw for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 22 May 2004 17:35:16 -0700
Message-ID: <05e201c4405e$cebf6610$2000000a@schlepptopp>
From: "roland" <for_spam@gmx.de>
References: <20040229043549.GA8583@ccure.user-mode-linux.org>
	<02dc01c43c4a$bb7c0490$2000000a@schlepptopp>
	<1084831251.1230.4.camel@chartreuse>
	<03ff01c43c5d$7db6e5e0$2000000a@schlepptopp>
	<20040518175904.GB29114@ccure.user-mode-linux.org>
	<1084987654.2250.4.camel@chartreuse>
	<012201c43dcb$402ca6a0$2000000a@schlepptopp>
	<1084990661.2255.28.camel@chartreuse>
	<018a01c43dd9$0173f270$2000000a@schlepptopp>
	<1084996157.2256.36.camel@chartreuse>
	<05a001c43e12$7affe2a0$2000000a@schlepptopp>
	<1085057350.1197.2.camel@chartreuse>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_05DF_01C4406F.8E32FBF0"
Subject: [uml-devel] [PATCH] commandline switch for sysemu patch
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
Date: Sun, 23 May 2004 02:42:14 +0200
To: Laurent Vivier <LaurentVivier@wanadoo.fr>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>, blaisorblade_spam@yahoo.it, uml@hno.marasystems.com


This is a multi-part message in MIME format.

------=_NextPart_000_05DF_01C4406F.8E32FBF0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by nerdnet.nl id
	i4N0eSTx015208

hi !
I have enhanced laurents sysemu patch a little bit.

the attached patch adds an additional commandline-switch to uml.
if you specify "sysemu" on the commandline, it makes uml use sysemu, if
the host has the sysemu patch,too.
if you don`t specify it, uml doesn`t use sysemu at all.
this makes it easier to compare uml behaviour with and without sysemu (yo=
u
don`t need 2 different kernels for that purpose)

Laurent - if you like it, perhaps you could publish that on your website =
or
include it in your sysemu patch?

regards
roland

ps:
sorry - i have only done it for 2.6.6

pps:
since this is my first patch, maybe this is far from being perfect. feel =
free
to comment. :)


>Hi,
>
>I put all related information at this URL:
>
>http://perso.wanadoo.fr/laurent.vivier/UML
>
>I have modified the 2.4.24 patches to set PTRACE_SYSEMU to 31 too.
>This modification allows to use 2.4.24 UML on 2.6.6 host, and 2.6.6 UML
>on 2.4.24 host.
>
>Regards,
>Laurent
>
>Le jeu 20/05/2004 =E0 04:30, roland a =E9crit :
> Hi Laurent,
> i wondered about:
> "Checking syscall emulation patch for ptrace...missing"
>
> so  - i dig into this:
>
> the uml-patch needs to be adjusted to the fix you gave for the host pat=
ch:
> in arch/um/kernel/skas/include/ptrace-skas.h
> i changed :
> #define PTRACE_SYSEMU 25
> to
> #define PTRACE_SYSEMU 31
>
> whoha - now sysemu patch is running with 2.6.6  :)
>
> same positive effect: the getpid loop runs MUCH faster.
> i have tested some other commands and if i run a "vmstat 1" on the HOST=
,
> i can see the context-swap-rate drop down significantly.
>
> great!
>
> laurent, can you post the sysemu uml and host patch again in ONE mail,
> containing the corrected defines?
> others will probably have it easier this way!
> (maybe some notes about how it works and what it does would be helpful,=
 too)
>
> thanks a lot!
>
> now we need some real-world performance tests/comparisons :)
> regards
> roland
>
> ps:
> i will do some more tests. maybe blaisorblade already wants to mention =
that
> patch in his 2.6 documentation at: http://www.user-mode-linux.org/~blai=
sorblade/ ?
>
>
>
>
>
>
> >in include/linux/ptrace.h ,
> >change
> >#define PTRACE_SCEMU            25
> >by
> >#define PTRACE_SCEMU            31
>
>
>
>
>
> ----- Original Message -----=20
> From: "Laurent Vivier" <LaurentVivier@wanadoo.fr>
> To: "roland" <for_spam@gmx.de>
> Cc: <user-mode-linux-devel@lists.sourceforge.net>
> Sent: Wednesday, May 19, 2004 9:49 PM
> Subject: Re: [uml-devel] [PATCH] host context switch reduction
>



------=_NextPart_000_05DF_01C4406F.8E32FBF0
Content-Type: application/octet-stream;
	name="sysemu_cmdline.patch"
Content-Disposition: attachment;
	filename="sysemu_cmdline.patch"
Content-Transfer-Encoding: quoted-printable

--- linux-2.6.6/arch/um/kernel/process.c	2004-07-07 06:21:19.144801856 =
+0200=0A=
+++ linux-2.6.6/arch/um/kernel/process.c.sysemu	2004-07-07 =
06:21:09.136323376 +0200=0A=
@@ -41,6 +41,8 @@=0A=
 #include "skas_ptrace.h"=0A=
 #endif=0A=
 =0A=
+int sysemu_active=3D0;=0A=
+=0A=
 void init_new_thread_stack(void *sig_stack, void (*usr1_handler)(int))=0A=
 {=0A=
 	int flags =3D 0, pages;=0A=
@@ -230,12 +232,12 @@=0A=
 	printk("OK\n");=0A=
 =0A=
 #ifdef PTRACE_SYSEMU=0A=
-	printk("Checking syscall emulation patch for ptrace...");=0A=
+       printk("Checking syscall emulation patch for ptrace on HOST...");=0A=
 	use_sysemu =3D 0;=0A=
 	pid =3D start_ptraced_child(&stack);=0A=
 	if(ptrace(PTRACE_SYSEMU, pid, 0, 0) >=3D 0) {=0A=
-		struct user_regs_struct regs;=0A=
-=0A=
+  	 	struct user_regs_struct regs;=0A=
+ =0A=
 		if (waitpid(pid, &status, WUNTRACED) < 0)=0A=
 			panic("check_ptrace : wait failed, errno =3D %d", errno);=0A=
 		if(!WIFSTOPPED(status) || (WSTOPSIG(status) !=3D SIGTRAP))=0A=
@@ -252,18 +254,44 @@=0A=
 =0A=
 		stop_ptraced_child(pid, stack, 0);=0A=
 =0A=
-		printk("OK\n");=0A=
-		use_sysemu =3D 1;=0A=
-	}=0A=
-	else=0A=
-	{=0A=
-		printk("missing\n");=0A=
+		printk("Found!\n");=0A=
+                printk("Syscall emulation is...");=0A=
+                if(sysemu_active) {=0A=
+         	 use_sysemu =3D 1;=0A=
+                 printk("On!\n"); =0A=
+                }           =0A=
+                else {=0A=
+                 use_sysemu =3D 0;=0A=
+                 printk("Off!\n");  =0A=
+                }          =0A=
+     =0A=
+	 }=0A=
+	 else=0A=
+	 {=0A=
+	 	printk("Missing!\n");=0A=
+                if(sysemu_active) {=0A=
+                 printk("Notice: You cannot use syscall emulation on =
this host!\n");=0A=
+                }=0A=
 		stop_ptraced_child(pid, stack, 1);=0A=
-	}=0A=
-=0A=
+	 }=0A=
+        =0A=
+        =0A=
 # endif /* PTRACE_SYSEMU */=0A=
 }=0A=
 =0A=
+=0A=
+static void sysemufnc(char *str)=0A=
+{=0A=
+ sysemu_active=3D1;=0A=
+}=0A=
+=0A=
+__uml_setup("sysemu",sysemufnc,=0A=
+"sysemu\n    Turn syscall emulation patch for ptrace (SYSEMU) on.\n"=0A=
+"    SYSEMU is a performance-patch introduced by Laurent Vivier. It =
changes\n"=0A=
+"    behaviour of ptrace() and helps reducing host context switch =
rate.\n"=0A=
+"    To make it working, you need a kernel patch for your host, too.\n"=0A=
+"    See http://perso.wanadoo.fr/laurent.vivier/UML/ for further =
information.\n\n");=0A=
+=0A=
 int run_kernel_thread(int (*fn)(void *), void *arg, void **jmp_ptr)=0A=
 {=0A=
 	jmp_buf buf;=0A=

------=_NextPart_000_05DF_01C4406F.8E32FBF0--



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
