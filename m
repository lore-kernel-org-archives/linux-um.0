Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EFFCD690EB
	for <linux-um@archiver.kernel.org>; Thu, 28 Nov 2024 08:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7E87kUCgCJcEBbvfLey0kVN3O59NNSK0NS+0Z1Nt0xw=; b=Fzi/7dg8TFpUquI+fOWqbxeHVh
	Nfd557+0hDFibl6uyM/yymHf6X5fnNbyyg6UVN6BMV+LDjDy++wcK5ZjwHKjrdgUyXBDr6UpQc7Yj
	nYjSmg0Sb3ROWUBZTZHT4mLpyYPd1Ra0+FoNpT1oDIWsnVK6wOf8KNGecVPVFxJmC11eIjixFwwwc
	CMkIkJka4ilxjl9oF2RvGhashURrYgZRnh+F6Amrzi/9u0f57VyFlg7AELcDXkM4W23lEEdH6ad17
	xd1MFCj70+zbqKSrJKFbJ1aCIOLVGpWpx9eBIuB01LZV1PoJ9ogqyPn28u6C9TqGUiM+kMqznPr/M
	mGnoGCUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tGZxE-0000000F0tQ-1NlG;
	Thu, 28 Nov 2024 08:32:52 +0000
Received: from out0-203.mail.aliyun.com ([140.205.0.203])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tGZwE-0000000F0je-3IwH
	for linux-um@lists.infradead.org;
	Thu, 28 Nov 2024 08:31:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1732782708; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=7E87kUCgCJcEBbvfLey0kVN3O59NNSK0NS+0Z1Nt0xw=;
	b=B79KftO6f+S8j5mdxmEiDBX24QI+0n8eopUjsQxRvRn2mS7/HM6qV4xkmcuIzFnFqjGgsKdCPdGP1TKkdDJA17m2wnh+bP60sB41V6Ofg12evCiFpKkmS2NlguhCgtCaIQ557NNdvYQFqR4oA3+BhtmwfHUZDBjmYxbxTbL6UUM=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.aP07WV5_1732782707 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 28 Nov 2024 16:31:47 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <linux-um@lists.infradead.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH 4/9] um: Mark set_stklim as __init
Date: Thu, 28 Nov 2024 16:31:32 +0800
Message-Id: <20241128083137.2219830-5-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241128083137.2219830-1-tiwei.btw@antgroup.com>
References: <20241128083137.2219830-1-tiwei.btw@antgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241128_003150_991259_E811A345 
X-CRM114-Status: UNSURE (   6.97  )
X-CRM114-Notice: Please train this message.
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

It's only invoked during boot from main().

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/os-Linux/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/os-Linux/main.c b/arch/um/os-Linux/main.c
index 0afcdeb8995b..cf9697aa17f3 100644
--- a/arch/um/os-Linux/main.c
+++ b/arch/um/os-Linux/main.c
@@ -25,7 +25,7 @@
 
 long elf_aux_hwcap;
 
-static void set_stklim(void)
+static void __init set_stklim(void)
 {
 	struct rlimit lim;
 
-- 
2.34.1


