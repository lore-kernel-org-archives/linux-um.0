Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab6.miniserver.com ([5.153.251.140]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hnJJR-0006BT-P0
 for linux-um@lists.infradead.org; Tue, 16 Jul 2019 08:59:55 +0000
From: anton.ivanov@cambridgegreys.com
Subject: [PATCHv3 3/5] um: Add checks to mtu parameter parsing
Date: Tue, 16 Jul 2019 09:59:37 +0100
Message-Id: <20190716085939.21297-3-anton.ivanov@cambridgegreys.com>
In-Reply-To: <20190716085939.21297-1-anton.ivanov@cambridgegreys.com>
References: <20190716085939.21297-1-anton.ivanov@cambridgegreys.com>
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: linux-um@lists.infradead.org
Cc: richard@nod.at, Anton Ivanov <anton.ivanov@cambridgegreys.com>

From: Anton Ivanov <anton.ivanov@cambridgegreys.com>

Adds a sanity check to the parsing of mtu command line param

Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
---
 arch/um/drivers/vector_kern.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
index e314a60cdc98..e79cd1dcb018 100644
--- a/arch/um/drivers/vector_kern.c
+++ b/arch/um/drivers/vector_kern.c
@@ -121,7 +121,8 @@ static int get_mtu(struct arglist *def)
 
 	if (mtu != NULL) {
 		if (kstrtoul(mtu, 10, &result) == 0)
-			return result;
+			if ((result < (1 << 16) - 1) && (result >= 576))
+				return result;
 	}
 	return ETH_MAX_PACKET;
 }
-- 
2.11.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

