Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JpSA4-0003kU-ER for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 25 Apr 2008 10:56:40 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JpS9v-0000rF-Tl
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 25 Apr 2008 10:56:35 -0700
Date: Fri, 25 Apr 2008 13:56:10 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080425175610.GA11190@c2.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 10/19] UML - Fix errno return
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>
Cc: Johann Felix Soden <johfel@users.sourceforge.net>

From: Johann Felix Soden <johfel@users.sourceforge.net>

Error returns are negative.

Signed-off-by: Johann Felix Soden <johfel@users.sourceforge.net>
Signed-off-by: Jeff Dike <jdike@linux.intel.com>
---
 arch/um/drivers/hostaudio_kern.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.22/arch/um/drivers/hostaudio_kern.c
===================================================================
--- linux-2.6.22.orig/arch/um/drivers/hostaudio_kern.c	2007-11-14 10:33:29.000000000 -0500
+++ linux-2.6.22/arch/um/drivers/hostaudio_kern.c	2008-02-13 12:36:26.000000000 -0500
@@ -154,7 +154,7 @@ static int hostaudio_ioctl(struct inode 
 	case SNDCTL_DSP_SUBDIVIDE:
 	case SNDCTL_DSP_SETFRAGMENT:
 		if (get_user(data, (int __user *) arg))
-			return EFAULT;
+			return -EFAULT;
 		break;
 	default:
 		break;

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
