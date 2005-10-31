Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EWQdF-0007U9-VO	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 30 Oct 2005 19:46:49 -0800
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1EWQdF-0007IL-OQ
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 30 Oct 2005 19:46:50 -0800
Message-Id: <200510310439.j9V4des7000867@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 7/10] UML - switch_mm fix
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
Date: Sun, 30 Oct 2005 23:39:40 -0500
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, bcrl@linux.intel.com

From: Ben Lahaise <bcrl@linux.intel.com>
Not quite, something along the lines of the patch below works correctly
(and makes aio performance not suffer from multiple second delays), as
skas0 mode correctly switches mm contexts, unlike TT (which should
probably get nuked from the kernel now that skas0 seems to be working).

                -ben

Signed-off-by: Benjamin LaHaise <bcrl@linux.intel.com>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.13-mm1/include/asm-um/mmu_context.h
===================================================================
--- linux-2.6.13-mm1.orig/include/asm-um/mmu_context.h	2005-09-01 16:03:21.000000000 -0400
+++ linux-2.6.13-mm1/include/asm-um/mmu_context.h	2005-09-07 12:21:22.000000000 -0400
@@ -29,7 +29,8 @@
 	 * possible.
 	 */
 	if (old != new && (current->flags & PF_BORROWED_MM))
-		force_flush_all();
+		CHOOSE_MODE(force_flush_all(),
+			    switch_mm_skas(&new->context.skas.id));
 }
 
 static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next, 



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
