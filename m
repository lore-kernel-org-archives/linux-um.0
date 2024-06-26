Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C88EC3065B
	for <linux-um@archiver.kernel.org>; Wed, 26 Jun 2024 13:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mh6AtIlXNX8AYvi8mLYHpzJ/KklzokaHANiSlAS1Kv8=; b=nwUjGwZTi+jRD2jDbiPKdEEb7a
	zdim62Am8yMQVgQ6rdaK3RI7SzqdGWrCur6RvMiBEnOxXGhyBgKP6pKUx1iCCU2PdghsxntvmEHVW
	BenW4HESxPNCqFLpRnBwjwaba1Lt3q+EtWFtCBV+m63JFRRZMduZKv/123cID8iprq1h/tDlTlaRD
	ATbSoHvz20JVX9Xq9uD0HrEex/VgqjeA2qlk80YpJ6Sr1aV2tk/hb8PGCYtyJtYPmN/q6g5bmPt+0
	35ezQXlecB9GTiF1wOUtGBCfefP3Yos+GHLcWrzBtXeq/h4OYcs9a1y3LZ7E74y4LVNaJXmEVPwVY
	LlbQjbZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMT88-000000074gC-0cSF;
	Wed, 26 Jun 2024 13:56:12 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMT80-000000074d2-3dxD
	for linux-um@lists.infradead.org;
	Wed, 26 Jun 2024 13:56:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=mh6AtIlXNX8AYvi8mLYHpzJ/KklzokaHANiSlAS1Kv8=;
	t=1719410164; x=1720619764; b=rAZG2Nd/hwtKzwlQcM2GDERZWx5CUaLJz2wBlDBvfBDq/7I
	i22MuZvjFRt7pArIvgiO7FWJ1Z+5RE5yKfSSdqqIWD81bpC+26UdJBJfyeVyyPNwXnPfQ03qoLKE2
	6dxNd8Cs6BScDCYPlD1YbPTnDvHNZIZXPYVpBQEcYOcyV+Hq1yCZ30BcQzqYCcLZZmLEj1D0juQxN
	PDlEMppVz8nez7fyEt8DRNzHfZ931KJIKIyj3DyzB7VFz+RNSIF4Hkvk95iV0tVZqsco9wFjDVQfG
	UJhzGQfw9ec5d2mXiZJxBkZiw/pc+t02lnJp8cKmBOIVt44F5M8Fpq2PyXdzrxoA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1sMT7x-00000003rXd-3Egv;
	Wed, 26 Jun 2024 15:56:02 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v6 2/7] um: Add generic stub_syscall1 function
Date: Wed, 26 Jun 2024 15:53:45 +0200
Message-ID: <20240626135350.493110-3-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240626135350.493110-1-benjamin@sipsolutions.net>
References: <20240626135350.493110-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240626_065604_975458_80185D13 
X-CRM114-Status: UNSURE (   7.17  )
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

From: Benjamin Berg <benjamin.berg@intel.com>

The 64bit version did not have a stub_syscall1 function yet. Add it as
it will be useful to implement a static binary for stub loading.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
---
 arch/x86/um/shared/sysdep/stub_64.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/x86/um/shared/sysdep/stub_64.h b/arch/x86/um/shared/sysdep/stub_64.h
index c99ea6e06f96..6ed2ce4b54ba 100644
--- a/arch/x86/um/shared/sysdep/stub_64.h
+++ b/arch/x86/um/shared/sysdep/stub_64.h
@@ -27,6 +27,17 @@ static __always_inline long stub_syscall0(long syscall)
 	return ret;
 }
 
+static __always_inline long stub_syscall1(long syscall, long arg1)
+{
+	long ret;
+
+	__asm__ volatile (__syscall
+		: "=a" (ret)
+		: "0" (syscall), "D" (arg1) : __syscall_clobber );
+
+	return ret;
+}
+
 static __always_inline long stub_syscall2(long syscall, long arg1, long arg2)
 {
 	long ret;
-- 
2.45.2


