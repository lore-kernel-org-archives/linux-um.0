Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E48F0C47DA2
	for <linux-um@archiver.kernel.org>; Fri, 12 Jan 2024 20:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Vxm7GroJb1jr7a7SKxct7zVVLJ9MIYxfQSDNcHJxJs8=; b=MhyLKmL066fEi76nBR1Qz2n85r
	p2gDkMXabQQvqlFG59UX23JfTwT7y0m+/rpf6+hmiBY6a4prdgo7majQgX8cPivkFpfdKZ1mD7y/6
	ZKwsXVy+/Go2+LhR4eG3jfX7hZUlUtuEfvh+TAFdNcGf/ZSmDH9662bViJcZL4nxgBOEEa503RTbZ
	MYn+0+2nXRpH81cTqSo9B3sEe0W67YErHjewUsPbi6QGiKkMVhU9N0yfRrDupZg+5drvTjJtb5bWS
	ZF3f0VJNUd2vDqz7rNWF8UF8WJcCAJsLYSglDfjqQhHM2sRnhneR+nnt9rPhWvFOf7X16jzVvBL1k
	7WVHr5nw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rONox-003tyc-22;
	Fri, 12 Jan 2024 20:08:03 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rONop-003tru-2e;
	Fri, 12 Jan 2024 20:07:57 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 56DAA61E52;
	Fri, 12 Jan 2024 20:07:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC66AC43601;
	Fri, 12 Jan 2024 20:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705090075;
	bh=QNmBS0brQeJSjUserQhzHk2Vt2IzcbhX82b9CN/v9CM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y8kgwibdxmE4vap0GuM/fVQuLavqIYEsi/kkmbe/DQ87QPH+0t1CqfbhrLlhb1UL7
	 HsKrA+qsZUl+LD2qh7XyoCRY68FeKquq9mWHhynzJkscVBNamnfsdrIokEUGS67SUs
	 DPI8umccncrhCQPBTmfFVD9pIDflhg54WSTK/c+AFyumnZWqevRYptze5nxWAy/OKp
	 yE/oFcwKeA8aWm8KE6nIeYSdurXI9VBChIHzWI0MMjdlCRZFqlE+p5Iv5QKxv/AAjV
	 S9tenjVL7krLEEJ9qqZGhYxmpGtuN3+CCUhplyCBQyMn8i0jOHxtZGOf4SS6LTk4Eq
	 iAbnScBTZWkxw==
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
Subject: [PATCH 5/6] of: unittest: treat missing of_root as error instead of fixing up
Date: Fri, 12 Jan 2024 12:07:48 -0800
Message-ID: <20240112200750.4062441-6-sboyd@kernel.org>
X-Mailer: git-send-email 2.43.0.275.g3460e3d667-goog
In-Reply-To: <20240112200750.4062441-1-sboyd@kernel.org>
References: <20240112200750.4062441-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240112_120755_901697_A6D35606 
X-CRM114-Status: GOOD (  12.67  )
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


