Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CHANk-0002hv-RY for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 11 Oct 2004 17:19:12 -0700
Received: from host157-148.pool8289.interbusiness.it ([82.89.148.157]
	helo=zion.localdomain)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CHANi-0000K3-EU for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 11 Oct 2004 17:19:12 -0700
From: blaisorblade_spam@yahoo.it
Message-Id: <20041012001806.72C46888B@zion.localdomain>
Subject: [uml-devel] [patch 10/10] uml: use always a separate io thread for UBD
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
Date: Tue, 12 Oct 2004 02:18:06 +0200
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it


Currently, ubd=sync is different from replacing ubd#= with ubd#s=. This is
against Principle of Least Surprise, so remove this difference.

Also the current ubd=sync behaviour is completely useless: it is to make sure
that when the kernel has synched its I/O to the virtual disk, the host does
not invalidate this with his caching; this causes ReiserFS corruption.

But since actually we call end_request() only after the io_thread has done its
work, we never lie to the block layer. Using O_SYNC as we do when replacing
ubd#= with ubd#s= is enough.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 linux-2.6.9-current-paolo/arch/um/drivers/ubd_kern.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff -puN arch/um/drivers/ubd_kern.c~uml-use-always-io-thread arch/um/drivers/ubd_kern.c
--- linux-2.6.9-current/arch/um/drivers/ubd_kern.c~uml-use-always-io-thread	2004-10-12 01:22:17.061952232 +0200
+++ linux-2.6.9-current-paolo/arch/um/drivers/ubd_kern.c	2004-10-12 01:22:17.064951776 +0200
@@ -773,9 +773,11 @@ int ubd_driver_init(void){
 	unsigned long stack;
 	int err;
 
+	/* Set by CONFIG_BLK_DEV_UBD_SYNC or ubd=sync.*/
 	if(global_openflags.s){
-		printk(KERN_INFO "ubd : Synchronous mode\n");
-		return(0);
+		printk(KERN_INFO "ubd: Synchronous mode\n");
+		/* Letting ubd=sync be like using ubd#s= instead of ubd#= is
+		 * enough. So use anyway the io thread. */
 	}
 	stack = alloc_stack(0, 0);
 	io_pid = start_io_thread(stack + PAGE_SIZE - sizeof(void *), 
_


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
