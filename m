Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08E7ECCF9E5
	for <linux-um@archiver.kernel.org>; Sun, 26 Oct 2025 23:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=CRacuABoXwuQKC/k3hW5P+seA3FlCqJzLdG/7VtjiNM=; b=wwayQuOyWy/ldAXaIXyoRNsanL
	qKTAVkfAqH7vfANT5SKg4Y64gPJFa1aR4+HYp24VbLR1imW/4RJytR6HDvqzeoDjAS0TiKcaGrbLv
	ht6h0b5FqjdNiYSS7O+GSkKg9/eaK2JCwu3EWrvfVVreVWWjAna2Xsf8vLJ/bfwH6BqWyLYZ3X77N
	w6dqJK+szSbyCrd49O+sMM4iXgkL2XjrLYmhuQuE60EmJaNngzbQhxRThJeDe662vlYeEJwgfh302
	SSf+EGDtrrE0lCkdj6loFhMBV095CdJ4/g9OZqT6XEpR95g8Q+MiZ067k64GxyNPPsMeznYG9EMT+
	9NUxy2wg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDAeS-0000000CsKP-35bU;
	Sun, 26 Oct 2025 23:59:56 +0000
Received: from out-171.mta0.migadu.com ([2001:41d0:1004:224b::ab])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDAeP-0000000CsGw-0KTJ
	for linux-um@lists.infradead.org;
	Sun, 26 Oct 2025 23:59:54 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761523177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CRacuABoXwuQKC/k3hW5P+seA3FlCqJzLdG/7VtjiNM=;
	b=ECs4j+Bmy1Ff9VJ9EAH03hIcz7/b1ElZEnqQXEi3CrdFg1YVkBzM5sJXrv/uNexEJKXUCt
	AxpASvEbWwL6I2FV0/LgepduA1mfhTwHRxhx8OusiHYWmhAc+S0aPK1vSZ+SNBd9pjO4y4
	l16RtPxVjQ7mLHskP2ekTND058ENTZY=
From: Tiwei Bie <tiwei.bie@linux.dev>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	tiwei.btw@antgroup.com,
	tiwei.bie@linux.dev
Subject: [PATCH 0/3] um: Memory related cleanups
Date: Mon, 27 Oct 2025 07:59:09 +0800
Message-Id: <20251026235912.1654016-1-tiwei.bie@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251026_165953_259844_4866305D 
X-CRM114-Status: UNSURE (   5.01  )
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

Tiwei Bie (3):
  um: Use PAGE_ALIGN() for address alignment
  um: Replace UML_ROUND_UP() with PAGE_ALIGN()
  um: Remove file-based iomem emulation support

 arch/um/Kconfig                    |   6 --
 arch/um/drivers/Makefile           |   1 -
 arch/um/drivers/mmapper_kern.c     | 135 -----------------------------
 arch/um/include/asm/pgtable.h      |   4 +-
 arch/um/include/shared/kern_util.h |   4 -
 arch/um/include/shared/mem_user.h  |  13 ---
 arch/um/kernel/mem.c               |   4 +-
 arch/um/kernel/physmem.c           |  71 ---------------
 arch/um/kernel/um_arch.c           |  19 ++--
 arch/um/os-Linux/skas/process.c    |   7 --
 arch/um/os-Linux/start_up.c        |  50 -----------
 11 files changed, 9 insertions(+), 305 deletions(-)
 delete mode 100644 arch/um/drivers/mmapper_kern.c


base-commit: 211ddde0823f1442e4ad052a2f30f050145ccada
-- 
2.34.1


