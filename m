Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JpSA3-0003l8-Qk for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 25 Apr 2008 10:56:39 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JpSA0-0000sU-L6
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 25 Apr 2008 10:56:39 -0700
Date: Fri, 25 Apr 2008 13:56:17 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080425175617.GA11204@c2.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 17/19] UML - use DIV_ROUND_UP
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

From: Jiri Olsa <olsajiri@gmail.com>

I just saw similar patches in the janitor kernel's list,
and spotted place it fits.

Signed-off-by: Jiri Olsa <olsajiri@gmail.com>
Signed-off-by: Jeff Dike <jdike@linux.intel.com>
---
 arch/um/drivers/ubd_kern.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6-git/arch/um/drivers/ubd_kern.c
===================================================================
--- linux-2.6-git.orig/arch/um/drivers/ubd_kern.c	2008-04-24 16:51:07.000000000 -0400
+++ linux-2.6-git/arch/um/drivers/ubd_kern.c	2008-04-24 17:06:17.000000000 -0400
@@ -1004,8 +1004,8 @@ static void cowify_bitmap(__u64 io_offse
 	 * by one word.  Thanks to Lynn Kerby for the fix and James McMechan
 	 * for the original diagnosis.
 	 */
-	if(*cow_offset == ((bitmap_len + sizeof(unsigned long) - 1) /
-			   sizeof(unsigned long) - 1))
+	if (*cow_offset == (DIV_ROUND_UP(bitmap_len,
+					 sizeof(unsigned long)) - 1))
 		(*cow_offset)--;
 
 	bitmap_words[0] = bitmap[*cow_offset];

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
