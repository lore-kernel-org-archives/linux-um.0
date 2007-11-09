Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Iqao1-0002i6-6u for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 09 Nov 2007 12:50:21 -0800
Received: from nz-out-0506.google.com ([64.233.162.227])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Iqao0-0001je-6i
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 09 Nov 2007 12:50:20 -0800
Received: by nz-out-0506.google.com with SMTP id f1so2124459nzc
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 09 Nov 2007 12:50:19 -0800 (PST)
Message-ID: <ea9232d10711091250w699db72eh1b7254b02defc116@mail.gmail.com>
Date: Fri, 9 Nov 2007 21:50:16 +0100
From: Magotari <magotari@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH] uml: cleanup unused return values
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: jdike@addtoit.com
Cc: user-mode-linux-devel@lists.sourceforge.net

This patch changes a few functions into returning void.
The return values were not used anyway, so I think it should not be a problem.
Also removed a little leftover bit from TT mode.

Karol Swietlicki

Signed-off-by: Karol Swietlicki <magotari@gmail.com>

---
diff -rupN linux-2.6.23.orig/arch/um/include/os.h
linux-2.6.23/arch/um/include/os.h
--- linux-2.6.23.orig/arch/um/include/os.h	2007-11-04 14:50:57.000000000 +0100
+++ linux-2.6.23/arch/um/include/os.h	2007-11-04 14:54:39.000000000 +0100
@@ -168,14 +168,10 @@ extern int os_fchange_dir(int fd);

 /* start_up.c */
 extern void os_early_checks(void);
-extern int can_do_skas(void);
+extern void can_do_skas(void);
 extern void os_check_bugs(void);
 extern void check_host_supports_tls(int *supports_tls, int *tls_min);

-/* Make sure they are clear when running in TT mode. Required by
- * SEGV_MAYBE_FIXABLE */
-#define clear_can_do_skas() do { ptrace_faultinfo = proc_mm = 0; } while (0)
-
 /* mem.c */
 extern int create_mem_file(unsigned long long len);

diff -rupN linux-2.6.23.orig/arch/um/kernel/um_arch.c
linux-2.6.23/arch/um/kernel/um_arch.c
--- linux-2.6.23.orig/arch/um/kernel/um_arch.c	2007-11-04
14:50:57.000000000 +0100
+++ linux-2.6.23/arch/um/kernel/um_arch.c	2007-11-09 21:39:50.000000000 +0100
@@ -197,7 +197,7 @@ __uml_setup("--help", Usage,
 "    Prints this message.\n\n"
 );

-static int __init uml_checksetup(char *line, int *add)
+static void __init uml_checksetup(char *line, int *add)
 {
 	struct uml_param *p;

@@ -207,10 +207,9 @@ static int __init uml_checksetup(char *l

 		n = strlen(p->str);
 		if (!strncmp(line, p->str, n) && p->setup_func(line + n, add))
-			return 1;
+			return;
 		p++;
 	}
-	return 0;
 }

 static void __init uml_postsetup(void)
diff -rupN linux-2.6.23.orig/arch/um/os-Linux/start_up.c
linux-2.6.23/arch/um/os-Linux/start_up.c
--- linux-2.6.23.orig/arch/um/os-Linux/start_up.c	2007-11-04
14:50:57.000000000 +0100
+++ linux-2.6.23/arch/um/os-Linux/start_up.c	2007-11-04 14:55:36.000000000 +0100
@@ -466,7 +466,7 @@ static inline void check_skas3_proc_mm(v
 	else non_fatal("found\n");
 }

-int can_do_skas(void)
+void can_do_skas(void)
 {
 	non_fatal("Checking for the skas3 patch in the host:\n");

@@ -476,8 +476,6 @@ int can_do_skas(void)

 	if (!proc_mm || !ptrace_faultinfo || !ptrace_ldt)
 		skas_needs_stub = 1;
-
-	return 1;
 }

 int __init parse_iomem(char *str, int *add)

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
