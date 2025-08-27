Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B200CA0FF0
	for <linux-um@archiver.kernel.org>; Wed, 27 Aug 2025 00:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=oonzneQiqfMta1MyGAyLI4NAPiWLQEJn/r/IuCk/WLc=; b=i2YpE1mv80xNvP3THTWrUCNC90
	Nlz1f0sVk98k5Qq7KyyZCV6ZTM5S0GfIZ0zGhd0zvxzhp9qWhbuyScwo5ls9j/2T5dyeRYKhtli6M
	BuacRXAb40NxoKkJbGXwTtQ7ayiZjdEQVteTnWnZJ4aUMpsBjsclaYhvzCEZ/vK2J+tQVb3rGdGiu
	0w5GzHvTy6eYwRDTJCHuOVCt7kAXR10gPGfRsch8qkyiiD/yWAF6b/OdPxSHAEJj1Fhjef8JUEOlX
	qQ+7Marw1pOoKQ0I+yPwZENuybfmxKFyFTjWq5vEevpBmKmEtX9Sd3apAx9yY/LUYcUwIa+1C0byu
	vdA3dafA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ur4Tv-0000000DTTC-1Fo8;
	Wed, 27 Aug 2025 00:57:43 +0000
Received: from out-187.mta1.migadu.com ([2001:41d0:203:375::bb])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ur4Ts-0000000DTMp-2wLE
	for linux-um@lists.infradead.org;
	Wed, 27 Aug 2025 00:57:42 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756256244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oonzneQiqfMta1MyGAyLI4NAPiWLQEJn/r/IuCk/WLc=;
	b=SlRa9c9xRIcMrNtVudyr/J+p6oRDmdJ7md5XMaP7nC7zDq0GXMzeVIqA+nvQrMiXZ4urp+
	ZTSAz/oP3kXa2j+jrb0t/+MqqVvUQp1XHS1bEwCQ3RAm5E3TUO1BZB8lh4yEREkKvQnJUY
	7TGEsFaH88KypT1A51ahY58Ms6sqMu8=
From: Tiwei Bie <tiwei.bie@linux.dev>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	tiwei.btw@antgroup.com,
	tiwei.bie@linux.dev
Subject: [PATCH v2 0/7] um: Misc cleanups
Date: Wed, 27 Aug 2025 08:56:56 +0800
Message-Id: <20250827005703.3847636-1-tiwei.bie@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250826_175740_889748_0335047F 
X-CRM114-Status: UNSURE (   5.26  )
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

v2:
- Fix commit log for PATCH 2/7 (the original indentation is a tab
  plus a space, not a single tab);

v1: https://lore.kernel.org/linux-um/20250824154425.2243375-1-tiwei.bie@linux.dev/

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


