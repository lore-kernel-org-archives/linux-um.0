Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAB83D1CDC6
	for <linux-um@archiver.kernel.org>; Mon,  8 Dec 2025 02:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=JVapxETF+bI9u8MeuWHunFkO87eXCNelBUhqoYbwZ3w=; b=RT+wiHiRDtmP95udBtSY7GkX1N
	/LjXiQTXz0/Mk7iKZq9Ly7e0h2MWlhXNJogPpIs1e1THzIbbix4TNaBcslzPZiPCxIERMVeMoDxzT
	IWIXdsPOEU14wjR+MmOuyJMyZMJ1xWoKP4R8suI5zXREZuLSVGJ7E/uHa1Gw+rVrTecIN2P919YnZ
	1mGA8x6Z1iXKM955mTo+oaF1MvyzKumGnL3yY5p3+qMFQUimCcjP5wx1CJau2VO28dqRFkKAboNa7
	jqB8TXik+o/yr/0FuIFlQ33n5kZUTA9usSGvH139nj3D6kUKxVg5SpmjMoJHdrSUohbv0WKavVoxp
	XmCXBuTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vSR89-0000000CUpm-1Hzm;
	Mon, 08 Dec 2025 02:37:41 +0000
Received: from mailgw.kylinos.cn ([124.126.103.232])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vSR86-0000000CUpF-0Xo6
	for linux-um@lists.infradead.org;
	Mon, 08 Dec 2025 02:37:40 +0000
X-UUID: d5eb0fbcd3de11f0a38c85956e01ac42-20251208
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:f488f504-f558-433e-b84c-c9a120caee24,IP:0,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:-5
X-CID-META: VersionHash:a9d874c,CLOUDID:0442bb4fc7d2319a99e4647291aa903e,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|898,TC:nil,Content:0|15|50,EDM:-
	3,IP:nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:
	0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: d5eb0fbcd3de11f0a38c85956e01ac42-20251208
X-User: chenchangcheng@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <chenchangcheng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 608062599; Mon, 08 Dec 2025 10:37:27 +0800
From: Chen Changcheng <chenchangcheng@kylinos.cn>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com
Cc: johannes@sipsolutions.net,
	benjamin.berg@intel.com,
	linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Chen Changcheng <chenchangcheng@kylinos.cn>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] um: use ARRAY_SIZE to calculate the length of an array
Date: Mon,  8 Dec 2025 10:37:23 +0800
Message-Id: <20251208023723.19789-1-chenchangcheng@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251207_183738_519956_55C3667C 
X-CRM114-Status: UNSURE (   8.68  )
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

cocci warnings: (new ones prefixed by >>)
>> arch/um/kernel/skas/stub_exe.c:180:23-24: WARNING: Use ARRAY_SIZE

Fixes: 406d17c6c370 ("um: Implement kernel side of SECCOMP based process handling")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202512080556.BbmGuwU4-lkp@intel.com/
Signed-off-by: Chen Changcheng <chenchangcheng@kylinos.cn>
---
 arch/um/kernel/skas/stub_exe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/kernel/skas/stub_exe.c b/arch/um/kernel/skas/stub_exe.c
index cbafaa684e66..01a938a5bb4f 100644
--- a/arch/um/kernel/skas/stub_exe.c
+++ b/arch/um/kernel/skas/stub_exe.c
@@ -193,7 +193,7 @@ noinline static void real_init(void)
 			BPF_STMT(BPF_RET | BPF_K, SECCOMP_RET_ALLOW),
 		};
 		struct sock_fprog prog = {
-			.len = sizeof(filter) / sizeof(filter[0]),
+			.len = ARRAY_SIZE(filter),
 			.filter = filter,
 		};
 
-- 
2.25.1


