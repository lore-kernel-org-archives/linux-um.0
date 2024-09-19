Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E124FCDD552
	for <linux-um@archiver.kernel.org>; Thu, 19 Sep 2024 12:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=JydPX7TP1sF3IR7U5Z9Mczu4s00M5JLlQZyS6S1H+/Q=; b=WDPDxC154eKOR8QV0Jua45ZDXZ
	SLNUgiBhSNDCxmwKnn5O+CZv0cnzTqsfXFt8Bqi+PVtq2YYUw9go8c+SU44FNHNNvYZIUpK0KMIV9
	eou57lqpUJxnUeE0vQvwEfWoLlUwaCMTzDxgOGRrLdpRWiSvZOtuKbuAzBriurutsrmdvzvJ0KIsE
	CKqHgHi4egdAM3ocyd0PnFO22QQKnyRq+2rY5VjjYtbNW69OHLLwke1RwT18VZDlUiCAYAPHbptsQ
	HacOEbH1vYTza1QdWls5pfiI4ZcOLqn5dK5/r2SmYXHEKlXrVvjxDSp1z0tIrtQvP0KvgsWYcHxHo
	Pvmxiv9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1srGXU-0000000AGnu-0SXQ;
	Thu, 19 Sep 2024 12:45:40 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1srGXR-0000000AGmh-0wVd
	for linux-um@lists.infradead.org;
	Thu, 19 Sep 2024 12:45:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=JydPX7TP1sF3IR7U5Z9Mczu4s00M5JLlQZyS6S1H+/Q=; t=1726749935; x=1727959535; 
	b=e7PxDMY9v+p5u6qr1rRmIJnx2VWsJlCM/9wrNBq8BJBdxHerIHfjg7ghQjtkzpp6AzUDF+k2lAo
	4VTPwUc6zVnlEQ44HDf5Q8cXvDXbWj9L7RbJmFdsk5cf+Qp8EfnfgnAljXgT/N0JwLEZhlwOvFDHb
	uuzngAME6gg8MJK54uRb4YqILUmlKLT7nRkf4Dq5N0YoWjN925+ClUuraPIK39iF0qmWyfhsO3oIT
	mKo51iE41NScKr02TpUWmKg0xUlY25H3EoQ7jfH9OWlKK5NsGVL670BoHoPOxx3UFMASsCdjEVd5C
	4BK/XIhCT+lTSU8Lfghn/jBPLsnlijDu6DFA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1srGXL-000000047AZ-1Szl;
	Thu, 19 Sep 2024 14:45:31 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v9 00/10] Increased address space for 64 bit
Date: Thu, 19 Sep 2024 14:45:01 +0200
Message-ID: <20240919124511.282088-1-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240919_054537_295786_C8A748CC 
X-CRM114-Status: GOOD (  15.65  )
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
host task size and switches to four-level page tables on 64 bit. All of
this means the userspace TASK_SIZE is much larger and in turn permits
userspace applications that need a lot of virtual addresses to work
fine.

One such application is ASAN which uses a fixed address in memory that
would otherwise not be addressable.

v9:
* Drop support for 3-level page tables (on top of Tiwei Bie's patch)
* Add patches to set PR_SET_PDEATHSIG for more robust cleanup
* Cleanup top address calculation a bit more
* Use code address for stub data location

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

Benjamin Berg (10):
  um: Add generic stub_syscall1 function
  um: use execveat to create userspace MMs
  um: Set parent death signal for userspace process
  um: Set parent death signal for winch thread/process
  um: Add compile time assert that stub fits on a page
  um: Calculate stub data address relative to stub code
  um: Limit TASK_SIZE to the addressable range
  um: Discover host_task_size from envp
  um: clear all memory in new userspace processes
  um: Switch to 4 level page tables on 64 bit

 arch/um/Kconfig                               |   4 +-
 arch/um/Makefile                              |   3 +-
 arch/um/drivers/chan_user.c                   |   3 +
 arch/um/include/asm/page.h                    |  14 +-
 arch/um/include/asm/pgalloc.h                 |  11 +-
 .../{pgtable-3level.h => pgtable-4level.h}    |  40 +++-
 arch/um/include/asm/pgtable.h                 |   8 +-
 arch/um/include/shared/as-layout.h            |   2 +-
 arch/um/include/shared/os.h                   |   3 -
 arch/um/include/shared/skas/stub-data.h       |  11 ++
 arch/um/kernel/dyn.lds.S                      |   3 +
 arch/um/kernel/mem.c                          |  17 +-
 arch/um/kernel/skas/.gitignore                |   2 +
 arch/um/kernel/skas/Makefile                  |  33 +++-
 arch/um/kernel/skas/mmu.c                     |  25 +--
 arch/um/kernel/skas/stub_exe.c                |  91 +++++++++
 arch/um/kernel/skas/stub_exe_embed.S          |  11 ++
 arch/um/kernel/um_arch.c                      |  34 +++-
 arch/um/os-Linux/main.c                       |   9 +-
 arch/um/os-Linux/mem.c                        |   2 +-
 arch/um/os-Linux/skas/process.c               | 181 ++++++++++++------
 arch/x86/um/Kconfig                           |   3 -
 arch/x86/um/os-Linux/Makefile                 |   2 +-
 arch/x86/um/os-Linux/task_size.c              | 151 ---------------
 arch/x86/um/shared/sysdep/stub_32.h           |  10 +-
 arch/x86/um/shared/sysdep/stub_64.h           |  19 +-
 26 files changed, 420 insertions(+), 272 deletions(-)
 rename arch/um/include/asm/{pgtable-3level.h => pgtable-4level.h} (66%)
 create mode 100644 arch/um/kernel/skas/.gitignore
 create mode 100644 arch/um/kernel/skas/stub_exe.c
 create mode 100644 arch/um/kernel/skas/stub_exe_embed.S
 delete mode 100644 arch/x86/um/os-Linux/task_size.c

-- 
2.46.0


