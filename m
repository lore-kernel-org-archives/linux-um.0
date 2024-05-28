Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B9C9C25B7E
	for <linux-um@archiver.kernel.org>; Tue, 28 May 2024 08:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=mufjjqipHzBWIckA1+JrfpsQX/ggYeP7cG1Lgb6bYxU=; b=h0KPpY4ohTUt14pFcGv1U3lV0f
	x39EEsF/V5STcXHruORm1OfYqFAfD93iq3Lkg3pSCAQmTdtWWWP9j8KEGr398gLthC5RrmZbSbUTH
	3cCLYHTxLbNxlnNMWR38rCUQ1jiJx7dBhrVDdYUt0ItRCWtCO2Jw+kIZ2PZQIpp5A//x6QDTTMILI
	8CGSvYcZNCuoEXH1N8wM30O3g6e6sMVAEh/3P4oPgYb+eqcEDQaEwCGBiFqhVxe/4ieefiMQeY9vd
	U7JZoTdl3W5vfvLldr9I8qSq68IhwG29ACBCa4W4wt3v1OOWEFezrMih4itqExA4X2k5M2mimzbpI
	mCNgkr2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBsbO-0000000HY4Z-36Mp;
	Tue, 28 May 2024 08:54:38 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBsbL-0000000HY3Y-3YSJ
	for linux-um@lists.infradead.org;
	Tue, 28 May 2024 08:54:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=mufjjqipHzBWIckA1+JrfpsQX/ggYeP7cG1Lgb6bYxU=; t=1716886473; x=1718096073; 
	b=aQi8Ws6FgTfK6HOdenl24G+40L65+9qDt3RDyN9t06hh7AoG0ZROAGM9BT/rCfxJG4LRgmyZpOt
	UHaswgdVpVLRuRFZeL3jJpDtCnJ2wVkB2VbFbdufATVAqjTBRgz0AOm/4mq9lHNOBiP4EHfgSjgyY
	2ZMHewAnJxBJpesE5wsNNNA3xcz3cQ5Cyfgsjmo3ctMqlvYfC83Y4URRHwGc+0CeYlt2ucXsO16Hi
	ujJ7UVFjC+mPsNctFtfStDYg00os5zO4Jy5UgLy5O3yJd7Us82cyMLgYZuV6uql394f2Qw8duX3RB
	EyOmnL4FipIl/vWbgNR0Qy4JeiNbRUbc1BVA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1sBsbG-0000000EAlo-1Enk;
	Tue, 28 May 2024 10:54:30 +0200
From: benjamin@sipsolutions.net
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH 0/5] Increased address space for 64 bit
Date: Tue, 28 May 2024 10:54:14 +0200
Message-ID: <20240528085419.1964424-1-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240528_015436_195289_D8A53746 
X-CRM114-Status: UNSURE (   8.32  )
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

This patchset fixes a few bugs, adds a new method of discovering the
host task size and finally adds four level page table support. All of
this means the userspace TASK_SIZE is much larger and in turns permits
userspace applications that need a lot of virtual addresses to work
fine.

One such application is ASAN which uses a fixed address in memory that
would otherwise not be addressable.

Benjamin Berg (5):
  um: Fix stub_start address calculation
  um: Limit TASK_SIZE to the addressable range
  um: Do a double clone to disable rseq
  um: Discover host_task_size from envp
  um: Add 4 level page table support

 arch/um/Kconfig                      |   1 +
 arch/um/include/asm/page.h           |  14 +++-
 arch/um/include/asm/pgalloc.h        |  11 ++-
 arch/um/include/asm/pgtable-4level.h | 119 +++++++++++++++++++++++++++
 arch/um/include/asm/pgtable.h        |   6 +-
 arch/um/include/shared/as-layout.h   |   2 +-
 arch/um/include/shared/os.h          |   2 +-
 arch/um/kernel/mem.c                 |  17 +++-
 arch/um/kernel/um_arch.c             |  14 +++-
 arch/um/os-Linux/main.c              |   9 +-
 arch/um/os-Linux/skas/process.c      |  54 +++++++++++-
 arch/x86/um/Kconfig                  |  38 ++++++---
 arch/x86/um/os-Linux/task_size.c     |  19 ++++-
 13 files changed, 274 insertions(+), 32 deletions(-)
 create mode 100644 arch/um/include/asm/pgtable-4level.h

-- 
2.45.1


