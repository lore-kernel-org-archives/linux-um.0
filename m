Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Es0pa-0000SU-J2 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 29 Dec 2005 08:40:46 -0800
Received: from host3-98.pool876.interbusiness.it ([87.6.98.3]
	helo=zion.home.lan) by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1Es0pa-0001Dn-1Q for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 29 Dec 2005 08:40:46 -0800
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Message-Id: <20051229163956.4985.92278.stgit@zion.home.lan>
In-Reply-To: <20051229163803.4985.66742.stgit@zion.home.lan>
References: <20051229163803.4985.66742.stgit@zion.home.lan>
Subject: [uml-devel] [PATCH 3/5] uml: hostfs - fix possible PAGE_CACHE_SHIFT
	overflows
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
Date: Thu, 29 Dec 2005 17:39:57 +0100
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Prevent page->index << PAGE_CACHE_SHIFT from overflowing.

There is a casting there, but was added without care, so it's at the wrong
place. Note the extra parens around the shift - "+" is higher precedence than
"<<", leading to a GCC warning which saved all us.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 fs/hostfs/hostfs_kern.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index 3aac164..b3ad0bd 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -501,11 +501,16 @@ int hostfs_commit_write(struct file *fil
 	long long start;
 	int err = 0;
 
-	start = (long long) (page->index << PAGE_CACHE_SHIFT) + from;
+	start = (((long long) page->index) << PAGE_CACHE_SHIFT) + from;
 	buffer = kmap(page);
 	err = write_file(FILE_HOSTFS_I(file)->fd, &start, buffer + from,
 			 to - from);
 	if(err > 0) err = 0;
+
+	/* Actually, if !err, write_file has added to-from to start, so, despite
+	 * the appearance, we are comparing i_size against the _last_ written
+	 * location, as we should. */
+
 	if(!err && (start > inode->i_size))
 		inode->i_size = start;
 



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
