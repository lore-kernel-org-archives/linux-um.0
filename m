Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CUxJe-000075-CF for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Nov 2004 17:11:58 -0800
Received: from www.ssc.unict.it ([151.97.230.9] helo=ssc.unict.it)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CUxJc-0002d9-9M for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Nov 2004 17:11:58 -0800
From: blaisorblade_spam@yahoo.it
Message-Id: <20041119011337.74CDD7B9C9@zion.localdomain>
Subject: [uml-devel] [patch 3/4] uml: remove most devfs_mk_symlink calls
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
Date: Fri, 19 Nov 2004 02:13:37 +0100
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it, hch@infradead.org, jdike@addtoit.com


Cc: Christoph Hellwig <hch@infradead.org>

Remove uses of devfs_mk_symlink().

We didn't do this before to avoid breaking most user setups, but this patch
should be quite harmless.

I've excluded the hottest part, i.e. the ubd symlink, while removing the
other; I released a end-user tree with this patch and there was a good number
of people using the symlink rather than the preferred name. That part will be
merged later, I think.

Since now we have evidence of less and less users using devfs, we think that
it will not cause too much problems.

Acked-by: Jeff Dike <jdike@addtoit.com>

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 linux-2.6.10-rc-paolo/arch/um/drivers/line.c         |    9 +--------
 linux-2.6.10-rc-paolo/arch/um/drivers/mmapper_kern.c |    1 -
 2 files changed, 1 insertion(+), 9 deletions(-)

diff -puN arch/um/drivers/line.c~uml-remove-most-devfs-mk-symlink arch/um/drivers/line.c
--- linux-2.6.10-rc/arch/um/drivers/line.c~uml-remove-most-devfs-mk-symlink	2004-11-18 18:24:27.751930176 +0100
+++ linux-2.6.10-rc-paolo/arch/um/drivers/line.c	2004-11-18 18:24:27.755929568 +0100
@@ -415,8 +415,7 @@ struct tty_driver *line_register_devfs(s
 			 struct tty_operations *ops, struct line *lines,
 			 int nlines)
 {
-	int err, i;
-	char *from, *to;
+	int i;
 	struct tty_driver *driver = alloc_tty_driver(nlines);
 
 	if (!driver)
@@ -436,12 +435,6 @@ struct tty_driver *line_register_devfs(s
 	if (tty_register_driver(driver))
 		panic("line_register_devfs : Couldn't register driver\n");
 
-	from = line_driver->symlink_from;
-	to = line_driver->symlink_to;
-	err = devfs_mk_symlink(from, to);
-	if(err) printk("Symlink creation from /dev/%s to /dev/%s "
-		       "returned %d\n", from, to, err);
-
 	for(i = 0; i < nlines; i++){
 		if(!lines[i].valid) 
 			tty_unregister_device(driver, i);
diff -puN arch/um/drivers/mmapper_kern.c~uml-remove-most-devfs-mk-symlink arch/um/drivers/mmapper_kern.c
--- linux-2.6.10-rc/arch/um/drivers/mmapper_kern.c~uml-remove-most-devfs-mk-symlink	2004-11-18 18:24:27.753929872 +0100
+++ linux-2.6.10-rc-paolo/arch/um/drivers/mmapper_kern.c	2004-11-18 18:24:27.756929416 +0100
@@ -128,7 +128,6 @@ static int __init mmapper_init(void)
 	p_buf = __pa(v_buf);
 
 	devfs_mk_cdev(MKDEV(30, 0), S_IFCHR|S_IRUGO|S_IWUGO, "mmapper");
-	devfs_mk_symlink("mmapper0", "mmapper");
 	return(0);
 }
 
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
