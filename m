Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Hix2y-0000wv-4X for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 01 May 2007 11:25:56 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Hix2w-0006Ef-Ix
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 01 May 2007 11:25:56 -0700
Date: Tue, 1 May 2007 14:21:58 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070501182158.GA8358@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 4/6] UML - free() wrapper should call libc free
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
To: akpm@osdl.org
Cc: LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

The libc free wrapper wasn't correctly detecting buffers obtained with
malloc().  This is now done by seeing if the page was reserved.  This is
the case for memory which is left aside for libc and isn't given to
the page allocator.  If we free a pointer in a reserved page, it is
given to free() rather than kfree().

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
--
 arch/um/include/user.h   |    1 +
 arch/um/kernel/um_arch.c |    7 +++++++
 arch/um/os-Linux/main.c  |    6 +++++-
 3 files changed, 13 insertions(+), 1 deletion(-)

Index: linux-2.6.21-mm/arch/um/include/user.h
===================================================================
--- linux-2.6.21-mm.orig/arch/um/include/user.h	2007-04-26 17:33:01.000000000 -0400
+++ linux-2.6.21-mm/arch/um/include/user.h	2007-04-27 14:21:35.000000000 -0400
@@ -27,5 +27,6 @@ extern int in_aton(char *str);
 extern int open_gdb_chan(void);
 extern size_t strlcpy(char *, const char *, size_t);
 extern size_t strlcat(char *, const char *, size_t);
+extern int reserved_address(void *addr);
 
 #endif
Index: linux-2.6.21-mm/arch/um/kernel/um_arch.c
===================================================================
--- linux-2.6.21-mm.orig/arch/um/kernel/um_arch.c	2007-04-26 17:41:21.000000000 -0400
+++ linux-2.6.21-mm/arch/um/kernel/um_arch.c	2007-04-27 14:30:36.000000000 -0400
@@ -500,6 +500,13 @@ void __init check_bugs(void)
 	os_check_bugs();
 }
 
+int reserved_address(void *addr)
+{
+	struct page *page = virt_to_page(addr);
+
+	return(PageReserved(page));
+}
+
 void apply_alternatives(struct alt_instr *start, struct alt_instr *end)
 {
 }
Index: linux-2.6.21-mm/arch/um/os-Linux/main.c
===================================================================
--- linux-2.6.21-mm.orig/arch/um/os-Linux/main.c	2007-04-26 17:41:10.000000000 -0400
+++ linux-2.6.21-mm/arch/um/os-Linux/main.c	2007-04-27 14:30:31.000000000 -0400
@@ -266,6 +266,8 @@ void __wrap_free(void *ptr)
 	/* We need to know how the allocation happened, so it can be correctly
 	 * freed.  This is done by seeing what region of memory the pointer is
 	 * in -
+	 *	in a reserved page - free, assume the pointer was
+	 *	    acquired with malloc, since it couldn't have been kmalloced.
 	 * 	physical memory - kmalloc/kfree
 	 *	kernel virtual memory - vmalloc/vfree
 	 * 	anywhere else - malloc/free
@@ -281,7 +283,9 @@ void __wrap_free(void *ptr)
 	 * there is a possibility for memory leaks.
 	 */
 
-	if((addr >= uml_physmem) && (addr < high_physmem)){
+	if(kmalloc_ok && reserved_address(ptr))
+		__real_free(ptr);
+	else if((addr >= uml_physmem) && (addr < high_physmem)){
 		if(CAN_KMALLOC())
 			kfree(ptr);
 	}

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
