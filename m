Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB8A1C4450A
	for <linux-um@archiver.kernel.org>; Fri, 17 Jul 2026 03:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=oVA9ELg0WuwCIZs6UXT9ixQUzwFDC7YLIE2hG8P4/H8=; b=Y8nvL6scomouEsLv07ipWjGRnP
	OYPSO2jOJfst5N+BZd8mHVHeYWmud8l5XiWxsKFODj3QaEduofhvR0EH3m6Tew1EzNOYl+LdBHNx0
	+HTSBTF72rz4nT9EXW7+dvgJ1kdaBcjOWT7LIUkJGa0LRHUZAK95180HO8WS3iDrOa/OjsiWs1kYs
	94mFAFqr6ZzGXXiFZsL1SY7S75PpboPHklsfjbj4JVeJgtUZ3tOOOB69DNDiweftiTfosfpR8tVZS
	chJGPu4G4ESFzf+9zWS/PvwyUzrskEsKIUTW+oheTQBrHrJuVXQDp1VttcH+OjYMhs4uU85ZmQ51b
	fn7fh+pg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkYrQ-000000010dp-441N;
	Fri, 17 Jul 2026 03:03:36 +0000
Received: from mailgw.kylinos.cn ([124.126.103.232])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkYrO-000000010d6-0jy0
	for linux-um@lists.infradead.org;
	Fri, 17 Jul 2026 03:03:35 +0000
X-UUID: 136ac1f6818c11f1aa26b74ffac11d73-20260717
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:ad252ab9-877f-4000-8262-19d99b269e31,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:8d6ce536896b87b49f2a8bfee7645658,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|865|898,TC:nil,Content:0|15|50,E
	DM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA
	:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 136ac1f6818c11f1aa26b74ffac11d73-20260717
X-User: yanlonglong@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <yanlonglong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1415036839; Fri, 17 Jul 2026 11:03:24 +0800
From: longlong yan <yanlonglong@kylinos.cn>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: longlong yan <yanlonglong@kylinos.cn>
Subject: [PATCH] um: use ARRAY_SIZE macro in stub_exe.c
Date: Fri, 17 Jul 2026 11:03:08 +0800
Message-ID: <20260717030308.996-1-yanlonglong@kylinos.cn>
X-Mailer: git-send-email 2.47.1.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260716_200334_526117_5ED7479A 
X-CRM114-Status: UNSURE (   7.19  )
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

The ARRAY_SIZE macro is more compact and more formal in linux source.

Fixes: 406d17c6c370 ("um: Implement kernel side of SECCOMP based process handling")
Signed-off-by: longlong yan <yanlonglong@kylinos.cn>
---
 arch/um/kernel/skas/stub_exe.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/um/kernel/skas/stub_exe.c b/arch/um/kernel/skas/stub_exe.c
index cbafaa684e66..2b89acbcbad8 100644
--- a/arch/um/kernel/skas/stub_exe.c
+++ b/arch/um/kernel/skas/stub_exe.c
@@ -7,6 +7,7 @@
 #include <linux/filter.h>
 #include <linux/seccomp.h>
 #include <generated/asm-offsets.h>
+#include <shared/user.h>
 
 void _start(void);
 
@@ -193,7 +194,7 @@ noinline static void real_init(void)
 			BPF_STMT(BPF_RET | BPF_K, SECCOMP_RET_ALLOW),
 		};
 		struct sock_fprog prog = {
-			.len = sizeof(filter) / sizeof(filter[0]),
+			.len = ARRAY_SIZE(filter),
 			.filter = filter,
 		};
 
-- 
2.43.0


