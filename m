Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EAxvx-0007FV-Aa	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 01 Sep 2005 15:53:25 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1EAxvw-0007A8-Ln
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 01 Sep 2005 15:53:25 -0700
Message-Id: <200509012217.j81MHKE7011567@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 10/12] UML - Allow host capability usage to be
	disabled
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
Date: Thu, 01 Sep 2005 18:17:20 -0400
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, Bodo Stroesser <bstroesser@fujitsu-siemens.com>

From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>

Add new cmdline setups:
  - noprocmm
  - noptracefaultinfo
In case of testing, they can be used to switch off usage of
/proc/mm and PTRACE_FAULTINFO independently.

Signed-off-by: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: test/arch/um/os-Linux/start_up.c
===================================================================
--- test.orig/arch/um/os-Linux/start_up.c	2005-09-01 16:42:42.000000000 -0400
+++ test/arch/um/os-Linux/start_up.c	2005-09-01 16:51:23.000000000 -0400
@@ -275,6 +275,30 @@
 	check_ptrace();
 }
 
+static int __init noprocmm_cmd_param(char *str, int* add)
+{
+	proc_mm = 0;
+	return 0;
+}
+
+__uml_setup("noprocmm", noprocmm_cmd_param,
+"noprocmm\n"
+"    Turns off usage of /proc/mm, even if host supports it.\n"
+"    To support /proc/mm, the host needs to be patched using\n"
+"    the current skas3 patch.\n\n");
+
+static int __init noptracefaultinfo_cmd_param(char *str, int* add)
+{
+	ptrace_faultinfo = 0;
+	return 0;
+}
+
+__uml_setup("noptracefaultinfo", noptracefaultinfo_cmd_param,
+"noptracefaultinfo\n"
+"    Turns off usage of PTRACE_FAULTINFO, even if host supports\n"
+"    it. To support PTRACE_FAULTINFO, the host needs to be patched\n"
+"    using the current skas3 patch.\n\n");
+
 #ifdef UML_CONFIG_MODE_SKAS
 static inline void check_skas3_ptrace_support(void)
 {



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
