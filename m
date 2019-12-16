Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1igtmP-0001ay-FN
 for linux-um@lists.infradead.org; Mon, 16 Dec 2019 17:03:34 +0000
From: anton.ivanov@cambridgegreys.com
Subject: [PATCH v3 4/6] um: Enable GRO by default when using raw in pcap
 compat mode
Date: Mon, 16 Dec 2019 17:03:19 +0000
Message-Id: <20191216170321.14056-4-anton.ivanov@cambridgegreys.com>
In-Reply-To: <20191216170321.14056-1-anton.ivanov@cambridgegreys.com>
References: <20191216170321.14056-1-anton.ivanov@cambridgegreys.com>
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
Cc: richard@nod.at, brendanhiggins@google.com, Anton Ivanov <anton.ivanov@cambridgegreys.com>

From: Anton Ivanov <anton.ivanov@cambridgegreys.com>

GRO is enabled nearly everywhere in Linux nowdays, not having
it on by default results in packet drops across the board.

Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
---
 arch/um/drivers/vector_kern.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
index 234081ad4f02..d52c24874f2a 100644
--- a/arch/um/drivers/vector_kern.c
+++ b/arch/um/drivers/vector_kern.c
@@ -1717,9 +1717,9 @@ int vector_compat_eth_configure(char *str, int index)
 			       &options[0], &options[1], &mac, NULL);
 
 		if ((mac != NULL) && strlen(mac) > 0)
-			snprintf(tempargs, MAX_COMPAT_ARG, "transport=raw,ifname=%s,mac=%s", ifname, mac);
+			snprintf(tempargs, MAX_COMPAT_ARG, "transport=raw,gro=1,ifname=%s,mac=%s", ifname, mac);
 		else
-			snprintf(tempargs, MAX_COMPAT_ARG, "transport=raw,ifname=%s", ifname);
+			snprintf(tempargs, MAX_COMPAT_ARG, "transport=raw,gro=1,ifname=%s", ifname);
 
 		strcpy(newargs, tempargs);
 
-- 
2.20.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

