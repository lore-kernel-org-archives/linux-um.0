Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bh4fQ-0007jq-VO for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 04 Jul 2004 03:56:16 -0700
Received: from ppp-62-11-79-149.dialup.tiscali.it ([62.11.79.149]
	helo=zion.localdomain)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1Bh4fP-0000Jb-S0 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 04 Jul 2004 03:56:16 -0700
From: blaisorblade_spam@yahoo.it
Message-Id: <20040704105632.DC0B378A@zion.localdomain>
Subject: [uml-devel] [patch 1/1] Fix malloc-use-vmalloc
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
Date: Sun, 04 Jul 2004 12:56:32 +0200
To: jdike@addtoit.com
Cc: user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it


* Avoid allocating more than one page at once: that can require
moving pages around to have two contiguos pages, so we're better
with vmalloc.
* Make sure we free() someway, inside __wrap_free.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 linux-2.4.26-paolo/arch/um/main.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff -puN arch/um/main.c~malloc-use-vmalloc-fix arch/um/main.c
--- linux-2.4.26/arch/um/main.c~malloc-use-vmalloc-fix	2004-07-04 12:52:43.887588064 +0200
+++ linux-2.4.26-paolo/arch/um/main.c	2004-07-04 12:52:43.889587760 +0200
@@ -168,7 +168,7 @@ void *__wrap_malloc(int size)
 
 	if(!CAN_KMALLOC())
 		return(__real_malloc(size));
-	else if(size < 128 * 1024) /* kmalloc is good for only 128K */
+	else if(size <= PAGE_SIZE) /* finding contiguos pages is hard */
 		ret = um_kmalloc(size);
 	else ret = um_vmalloc(size);
 
@@ -213,8 +213,11 @@ void __wrap_free(void *ptr)
 			kfree(ptr);
 		else if((addr >= start_vm) && (addr <= end_vm))
 			vfree(ptr);
+		else
+			__real_free(ptr);
 	}
-	else __real_free(ptr);
+	else
+		__real_free(ptr);
 }
 
 /*
_


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
