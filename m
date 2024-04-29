Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D081C19F4F
	for <linux-um@archiver.kernel.org>; Mon, 29 Apr 2024 13:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=7atq02NMLxl5ym4FntoXCysokW3IWSRkkjwzlxiaA28=; b=naNDQsu9FRH3A64Yqp44zEPpYF
	rasS20Zi4pp+nf8rZWf07tT/IqCmDhG5F+uTLDyCyfCkOKKxkbzjaroBAvZxT9RaWoEgKXGezSKdZ
	8XInz+vColo/NJCNNBJcuLJqsgGIHX8R4CUJguJafz6ChjdZbWPooF9hnL8/l5ARrgQjx64ITt4EQ
	yqvW4DCC7d5L2y7LWMopjdM5rW1nkxswpQku1vnInEaWsi6wwoyHQw7XrbCG04B7Siiaj8TUuECgC
	2Flwzb1WS7gXNlALdnZApx9eQiqwCw+LhZKJnERuVdPCVZ4TCdHbPOqNLC+pweew8hgnGpGlMiX5f
	tFewUXNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1RMr-00000002zur-1R0O;
	Mon, 29 Apr 2024 13:48:29 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1RMn-00000002zmZ-12sW
	for linux-um@lists.infradead.org;
	Mon, 29 Apr 2024 13:48:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=7atq02NMLxl5ym4FntoXCysokW3IWSRkkjwzlxiaA28=; t=1714398498; x=1715608098; 
	b=ObMF1tfE31awzRTX7+JkYQSlXVzx1wRfn/nzQIrhUZIAO0TnZwwtyuaZI6zScU+qpe5M8efTttI
	MwFVMDpoLMHSu58nI8ns0atqEaNKjr+CaR4EC/i9q8bKVda4ReABvF1pRYmpz/RLRcW7uQ3J1ZOnR
	6DZFdr3gOi7fEfeU0gMXc2JrlrT6GcgqT+XiNS5CZjSxgr9hptrL2Q0mzBPsGRJRxVa22/IBxGhgh
	e4O4MHRRcvxWLz6wBAmlC5NNbvegxZkIVUit5pBhDfxhy5xisXF2GP/kLUNLm9H4+RakwYCgZQqtd
	A4HK/czQpra02syonvSxdXuDDWJpx812uEGg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1s1RMc-0000000CW0d-3oOM;
	Mon, 29 Apr 2024 15:48:15 +0200
From: benjamin@sipsolutions.net
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v2 00/12] Rework stub syscall and page table handling
Date: Mon, 29 Apr 2024 15:47:47 +0200
Message-ID: <20240429134759.244517-1-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240429_064825_560741_0A4A7FA7 
X-CRM114-Status: GOOD (  12.39  )
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

This patchset reworks the stub syscall handling and also redos how page
table updates are tracked and synchronized. Some of this originated in
the SECCOMP patchset, but it became clear that these refactorings make
sense independently as they result in a considerably fewer page faults.

As an example, these changes bring the runtime of one of the hostapd
hwsim test modules from 121 seconds down to 103 seconds. Actual results
will depend heavily on how pagefault heavy the workload is.

Lowering the amount of pagefaults is due to proactively syncing PTEs
that are set (and were previously unset) and also delaying
synchronization so that multiple updates can be done in one step rather
than requiring multiple task switches.

This refactoring also fixes various odd corner cases in how UML was
handling memory and cloning of MMs. As part of this work, support for
LDTs has been dropped. My expectation is that this is not a problem as
it should only be needed by legacy applications.

Changes in v2:
* Address comments from Tiwei Bie
* Remove duplicate report_enomem declaration

Benjamin Berg (12):
  um: Remove stub-data.h include from common-offsets.h
  um: Create signal stack memory assignment in stub_data
  um: Add generic stub_syscall6 function
  um: Rework syscall handling
  um: compress memory related stub syscalls while adding them
  um: remove LDT support
  um: remove copy_context_skas0
  um: Delay flushing syscalls until the thread is restarted
  um: Do not flush MM in flush_thread
  um: remove force_flush_all from fork_handler
  um: simplify and consolidate TLB updates
  um: refactor TLB update handling

 arch/um/drivers/ubd_kern.c              |   2 -
 arch/um/include/asm/mmu.h               |  10 +-
 arch/um/include/asm/mmu_context.h       |   2 -
 arch/um/include/asm/pgtable.h           |  32 ++
 arch/um/include/asm/tlbflush.h          |  46 +-
 arch/um/include/shared/as-layout.h      |   2 +-
 arch/um/include/shared/common-offsets.h |   5 -
 arch/um/include/shared/os.h             |  27 +-
 arch/um/include/shared/skas/mm_id.h     |   2 +-
 arch/um/include/shared/skas/skas.h      |   2 +
 arch/um/include/shared/skas/stub-data.h |  35 +-
 arch/um/include/shared/user.h           |   8 +
 arch/um/kernel/exec.c                   |   9 -
 arch/um/kernel/process.c                |   2 -
 arch/um/kernel/skas/Makefile            |   9 +-
 arch/um/kernel/skas/clone.c             |  48 ---
 arch/um/kernel/skas/mmu.c               |  33 +-
 arch/um/kernel/skas/process.c           |  18 +
 arch/um/kernel/skas/stub.c              |  69 +++
 arch/um/kernel/tlb.c                    | 551 ++++--------------------
 arch/um/kernel/trap.c                   |  15 +-
 arch/um/os-Linux/skas/mem.c             | 248 ++++++-----
 arch/um/os-Linux/skas/process.c         | 121 +-----
 arch/um/os-Linux/start_up.c             |   1 +
 arch/x86/um/Makefile                    |   4 +-
 arch/x86/um/asm/mm_context.h            |  70 ---
 arch/x86/um/ldt.c                       | 380 ----------------
 arch/x86/um/shared/sysdep/stub.h        |   1 +
 arch/x86/um/shared/sysdep/stub_32.h     |  29 +-
 arch/x86/um/shared/sysdep/stub_64.h     |  23 +-
 arch/x86/um/stub_32.S                   |  56 ---
 arch/x86/um/stub_64.S                   |  50 ---
 arch/x86/um/tls_32.c                    |   1 +
 33 files changed, 543 insertions(+), 1368 deletions(-)
 delete mode 100644 arch/um/kernel/skas/clone.c
 create mode 100644 arch/um/kernel/skas/stub.c
 delete mode 100644 arch/x86/um/asm/mm_context.h
 delete mode 100644 arch/x86/um/ldt.c
 delete mode 100644 arch/x86/um/stub_32.S
 delete mode 100644 arch/x86/um/stub_64.S

-- 
2.44.0


