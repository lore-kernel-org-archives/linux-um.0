Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GSdgU-0001II-D1 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 27 Sep 2006 10:59:02 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GSdgR-0004LW-Id
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 27 Sep 2006 10:59:02 -0700
Message-Id: <200609271757.k8RHvtNK005742@ccure.user-mode-linux.org>
Mime-Version: 1.0
Date: Wed, 27 Sep 2006 13:57:55 -0400
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 4/5] UML - Close file descriptor leaks
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Close two file descriptor leaks, one in the ubd driver and one to
/proc/mounts.  The ubd driver bug also leaked some vmalloc space.
The /proc/mounts leak was a descriptor that was just never closed.

Signed-off-by: Jeff Dike <jdike@addtoit.com>
---

 arch/um/drivers/ubd_kern.c |    9 ++-------
 arch/um/os-Linux/mem.c     |    6 +++++-
 2 files changed, 7 insertions(+), 8 deletions(-)

Index: linux-2.6.18-mm/arch/um/drivers/ubd_kern.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/drivers/ubd_kern.c	2006-09-26 16:28:58.000000000 -0400
+++ linux-2.6.18-mm/arch/um/drivers/ubd_kern.c	2006-09-26 16:31:24.000000000 -0400
@@ -667,18 +667,15 @@ static int ubd_add(int n)
 	if(dev->file == NULL)
 		goto out;
 
-	if (ubd_open_dev(dev))
-		goto out;
-
 	err = ubd_file_size(dev, &dev->size);
 	if(err < 0)
-		goto out_close;
+		goto out;
 
 	dev->size = ROUND_BLOCK(dev->size);
 
 	err = ubd_new_disk(MAJOR_NR, dev->size, n, &ubd_gendisk[n]);
 	if(err)
-		goto out_close;
+		goto out;
 
 	if(fake_major != MAJOR_NR)
 		ubd_new_disk(fake_major, dev->size, n,
@@ -690,8 +687,6 @@ static int ubd_add(int n)
 		make_ide_entries(ubd_gendisk[n]->disk_name);
 
 	err = 0;
-out_close:
-	ubd_close(dev);
 out:
 	return err;
 }
Index: linux-2.6.18-mm/arch/um/os-Linux/mem.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/os-Linux/mem.c	2006-09-26 16:28:50.000000000 -0400
+++ linux-2.6.18-mm/arch/um/os-Linux/mem.c	2006-09-26 16:31:24.000000000 -0400
@@ -132,6 +132,9 @@ err:
 	else if(found < 0)
 		printf("read returned errno %d\n", -found);
 
+out:
+	close(fd);
+
 	return;
 
 found:
@@ -141,11 +144,12 @@ found:
 
 	if(strncmp(buf, "tmpfs", strlen("tmpfs"))){
 		printf("not tmpfs\n");
-		return;
+		goto out;
 	}
 
 	printf("OK\n");
 	default_tmpdir = "/dev/shm";
+	goto out;
 }
 
 /*


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
