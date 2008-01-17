Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JFcU3-00018X-H0 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Jan 2008 13:41:11 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JFcU2-00014s-OY
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Jan 2008 13:41:11 -0800
Date: Thu, 17 Jan 2008 16:40:47 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080117214047.GA6767@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 16/20] UML - Use of a public MAC is a warning,
	not an error
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
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

Downgrade one of the MAC validity checks.  If it's one that could be
possibly assigned to a physical NIC, then nothing will break.  So,
emit a warning in this case, but keep the requested MAC.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
---
 arch/um/drivers/net_kern.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

Index: linux-2.6-git/arch/um/drivers/net_kern.c
===================================================================
--- linux-2.6-git.orig/arch/um/drivers/net_kern.c	2008-01-02 13:16:19.000000000 -0500
+++ linux-2.6-git/arch/um/drivers/net_kern.c	2008-01-02 15:37:02.000000000 -0500
@@ -318,7 +318,7 @@ static void setup_etheraddr(char *str, u
 	if (str == NULL)
 		goto random;
 
-	for (i = 0;i < 6; i++) {
+	for (i = 0; i < 6; i++) {
 		addr[i] = simple_strtoul(str, &end, 16);
 		if ((end == str) ||
 		   ((*end != ':') && (*end != ',') && (*end != '\0'))) {
@@ -343,14 +343,13 @@ static void setup_etheraddr(char *str, u
 	}
 	if (!is_local_ether_addr(addr)) {
 		printk(KERN_WARNING
-		       "Warning: attempt to assign a globally valid ethernet "
+		       "Warning: Assigning a globally valid ethernet "
 		       "address to a device\n");
-		printk(KERN_WARNING "You should better enable the 2nd "
-		       "rightmost bit in the first byte of the MAC,\n");
+		printk(KERN_WARNING "You should set the 2nd rightmost bit in "
+		       "the first byte of the MAC,\n");
 		printk(KERN_WARNING "i.e. %02x:%02x:%02x:%02x:%02x:%02x\n",
 		       addr[0] | 0x02, addr[1], addr[2], addr[3], addr[4],
 		       addr[5]);
-		goto random;
 	}
 	return;
 

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
