Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j4hNn-0003QW-I1
 for linux-um@lists.infradead.org; Thu, 20 Feb 2020 08:40:32 +0000
From: Leon Romanovsky <leon@kernel.org>
Subject: [PATCH 1/2] um: Don't overwrite ethtool driver version
Date: Thu, 20 Feb 2020 10:40:13 +0200
Message-Id: <20200220084014.238768-2-leon@kernel.org>
In-Reply-To: <20200220084014.238768-1-leon@kernel.org>
References: <20200220084014.238768-1-leon@kernel.org>
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
To: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Leon Romanovsky <leonro@mellanox.com>, linux-um <linux-um@lists.infradead.org>

From: Leon Romanovsky <leonro@mellanox.com>


In-tree drivers don't need to manage internal version because
they are aligned to the global Linux kernel version, which is
reported by default with "ethtool -i".

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 arch/um/drivers/net_kern.c    | 1 -
 arch/um/drivers/vector_kern.c | 2 --
 2 files changed, 3 deletions(-)

diff --git a/arch/um/drivers/net_kern.c b/arch/um/drivers/net_kern.c
index 35ebeebfc1a8..af07733c2dc8 100644
--- a/arch/um/drivers/net_kern.c
+++ b/arch/um/drivers/net_kern.c
@@ -266,7 +266,6 @@ static void uml_net_get_drvinfo(struct net_device *dev,
 				struct ethtool_drvinfo *info)
 {
 	strlcpy(info->driver, DRIVER_NAME, sizeof(info->driver));
-	strlcpy(info->version, "42", sizeof(info->version));
 }

 static const struct ethtool_ops uml_net_ethtool_ops = {
diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
index 0ff86391f77d..9693dfca7651 100644
--- a/arch/um/drivers/vector_kern.c
+++ b/arch/um/drivers/vector_kern.c
@@ -46,7 +46,6 @@


 #define DRIVER_NAME "uml-vector"
-#define DRIVER_VERSION "01"
 struct vector_cmd_line_arg {
 	struct list_head list;
 	int unit;
@@ -1378,7 +1377,6 @@ static void vector_net_get_drvinfo(struct net_device *dev,
 				struct ethtool_drvinfo *info)
 {
 	strlcpy(info->driver, DRIVER_NAME, sizeof(info->driver));
-	strlcpy(info->version, DRIVER_VERSION, sizeof(info->version));
 }

 static int vector_net_load_bpf_flash(struct net_device *dev,
--
2.24.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

