Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CUxJm-0000BR-Aj for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Nov 2004 17:12:06 -0800
Received: from www.ssc.unict.it ([151.97.230.9] helo=ssc.unict.it)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CUxJl-0007Eo-AE for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Nov 2004 17:12:06 -0800
From: blaisorblade_spam@yahoo.it
Message-Id: <20041119011343.937D97B9AA@zion.localdomain>
Subject: [uml-devel] [patch 4/4] Uml: fix __wrap_free comment.
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
Date: Fri, 19 Nov 2004 02:13:42 +0100
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it


Reworded the comment about __wrap_free detection of the allocator used to
allocate the pointer (it can free a pointer created by either the host
malloc(), kmalloc() or vmalloc()).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 linux-2.6.10-rc-paolo/arch/um/kernel/main.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff -puN arch/um/kernel/main.c~uml-wrap_free arch/um/kernel/main.c
--- linux-2.6.10-rc/arch/um/kernel/main.c~uml-wrap_free	2004-11-16 02:19:08.289619800 +0100
+++ linux-2.6.10-rc-paolo/arch/um/kernel/main.c	2004-11-16 02:19:08.292619344 +0100
@@ -222,13 +222,16 @@ void __wrap_free(void *ptr)
 	 * 	physical memory - kmalloc/kfree
 	 *	kernel virtual memory - vmalloc/vfree
 	 * 	anywhere else - malloc/free
-	 * If kmalloc is not yet possible, then the kernel memory regions
-	 * may not be set up yet, and the variables not initialized.  So,
-	 * free is called.
+	 * If kmalloc is not yet possible, then either high_physmem and/or
+	 * end_vm are still 0 (as at startup), in which case we call free, or
+	 * we have set them, but anyway addr has not been allocated from those
+	 * areas. So, in both cases __real_free is called.
 	 *
 	 * CAN_KMALLOC is checked because it would be bad to free a buffer
 	 * with kmalloc/vmalloc after they have been turned off during
 	 * shutdown.
+	 * XXX: However, we sometimes shutdown CAN_KMALLOC temporarily, so
+	 * there is a possibility for memory leaks.
 	 */
 
 	if((addr >= uml_physmem) && (addr < high_physmem)){
_


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
