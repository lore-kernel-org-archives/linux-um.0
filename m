Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Ip7c2-0006lB-Hr for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 05 Nov 2007 11:27:54 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Ip7c1-00058K-Vv
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 05 Nov 2007 11:27:54 -0800
Date: Mon, 5 Nov 2007 14:27:48 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20071105192748.GA8793@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 5/6] UML - clone.c tidying
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
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

clone.c needed some style attention -
	updated copyright
	include trimming
	coding style

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
---
 arch/um/kernel/skas/clone.c |   32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

Index: linux-2.6/arch/um/kernel/skas/clone.c
===================================================================
--- linux-2.6.orig/arch/um/kernel/skas/clone.c	2007-11-05 14:06:09.000000000 -0500
+++ linux-2.6/arch/um/kernel/skas/clone.c	2007-11-05 14:13:50.000000000 -0500
@@ -1,17 +1,20 @@
-#include <sched.h>
+/*
+ * Copyright (C) 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
+ * Licensed under the GPL
+ */
+
 #include <signal.h>
-#include <sys/mman.h>
-#include <sys/time.h>
+#include <sched.h>
 #include <asm/unistd.h>
+#include <sys/time.h>
 #include "as-layout.h"
+#include "kern_constants.h"
 #include "ptrace_user.h"
-#include "skas.h"
 #include "stub-data.h"
-#include "uml-config.h"
 #include "sysdep/stub.h"
-#include "kern_constants.h"
 
-/* This is in a separate file because it needs to be compiled with any
+/*
+ * This is in a separate file because it needs to be compiled with any
  * extraneous gcc flags (-pg, -fprofile-arcs, -ftest-coverage) disabled
  *
  * Use UM_KERN_PAGE_SIZE instead of PAGE_SIZE because that calls getpagesize
@@ -26,25 +29,26 @@ stub_clone_handler(void)
 
 	err = stub_syscall2(__NR_clone, CLONE_PARENT | CLONE_FILES | SIGCHLD,
 			    STUB_DATA + UM_KERN_PAGE_SIZE / 2 - sizeof(void *));
-	if(err != 0)
+	if (err != 0)
 		goto out;
 
 	err = stub_syscall4(__NR_ptrace, PTRACE_TRACEME, 0, 0, 0);
-	if(err)
+	if (err)
 		goto out;
 
-	err = stub_syscall3(__NR_setitimer, ITIMER_VIRTUAL, 
+	err = stub_syscall3(__NR_setitimer, ITIMER_VIRTUAL,
 			    (long) &data->timer, 0);
-	if(err)
+	if (err)
 		goto out;
 
 	remap_stack(data->fd, data->offset);
 	goto done;
 
  out:
-	/* save current result. 
-	 * Parent: pid; 
-	 * child: retcode of mmap already saved and it jumps around this 
+	/*
+	 * save current result.
+	 * Parent: pid;
+	 * child: retcode of mmap already saved and it jumps around this
 	 * assignment
 	 */
 	data->err = err;

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
