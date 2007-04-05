Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HZUwY-0004aE-91 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 05 Apr 2007 09:36:14 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HZUwW-0003lT-Ho
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 05 Apr 2007 09:36:14 -0700
Date: Thu, 5 Apr 2007 12:31:59 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070405163159.GA7117@c2.user-mode-linux.org>
References: <20070402165011.GA7616@c2.user-mode-linux.org>
	<200704031950.17109.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <200704031950.17109.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [PATCH 2/4] UML - tidy process.c
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>, Blaisorblade <blaisorblade@yahoo.it>
Cc: LKML <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net

On Tue, Apr 03, 2007 at 07:50:16PM +0200, Blaisorblade wrote:
> Please, simply include uml-config.h and use just UML_CONFIG_MODE_TT.

okok :-)

	Jeff



Use only one ifdef to mark stack_sp as being tt mode only.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
--
 arch/um/include/kern_util.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: linux-2.6.21-mm/arch/um/include/kern_util.h
===================================================================
--- linux-2.6.21-mm.orig/arch/um/include/kern_util.h	2007-04-03 13:14:38.000000000 -0400
+++ linux-2.6.21-mm/arch/um/include/kern_util.h	2007-04-05 12:24:36.000000000 -0400
@@ -8,6 +8,7 @@
 
 #include "sysdep/ptrace.h"
 #include "sysdep/faultinfo.h"
+#include "uml-config.h"
 
 typedef void (*kern_hndl)(int, union uml_pt_regs *);
 
@@ -33,7 +34,7 @@ extern int nsyscalls;
 	UML_ROUND_DOWN(((unsigned long) addr) + PAGE_SIZE - 1)
 
 extern int kernel_fork(unsigned long flags, int (*fn)(void *), void * arg);
-#if defined(CONFIG_MODE_TT) || defined(UML_CONFIG_MODE_TT)
+#ifdef UML_CONFIG_MODE_TT
 extern unsigned long stack_sp(unsigned long page);
 #endif
 extern int kernel_thread_proc(void *data);

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
