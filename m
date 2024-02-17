Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74D40C48BF6
	for <linux-um@archiver.kernel.org>; Sat, 17 Feb 2024 01:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ltXg5dLqXeEAw0B9ekuGlp0meqmOfPS4K+bnj0EGYEw=; b=jXVpKVqk6af541yxJZxPxCfevc
	+oouPH2z4JLM01I1OzSvej2I5Yy53GQItrwRuq9wjBe8EDbDIVABPyilFt2+QSq4p9qEAeAc95ylp
	OKyYUypv2dTH95MiTsyVUqGmMGrpw4XsyvA/S9JRwtuxxNUyJnmxFHTur8Gyppc+J3Jj+h31Uhm3T
	b4iQ0jHtN3vlV4X8EBAS+1LZQz0b61VCRhh1xKH3fm5x+wZSgWR2RoOE6Y8fERQu9krOgqU4fjtrb
	B5FkNqm+KDHf2rGcIvR324AgMsIQGTzdDIYFE84mZ+M+6rTghENgDgMusEepRWzaGoyuKh40t+X6N
	ksIUxtVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rb99u-00000004LzE-3ng6;
	Sat, 17 Feb 2024 01:06:26 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rb99X-00000004LiI-1ZU4;
	Sat, 17 Feb 2024 01:06:05 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id C47D062116;
	Sat, 17 Feb 2024 01:06:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 294E0C43394;
	Sat, 17 Feb 2024 01:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708131962;
	bh=a4ZJdi1g6SmL1slfPXA0Sdc1BiW+RCSDLbBzSuVLxg0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fR7K0DPmwLwliOjcvLTQMYx/yhvXd+Lt+J20YtU0eJg9BBupTobaTXvHDKz0ElN1w
	 lyN91Teoqb6L2FiUFaTin94ppj2bXx/OQ+5Zh9nlGBCkw98caMK44i80kS9zuogCk7
	 mhCc644572dUf8Iq4dDijMBDhsqAR1qvwJuMq095NWCspfbOK6Sumcdd6hlvus4rY5
	 pJtJzorxKorAn51SisFu2bSBgpRVzJ6rZw7i2j2hIexRCBfO1hTtdhdRp1aExld7zC
	 LS7kGmSBV76MFa+4KC96o2AvD8CCs6u81WWqcJQR/bglZGe4WFTGsxvKciZGKD270o
	 ma7B4X6MmNn+A==
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
Subject: [PATCH v4 6/7] of: unittest: treat missing of_root as error instead of fixing up
Date: Fri, 16 Feb 2024 17:05:55 -0800
Message-ID: <20240217010557.2381548-7-sboyd@kernel.org>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
In-Reply-To: <20240217010557.2381548-1-sboyd@kernel.org>
References: <20240217010557.2381548-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240216_170603_505867_7416CB93 
X-CRM114-Status: GOOD (  12.37  )
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
index 891752a20a5f..4c67de37bf26 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -1744,20 +1744,16 @@ static int __init unittest_data_add(void)
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


