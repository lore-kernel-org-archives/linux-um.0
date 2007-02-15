Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HHXQi-0004zU-6Q for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 14 Feb 2007 19:37:08 -0800
Received: from smtp006.mail.ukl.yahoo.com ([217.12.11.95])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1HHXQf-0007v2-24
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 14 Feb 2007 19:37:07 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Thu, 15 Feb 2007 04:36:54 +0100
References: <Pine.LNX.4.64.0701260101250.5924@sparrow>
	<20070126151328.GA4436@ccure.user-mode-linux.org>
In-Reply-To: <20070126151328.GA4436@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_WV90FHB0e0b8BCB"
Message-Id: <200702150436.54553.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Possible hostfs uml kernel data corruption with
	missing host directory (fc6, 2.6.20-rc5-git3 on opteron)
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>, William Stearns <wstearns@pobox.com>

--Boundary-00=_WV90FHB0e0b8BCB
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Friday 26 January 2007 16:13, Jeff Dike wrote:
> On Fri, Jan 26, 2007 at 04:07:05AM -0500, William Stearns wrote:
> > 	After bisecting the difference between the two root filesystems,
> > the critical change was a line in /etc/fstab:
> >
> > none            /mirrors        hostfs  defaults,/home/mirrors  0 0
> >
> > 	Woah.

Ok, I think I have found it from code analisys (no testing done). Please test 
the attached patch, since the bug is repeatable for you.

Ok, we have a double kfree inside hostfs_fill_sb_common; since name is 
assigned to host_filename, it is owned by the inode, and freed both by dput 
and by kfree(name).

The path from dput to the first free is:
dput->iput->hostfs_destroy_inode->kfree(... ->host_filename)

The simplest fix is to clear 'name' after assigning it to ->host_filename. 
Patch attached - the second hunk is totally optional, it avoids a 
kfree(NULL);. The goal was maximum simplicity here.

Also, I discovered that in read_inode, failure from file_type (which calls 
lstat64) is ignored. read_name is subsequently called, it calls lstat again, 
so this should not be a problem; however, the other call to file_type (in 
init_inode) is also unchecked, and that is less robust.
-- 
Inform me of my mistakes, so I can add them to my list!
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade

--Boundary-00=_WV90FHB0e0b8BCB
Content-Type: text/x-diff; charset="iso-8859-1";
	name="hostfs-fix-double-free.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="hostfs-fix-double-free.diff"

Subject: uml - hostfs: fix double free

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Fix double free in the error path - when name is assigned into root_inode we do
not own it any more and we must not kfree() it - see patch for details.

Thanks to William Stearns for the initial report.

CC: William Stearns <wstearns@pobox.com>
Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Index: linux-2.6.git/fs/hostfs/hostfs_kern.c
===================================================================
--- linux-2.6.git.orig/fs/hostfs/hostfs_kern.c
+++ linux-2.6.git/fs/hostfs/hostfs_kern.c
@@ -966,6 +966,9 @@ static int hostfs_fill_sb_common(struct 
 		goto out_put;
 
 	HOSTFS_I(root_inode)->host_filename = name;
+	/* Avoid that in the error path, iput(root_inode) frees again name through
+	 * hostfs_destroy_inode! */
+	name = NULL;
 
 	err = -ENOMEM;
 	sb->s_root = d_alloc_root(root_inode);
@@ -977,7 +980,7 @@ static int hostfs_fill_sb_common(struct 
                 /* No iput in this case because the dput does that for us */
                 dput(sb->s_root);
                 sb->s_root = NULL;
-		goto out_free;
+		goto out;
         }
 
 	return(0);

--Boundary-00=_WV90FHB0e0b8BCB
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--Boundary-00=_WV90FHB0e0b8BCB
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--Boundary-00=_WV90FHB0e0b8BCB--
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 

