Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-list1-b.sourceforge.net ([10.3.1.7]
	helo=sc8-sf-list1.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FnRl7-0008HU-LQ for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 05 Jun 2006 19:57:34 -0700
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Fmmi4-00076V-SC for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 04 Jun 2006 00:07:40 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Fmi9s-0005PX-Bo
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 03 Jun 2006 19:16:07 -0700
Message-Id: <200606040216.k542GG9q004842@ccure.user-mode-linux.org>
Mime-Version: 1.0
Date: Sat, 03 Jun 2006 22:16:16 -0400
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 4/6] UML - __user annotation in arch_prctl
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
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, Al Viro <viro@zeniv.linux.org.uk>

From: Al Viro <viro@zeniv.linux.org.uk>

fix uml/amd64 prctl()
   
put_user() there should go to (long __user *)addr, not &addr

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.17-mm/arch/um/sys-x86_64/syscalls.c
===================================================================
--- linux-2.6.17-mm.orig/arch/um/sys-x86_64/syscalls.c	2006-05-31 12:14:58.000000000 -0400
+++ linux-2.6.17-mm/arch/um/sys-x86_64/syscalls.c	2006-06-02 18:39:09.000000000 -0400
@@ -45,7 +45,7 @@ static long arch_prctl_tt(int code, unsi
 	case ARCH_GET_GS:
 		ret = arch_prctl(code, (unsigned long) &tmp);
 		if(!ret)
-			ret = put_user(tmp, &addr);
+			ret = put_user(tmp, (long __user *)addr);
 		break;
 	default:
 		ret = -EINVAL;




_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
