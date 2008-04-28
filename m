Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JqbdU-0002Gw-EM for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 28 Apr 2008 15:15:48 -0700
Received: from feh.colobox.com ([209.177.154.210] ident=qmailr)
	by mail.sourceforge.net with smtp (Exim 4.44) id 1JqbdS-0008KJ-Op
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 28 Apr 2008 15:15:48 -0700
Date: 28 Apr 2008 15:15:46 -0700
Message-ID: <20080428221546.13915.qmail@feh.colobox.com>
From: "Ryan Finnie" <ryan@finnie.org>
In-Reply-To: <20080428172840.GF9628@c2.user-mode-linux.org>
Subject: [uml-devel] [PATCH] SKAS4 - Add noswitchmm,
	noptraceswitchmm and mode=skas3 switches
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

The SKAS4 patch that eventually hits mainline will almost certainly be 
incompatible with the current working SKAS4 patchset.  To that end, add 
mode=skas3, so current SKAS4 guests can be run in SKAS3 mode if/when 
future SKAS4 hosts are incompatible.  At current time, if a SKAS4 check 
fails, it falls back directly to SKAS0.

This can also let one force SKAS3 mode (for whatever reason) on hybrid 
SKAS3/SKAS4 hosts.  If mode=skas3 is specified and the SKAS3 patch has 
not been applied, the guest will fall back to SKAS0.

Also are included are individual "noswitchmm" and "noptraceswitchmm" 
switches for good measure, as "noptracefaultinfo", "noptraceldt", and 
"noprocmm" (SKAS3), and "nogetsiginfo" (SKAS4) are already available.

Signed-off-by: Ryan Finnie <ryan@finnie.org>
---

 start_up.c |   44 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 42 insertions(+), 2 deletions(-)


diff -ruN linux-2.6.24.orig/arch/um/os-Linux/start_up.c linux-2.6.24/arch/um/os-Linux/start_up.c
--- linux-2.6.24.orig/arch/um/os-Linux/start_up.c	2008-04-14 16:21:37.000000000 -0700
+++ linux-2.6.24/arch/um/os-Linux/start_up.c	2008-04-14 16:41:56.000000000 -0700
@@ -192,6 +192,24 @@
 "mode=skas0\n"
 "    Disables SKAS3 and SKAS4 usage, so that SKAS0 is used.\n\n");
 
+static int __init mode_skas3_cmd_param(char *str, int* add)
+{
+	disable_ptrace_faultinfo = 0;
+	disable_ptrace_ldt = 0;
+	disable_proc_mm = 0;
+
+	disable_switch_mm = 1;
+	disable_siginfo_segv = 1;
+	disable_ptrace_switch_mm = 1;
+
+	return 0;
+}
+
+__uml_setup("mode=skas3", mode_skas3_cmd_param,
+"mode=skas3\n"
+"    Disables SKAS4 usage, so that SKAS3 is used, or SKAS0 if SKAS3 is\n"
+"    not available.\n\n");
+
 /* Changed only during early boot */
 static int force_sysemu_disabled = 0;
 
@@ -559,6 +577,17 @@
 	return n;
 }
 
+static int __init noswitchmm_cmd_param(char *str, int *add)
+{
+	disable_switch_mm = 1;
+	return 0;
+}
+
+__uml_setup("noswitchmm", noswitchmm_cmd_param,
+"noswitchmm\n"
+"    Turns off usage of SKAS4 switch_mm (and new_mm), even if the host\n"
+"    supports it.\n\n");
+
 static int __init nogetsiginfo_cmd_param(char *str, int *add)
 {
 	disable_siginfo_segv = 1;
@@ -570,6 +599,17 @@
 "    Turns off usage of PTRACE_GETSIGINFO to read page fault information\n"
 "    from a child process, even if the host supports it.\n\n");
 
+static int __init noptraceswitchmm_cmd_param(char *str, int *add)
+{
+	disable_ptrace_switch_mm = 1;
+	return 0;
+}
+
+__uml_setup("noptraceswitchmm", noptraceswitchmm_cmd_param,
+"noptraceswitchmm\n"
+"    Turns off PTRACE_SWITCH_MM support, even if the host supports "
+"it.\n\n");
+
 #ifndef PTRACE_GETSIGINFO
 #define PTRACE_GETSIGINFO	0x4202
 #endif
@@ -817,7 +857,8 @@
 
 void can_do_skas(void)
 {
-	if (!can_do_skas4())
+	can_do_skas4();
+	if (!have_switch_mm)
 		can_do_skas3();
 }
 


-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
