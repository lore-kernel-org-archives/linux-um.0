Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from zeniv-ca.linux.org.uk ([2607:5300:60:148a::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mSQuN-003BOm-6x
 for linux-um@lists.infradead.org; Mon, 20 Sep 2021 21:33:07 +0000
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1mSQuM-005yeo-DL
 for linux-um@lists.infradead.org; Mon, 20 Sep 2021 21:33:02 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 13/15] um: header debriding - net_*.h
Date: Mon, 20 Sep 2021 21:32:59 +0000
Message-Id: <20210920213301.1424730-13-viro@zeniv.linux.org.uk>
In-Reply-To: <20210920213301.1424730-1-viro@zeniv.linux.org.uk>
References: <YUj9S+S4Gd86mM6N@zeniv-ca.linux.org.uk>
 <20210920213301.1424730-1-viro@zeniv.linux.org.uk>
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: linux-um@lists.infradead.org

externs dead since before the initial merge

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/um/include/shared/net_kern.h | 2 --
 arch/um/include/shared/net_user.h | 1 -
 2 files changed, 3 deletions(-)

diff --git a/arch/um/include/shared/net_kern.h b/arch/um/include/shared/net_kern.h
index a87be13c5b877..441a8a3093294 100644
--- a/arch/um/include/shared/net_kern.h
+++ b/arch/um/include/shared/net_kern.h
@@ -59,8 +59,6 @@ struct transport {
 	const int setup_size;
 };
 
-extern struct net_device *ether_init(int);
-extern unsigned short ether_protocol(struct sk_buff *);
 extern int tap_setup_common(char *str, char *type, char **dev_name,
 			    char **mac_out, char **gate_addr);
 extern void register_transport(struct transport *new);
diff --git a/arch/um/include/shared/net_user.h b/arch/um/include/shared/net_user.h
index 1b0531769a5eb..ba92a4d935312 100644
--- a/arch/um/include/shared/net_user.h
+++ b/arch/um/include/shared/net_user.h
@@ -24,7 +24,6 @@ struct net_user_info {
 	int mtu;
 };
 
-extern void ether_user_init(void *data, void *dev);
 extern void iter_addresses(void *d, void (*cb)(unsigned char *,
 					       unsigned char *, void *),
 			   void *arg);
-- 
2.11.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

