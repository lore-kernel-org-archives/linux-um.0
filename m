Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D5A6C369D9
	for <linux-um@archiver.kernel.org>; Sat,  3 May 2025 05:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NKznqwoy9DrN9bpIR8UajZcopvMn4V+9IrQ2VwPgjPQ=; b=2+84IIq/ZGPF3M+jIS/lET4OWp
	304CF9JGUHU3yL5vMBc0vGjO8ZzA0XxO/ZOboDUxPlvuje6gQ3VC8W6//PAMQ4WiFfu2MZg/LKQZZ
	GJpkc5Qcy6mB0XbxMNJS7rORcdUVlYH/WtyF/YtimRd66SjuHjhWE5aQJUAuKwn7Y7LAeLSU/p6xg
	SvJXzN2jnP6VYZezVp4ciSrRf1DaR5cJ7Vhh6SEcg1YkxGwsD2lQTEpGGXerfG/8xsM38/m1iO/cl
	wEK/FWkbVGpH5DPHzlg7s766YGL0JTXr99TP65oSwvoVrPd/2i4LWm3ioMW9g13hA5T+74s4zVeGu
	vDlJPosg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uB5Fl-00000003VlB-1AYW;
	Sat, 03 May 2025 05:17:33 +0000
Received: from out0-206.mail.aliyun.com ([140.205.0.206])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uB5Fh-00000003Vij-0ecb
	for linux-um@lists.infradead.org;
	Sat, 03 May 2025 05:17:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1746249446; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=NKznqwoy9DrN9bpIR8UajZcopvMn4V+9IrQ2VwPgjPQ=;
	b=Kl/F1zGM9aegTQSyk8biDt+SwCoC8nbvh0K6HU2+RysDrbZpfYhmgzd+Nmau0X5+TftiFcJ97O/uv+IqVf4yvcypvpoYSoYi+PaPdJ14caXbMZg2/gunc8WBo7tOaszmuA4qugsbP37fLkdrcI+f+IscbMEH6NKy5oudHuQnYa4=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.cdmPQBq_1746249444 cluster:ay29)
          by smtp.aliyun-inc.com;
          Sat, 03 May 2025 13:17:24 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <linux-um@lists.infradead.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH 2/3] um: vector: Eliminate the dependency on uml_net
Date: Sat, 03 May 2025 13:17:09 +0800
Message-Id: <20250503051710.3286595-3-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250503051710.3286595-1-tiwei.btw@antgroup.com>
References: <20250503051710.3286595-1-tiwei.btw@antgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250502_221729_691093_073D6FD6 
X-CRM114-Status: GOOD (  13.18  )
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

The only dependency on uml_net (i.e., the legacy network transport
infrastructure) is the call to uml_net_setup_etheraddr(). Implement
it inside vector to eliminate the uml_net dependency completely. It
will allow us to remove uml_net in the next step.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/drivers/Kconfig       |  1 -
 arch/um/drivers/vector_kern.c | 52 +++++++++++++++++++++++++++++++++--
 2 files changed, 50 insertions(+), 3 deletions(-)

diff --git a/arch/um/drivers/Kconfig b/arch/um/drivers/Kconfig
index 5bf4f0f3fd01..2067e37d6b63 100644
--- a/arch/um/drivers/Kconfig
+++ b/arch/um/drivers/Kconfig
@@ -145,7 +145,6 @@ config UML_NET
 
 config UML_NET_VECTOR
 	bool "Vector I/O high performance network devices"
-	depends on UML_NET
 	select MAY_HAVE_RUNTIME_DEPS
 	help
 	  This User-Mode Linux network driver uses multi-message send
diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
index b97bb52dd562..0d5c96897fa0 100644
--- a/arch/um/drivers/vector_kern.c
+++ b/arch/um/drivers/vector_kern.c
@@ -27,7 +27,6 @@
 #include <init.h>
 #include <irq_kern.h>
 #include <irq_user.h>
-#include <net_kern.h>
 #include <os.h>
 #include "mconsole_kern.h"
 #include "vector_user.h"
@@ -1539,7 +1538,56 @@ static void vector_timer_expire(struct timer_list *t)
 	napi_schedule(&vp->napi);
 }
 
+static void vector_setup_etheraddr(struct net_device *dev, char *str)
+{
+	u8 addr[ETH_ALEN];
+	char *end;
+	int i;
 
+	if (str == NULL)
+		goto random;
+
+	for (i = 0; i < 6; i++) {
+		addr[i] = simple_strtoul(str, &end, 16);
+		if ((end == str) ||
+		   ((*end != ':') && (*end != ',') && (*end != '\0'))) {
+			printk(KERN_ERR
+			       "setup_etheraddr: failed to parse '%s' "
+			       "as an ethernet address\n", str);
+			goto random;
+		}
+		str = end + 1;
+	}
+	if (is_multicast_ether_addr(addr)) {
+		printk(KERN_ERR
+		       "Attempt to assign a multicast ethernet address to a "
+		       "device disallowed\n");
+		goto random;
+	}
+	if (!is_valid_ether_addr(addr)) {
+		printk(KERN_ERR
+		       "Attempt to assign an invalid ethernet address to a "
+		       "device disallowed\n");
+		goto random;
+	}
+	if (!is_local_ether_addr(addr)) {
+		printk(KERN_WARNING
+		       "Warning: Assigning a globally valid ethernet "
+		       "address to a device\n");
+		printk(KERN_WARNING "You should set the 2nd rightmost bit in "
+		       "the first byte of the MAC,\n");
+		printk(KERN_WARNING "i.e. %02x:%02x:%02x:%02x:%02x:%02x\n",
+		       addr[0] | 0x02, addr[1], addr[2], addr[3], addr[4],
+		       addr[5]);
+	}
+	eth_hw_addr_set(dev, addr);
+	return;
+
+random:
+	printk(KERN_INFO
+	       "Choosing a random ethernet address for device %s\n", dev->name);
+	eth_hw_addr_random(dev);
+}
 
 static void vector_eth_configure(
 		int n,
@@ -1574,7 +1622,7 @@ static void vector_eth_configure(
 	 * and fail.
 	 */
 	snprintf(dev->name, sizeof(dev->name), "vec%d", n);
-	uml_net_setup_etheraddr(dev, uml_vector_fetch_arg(def, "mac"));
+	vector_setup_etheraddr(dev, uml_vector_fetch_arg(def, "mac"));
 	vp = netdev_priv(dev);
 
 	/* sysfs register */
-- 
2.34.1


