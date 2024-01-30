Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3765EC47DA9
	for <linux-um@archiver.kernel.org>; Tue, 30 Jan 2024 00:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Vxm7GroJb1jr7a7SKxct7zVVLJ9MIYxfQSDNcHJxJs8=; b=5BWWOIpt3CIY1Fw7C6AnRvbwAb
	Pghdzhw3EAP+jrH0vV4fwsgajjNJj5EGMqjLwVcPHrdr/nY0F6kTdHMQo5My2p43q4k4c/Zeppc0E
	Q4MoBImAIY9Dat1l1b6bEpbzaGuHUZgb4KhPibsF/aA4J+MgQijbghWy5qm7R8hWk0sKjwkKwVY5y
	bJMdEMsN8Dym+N8DdPlkHC653sgJ/q43ehqNL4EU9m1JVGQ4dk0x/lK8qhAVYJpLyvL22W4AZd3rw
	ReV6Uu+eFCORQOYcZDHbOB25FZu1Mq58jA2wpTRrkcFzio2156bh2Tvd0K2C8uiwwzAME23BUFliP
	9L3kDPZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUcG4-0000000EjlW-39zH;
	Tue, 30 Jan 2024 00:45:48 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUcFX-0000000EjQC-1t2z;
	Tue, 30 Jan 2024 00:45:18 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id E11E462614;
	Tue, 30 Jan 2024 00:45:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C548C43399;
	Tue, 30 Jan 2024 00:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706575514;
	bh=QNmBS0brQeJSjUserQhzHk2Vt2IzcbhX82b9CN/v9CM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oAvRw3fAoNWjiVmINtzMu5LYHOPzthZ41RXtSehMcsOa5hH/n47mQJbwPX2YmtRQH
	 bzWW1cBevhWm3guAvl0N4bT/8Is877dtInpWAtotrWqzYO0DdFYikRUBbXY+71z0iT
	 /pv5C9PH8rC3AmSPrzXXEB7xIE4NlYtlu0suj1aSB3RA3o39qzMCUBpl27IdEdtupr
	 jVCILCD5y8v/gEjL2xzgqAcFMBCJySfXA1Gwxafe26t3L/H+BORWJN4ONXYV3gI5gH
	 CVpyf+GvJfjjAqShbWztM2Npaan26dTC/XaAATjqVlON4splpFImESEFk1h1AOMSWI
	 +kqrvevHV7aEg==
From: Stephen Boyd <sboyd@kernel.org>
To: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	linux-um@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	kunit-dev@googlegroups.com,
	linux-kselftest@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v2 6/7] of: unittest: treat missing of_root as error instead of fixing up
Date: Mon, 29 Jan 2024 16:45:05 -0800
Message-ID: <20240130004508.1700335-7-sboyd@kernel.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240130004508.1700335-1-sboyd@kernel.org>
References: <20240130004508.1700335-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240129_164515_665992_483552DC 
X-CRM114-Status: GOOD (  12.92  )
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

From: Frank Rowand <frowand.list@gmail.com>

unflatten_device_tree() now ensures that the 'of_root' node is populated
with the root of a default empty devicetree. Remove the unittest code
that created 'of_root' if it was missing. Verify that 'of_root' is valid
before attempting to attach the testcase-data subtree. Remove the
unittest code that unflattens the unittest overlay base if architecture
is UML because that is always done now.

Signed-off-by: Frank Rowand <frowand.list@gmail.com>
Link: https://lore.kernel.org/r/20230317053415.2254616-3-frowand.list@gmail.com
Cc: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/of/unittest.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index a8b27dd16ecf..742d919e8ab4 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -1732,20 +1732,16 @@ static int __init unittest_data_add(void)
 		return -EINVAL;
 	}
 
+	/* attach the sub-tree to live tree */
 	if (!of_root) {
-		of_root = unittest_data_node;
-		for_each_of_allnodes(np)
-			__of_attach_node_sysfs(np);
-		of_aliases = of_find_node_by_path("/aliases");
-		of_chosen = of_find_node_by_path("/chosen");
-		of_overlay_mutex_unlock();
-		return 0;
+		pr_warn("%s: no live tree to attach sub-tree\n", __func__);
+		kfree(unittest_data);
+		return -ENODEV;
 	}
 
 	EXPECT_BEGIN(KERN_INFO,
 		     "Duplicate name in testcase-data, renamed to \"duplicate-name#1\"");
 
-	/* attach the sub-tree to live tree */
 	np = unittest_data_node->child;
 	while (np) {
 		struct device_node *next = np->sibling;
-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git


