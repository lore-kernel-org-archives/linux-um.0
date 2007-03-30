Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HXNZV-0001ov-NA for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 30 Mar 2007 13:19:41 -0700
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HXNZU-0003tW-1V
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 30 Mar 2007 13:19:41 -0700
From: <gregkh@suse.de>
Date: Fri, 30 Mar 2007 13:17:58 -0700
In-Reply-To: <20070323181817.GA8694@c2.user-mode-linux.org>
Message-Id: <20070330201931.71EE0C9F718@imap.suse.de>
Subject: [uml-devel] patch uml-fix-epoll.patch queued to -stable tree
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: jdike@addtoit.com, akpm@osdl.org, gregkh@suse.de, jdike@linux.intel.com, user-mode-linux-devel@lists.sourceforge.net
Cc: stable@kernel.org


This is a note to let you know that we have just queued up the patch titled

     Subject: UML - fix epoll

to the 2.6.20-stable tree.  Its filename is

     uml-fix-epoll.patch

A git repo of this tree can be found at 
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary


From stable-bounces@linux.kernel.org Fri Mar 23 11:22:17 2007
From: Jeff Dike <jdike@addtoit.com>
Date: Fri, 23 Mar 2007 14:18:17 -0400
Subject: UML - fix epoll
To: Andrew Morton <akpm@osdl.org>, stable@kernel.org
Cc: uml-devel <user-mode-linux-devel@lists.sourceforge.net>
Message-ID: <20070323181817.GA8694@c2.user-mode-linux.org>
Content-Disposition: inline

From: Jeff Dike <jdike@addtoit.com>

UML/x86_64 needs the same packing of struct epoll_event as x86_64.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

--- linux-2.6.21-mm.orig/include/linux/eventpoll.h	2007-03-05 13:01:17.000000000 -0500
+++ linux-2.6.21-mm/include/linux/eventpoll.h	2007-03-23 14:03:07.000000000 -0400
@@ -31,12 +31,19 @@
 /* 
  * On x86-64 make the 64bit structure have the same alignment as the
  * 32bit structure. This makes 32bit emulation easier.
+ *
+ * UML/x86_64 needs the same packing as x86_64 - UML + UML_X86 +
+ * 64_BIT adds up to UML/x86_64.
  */
 #ifdef __x86_64__
 #define EPOLL_PACKED __attribute__((packed))
 #else
+#if defined(CONFIG_UML) && defined(CONFIG_UML_X86) && defined(CONFIG_64BIT)
+#define EPOLL_PACKED __attribute__((packed))
+#else
 #define EPOLL_PACKED
 #endif
+#endif
 
 struct epoll_event {
 	__u32 events;

_______________________________________________
stable mailing list
stable@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/stable


Patches currently in stable-queue which might be from jdike@addtoit.com are


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
