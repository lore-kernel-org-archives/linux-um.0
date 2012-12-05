Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Paul.Chavent@onera.fr>) id 1TgGM1-00085p-R6
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 05 Dec 2012 14:53:41 +0000
Received: from briaree.onecert.fr ([134.212.190.4])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1TgGLv-0006JH-Dl for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 05 Dec 2012 14:53:39 +0000
From: Paul Chavent <Paul.Chavent@onera.fr>
Date: Wed,  5 Dec 2012 15:20:53 +0100
Message-Id: <1354717253-8737-1-git-send-email-paul.chavent@onera.fr>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: [uml-devel] [PATCH] net: fixup tx time stamping for uml vde driver.
To: jdike@addtoit.com, richard@nod.at, user-mode-linux-devel@lists.sourceforge.net, netdev@vger.kernel.org
Cc: Paul Chavent <Paul.Chavent@onera.fr>

Call skb_tx_timestamp after write completion.

Signed-off-by: Paul Chavent <paul.chavent@onera.fr>
---
 arch/um/drivers/vde_kern.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/um/drivers/vde_kern.c b/arch/um/drivers/vde_kern.c
index 6a365fa..38fea2f 100644
--- a/arch/um/drivers/vde_kern.c
+++ b/arch/um/drivers/vde_kern.c
@@ -52,9 +52,13 @@ static int vde_write(int fd, struct sk_buff *skb, struct uml_net_private *lp)
 {
 	struct vde_data *pri = (struct vde_data *) &lp->user;
 
-	if (pri->conn != NULL)
-		return vde_user_write((void *)pri->conn, skb->data,
-				      skb->len);
+	if (pri->conn != NULL) {
+		int count;
+		count = vde_user_write((void *)pri->conn, skb->data,
+				       skb->len);
+		skb_tx_timestamp(skb);
+		return count;
+	}
 
 	printk(KERN_ERR "vde_write - we have no VDECONN to write to");
 	return -EBADF;
-- 
1.7.12.1


------------------------------------------------------------------------------
LogMeIn Rescue: Anywhere, Anytime Remote support for IT. Free Trial
Remotely access PCs and mobile devices and provide instant support
Improve your efficiency, and focus on delivering more value-add services
Discover what IT Professionals Know. Rescue delivers
http://p.sf.net/sfu/logmein_12329d2d
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

