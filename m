Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBA64CCF9E5
	for <linux-um@archiver.kernel.org>; Mon, 27 Oct 2025 05:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=DcD2u9ai7ViRDzlSZV32bCSav6qaOPqqoIWDxgrWGto=; b=GnVLoUQ1++d4hcB/RZ84CTEVUZ
	yyDVRhO+A06URDNvZ9K/Z3qA+ktD7updg2JJ8PoIn6xQsCtdq8rbhuTzLl+3kJjJ9oKLLETGtc+lU
	0Ll91jofNJwNfV3KxYffNJxf8CquC6VdENQan9bQC9r9U7/BmlvtFNpxqcKvwIUxIDWTt3JoOTJAo
	eXIXQVquYwolXGmvZCdo9FhGRBzMXBrg6SHjUzZEUv7XgTJvjtxB9s2cAnsgwzr1t8ljj4k27ydeH
	fgDy9FbR9HCUZLmpLLvt3V7KTAilMzFTuv4GAVf0N0PD1r3nspYHAoCPKjDSj2ZD0aynpjDhVOKnq
	hxrEBdPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDG3Q-0000000D8lW-3cjI;
	Mon, 27 Oct 2025 05:46:04 +0000
Received: from out-173.mta1.migadu.com ([2001:41d0:203:375::ad])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDG3K-0000000D8k0-2QWS
	for linux-um@lists.infradead.org;
	Mon, 27 Oct 2025 05:46:01 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761543955;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DcD2u9ai7ViRDzlSZV32bCSav6qaOPqqoIWDxgrWGto=;
	b=tlvuOMcKJCkKTWyGge1jmlqKD7Pu1qGaoKB2lpWl3ruRDb4sAN4jl/nEZPaZwcpJbR85YI
	HC9Aj4K6szbBjNEBy+GI+GerkyfOunAsTj+KjFCe9OcySRs0VtgaKmcroAqVfcKeelcZZz
	QBf0HnosMExvquPHd/aW6GDIK/L+dx8=
From: Tiwei Bie <tiwei.bie@linux.dev>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	tiwei.btw@antgroup.com,
	tiwei.bie@linux.dev
Subject: [PATCH v2 0/4] um: Memory related cleanups
Date: Mon, 27 Oct 2025 13:45:15 +0800
Message-Id: <20251027054519.1996090-1-tiwei.bie@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251026_224559_355481_0E50633D 
X-CRM114-Status: UNSURE (   5.18  )
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
- Add "um: Make host_task_size a local variable";

v1: https://lore.kernel.org/all/20251026235912.1654016-1-tiwei.bie@linux.dev/

Tiwei Bie (4):
  um: Make host_task_size a local variable
  um: Use PAGE_ALIGN() for address alignment
  um: Replace UML_ROUND_UP() with PAGE_ALIGN()
  um: Remove file-based iomem emulation support

 arch/um/Kconfig                    |   6 --
 arch/um/drivers/Makefile           |   1 -
 arch/um/drivers/mmapper_kern.c     | 135 -----------------------------
 arch/um/include/asm/pgtable.h      |   4 +-
 arch/um/include/shared/as-layout.h |   1 -
 arch/um/include/shared/kern_util.h |   4 -
 arch/um/include/shared/mem_user.h  |  13 ---
 arch/um/kernel/mem.c               |   4 +-
 arch/um/kernel/physmem.c           |  71 ---------------
 arch/um/kernel/um_arch.c           |  22 ++---
 arch/um/os-Linux/skas/process.c    |   7 --
 arch/um/os-Linux/start_up.c        |  50 -----------
 12 files changed, 10 insertions(+), 308 deletions(-)
 delete mode 100644 arch/um/drivers/mmapper_kern.c


base-commit: 211ddde0823f1442e4ad052a2f30f050145ccada
-- 
2.34.1


