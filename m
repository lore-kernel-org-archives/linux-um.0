Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AFFS3-0006Zw-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu, 30 Oct 2003 08:15:11 -0800
Received: from hirsch.in-berlin.de ([192.109.42.6] ident=root)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.24)
	id 1AFFS3-0006nS-3c
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 30 Oct 2003 08:15:11 -0800
From: Gerd Knorr <kraxel@bytesex.org>
Message-ID: <20031030162902.GE19575@bytesex.org>
References: <20031030155757.GA19575@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031030155757.GA19575@bytesex.org>
Subject: [uml-devel] [patch] change ubd names
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Thu, 30 Oct 2003 17:29:02 +0100
To: Jeff Dike <jdike@addtoit.com>, uml devel <user-mode-linux-devel@lists.sourceforge.net>

  Hi,

This patch renames the virtual block devices from ubd0,1,2 to
ubda,b,c (in /proc/partitions).  This is how they are named
in 2.4 kernels.  And this is IMHO better to number devices that
way because (a) hd + sd use the same scheme and (b) it is much
less confusing if you create partitions on your virtual block
devices.

  Gerd

--- 2.6.0-test9/arch/um/drivers/ubd_kern.c.ubd	2003-10-30 12:08:33.000000000 +0100
+++ 2.6.0-test9/arch/um/drivers/ubd_kern.c	2003-10-30 12:09:11.000000000 +0100
@@ -528,7 +528,7 @@
 	disk->fops = &ubd_blops;
 	set_capacity(disk, size / 512);
 	if(major == MAJOR_NR){
-		sprintf(disk->disk_name, "ubd%d", unit);
+		sprintf(disk->disk_name, "ubd%c", 'a' + unit);
 		sprintf(disk->devfs_name, "ubd/disc%d", unit);
 		sprintf(from, "ubd/%d", unit);
 		sprintf(to, "disc%d/disc", unit);


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
