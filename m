Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31467D690E8
	for <linux-um@archiver.kernel.org>; Thu, 28 Nov 2024 08:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=btI1okv/tr01jFsz6smIK4ol80YedP8ZiMg8DfX3xn4=; b=cC/ckkvWPyNhLfeZUU5Lc/nx75
	4hHY67ed9BAZfOqLvulb0U0aRcrgqKbUV4IXvR1aECdsE0I5Umv6qhn1y2eJY3xFP1VlG0if2Sh5x
	M+wFm8EVsbBACN4bEmdqLqgHuMv0Sa5wSYSrHufzVOhiP5reAVihsdZkav8qXDnp3EDkIMOnIpfl2
	zrURBuE/SdvkaIcrPB8LZdFPEyzdRrdMsKBV18rLXo69m92OMkeJ2mJrLz2+KHIKw/wYna91sKV/G
	mR3v1Uru/MiEZ+GbPhJKrCaAMbOPrHdFfxKYrfUjke/B1fVDdzESYbXMHq+9BOAnofJNbtEGS0crP
	QiLGQa0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tGZlV-0000000EyXK-42gF;
	Thu, 28 Nov 2024 08:20:45 +0000
Received: from out0-209.mail.aliyun.com ([140.205.0.209])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tGZkg-0000000EyIG-0vpI
	for linux-um@lists.infradead.org;
	Thu, 28 Nov 2024 08:19:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1732781989; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=btI1okv/tr01jFsz6smIK4ol80YedP8ZiMg8DfX3xn4=;
	b=DDIIHKLlFlVPi9LOmTeK0q7awOMYr7cp3G2+oac1v19xtygHfxsw6ekMOI8NnocykYYhX7SG/R/oHSHK9woFWZihjGoB78/Yxt0itgAT5HtwBFDHdDpd4H5ef7GmusWguL8lPtOFkviPGECDb+FboAszUs5kOH+zB7c2nN9ZtIY=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.aP-8fnC_1732781987 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 28 Nov 2024 16:19:48 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <linux-um@lists.infradead.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH 1/3] um: Remove unused MODULES_LEN macro
Date: Thu, 28 Nov 2024 16:19:37 +0800
Message-Id: <20241128081939.2216246-2-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241128081939.2216246-1-tiwei.btw@antgroup.com>
References: <20241128081939.2216246-1-tiwei.btw@antgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241128_001954_543868_DE153F6F 
X-CRM114-Status: UNSURE (   6.44  )
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

It's not used anywhere. And its definition doesn't seem right.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/include/asm/pgtable.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/um/include/asm/pgtable.h b/arch/um/include/asm/pgtable.h
index 12bfc58a8580..79ff979520bb 100644
--- a/arch/um/include/asm/pgtable.h
+++ b/arch/um/include/asm/pgtable.h
@@ -52,7 +52,6 @@ extern unsigned long end_iomem;
 #define VMALLOC_END	(FIXADDR_START-2*PAGE_SIZE)
 #define MODULES_VADDR	VMALLOC_START
 #define MODULES_END	VMALLOC_END
-#define MODULES_LEN	(MODULES_VADDR - MODULES_END)
 
 #define _PAGE_TABLE	(_PAGE_PRESENT | _PAGE_RW | _PAGE_USER | _PAGE_ACCESSED | _PAGE_DIRTY)
 #define _KERNPG_TABLE	(_PAGE_PRESENT | _PAGE_RW | _PAGE_ACCESSED | _PAGE_DIRTY)
-- 
2.34.1


