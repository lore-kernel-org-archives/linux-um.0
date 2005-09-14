Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EFfL9-0003hp-ML	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 14 Sep 2005 15:02:51 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1EFfL8-0004DL-9w
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 14 Sep 2005 15:02:51 -0700
Message-Id: <200509142155.j8ELtxC1012142@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 4/10] UML - Remove an unused file
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
Date: Wed, 14 Sep 2005 17:55:59 -0400
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

This removes a file which is no longer used.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.13-mm2/arch/um/drivers/ubd_user.c
===================================================================
--- linux-2.6.13-mm2.orig/arch/um/drivers/ubd_user.c	2005-08-28 19:41:01.000000000 -0400
+++ linux-2.6.13-mm2/arch/um/drivers/ubd_user.c	2005-09-09 12:53:03.802794632 -0400
@@ -1,75 +0,0 @@
-/* 
- * Copyright (C) 2000, 2001, 2002 Jeff Dike (jdike@karaya.com)
- * Copyright (C) 2001 Ridgerun,Inc (glonnon@ridgerun.com)
- * Licensed under the GPL
- */
-
-#include <stddef.h>
-#include <unistd.h>
-#include <errno.h>
-#include <sched.h>
-#include <signal.h>
-#include <string.h>
-#include <netinet/in.h>
-#include <sys/time.h>
-#include <sys/socket.h>
-#include <sys/mman.h>
-#include <sys/param.h>
-#include "asm/types.h"
-#include "user_util.h"
-#include "kern_util.h"
-#include "user.h"
-#include "ubd_user.h"
-#include "os.h"
-#include "cow.h"
-
-#include <endian.h>
-#include <byteswap.h>
-
-void ignore_sigwinch_sig(void)
-{
-	signal(SIGWINCH, SIG_IGN);
-}
-
-int start_io_thread(unsigned long sp, int *fd_out)
-{
-	int pid, fds[2], err;
-
-	err = os_pipe(fds, 1, 1);
-	if(err < 0){
-		printk("start_io_thread - os_pipe failed, err = %d\n", -err);
-		goto out;
-	}
-
-	kernel_fd = fds[0];
-	*fd_out = fds[1];
-
-	pid = clone(io_thread, (void *) sp, CLONE_FILES | CLONE_VM | SIGCHLD,
-		    NULL);
-	if(pid < 0){
-		printk("start_io_thread - clone failed : errno = %d\n", errno);
-		err = -errno;
-		goto out_close;
-	}
-
-	return(pid);
-
- out_close:
-	os_close_file(fds[0]);
-	os_close_file(fds[1]);
-	kernel_fd = -1;
-	*fd_out = -1;
- out:
-	return(err);
-}
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
