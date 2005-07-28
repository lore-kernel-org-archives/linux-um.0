Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DyBLX-0000U1-Bc	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 28 Jul 2005 09:34:59 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1DyBLS-0000WV-6V
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 28 Jul 2005 09:34:59 -0700
Message-Id: <200507281626.j6SGQoWs009492@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 5/7] UML - Fix typo
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
Date: Thu, 28 Jul 2005 12:26:50 -0400
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, Bodo Stroesser <bstroesser@fujitsu-siemens.com>

From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>

Fix a typo in wait_stub_done.

Signed-off-by: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.12-rc3-mm2/arch/um/kernel/skas/process.c
===================================================================
--- linux-2.6.12-rc3-mm2.orig/arch/um/kernel/skas/process.c	2005-07-28 11:06:35.000000000 -0400
+++ linux-2.6.12-rc3-mm2/arch/um/kernel/skas/process.c	2005-07-28 11:44:07.000000000 -0400
@@ -64,7 +64,7 @@
                 (WSTOPSIG(status) == SIGVTALRM));
 
         if((n < 0) || !WIFSTOPPED(status) ||
-           (WSTOPSIG(status) != SIGUSR1 && WSTOPSIG(status != SIGTRAP))){
+           (WSTOPSIG(status) != SIGUSR1 && WSTOPSIG(status) != SIGTRAP)){
                 panic("%s : failed to wait for SIGUSR1/SIGTRAP, "
                       "pid = %d, n = %d, errno = %d, status = 0x%x\n",
                       fname, pid, n, errno, status);



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO September
19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
