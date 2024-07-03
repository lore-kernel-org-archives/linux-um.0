Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40177C3271F
	for <linux-um@archiver.kernel.org>; Wed,  3 Jul 2024 15:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=MXlJ8msdfDvSl+1pLP3tU8dF23G4Je/mG9j/KSsqqsM=; b=oMhbIsWiCN5Wu7WLRmD9GULg8X
	3/9++PDV7HOAO+wK5fTycm1MWbDLzD/YiflWkWaZTbytHLC3wTDngEs+hyfwZpAdywyMSOlmZMUpk
	8261x3H0i96iJgBlxZoF8Qj2rKMy4TNOPbID1tzIFwRNf7qnzi7lXY3A7Xp8loHdSRJwGZ+MNSUoI
	ekSJj7MsVJgcLNglkOXqbgIyOMNg7PAZh75A0H7+a/JJHQiEUAvtFx+a4HHemXxE2AJDZL/pGv2Nv
	ZOIk+7gTqwcuBuVEMGuXs2cAElfPMBJURWkouL+PL1Yg7/coXiVsdd6fEtnVgtKy982EjNvwvNbHl
	6MM6LRrg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sP1TT-0000000AaaU-1Me1;
	Wed, 03 Jul 2024 15:00:47 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sP0JN-0000000ALGz-2L1p
	for linux-um@bombadil.infradead.org;
	Wed, 03 Jul 2024 13:46:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=MXlJ8msdfDvSl+1pLP3tU8dF23G4Je/mG9j/KSsqqsM=; b=Qp4VBW3DgyW+XC3oAks4MPBXqa
	xLjAcmN/8oEFKp9603hVr7Kx6X+i4BRccBH8l9Pi0fTt0lA4qKMh8bTZaXs0Zvhi/J/DrEBgmPEzJ
	O/Dep3LERgcy4MwA0dqHTfvRX4TDATOsTSuwnuDHvP+zZcpDxFgJ2HDTD2ALmN+ZxYcA4r6FOe8xr
	+/CpALyDmVPmM80RciNQ99mOnsVLDrJAQ2YDpVGXjQtP7EvhGZP62M0ucDQ1TGzvpZjiBEPZkDzae
	bsm3Kvbf//07ypAn3ZXvcqVWWjRyBPGuJef0kucmL/X1KGEc7aZ64Zlxg0y3UQ5grhYoOtjsfZbo6
	wshJofow==;
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sP0JK-0000000A1Fx-0CrW
	for linux-um@lists.infradead.org;
	Wed, 03 Jul 2024 13:46:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=MXlJ8msdfDvSl+1pLP3tU8dF23G4Je/mG9j/KSsqqsM=; t=1720014371; x=1721223971; 
	b=TigXaRTC2ficIyrFp3VEuiLqtLQJ9N74/Maw6Evx+YGvAsYftrYVGi/L1u6iHdMTzHOifM6VUo0
	PrKHGudUR8DVxjQeutXHfSSHM/Ied1Dn4x2drWadeEOsbh2QYsODURjFju4EXI0eIDlVu5DYUnaHr
	ioIF8pJ54q8Nve7wqohYsp57rNE+sHlq5aWTYDcYCGMY4UrVBObztQ5ZWlaORwGu+FR8Lx2dnXPUt
	19z5E5Tq8q/zD+IK+6/1KAZPJGfGRzrrbYKujRUEKA+8lug1StVj0ShynOiKrutg6VlyYjLteKstY
	GAotIlcNLNzG4ueaP9VpTyY8G2ecG0nfyykA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1sP0JE-000000094nb-2829;
	Wed, 03 Jul 2024 15:46:08 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v4 00/12] Rework stub syscall and page table handling
Date: Wed,  3 Jul 2024 15:45:24 +0200
Message-ID: <20240703134536.1161108-1-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240703_144614_462546_5DF6CE4E 
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

Changes in v4:
* Only clear memory up to TASK_SIZE

Changes in v3:
* Remove more left over code from copy_context_skas0 removal
* Fix mprotect syscall in stub

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
 arch/um/include/shared/skas/stub-data.h |  36 +-
 arch/um/include/shared/user.h           |   8 +
 arch/um/kernel/exec.c                   |   9 -
 arch/um/kernel/process.c                |   2 -
 arch/um/kernel/skas/Makefile            |   9 +-
 arch/um/kernel/skas/clone.c             |  48 ---
 arch/um/kernel/skas/mmu.c               |  54 ++-
 arch/um/kernel/skas/process.c           |  18 +
 arch/um/kernel/skas/stub.c              |  69 +++
 arch/um/kernel/tlb.c                    | 545 ++++--------------------
 arch/um/kernel/trap.c                   |  15 +-
 arch/um/os-Linux/skas/mem.c             | 245 ++++++-----
 arch/um/os-Linux/skas/process.c         | 121 +-----
 arch/um/os-Linux/start_up.c             |   1 +
 arch/x86/um/Makefile                    |   4 +-
 arch/x86/um/asm/mm_context.h            |  70 ---
 arch/x86/um/ldt.c                       | 380 -----------------
 arch/x86/um/shared/sysdep/stub.h        |   2 +-
 arch/x86/um/shared/sysdep/stub_32.h     |  45 +-
 arch/x86/um/shared/sysdep/stub_64.h     |  41 +-
 arch/x86/um/stub_32.S                   |  56 ---
 arch/x86/um/stub_64.S                   |  50 ---
 arch/x86/um/tls_32.c                    |   1 +
 33 files changed, 554 insertions(+), 1405 deletions(-)
 delete mode 100644 arch/um/kernel/skas/clone.c
 create mode 100644 arch/um/kernel/skas/stub.c
 delete mode 100644 arch/x86/um/asm/mm_context.h
 delete mode 100644 arch/x86/um/ldt.c
 delete mode 100644 arch/x86/um/stub_32.S
 delete mode 100644 arch/x86/um/stub_64.S

-- 
2.45.2


