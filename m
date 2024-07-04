Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3FC1C30653
	for <linux-um@archiver.kernel.org>; Thu,  4 Jul 2024 19:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=5y/xpoa/oOQpN4QDZPHqupqO6yruNSDBP8CHG8H25kE=; b=XQA5hX85ovrnMfEvpSc629RQzF
	dCo1qf0PmsOkJRLTX1XRCLkQLRYfV06vBsqob/16P/O6rdovR9jujD63ng5rtz4jpOsb79B1BcKgE
	ThLpYnW8MuvdHB4o3PsB4GiRLxVebmUA3zDFmHBbhicSQu8OahPVqA2kdAzXT5VPaJsKHQQEb78Qx
	hCWflGbt9Pr5EJ+Kb3HW31KrgSfjVYqGzlDHhZ//Qc4i/V2AWXysSsS0CUP7b0JwTGBOO9WcjXYyN
	7xsjt446ZXdkyOUZAveplaPLucVr1xeaj608ZJoak1GbK8dl1Wd6sM7ge4R7A/cmErEkyD4+nLq0v
	UCUSxs3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPRle-0000000EEDo-2qoO;
	Thu, 04 Jul 2024 19:05:18 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPRlb-0000000EECN-3LKd
	for linux-um@lists.infradead.org;
	Thu, 04 Jul 2024 19:05:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=5y/xpoa/oOQpN4QDZPHqupqO6yruNSDBP8CHG8H25kE=; t=1720119915; x=1721329515; 
	b=lgbqFkpsNllC+wYp07z1i+gSscGpXkKVm7tRwyNBb4Pp23grBQ2p7r3kXRCqj+JMww6L7dVOzqQ
	JdZmeNvqTdSQuMuXv3yg9fxUpVvwAQ0oFlE9fnhoB0rOt0fVE8rv1JxC2ENuxzY2dU5uSKFrOVKU8
	azTGdskV8/V0Hw3bX/JFN+yaH50CWD21PIz4ZKPiHpfj1zh+MCmljNpfN5/3vSepAWGPvEdqejOqw
	QjecEOK7lWtOtomDnbgXzlXj78svoGI2DCbk6otI39BLduCSSrQLyCs7E1yX74jjLdBZiwK/9BGs0
	0FMlkqu7Zuvs1H2HpYvkxhygydWLvm+9A5Gg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1sPRlY-0000000DrZs-0A7k;
	Thu, 04 Jul 2024 21:05:12 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v8 0/7] Increased address space for 64 bit
Date: Thu,  4 Jul 2024 21:04:59 +0200
Message-ID: <20240704190506.1438493-1-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240704_120515_861241_B6BA6FBF 
X-CRM114-Status: GOOD (  12.11  )
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

The new version of the patchset uses execveat on a memfd instead of
cloning twice to disable rseq. This should be much more robust going
forward as it will also avoid issues with other new features like mseal.

This patchset fixes a few bugs, adds a new method of discovering the
host task size and finally adds four level page table support. All of
this means the userspace TASK_SIZE is much larger and in turns permits
userspace applications that need a lot of virtual addresses to work
fine.

One such application is ASAN which uses a fixed address in memory that
would otherwise not be addressable.

v8:
* Make changes suggested by Johannes Berg

v7:
* Plenty of changes to fix 32 bit and improve the logic

v6:
* Apply fixes pointed out by Tiwei Bie
* Add temporary file fallback as memfd is not always supported

v5:
* Use execveat with memfd instead of double clone

v4:
* Do not use WNOHANG in wait for CLONE_VFORK

v3:
* Undo incorrect change in child wait loop

v2:
* Improved double clone logic using CLONE_VFORK
* Kconfig fixes pointed out by Tiwei Bie

Benjamin Berg (7):
  um: Add generic stub_syscall1 function
  um: use execveat to create userspace MMs
  um: Fix stub_start address calculation
  um: Limit TASK_SIZE to the addressable range
  um: Discover host_task_size from envp
  um: clear all memory in new userspace processes
  um: Add 4 level page table support

 arch/um/Kconfig                         |   1 +
 arch/um/include/asm/page.h              |  14 +-
 arch/um/include/asm/pgalloc.h           |  11 +-
 arch/um/include/asm/pgtable-4level.h    | 119 ++++++++++++++++
 arch/um/include/asm/pgtable.h           |   6 +-
 arch/um/include/shared/as-layout.h      |   2 +-
 arch/um/include/shared/os.h             |   2 +-
 arch/um/include/shared/skas/stub-data.h |  11 ++
 arch/um/kernel/mem.c                    |  17 ++-
 arch/um/kernel/skas/.gitignore          |   2 +
 arch/um/kernel/skas/Makefile            |  33 ++++-
 arch/um/kernel/skas/mmu.c               |  25 +---
 arch/um/kernel/skas/stub_exe.c          |  88 ++++++++++++
 arch/um/kernel/skas/stub_exe_embed.S    |  11 ++
 arch/um/kernel/um_arch.c                |  14 +-
 arch/um/os-Linux/main.c                 |   9 +-
 arch/um/os-Linux/mem.c                  |   2 +-
 arch/um/os-Linux/skas/process.c         | 181 ++++++++++++++++--------
 arch/x86/um/Kconfig                     |  38 +++--
 arch/x86/um/os-Linux/task_size.c        | 152 ++------------------
 arch/x86/um/shared/sysdep/stub_64.h     |  11 ++
 21 files changed, 501 insertions(+), 248 deletions(-)
 create mode 100644 arch/um/include/asm/pgtable-4level.h
 create mode 100644 arch/um/kernel/skas/.gitignore
 create mode 100644 arch/um/kernel/skas/stub_exe.c
 create mode 100644 arch/um/kernel/skas/stub_exe_embed.S

-- 
2.45.2


