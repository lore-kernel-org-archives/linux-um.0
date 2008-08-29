Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KZDCy-0005FE-Ug for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 29 Aug 2008 16:16:53 -0700
Received: from abydos.nerdbox.net ([216.151.149.55])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KZDCx-00060i-Gf
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 29 Aug 2008 16:16:48 -0700
Date: Fri, 29 Aug 2008 16:16:46 -0700 (PDT)
From: Steve VanDeBogart <vandebo-lkml@NerdBox.Net>
In-Reply-To: <alpine.DEB.1.00.0808281139420.15543@abydos.NerdBox.Net>
Message-ID: <alpine.DEB.1.00.0808291616170.15543@abydos.NerdBox.Net>
References: <alpine.DEB.1.00.0808281139420.15543@abydos.NerdBox.Net>
MIME-Version: 1.0
Subject: [uml-devel] [PATCH 4/6] VM: Annotate pagealloc
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
To: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, jiayingz@google.com, dkegel@google.com

Valgrind annotations for valgrind: memory is addressable once it's been
alloced, and unaddressable when it is freed again.  Can't use malloc-like
and free-like because valgrind considers a malloc-like chunk indivisible.

Signed-off-by: Steve VanDeBogart <vandebo-lkml@nerdbox.net>
---

Index: linux-2.6.27-rc5/mm/page_alloc.c
===================================================================
--- linux-2.6.27-rc5.orig/mm/page_alloc.c	2008-08-29 14:24:27.000000000 -0700
+++ linux-2.6.27-rc5/mm/page_alloc.c	2008-08-29 14:24:37.000000000 -0700
@@ -46,6 +46,7 @@
  #include <linux/page-isolation.h>
  #include <linux/memcontrol.h>
  #include <linux/debugobjects.h>
+#include <linux/memcheck.h>

  #include <asm/tlbflush.h>
  #include <asm/div64.h>
@@ -1080,6 +1081,7 @@
  		if (!page)
  			goto failed;
  	}
+	VALGRIND_MAKE_MEM_UNDEFINED(page_address(page), PAGE_SIZE << order);

  	__count_zone_vm_events(PGALLOC, zone, 1 << order);
  	zone_statistics(preferred_zone, zone);
@@ -1679,6 +1681,8 @@
  void __free_pages(struct page *page, unsigned int order)
  {
  	if (put_page_testzero(page)) {
+		VALGRIND_MAKE_MEM_NOACCESS(page_address(page),
+						PAGE_SIZE << order);
  		if (order == 0)
  			free_hot_page(page);
  		else

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
