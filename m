Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FMqnF-0003b7-Fg for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 24 Mar 2006 10:13:49 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FMqnD-0005db-N7
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 24 Mar 2006 10:13:49 -0800
Message-Id: <200603241815.k2OIF3sG005565@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 14/16] UML - Prevent umid theft
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
Date: Fri, 24 Mar 2006 13:15:03 -0500
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Behavior when booting two UMLs with the same umid was broken.  The
second one would steal the umid.  This fixes that, making the second
UML take a random umid instead.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.15/arch/um/os-Linux/umid.c
===================================================================
--- linux-2.6.15.orig/arch/um/os-Linux/umid.c	2006-02-09 18:49:55.000000000 -0500
+++ linux-2.6.15/arch/um/os-Linux/umid.c	2006-02-10 14:11:28.000000000 -0500
@@ -143,8 +143,10 @@ static int not_dead_yet(char *dir)
 		goto out_close;
 	}
 
-	if((kill(p, 0) == 0) || (errno != ESRCH))
+	if((kill(p, 0) == 0) || (errno != ESRCH)){
+		printk("umid \"%s\" is already in use by pid %d\n", umid, p);
 		return 1;
+	}
 
 	err = actually_do_remove(dir);
 	if(err)
@@ -234,33 +236,44 @@ int __init make_umid(void)
 	err = mkdir(tmp, 0777);
 	if(err < 0){
 		err = -errno;
-		if(errno != EEXIST)
+		if(err != -EEXIST)
 			goto err;
 
-		if(not_dead_yet(tmp) < 0)
+		/* 1   -> this umid is already in use
+		 * < 0 -> we couldn't remove the umid directory
+		 * In either case, we can't use this umid, so return -EEXIST.
+		 */
+		if(not_dead_yet(tmp) != 0)
 			goto err;
 
 		err = mkdir(tmp, 0777);
 	}
-	if(err < 0){
-		printk("Failed to create '%s' - err = %d\n", umid, err);
-		goto err_rmdir;
+	if(err){
+		err = -errno;
+		printk("Failed to create '%s' - err = %d\n", umid, -errno);
+		goto err;
 	}
 
 	umid_setup = 1;
 
 	create_pid_file();
 
-	return 0;
-
- err_rmdir:
-	rmdir(tmp);
+	err = 0;
  err:
 	return err;
 }
 
 static int __init make_umid_init(void)
 {
+	if(!make_umid())
+		return 0;
+
+	/* If initializing with the given umid failed, then try again with
+	 * a random one.
+	 */
+	printk("Failed to initialize umid \"%s\", trying with a random umid\n",
+	       umid);
+	*umid = '\0';
 	make_umid();
 
 	return 0;



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
