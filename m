Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CUxJG-00005R-Ke for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Nov 2004 17:11:34 -0800
Received: from www.ssc.unict.it ([151.97.230.9] helo=ssc.unict.it)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CUxJF-00078U-EH for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Nov 2004 17:11:34 -0800
From: blaisorblade_spam@yahoo.it
Message-Id: <20041119011332.64C417B9AA@zion.localdomain>
Subject: [uml-devel] [patch 2/4] hostfs - uml: add some other pagecache methods
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
Date: Fri, 19 Nov 2004 02:13:31 +0100
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it, viro@parcelfarce.linux.theplanet.co.uk


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
Cc: Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>

This is a follow-up to my previous "hostfs - uml: set .sendfile to
generic_file_sendfile" patch. I was asking whether other methods should have
been added, and comparing with ext3 I found some more ones.

However, I have not specific clues about them: I know they use the pagecache,
which relies on *page methods, which are defined by hostfs. So I think it
could work.

I have a doubt, whether hostfs needs the commented out method below:

static struct address_space_operations hostfs_aops = {
	.writepage 	= hostfs_writepage,
	.readpage	= hostfs_readpage,
/* 	.set_page_dirty = __set_page_dirty_nobuffers, */
	.prepare_write	= hostfs_prepare_write,
	.commit_write	= hostfs_commit_write
};

Hostfs does not have a underlying device (and I have some rough idea that
buffers cache block devices data), so I wonder if that is needed or not.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 linux-2.6.10-rc-paolo/fs/hostfs/hostfs_kern.c |    5 +++++
 1 files changed, 5 insertions(+)

diff -puN fs/hostfs/hostfs_kern.c~uml-hostfs-add-some-other-pagecache-methods fs/hostfs/hostfs_kern.c
--- linux-2.6.10-rc/fs/hostfs/hostfs_kern.c~uml-hostfs-add-some-other-pagecache-methods	2004-11-18 17:43:38.239312696 +0100
+++ linux-2.6.10-rc-paolo/fs/hostfs/hostfs_kern.c	2004-11-18 17:43:38.242312240 +0100
@@ -394,6 +394,10 @@ static struct file_operations hostfs_fil
 	.llseek		= generic_file_llseek,
 	.read		= generic_file_read,
 	.sendfile	= generic_file_sendfile,
+	.aio_read	= generic_file_aio_read,
+	.aio_write	= generic_file_aio_write,
+	.readv		= generic_file_readv,
+	.writev		= generic_file_writev,
 	.write		= generic_file_write,
 	.mmap		= generic_file_mmap,
 	.open		= hostfs_file_open,
@@ -402,6 +406,7 @@ static struct file_operations hostfs_fil
 };
 
 static struct file_operations hostfs_dir_fops = {
+	.llseek		= generic_file_llseek,
 	.readdir	= hostfs_readdir,
 	.read		= generic_read_dir,
 };
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
