Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1InydE-0000BZ-9Y for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 02 Nov 2007 08:40:24 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Inyd8-0005nD-Kr
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 02 Nov 2007 08:40:19 -0700
Date: Fri, 2 Nov 2007 11:40:15 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20071102154015.GA10288@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 6/6] UML - get_wchan fixes
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
Cc: Joe Perches <joe@perches.com>, LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

[ This can be merged with uml-implement-get_wchan.patch ]

The previous get_wchan patch needed some more work.  Joe Perches
suggested the use of bool where I was using a counter.  It also turned
out not to work so well on x86_64, so I changed the algorithm a bit.
Instead of skipping one frame and looking for the next non-sched
symbol, it now looks for at least one scheduler frame, then returns
the first symbol seen above that.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
---
 arch/um/kernel/process.c |   16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

Index: linux-2.6.22/arch/um/kernel/process.c
===================================================================
--- linux-2.6.22.orig/arch/um/kernel/process.c	2007-10-31 13:16:40.000000000 -0400
+++ linux-2.6.22/arch/um/kernel/process.c	2007-10-31 13:17:00.000000000 -0400
@@ -462,7 +462,8 @@ unsigned long arch_align_stack(unsigned 
 
 unsigned long get_wchan(struct task_struct *p)
 {
-	unsigned long stack_page, sp, ip, count = 0;
+	unsigned long stack_page, sp, ip;
+	bool seen_sched = 0;
 
 	if ((p == NULL) || (p == current) || (p->state == TASK_RUNNING))
 		return 0;
@@ -482,14 +483,11 @@ unsigned long get_wchan(struct task_stru
 
 	while (sp < stack_page + THREAD_SIZE) {
 		ip = *((unsigned long *) sp);
-		if (kernel_text_address(ip) && !in_sched_functions(ip)) {
-			/*
-			 * Skip one valid IP, which will be the low-level UML
-			 * context switcher.
-			 */
-			if (count++ == 1)
-				return ip;
-		}
+		if (in_sched_functions(ip))
+			/* Ignore everything until we're above the scheduler */
+			seen_sched = 1;
+		else if (kernel_text_address(ip) && seen_sched)
+			return ip;
 
 		sp += sizeof(unsigned long);
 	}

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
