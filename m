Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CFcvc-0000rr-PL for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Oct 2004 11:23:48 -0700
Received: from mail-relay-4.tiscali.it ([213.205.33.44])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CFcva-0007a7-9S for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Oct 2004 11:23:48 -0700
From: blaisorblade_spam@yahoo.it
Message-Id: <20041007182254.B3A8A49BA@zion.localdomain>
Subject: [uml-devel] [patch 1/2] uml: fix fd leak with HostFs
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
Date: Thu, 07 Oct 2004 20:22:54 +0200
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it


On 2.4 we used force_delete() to make sure inode were not cached, and we then
close the host file when the inode is cleared; when porting to 2.6 the
"force_delete" thing was dropped, and this patch adds a fix for this (by
setting drop_inode = generic_delete_inode).

Search for drop_inode in the 2.6 Documentation/filesystems/vfs.txt for info
about this.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 linux-2.6.9-current-paolo/fs/hostfs/hostfs_kern.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff -puN fs/hostfs/hostfs_kern.c~uml-HostFs-2.6-fd_leak fs/hostfs/hostfs_kern.c
--- linux-2.6.9-current/fs/hostfs/hostfs_kern.c~uml-HostFs-2.6-fd_leak	2004-10-07 17:38:01.075378432 +0200
+++ linux-2.6.9-current-paolo/fs/hostfs/hostfs_kern.c	2004-10-07 20:21:52.868718656 +0200
@@ -290,7 +290,6 @@ static void hostfs_delete_inode(struct i
 {
 	if(HOSTFS_I(inode)->fd != -1) {
 		close_file(&HOSTFS_I(inode)->fd);
-		printk("Closing host fd in .delete_inode\n");
 		HOSTFS_I(inode)->fd = -1;
 	}
 	clear_inode(inode);
@@ -301,9 +300,11 @@ static void hostfs_destroy_inode(struct 
 	if(HOSTFS_I(inode)->host_filename)
 		kfree(HOSTFS_I(inode)->host_filename);
 
+	/*XXX: This should not happen, probably. The check is here for
+	 * additional safety.*/
 	if(HOSTFS_I(inode)->fd != -1) {
 		close_file(&HOSTFS_I(inode)->fd);
-		printk("Closing host fd in .destroy_inode\n");
+		printk(KERN_DEBUG "Closing host fd in .destroy_inode\n");
 	}
 
 	kfree(HOSTFS_I(inode));
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
