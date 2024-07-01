Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AC36C2BD09
	for <linux-um@archiver.kernel.org>; Mon,  1 Jul 2024 22:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=EdbU9WAKk2mWPZQQ8gJfQzlz/YgQa80h5mjUcbYKQWw=; b=hiHfdxWVeTiapCGP64rhijlDXV
	9BXZLBG2a5wloX+bTPOG1X/yBTFLFj76hecEwVn1lV8BERDB6VRvln4lm1Ir77jKHs20ifTm/dGP0
	Hqhv060N9SLofT2Mv99o36X8MSg8X+tSeJAICOtZZmj1Mfr2lYdyJh92IWpRgVNSo4mV5oOTugtpt
	OBOJDKoYXXDPBNymAMswcX/Ok/NEEGOv4SXniiqO136TXpQ3831CwtwfC6XYGiUeoNtxXYKF3TBxB
	P/jCN9IpigQwmsXzXUdxI0uTxOXRA0BTq0e2TgAy9zAU14zx2PPflQefs9yzZJHQ4c9I/k/SBvLdN
	vWpkT/aA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOPo0-000000050W9-2Vrf;
	Mon, 01 Jul 2024 22:47:28 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOPnx-000000050VY-1UcW
	for linux-um@lists.infradead.org;
	Mon, 01 Jul 2024 22:47:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=EdbU9WAKk2mWPZQQ8gJfQzlz/YgQa80h5mjUcbYKQWw=; t=1719874044; x=1721083644; 
	b=w56PKqvAIXI1NGloFGsVhW4D15gtHZDiGfqO9nvkOXMlmJu7ir36LXGwDt9xwyA9atACUnYTNVF
	cpDX4Nf3/djmYrhB2sBQ4M6W11Hzr6D5VgsEYL0gUAZlKWKRlw+FsRTCpys4G2OmzPhbghWbiAjVT
	1oDVzEJW83BnAOHTNF9E85whopOAC0eBPoXfp5qtlp/1C1wUGMlSTR7sVZ1EPaGAieGJYAadtQ0mZ
	4lIIg6IhWz6NXNFugvIuQfv260+QLv+DzjAYiyrJQ9TpZ9ENW5d2gNc6Fv3Ep7KuDj46V28w7o8g0
	5F8nvEYup+IgyltI2mYqUPisMLWkYf1pErvQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sOPnu-00000003VtO-1gz9;
	Tue, 02 Jul 2024 00:47:22 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] hostfs: fix 32-bit crash
Date: Tue,  2 Jul 2024 00:47:18 +0200
Message-ID: <20240702004717.463818729615.Id0767e12f562a69c6cd3c3262dc3d765db350cf6@changeid>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240701_154725_419268_E1A6AD5F 
X-CRM114-Status: GOOD (  10.90  )
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

From: Johannes Berg <johannes.berg@intel.com>

dev_t is a kernel type and may have different definitions
in kernel and userspace. On 32-bit x86 this currently makes
the stat structure being 4 bytes longer in the user code,
causing stack corruption. Just use 'unsigned int' so the
same size is used.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 fs/hostfs/hostfs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/hostfs/hostfs.h b/fs/hostfs/hostfs.h
index 0239e3af3945..89217d1a2189 100644
--- a/fs/hostfs/hostfs.h
+++ b/fs/hostfs/hostfs.h
@@ -65,7 +65,7 @@ struct hostfs_stat {
 	unsigned long long blocks;
 	unsigned int maj;
 	unsigned int min;
-	dev_t dev;
+	unsigned int dev;
 };
 
 extern int stat_file(const char *path, struct hostfs_stat *p, int fd);
-- 
2.45.2


