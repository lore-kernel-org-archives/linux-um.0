Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FMqnJ-0003bQ-IB for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 24 Mar 2006 10:13:53 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FMqnI-0005im-Tu
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 24 Mar 2006 10:13:53 -0800
Message-Id: <200603241815.k2OIF6Ts005575@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 16/16] UML - Fix hostfs stack corruption
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
Date: Fri, 24 Mar 2006 13:15:06 -0500
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, Oleg Drokin <green@linuxhacker.ru>

Noted by Oleg Drokin:
We initialized an extra slot of struct kstatfs.spare, sometimes
causing stack corruption.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.16/fs/hostfs/hostfs_user.c
===================================================================
--- linux-2.6.16.orig/fs/hostfs/hostfs_user.c	2006-03-23 16:49:38.000000000 -0500
+++ linux-2.6.16/fs/hostfs/hostfs_user.c	2006-03-23 17:46:09.000000000 -0500
@@ -360,7 +360,6 @@ int do_statfs(char *root, long *bsize_ou
 	spare_out[2] = buf.f_spare[2];
 	spare_out[3] = buf.f_spare[3];
 	spare_out[4] = buf.f_spare[4];
-	spare_out[5] = buf.f_spare[5];
 	return(0);
 }
 



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
