Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CUxJ8-00004q-Cw for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Nov 2004 17:11:26 -0800
Received: from www.ssc.unict.it ([151.97.230.9] helo=ssc.unict.it)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CUxJ7-0002Xj-AJ for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Nov 2004 17:11:26 -0800
From: blaisorblade_spam@yahoo.it
Message-Id: <20041119011328.023F57B9AA@zion.localdomain>
Subject: [uml-devel] [patch 1/4] hostfs - uml: set .sendfile to
	generic_file_sendfile
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
Date: Fri, 19 Nov 2004 02:13:26 +0100
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it, viro@parcelfarce.linux.theplanet.co.uk


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
Cc: Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>

Make hostfs use the generic sendfile implementation. As you can see, the
problem was simply that it was forgot to set hostfs_file_fops.sendfile to
point to it. I've got one report that it works, and since hostfs uses the VFS
cache it seems reasonable. However, can somebody confirm this?

Also, is there anything spotting similar treatment?

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 linux-2.6.10-rc-paolo/fs/hostfs/hostfs_kern.c |    1 +
 1 files changed, 1 insertion(+)

diff -puN fs/hostfs/hostfs_kern.c~uml-hostfs-add-sendfile fs/hostfs/hostfs_kern.c
--- linux-2.6.10-rc/fs/hostfs/hostfs_kern.c~uml-hostfs-add-sendfile	2004-11-18 14:32:39.436315536 +0100
+++ linux-2.6.10-rc-paolo/fs/hostfs/hostfs_kern.c	2004-11-18 14:32:39.439315080 +0100
@@ -393,6 +393,7 @@ int hostfs_fsync(struct file *file, stru
 static struct file_operations hostfs_file_fops = {
 	.llseek		= generic_file_llseek,
 	.read		= generic_file_read,
+	.sendfile	= generic_file_sendfile,
 	.write		= generic_file_write,
 	.mmap		= generic_file_mmap,
 	.open		= hostfs_file_open,
_


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
