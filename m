Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Il867-0000t6-9v for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 25 Oct 2007 12:10:27 -0700
Received: from nz-out-0506.google.com ([64.233.162.232])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Il866-0005J0-Vx
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 25 Oct 2007 12:10:27 -0700
Received: by nz-out-0506.google.com with SMTP id f1so1993883nzc
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 25 Oct 2007 12:10:26 -0700 (PDT)
Message-ID: <ea9232d10710251210n31cdd93w79f175af403cd6ad@mail.gmail.com>
Date: Thu, 25 Oct 2007 21:10:25 +0200
From: Magotari <magotari@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH] uml: removing xmm detection
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

This patch removes some code which ran at every boot, but does not
seem to do anything anymore. Please test. It works for me but mistakes
can happen.

Karol Swietlicki

Signed-off-by: Karol Swietlicki <magotari@gmail.com>
---

diff -uprN linux-2.6.23-mm1/arch/um/sys-i386/bugs.c
linux-2.6.23-mm1.local/arch/um/sys-i386/bugs.c
--- linux-2.6.23-mm1/arch/um/sys-i386/bugs.c	2007-10-18 22:24:13.000000000 +0200
+++ linux-2.6.23-mm1.local/arch/um/sys-i386/bugs.c	2007-10-25
18:57:28.000000000 +0200
@@ -15,7 +15,6 @@

 /* Set during early boot */
 int host_has_cmov = 1;
-int host_has_xmm = 0;

  static char token(int fd, char *buf, int len, char stop)
 {
@@ -163,8 +162,6 @@ void arch_check_bugs(void)
 	}
  	if (check_cpu_flag("cmov", &have_it))
 		host_has_cmov = have_it;
-	if (check_cpu_flag("xmm", &have_it))
-		host_has_xmm = have_it;
 }

  int arch_handle_signal(int sig, struct uml_pt_regs *regs)
diff -uprN linux-2.6.23-mm1/include/asm-um/processor-i386.h
linux-2.6.23-mm1.local/include/asm-um/processor-i386.h
--- linux-2.6.23-mm1/include/asm-um/processor-i386.h	2007-10-18
22:24:26.000000000 +0200
+++ linux-2.6.23-mm1.local/include/asm-um/processor-i386.h	2007-10-25
18:59:15.000000000 +0200
@@ -10,7 +10,6 @@
  #include "asm/host_ldt.h"
  #include "asm/segment.h"

-extern int host_has_xmm;
  extern int host_has_cmov;

  /* include faultinfo structure */

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
