Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DslX5-0000wx-8O	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 13 Jul 2005 11:00:31 -0700
Received: from [151.97.230.9] (helo=ssc.unict.it)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.44)
	id 1DslX4-0005ls-A7	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 13 Jul 2005 11:00:31 -0700
From: blaisorblade@yahoo.it
Message-Id: <20050713180243.013CF21E73D@zion.home.lan>
Subject: [uml-devel] [patch 9/9] remove EXPORT_SYMBOL for root_dev
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
Date: Wed, 13 Jul 2005 20:02:42 +0200
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it, hch@infradead.org


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
CC: Christoph Hellwig <hch@infradead.org>

Remove ROOT_DEV after unexporting it in the previous patch, as requested time
ago by Christoph Hellwig.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-broken-paolo/init/do_mounts.c |    2 --
 1 files changed, 2 deletions(-)

diff -puN init/do_mounts.c~remove-export-root_dev init/do_mounts.c
--- linux-2.6.git-broken/init/do_mounts.c~remove-export-root_dev	2005-07-13 19:59:50.000000000 +0200
+++ linux-2.6.git-broken-paolo/init/do_mounts.c	2005-07-13 19:59:50.000000000 +0200
@@ -25,8 +25,6 @@ static char __initdata saved_root_name[6
 /* this is initialized in init/main.c */
 dev_t ROOT_DEV;
 
-EXPORT_SYMBOL(ROOT_DEV);
-
 static int __init load_ramdisk(char *str)
 {
 	rd_doload = simple_strtol(str,NULL,0) & 3;
_


-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP,
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
