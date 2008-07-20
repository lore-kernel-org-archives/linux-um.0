Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KKa4U-0000Nx-1q for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 20 Jul 2008 07:39:34 -0700
Received: from bigben2.bytemark.co.uk ([80.68.81.132])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KKa4S-0002OX-C6
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 20 Jul 2008 07:39:33 -0700
Received: from esaurito.net ([80.68.93.96])
	by bigben2.bytemark.co.uk with esmtp (Exim 4.63)
	(envelope-from <shammash@artha.org>) id 1KKa4Q-000675-JF
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 20 Jul 2008 14:39:30 +0000
Received: from localhost (localhost [127.0.0.1])
	by esaurito.net (Postfix) with ESMTP id D5371407C9
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 20 Jul 2008 16:39:28 +0200 (CEST)
Received: from pintsize (unknown [80.169.137.165])
	by esaurito.net (Postfix) with ESMTP id C829E407C8
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 20 Jul 2008 16:39:27 +0200 (CEST)
Date: Sun, 20 Jul 2008 15:39:29 +0100
From: Luca Bigliardi <shammash@artha.org>
Message-ID: <20080720143929.GD21627@pintsize>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="jI8keyz6grp/JLjh"
Content-Disposition: inline
Subject: [uml-devel] [PATCH] missed kmalloc() in vde_user.c
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Hi,
I'm attaching a patch for 2.6.26.


missed kmalloc() in vde_user.c

Signed-off-by: Luca Bigliardi <shammash@artha.org>



luca

-- 
Beware of programmers who carry screwdrivers.
                        -- Leonard Brandwein

http://www.artha.org/ - http://www.yue.it/

--jI8keyz6grp/JLjh
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="kmalloc-vde_user.diff"

diff --git a/arch/um/drivers/vde_user.c b/arch/um/drivers/vde_user.c
index 56533db..744eacf 100644
--- a/arch/um/drivers/vde_user.c
+++ b/arch/um/drivers/vde_user.c
@@ -78,7 +78,7 @@ void vde_init_libstuff(struct vde_data *vpri, struct vde_init *init)
 {
 	struct vde_open_args *args;
 
-	vpri->args = kmalloc(sizeof(struct vde_open_args), UM_GFP_KERNEL);
+	vpri->args = uml_kmalloc(sizeof(struct vde_open_args), UM_GFP_KERNEL);
 	if (vpri->args == NULL) {
 		printk(UM_KERN_ERR "vde_init_libstuff - vde_open_args "
 		       "allocation failed");

--jI8keyz6grp/JLjh
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
--jI8keyz6grp/JLjh
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--jI8keyz6grp/JLjh--

