Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-list2-b.sourceforge.net ([10.3.1.8]
	helo=sc8-sf-list2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bs4E8-0000Nk-UK for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 03 Aug 2004 11:41:32 -0700
Message-Id: <200408031940.i73JeWvv003385@ccure.user-mode-linux.org>
Subject: Re: [Valgrind-users] Re: [uml-devel] Re: UML and valgrind 
In-Reply-To: Your message of "Tue, 03 Aug 2004 13:33:36 EDT."
	<410FCC70.1050902@enterasys.com> 
References: <C28780ABC637504896EB86B4FB75FFBFA26E5E@MAANDMBX1.ets.enterasys.com>
	<410EFCDB.8080404@enterasys.com>
	<200408030517.i735HZUE026250@ccure.user-mode-linux.org>
	<Pine.LNX.4.60.0408031028541.22157@hermes-1.csi.cam.ac.uk>
	<200408031450.i73EoEvv002040@ccure.user-mode-linux.org>
	<Pine.LNX.4.60.0408031527320.22157@hermes-1.csi.cam.ac.uk>
	<200408031750.i73HoMvv002966@ccure.user-mode-linux.org>
	<410FCC70.1050902@enterasys.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
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
Date: Tue, 03 Aug 2004 15:40:32 -0400
To: "D. Bahi" <dbahi@enterasys.com>
Cc: Nicholas Nethercote <njn25@cam.ac.uk>, user-mode-linux-devel@lists.sourceforge.net, valgrind-users@lists.sourceforge.net

If you get past the clone and repe problems in valgrind, there was another
where V was confused by UML's stack switching.  I didn't see a patch for that
in my email, but someone special-cased longjmp in the stack overflow detection
to get around that.

IIRC, that got UML booting.  Now, it produced almost no useful information 
because V doesn't understand the kernel memory allocators.  So, below are
my attempts to make it do so.  These apply to UML, and describe the kernel
to V.

I don't guarantee that they are correct, but they should at least give you
an idea what needs to happen.

				Jeff

V doesn't see that PTRACE_FAULTINFO initializes the fault struct given to it:

diff -Naur um/arch/um/kernel/skas/process.c v/arch/um/kernel/skas/process.c
--- um/arch/um/kernel/skas/process.c	Tue Jan 14 21:09:16 2003
+++ v/arch/um/kernel/skas/process.c	Mon Dec 23 11:42:39 2002
@@ -25,6 +25,8 @@
 #include "proc_mm.h"
 #include "skas_ptrace.h"
 
+#include "memcheck.h"
+
 unsigned long exec_regs[FRAME_SIZE];
 unsigned long exec_fp_regs[HOST_FP_SIZE];
 unsigned long exec_fpx_regs[HOST_XFP_SIZE];
@@ -40,6 +42,7 @@
 		panic("handle_segv - PTRACE_FAULTINFO failed, errno = %d\n",
 		      errno);
 
+	VALGRIND_MAKE_READABLE(&fault, sizeof(fault));
 	segv(fault.addr, 0, FAULT_WRITE(fault.is_write), 1, NULL);
 }
 
This makes buffers writeable according to V when they are handed out by
the slab allocator, and no-access when they are freed:

diff -Naur um/mm/slab.c v/mm/slab.c
--- um/mm/slab.c	Fri Dec 20 18:42:53 2002
+++ v/mm/slab.c	Mon Dec 23 11:15:31 2002
@@ -76,6 +76,8 @@
 #include	<linux/seq_file.h>
 #include	<asm/uaccess.h>
 
+#include "memcheck.h"
+
 /*
  * DEBUG	- 1 for kmem_cache_create() to honour; SLAB_DEBUG_INITIAL,
  *		  SLAB_RED_ZONE & SLAB_POISON.
@@ -500,6 +502,11 @@
 	 * it is a named-page or buffer-page.  The members it tests are
 	 * of no interest here.....
 	 */
+
+	if(addr != NULL)
+	        VALGRIND_MAKE_WRITABLE(addr, 
+				       (1 << cachep->gfporder) * PAGE_SIZE);
+
 	return addr;
 }
 
@@ -1076,8 +1083,11 @@
 		 * the same cache which they are a constructor for.
 		 * Otherwise, deadlock. They must also be threaded.
 		 */
-		if (cachep->ctor)
+		if (cachep->ctor){
+		        VALGRIND_MAKE_WRITABLE(objp, cachep->objsize);
 			cachep->ctor(objp, cachep, ctor_flags);
+		        VALGRIND_MAKE_NOACCESS(objp, cachep->objsize);
+		}
 #if DEBUG
 		if (cachep->flags & SLAB_RED_ZONE)
 			objp -= BYTES_PER_WORD;
@@ -1528,7 +1538,11 @@
  */
 void * kmem_cache_alloc (kmem_cache_t *cachep, int flags)
 {
-	return __kmem_cache_alloc(cachep, flags);
+        void *ptr = __kmem_cache_alloc(cachep, flags);
+
+	if(ptr != NULL)
+	        VALGRIND_MAKE_READABLE(ptr, cachep->objsize);
+	return ptr;
 }
 
 /**
@@ -1557,10 +1571,16 @@
 	cache_sizes_t *csizep = cache_sizes;
 
 	for (; csizep->cs_size; csizep++) {
+   	        void *ptr;
 		if (size > csizep->cs_size)
 			continue;
-		return __kmem_cache_alloc(flags & GFP_DMA ?
-			 csizep->cs_dmacachep : csizep->cs_cachep, flags);
+		ptr = __kmem_cache_alloc(flags & GFP_DMA ?
+					 csizep->cs_dmacachep : 
+					 csizep->cs_cachep, flags);
+		if(ptr != NULL)
+		        VALGRIND_MAKE_WRITABLE(ptr, size);
+
+		return ptr;
 	}
 	return NULL;
 }

Ditto for vmalloc/vfree:

diff -Naur um/mm/vmalloc.c v/mm/vmalloc.c
--- um/mm/vmalloc.c	Mon Feb 25 12:50:45 2002
+++ v/mm/vmalloc.c	Mon Dec 23 11:30:26 2002
@@ -16,6 +16,8 @@
 #include <asm/uaccess.h>
 #include <asm/pgalloc.h>
 
+#include "memcheck.h"
+
 rwlock_t vmlist_lock = RW_LOCK_UNLOCKED;
 struct vm_struct * vmlist;
 
@@ -212,11 +214,14 @@
 		printk(KERN_ERR "Trying to vfree() bad address (%p)\n", addr);
 		return;
 	}
+
 	write_lock(&vmlist_lock);
 	for (p = &vmlist ; (tmp = *p) ; p = &tmp->next) {
 		if (tmp->addr == addr) {
 			*p = tmp->next;
 			vmfree_area_pages(VMALLOC_VMADDR(tmp->addr), tmp->size);
+			VALGRIND_MAKE_NOACCESS(VMALLOC_VMADDR(tmp->addr), 
+					      tmp->size);
 			write_unlock(&vmlist_lock);
 			kfree(tmp);
 			return;
@@ -244,6 +249,8 @@
 		vfree(addr);
 		return NULL;
 	}
+
+	VALGRIND_MAKE_WRITABLE(addr, size);
 	return addr;
 }
 



-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
