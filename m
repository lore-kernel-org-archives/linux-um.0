Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CyELe-0001U8-8X for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 07 Feb 2005 11:15:02 -0800
Received: from mail-relay-3.tiscali.it ([213.205.33.43])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CyELc-0002kV-9P for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 07 Feb 2005 11:15:02 -0800
From: blaisorblade@yahoo.it
Message-Id: <20050207191135.D8BC750BF2@zion>
Subject: [uml-devel] [patch 2/2] uml - hostfs: (security) fix chmod +s
	permission check [before 2.6.11]
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
Date: Mon, 07 Feb 2005 20:11:35 +0100
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it, xraz@rwxr-xr-x.de, viro@parcelfarce.linux.theplanet.co.uk


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Cc: Frank 'xraz' Fricke <xraz@rwxr-xr-x.de>, Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>

Frank Fricke reported that hostfs does not verify that a chmod +s, for
instance, is done by a sufficiently privileged user, as long as the UML kernel
itself can complete the operation on the host.

So, for instance, if UML is run as root and under /mnt/host we have a hostfs
mount, this works successfully:

paolo@zion:~ (0)$ chmod 4755 /mnt/host/bin/bash
paolo@zion:~ (0)$ ll /mnt/host/bin/bash

 -rwsr-xr-x  1 root root 662724 2004-10-20 02:15 /mnt/host/bin/bash*

(bash refuses running as setuid, but you could have another shell on the host,
as dash or whatever).

In general, if UML is run as uid 500 on the host, a hostfs mount is done and
under the hostfs mount there is a file with uid 500 on the host, I can freely
make it setuid (if it's executable).

This is especially bad when UML is run as root (which you should not do), but
is a problem in general, since it allows any user to create setuid 500 (in
this example) executables on the host filesystem.

Finally, while I was looking at the chmod() implementation, I spotted a kludge
in the code and explained it with a comment.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.11-paolo/fs/hostfs/hostfs.h      |   21 +++++++++++++++++++++
 linux-2.6.11-paolo/fs/hostfs/hostfs_kern.c |    4 ++++
 2 files changed, 25 insertions(+)

diff -puN fs/hostfs/hostfs_kern.c~uml-hostfs-fix-setuid-permission-check fs/hostfs/hostfs_kern.c
--- linux-2.6.11/fs/hostfs/hostfs_kern.c~uml-hostfs-fix-setuid-permission-check	2005-02-07 19:37:51.661248648 +0100
+++ linux-2.6.11-paolo/fs/hostfs/hostfs_kern.c	2005-02-07 19:39:24.317162808 +0100
@@ -823,6 +823,10 @@ int hostfs_setattr(struct dentry *dentry
 	char *name;
 	int err;
 
+	err = inode_change_ok(dentry->d_inode, attr);
+	if (err)
+		return err;
+
 	if(append)
 		attr->ia_valid &= ~ATTR_SIZE;
 
diff -puN fs/hostfs/hostfs.h~uml-hostfs-fix-setuid-permission-check fs/hostfs/hostfs.h
--- linux-2.6.11/fs/hostfs/hostfs.h~uml-hostfs-fix-setuid-permission-check	2005-02-07 19:37:51.663248344 +0100
+++ linux-2.6.11-paolo/fs/hostfs/hostfs.h	2005-02-07 19:37:51.666247888 +0100
@@ -16,9 +16,30 @@
 #define HOSTFS_ATTR_CTIME	64
 #define HOSTFS_ATTR_ATIME_SET	128
 #define HOSTFS_ATTR_MTIME_SET	256
+
+/* These two are unused by hostfs. */
 #define HOSTFS_ATTR_FORCE	512	/* Not a change, but a change it */
 #define HOSTFS_ATTR_ATTR_FLAG	1024
 
+/* If you are very careful, you'll notice that these two are missing:
+ *
+ * #define ATTR_KILL_SUID	2048
+ * #define ATTR_KILL_SGID	4096
+ *
+ * and this is because they were added in 2.5 development in this patch:
+ *
+ * http://linux.bkbits.net:8080/linux-2.5/
+ * cset@3caf4a12k4XgDzK7wyK-TGpSZ9u2Ww?nav=index.html
+ * |src/.|src/include|src/include/linux|related/include/linux/fs.h
+ *
+ * Actually, they are not needed by most ->setattr() methods - they are set by
+ * callers of notify_change() to notify that the setuid/setgid bits must be
+ * dropped.
+ * notify_change() will delete those flags, make sure attr->ia_valid & ATTR_MODE
+ * is on, and remove the appropriate bits from attr->ia_mode (attr is a
+ * "struct iattr *"). -BlaisorBlade
+ */
+
 struct hostfs_iattr {
 	unsigned int	ia_valid;
 	mode_t		ia_mode;
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
