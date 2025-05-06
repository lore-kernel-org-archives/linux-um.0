Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5392FC3ABAC
	for <linux-um@archiver.kernel.org>; Tue,  6 May 2025 06:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7LRCG+yHMISxqWJ35uox4TEoZXFcCDzOEbX2fT6fIis=; b=IDz+FliS5fp97Myvg/rZFk0sDv
	tipq+7CBck8ySCWmmjeLXFaVqhm+iLmtst8wVFiwlz65XaseiQLQKdXh580GUt4nQaigMvRubi8Mp
	rhWLnOd3G5dWhHi03/4Du7vqujiY062lcjP6FzQM+11BdkkspbBfGTlixxNbqCc4Pud/JJYe3aQvQ
	ogO76VBjg8Tc6yYFg8EVwtkNmflotvN8Xku9ignwc8UCnIOsdJApFCB/qapV3TvkRsHS01p2GRpSn
	cA8j6J3317jVgxGvn9e5s45pMcA1gDsXNHZEghwKBVkP2hR5fWXjkgznki8iNoCQIaP2YRx1ELUvE
	Qkiuz4hA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCBYy-0000000AcbW-3uJw;
	Tue, 06 May 2025 06:13:56 +0000
Received: from out0-221.mail.aliyun.com ([140.205.0.221])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCAHJ-0000000AIjW-2VZu
	for linux-um@lists.infradead.org;
	Tue, 06 May 2025 04:51:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1746507093; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=7LRCG+yHMISxqWJ35uox4TEoZXFcCDzOEbX2fT6fIis=;
	b=wunujUAKPJO7C7ymEpk/Fg47suuOGerB5qFrucS1eWHR228/7dpF3YpQSu+2iZBuwDRyywieOcMHxnqhRcIUPUiE3h9G2HWNuRcQu7bjbxDyH+ehVXwK3niE3qeNJw9bCVPQarJjh7FBikAx6K/G6pYL3AWc3j6MM3DffEWXqME=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.cfhx6w3_1746507090 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 06 May 2025 12:51:31 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <linux-um@lists.infradead.org>,
   <geert@linux-m68k.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH 1/2] um: vector: Clean up and modernize log messages
Date: Tue, 06 May 2025 12:51:16 +0800
Message-Id: <20250506045117.1896661-2-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250506045117.1896661-1-tiwei.btw@antgroup.com>
References: <20250506045117.1896661-1-tiwei.btw@antgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250505_215138_133504_3C5C6882 
X-CRM114-Status: GOOD (  11.65  )
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

Use pr_*() and netdev_*() to print log messages. While at it,
join split messages for easier grepping.

Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/drivers/vector_kern.c | 41 ++++++++++++++---------------------
 1 file changed, 16 insertions(+), 25 deletions(-)

diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
index 0d5c96897fa0..7822421057ea 100644
--- a/arch/um/drivers/vector_kern.c
+++ b/arch/um/drivers/vector_kern.c
@@ -8,6 +8,8 @@
  * Copyright (C) 2001 by various other people who didn't put their name here.
  */
 
+#define pr_fmt(fmt) "uml-vector: " fmt
+
 #include <linux/memblock.h>
 #include <linux/etherdevice.h>
 #include <linux/ethtool.h>
@@ -1551,41 +1553,33 @@ static void vector_setup_etheraddr(struct net_device *dev, char *str)
 		addr[i] = simple_strtoul(str, &end, 16);
 		if ((end == str) ||
 		   ((*end != ':') && (*end != ',') && (*end != '\0'))) {
-			printk(KERN_ERR
-			       "setup_etheraddr: failed to parse '%s' "
-			       "as an ethernet address\n", str);
+			netdev_err(dev,
+				"Failed to parse '%s' as an ethernet address\n", str);
 			goto random;
 		}
 		str = end + 1;
 	}
 	if (is_multicast_ether_addr(addr)) {
-		printk(KERN_ERR
-		       "Attempt to assign a multicast ethernet address to a "
-		       "device disallowed\n");
+		netdev_err(dev,
+			"Attempt to assign a multicast ethernet address to a device disallowed\n");
 		goto random;
 	}
 	if (!is_valid_ether_addr(addr)) {
-		printk(KERN_ERR
-		       "Attempt to assign an invalid ethernet address to a "
-		       "device disallowed\n");
+		netdev_err(dev,
+			"Attempt to assign an invalid ethernet address to a device disallowed\n");
 		goto random;
 	}
 	if (!is_local_ether_addr(addr)) {
-		printk(KERN_WARNING
-		       "Warning: Assigning a globally valid ethernet "
-		       "address to a device\n");
-		printk(KERN_WARNING "You should set the 2nd rightmost bit in "
-		       "the first byte of the MAC,\n");
-		printk(KERN_WARNING "i.e. %02x:%02x:%02x:%02x:%02x:%02x\n",
-		       addr[0] | 0x02, addr[1], addr[2], addr[3], addr[4],
-		       addr[5]);
+		netdev_warn(dev, "Warning: Assigning a globally valid ethernet address to a device\n");
+		netdev_warn(dev, "You should set the 2nd rightmost bit in the first byte of the MAC,\n");
+		netdev_warn(dev, "i.e. %02x:%02x:%02x:%02x:%02x:%02x\n",
+			addr[0] | 0x02, addr[1], addr[2], addr[3], addr[4], addr[5]);
 	}
 	eth_hw_addr_set(dev, addr);
 	return;
 
 random:
-	printk(KERN_INFO
-	       "Choosing a random ethernet address for device %s\n", dev->name);
+	netdev_info(dev, "Choosing a random ethernet address\n");
 	eth_hw_addr_random(dev);
 }
 
@@ -1601,14 +1595,12 @@ static void vector_eth_configure(
 
 	device = kzalloc(sizeof(*device), GFP_KERNEL);
 	if (device == NULL) {
-		printk(KERN_ERR "eth_configure failed to allocate struct "
-				 "vector_device\n");
+		pr_err("Failed to allocate struct vector_device for vec%d\n", n);
 		return;
 	}
 	dev = alloc_etherdev(sizeof(struct vector_private));
 	if (dev == NULL) {
-		printk(KERN_ERR "eth_configure: failed to allocate struct "
-				 "net_device for vec%d\n", n);
+		pr_err("Failed to allocate struct net_device for vec%d\n", n);
 		goto out_free_device;
 	}
 
@@ -1738,8 +1730,7 @@ static int __init vector_setup(char *str)
 
 	err = vector_parse(str, &n, &str, &error);
 	if (err) {
-		printk(KERN_ERR "vector_setup - Couldn't parse '%s' : %s\n",
-				 str, error);
+		pr_err("Couldn't parse '%s': %s\n", str, error);
 		return 1;
 	}
 	new = memblock_alloc_or_panic(sizeof(*new), SMP_CACHE_BYTES);
-- 
2.34.1


