Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Es0ps-0000U5-Bk for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 29 Dec 2005 08:41:04 -0800
Received: from host3-98.pool876.interbusiness.it ([87.6.98.3]
	helo=zion.home.lan) by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1Es0pr-0001BJ-SU for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 29 Dec 2005 08:41:04 -0800
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Message-Id: <20051229163953.4985.51651.stgit@zion.home.lan>
In-Reply-To: <20051229163803.4985.66742.stgit@zion.home.lan>
References: <20051229163803.4985.66742.stgit@zion.home.lan>
Subject: [uml-devel] [PATCH 2/5] Hostfs: remove unused var
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
Date: Thu, 29 Dec 2005 17:39:54 +0100
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Trivial removal of unused variable from this file - doesn't even change the
generated assembly code, in fact (gcc should trigger a warning for unused value
here).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 fs/hostfs/hostfs_kern.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index 4684eb7..3aac164 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -910,10 +910,8 @@ static struct inode_operations hostfs_di
 int hostfs_link_readpage(struct file *file, struct page *page)
 {
 	char *buffer, *name;
-	long long start;
 	int err;
 
-	start = page->index << PAGE_CACHE_SHIFT;
 	buffer = kmap(page);
 	name = inode_name(page->mapping->host, 0);
 	if(name == NULL) return(-ENOMEM);



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
