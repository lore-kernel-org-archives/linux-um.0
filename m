Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HOeao-0007K8-Rh for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 06 Mar 2007 10:40:59 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HOeak-0004j4-9a
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 06 Mar 2007 10:40:59 -0800
Message-Id: <200703061832.l26IW9J6006559@ccure.user-mode-linux.org>
Mime-Version: 1.0
Date: Tue, 06 Mar 2007 13:32:09 -0500
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 3/5] UML - handle block device hotplug errors
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

If a disk fails to open, i.e. its host file doesn't exist, it won't
be removable because the hot-unplug code checks the existence of its
gendisk.  This won't exist because it is only allocated for
successfully opened disks.  Thus, a typo on the command line can
result in a unusable and unfixable disk.

This is fixed by freeing the gendisk if it's there, but not letting
that affect the removal.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
--
 arch/um/drivers/ubd_kern.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

Index: test/arch/um/drivers/ubd_kern.c
===================================================================
--- test.orig/arch/um/drivers/ubd_kern.c	2007-03-05 13:14:50.000000000 -0500
+++ test/arch/um/drivers/ubd_kern.c	2007-03-05 13:40:13.000000000 -0500
@@ -790,14 +790,12 @@ static int ubd_id(char **str, int *start
 
 static int ubd_remove(int n, char **error_out)
 {
+	struct gendisk *disk;
 	struct ubd *ubd_dev;
 	int err = -ENODEV;
 
 	mutex_lock(&ubd_lock);
 
-	if(ubd_gendisk[n] == NULL)
-		goto out;
-
 	ubd_dev = &ubd_devs[n];
 
 	if(ubd_dev->file == NULL)
@@ -808,9 +806,12 @@ static int ubd_remove(int n, char **erro
 	if(ubd_dev->count > 0)
 		goto out;
 
-	del_gendisk(ubd_gendisk[n]);
-	put_disk(ubd_gendisk[n]);
-	ubd_gendisk[n] = NULL;
+ 	disk = ubd_gendisk[n];
+ 	ubd_gendisk[n] = NULL;
+	if(disk != NULL){
+		del_gendisk(disk);
+		put_disk(disk);
+	}
 
 	if(fake_gendisk[n] != NULL){
 		del_gendisk(fake_gendisk[n]);


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
