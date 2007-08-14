Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IL47q-0001a4-0h for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 14 Aug 2007 14:40:31 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IL47p-00089c-5l
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 14 Aug 2007 14:40:30 -0700
Date: Tue, 14 Aug 2007 17:40:25 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070814214025.GA17601@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 12/14] UML - Free LDT state on process exit
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

The space allocated for a process LDT wasn't being freed when the
process exited.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
--
 arch/um/kernel/skas/mmu.c |    2 ++
 1 file changed, 2 insertions(+)

Index: linux-2.6.22/arch/um/kernel/skas/mmu.c
===================================================================
--- linux-2.6.22.orig/arch/um/kernel/skas/mmu.c	2007-08-13 16:58:12.000000000 -0400
+++ linux-2.6.22/arch/um/kernel/skas/mmu.c	2007-08-13 16:59:32.000000000 -0400
@@ -149,4 +149,6 @@ void destroy_context(struct mm_struct *m
 		pmd_free((pmd_t *) mmu->last_pmd);
 #endif
 	}
+
+	free_ldt(mmu);
 }

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
