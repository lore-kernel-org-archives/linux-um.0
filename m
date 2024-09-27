Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8F44CDD1D2
	for <linux-um@archiver.kernel.org>; Fri, 27 Sep 2024 19:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:Message-ID:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=NBT3Qmx+CLMTj4wokl6RKqXlZuYVNskUrX83OSKuGJ0=; b=GfU8y440I1M+8sWbA/EjK0zNZ9
	TLVs3NfXkCdP3a+i1wT2w56JdFlkSMLkSoBK8DU909NnAuc2eyHoIZjqFf9T8+b/BrL/w8qONopCV
	T5u6SPkDfMb5OvrpHGYYby/V2JMLQ2PmyoCv12aEZIjAbmVidv20Oej6w9I5oxCOH0l+hqWMWO55o
	LKLYsS61f9aMmKpxqnJU0oxqaP1DniNThTjaquiAU7K9DHTgQG94mwUeXwpyqfPMu4+I+N4QltC4v
	pl69p5K6cH8hN8FQ46p1KJHOwQxcD1LvN0Zt+rINlWYP6cn+g3C25p2gd4w3XSjIfK1YIR0xcdC5R
	U5SdsRBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1suGdZ-0000000BxGo-4Bmz;
	Fri, 27 Sep 2024 19:28:22 +0000
Received: from lithops.sigma-star.at ([195.201.40.130])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1suGdW-0000000BxGO-3dYe
	for linux-um@lists.infradead.org;
	Fri, 27 Sep 2024 19:28:20 +0000
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 91DA064CD861;
	Fri, 27 Sep 2024 21:28:13 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 0tq4pwMvCWFM; Fri, 27 Sep 2024 21:28:13 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 0E2D064CD864;
	Fri, 27 Sep 2024 21:28:13 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 5E4KcxzTF_hK; Fri, 27 Sep 2024 21:28:12 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id E0E3764CD861;
	Fri, 27 Sep 2024 21:28:12 +0200 (CEST)
Date: Fri, 27 Sep 2024 21:28:12 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: torvalds <torvalds@linux-foundation.org>
Cc: linux-um <linux-um@lists.infradead.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <1875454673.111023.1727465292786.JavaMail.zimbra@nod.at>
Subject: [GIT PULL] UML updates for v6.12-rc1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF130 (Linux)/8.8.12_GA_3809)
Thread-Index: xCpkD3WT7efuMYU9z9yiA7gEewPKjA==
Thread-Topic: UML updates for v6.12-rc1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240927_122819_228114_C38B8B1E 
X-CRM114-Status: UNSURE (   7.18  )
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

Linus,

The following changes since commit 431c1646e1f86b949fa3685efc50b660a364c2b6:

  Linux 6.11-rc6 (2024-09-01 19:46:02 +1200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git tags/uml-for-linus-6.12-rc1

for you to fetch changes up to 381d2f95c8aa575d5d42bf1fe0ea9a70c4bec0cf:

  um: fix time-travel syscall scheduling hack (2024-09-12 20:46:23 +0200)

----------------------------------------------------------------
This pull request contains the following changes for UML:

- Removal of dead code (TT mode leftovers, etc.)
- Fixes for the network vector driver
- Fixes for time-travel mode

----------------------------------------------------------------
Anton Ivanov (2):
      um: vector: Replace locks guarding queue depth with atomics
      um: vector: Fix NAPI budget handling

Gaosheng Cui (1):
      um: Remove obsoleted declaration for execute_syscall_skas

Johannes Berg (3):
      um: remove variable stack array in os_rcv_fd_msg()
      um: remove ARCH_NO_PREEMPT_DYNAMIC
      um: fix time-travel syscall scheduling hack

Renzo Davoli (2):
      vector_user: add VDE support
      user_mode_linux_howto_v2: add VDE vector support in doc

Tiwei Bie (7):
      um: Remove unused kpte_clear_flush macro
      um: Remove the redundant newpage check in update_pte_range
      um: Remove unused fields from thread_struct
      um: Remove unused mm_fd field from mm_id
      um: Remove the call to SUBARCH_EXECVE1 macro
      um: Remove the declaration of user_thread function
      um: Remove outdated asm/sysrq.h header

 .../virt/uml/user_mode_linux_howto_v2.rst          |  37 ++++
 arch/um/Kconfig                                    |   1 -
 arch/um/drivers/vector_kern.c                      | 212 +++++++++++----------
 arch/um/drivers/vector_kern.h                      |   4 +-
 arch/um/drivers/vector_user.c                      |  83 ++++++++
 arch/um/include/asm/pgtable.h                      |   7 -
 arch/um/include/asm/processor-generic.h            |  20 +-
 arch/um/include/asm/sysrq.h                        |   8 -
 arch/um/include/shared/skas/mm_id.h                |   5 +-
 arch/um/include/shared/skas/skas.h                 |   2 -
 arch/um/kernel/exec.c                              |   3 -
 arch/um/kernel/process.c                           |   8 +-
 arch/um/kernel/reboot.c                            |   2 +-
 arch/um/kernel/skas/mmu.c                          |  12 +-
 arch/um/kernel/skas/process.c                      |   4 +-
 arch/um/kernel/skas/syscall.c                      |  34 ++--
 arch/um/kernel/sysrq.c                             |   1 -
 arch/um/kernel/time.c                              |   2 +-
 arch/um/kernel/tlb.c                               |  16 +-
 arch/um/os-Linux/file.c                            |   8 +-
 arch/um/os-Linux/skas/mem.c                        |   2 +-
 arch/um/os-Linux/skas/process.c                    |   2 +-
 arch/x86/um/sysrq_32.c                             |   1 -
 arch/x86/um/sysrq_64.c                             |   1 -
 24 files changed, 286 insertions(+), 189 deletions(-)
 delete mode 100644 arch/um/include/asm/sysrq.h

