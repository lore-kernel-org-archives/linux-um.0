Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EL49M-0008Hj-Aq	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 29 Sep 2005 12:33:00 -0700
Received: from ppp-62-11-74-97.dialup.tiscali.it ([62.11.74.97]
	helo=zion.home.lan)	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EL49L-0006Pi-43	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 29 Sep 2005 12:33:00 -0700
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Message-Id: <20050929193101.14528.90627.stgit@zion.home.lan>
In-Reply-To: <200509292102.44942.blaisorblade@yahoo.it>
References: <200509292102.44942.blaisorblade@yahoo.it>
Subject: [uml-devel] [PATCH 5/5] uml: remove empty hostfs_truncate method
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
Date: Thu, 29 Sep 2005 21:31:02 +0200
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Calling truncate() on hostfs spits a kernel warning "Something isn't implemented
here", but it still works fine.

Indeed, hostfs i_op->truncate doesn't do anything. But hostfs_setattr() ->
set_attr() correctly detects ATTR_SIZE and calls truncate() on the host. So we
should be safe (using ftruncate() may be better, in case the file is unlinked on
the host, but we aren't sure to have the file open for writing, and reopening it
would cause the same races; plus nobody should expect UML to be so careful).

So, the warning is wrong, because the current implementation is working. Al, am
I correct, and can the warning be therefore dropped?

CC: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 fs/hostfs/hostfs_kern.c |    7 -------
 1 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -793,11 +793,6 @@ int hostfs_rename(struct inode *from_ino
 	return(err);
 }
 
-void hostfs_truncate(struct inode *ino)
-{
-	not_implemented();
-}
-
 int hostfs_permission(struct inode *ino, int desired, struct nameidata *nd)
 {
 	char *name;
@@ -894,7 +889,6 @@ static struct inode_operations hostfs_io
 	.rmdir		= hostfs_rmdir,
 	.mknod		= hostfs_mknod,
 	.rename		= hostfs_rename,
-	.truncate	= hostfs_truncate,
 	.permission	= hostfs_permission,
 	.setattr	= hostfs_setattr,
 	.getattr	= hostfs_getattr,
@@ -910,7 +904,6 @@ static struct inode_operations hostfs_di
 	.rmdir		= hostfs_rmdir,
 	.mknod		= hostfs_mknod,
 	.rename		= hostfs_rename,
-	.truncate	= hostfs_truncate,
 	.permission	= hostfs_permission,
 	.setattr	= hostfs_setattr,
 	.getattr	= hostfs_getattr,



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
