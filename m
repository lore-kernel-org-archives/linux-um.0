Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DPm5m-000613-Gk for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 24 Apr 2005 11:44:30 -0700
Received: from mail-relay-3.tiscali.it ([213.205.33.43])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DPm5l-0000BV-Q2 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 24 Apr 2005 11:44:30 -0700
From: blaisorblade@yahoo.it
Message-Id: <20050424181919.D305E55D01@zion>
Subject: [uml-devel] [patch 5/7] uml - hostfs: avoid buffers
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
Date: Sun, 24 Apr 2005 20:19:19 +0200
To: akpm@osdl.org
Cc: jdike@addtoit.com, bstroesser@fujitsu-siemens.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Use this:
	.set_page_dirty = __set_page_dirty_nobuffers,

We already dropped the inclusion of <linux/buffer_head.h>, and we don't have
a backing block device for this FS.

"Without having looked at it, I'm sure that hostfs does not use
buffer_heads.  So setting your ->set_page_dirty a_op to point at
__set_page_dirty_nobuffers() is a reasonable thing to do - it'll provide a
slight speedup."

This speedup is one less spinlock held and one less conditional branch, which
isn't bad.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.12-paolo/fs/hostfs/hostfs_kern.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN fs/hostfs/hostfs_kern.c~uml-hostfs-avoid-buffers fs/hostfs/hostfs_kern.c
--- linux-2.6.12/fs/hostfs/hostfs_kern.c~uml-hostfs-avoid-buffers	2005-04-24 20:17:05.000000000 +0200
+++ linux-2.6.12-paolo/fs/hostfs/hostfs_kern.c	2005-04-24 20:17:05.000000000 +0200
@@ -521,7 +521,7 @@ int hostfs_commit_write(struct file *fil
 static struct address_space_operations hostfs_aops = {
 	.writepage 	= hostfs_writepage,
 	.readpage	= hostfs_readpage,
-/* 	.set_page_dirty = __set_page_dirty_nobuffers, */
+	.set_page_dirty = __set_page_dirty_nobuffers,
 	.prepare_write	= hostfs_prepare_write,
 	.commit_write	= hostfs_commit_write
 };
_


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
