Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B75FACA0EEB
	for <linux-um@archiver.kernel.org>; Sun, 24 Aug 2025 15:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=A4VEqe9RglaUDlbefqov5zhRUIU3ZxAWQNGa2Xp7GDc=; b=MOKwkR8Kkj4XcwHePx6M/IhQZG
	D4mQd1tbri9gmMOxsoKbU/xRjsKkYwB5FyYH8ZVpOIRi97NkNHfJKmtIprA49bdDyoHF7mPP+22+4
	EMD1JovdlPhj+wLsd9wbcs2yjbR++hdvOUTVmHMtt7hQngEPO8WoiXieUeaEOID2HzwM1U39e+rtS
	fhwQAXw5MObH0cNmdNkceHjDl4POhBdBKbRixW6jaIG2BnEOfGSboP0UjWH4FLBTKNIHoXLr2Ia02
	A1Qgjc60Mmv9DkYoOiJNsvtvWLdq2vW7MgJwiN6mPsUts03SawXQHa+h9thZjsSCvVpyyCkij5pXg
	Ot97/LRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqCuI-00000006JJJ-1qvg;
	Sun, 24 Aug 2025 15:45:22 +0000
Received: from out-170.mta1.migadu.com ([2001:41d0:203:375::aa])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqCuD-00000006JDs-3rE9
	for linux-um@lists.infradead.org;
	Sun, 24 Aug 2025 15:45:19 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756050297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=A4VEqe9RglaUDlbefqov5zhRUIU3ZxAWQNGa2Xp7GDc=;
	b=Ld/RPtcsBxWxAwdb/zRl0toSHx2Wt2Cu0v8cGVHlXFE6Ykxd2g4bG8BdiYvbGepkRkT/vM
	zxfS5HY3HEwRo9FzRPDnccBghKdzoVN8ztET75Chi2VV5GA2s+MLQ/3emxCD0/Y/V//UEd
	NOBkFSJRn27QyF/kioh5r2dfcIQIviA=
From: Tiwei Bie <tiwei.bie@linux.dev>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	tiwei.btw@antgroup.com,
	tiwei.bie@linux.dev
Subject: [PATCH 0/7] um: Misc cleanups
Date: Sun, 24 Aug 2025 23:44:18 +0800
Message-Id: <20250824154425.2243375-1-tiwei.bie@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250824_084518_096507_62E0A31A 
X-CRM114-Status: UNSURE (   4.37  )
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

From: Tiwei Bie <tiwei.btw@antgroup.com>

Tiwei Bie (7):
  um: Add missing trailing newline to help messages
  um: vector: Fix indentation for help message
  um: Fix help message for ssl-non-raw
  um: Indent time-travel help messages
  um: Remove unused offset and child_err fields from stub_data
  um: Remove outdated comment about STUB_DATA_PAGES
  um: Centralize stub size calculations

 arch/um/drivers/ssl.c                   |  5 +++-
 arch/um/drivers/ubd_kern.c              |  2 +-
 arch/um/drivers/vector_kern.c           |  2 +-
 arch/um/include/shared/as-layout.h      |  5 ++--
 arch/um/include/shared/skas/stub-data.h |  3 +-
 arch/um/kernel/dtb.c                    |  2 +-
 arch/um/kernel/time.c                   | 37 +++++++++++++------------
 arch/um/kernel/um_arch.c                |  4 +--
 arch/um/os-Linux/skas/process.c         |  2 +-
 arch/x86/um/shared/sysdep/stub_32.h     |  2 +-
 arch/x86/um/shared/sysdep/stub_64.h     |  2 +-
 11 files changed, 34 insertions(+), 32 deletions(-)

-- 
2.34.1


