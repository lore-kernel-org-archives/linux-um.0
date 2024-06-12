Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9119DC27C53
	for <linux-um@archiver.kernel.org>; Wed, 12 Jun 2024 16:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=VW+hTKLl5MYcXVci3T2M23aPUtMM1ahLNDMmxu8Cir8=; b=cF7HR+VkWAJEAMQPuhGzP15A4X
	+8H1uPbexg4QvwZiC+4MYqzeJ7D8PLCcFbofqNALrizwvc0m2W63oVJk2fwtw54Pr7/+OKaCOfV+L
	RzAnco/E1wHOj0f24YFCh2mIqeYFp/rMWdiq4c6jYXIC4Mu8pHw7CxjgNJGyeBqrV9Hu+SZGATFmi
	+UUiujxgWUUFOzlunuPP+sgx37cO/mV5BuQ5n/2tR+AZwmek9y7Wh2vMUTloaKlBeVUR6rLXZ0d7R
	bSOUaBhzp/Vttn04WK+My8msUcBRWIxy2SzCmGjJR+j9SJioKYypWUbUxL/KvcgDpVxpLJLULuC6P
	Ew4e5O3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHR2b-0000000DPtG-0njN;
	Wed, 12 Jun 2024 16:41:41 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHR2X-0000000DPrl-0VSy
	for linux-um@lists.infradead.org;
	Wed, 12 Jun 2024 16:41:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=VW+hTKLl5MYcXVci3T2M23aPUtMM1ahLNDMmxu8Cir8=; t=1718210496; x=1719420096; 
	b=N8wEDzfiW5LnjVcqIdPNZ7qsCkJWwbeLQIR5Qqi/rsycW03bXsnK3H/Zp4WNd7XaAfJc7Xt8DuD
	C++SLpLwll1NEjvV40TLd2hqVtUGCKFX1APoISdgZn2/tjbXRr0Oh6F2KjAV9iw3AjXh1GEKtKTnY
	j++0MUeX+8fQN74nT8txAZG4JTDhaeY1Ps269zp0u2UGO7yM3BBfdBBTD3lxw8nGtOcSgFv77zctO
	BtOm6qYrMy0ynq+pVhrvKwvxtEauCdajz7yZ2W8TJkCvMzgJiGBaO0ak/UgPmujnrU5l/Wzrb33+H
	UM2knmWjAUHOg0025MLob6cM8QtyJsiuFuYA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1sHR2T-0000000AUQy-1pNR;
	Wed, 12 Jun 2024 18:41:34 +0200
From: benjamin@sipsolutions.net
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v4 0/5] Increased address space for 64 bit
Date: Wed, 12 Jun 2024 18:41:03 +0200
Message-ID: <20240612164108.1742106-1-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240612_094137_409711_98AB3E33 
X-CRM114-Status: UNSURE (   9.78  )
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

Sorry for the noise, but I noticed that v3 has an issue on some host
kernels, so I changed the waitpid back to how it was before CLONE_VFORK.

This patchset fixes a few bugs, adds a new method of discovering the
host task size and finally adds four level page table support. All of
this means the userspace TASK_SIZE is much larger and in turns permits
userspace applications that need a lot of virtual addresses to work
fine.

One such application is ASAN which uses a fixed address in memory that
would otherwise not be addressable.

v2:
* Improved double clone logic using CLONE_VFORK
* Kconfig fixes pointed out by Tiwei Bie

v3:
* Undo incorrect change in child wait loop

v4:
* Do not use WNOHANG in wait for CLONE_VFORK

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
 arch/um/os-Linux/skas/process.c      |  53 +++++++++++-
 arch/x86/um/Kconfig                  |  38 ++++++---
 arch/x86/um/os-Linux/task_size.c     |  19 ++++-
 13 files changed, 273 insertions(+), 32 deletions(-)
 create mode 100644 arch/um/include/asm/pgtable-4level.h

-- 
2.45.1


