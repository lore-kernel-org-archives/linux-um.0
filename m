Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0927DC0218D
	for <linux-um@archiver.kernel.org>; Thu, 30 Jan 2025 22:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:Message-ID:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=eE8choOtGSm23imAMW/HRzSNN12/Idqteap2hE9+piQ=; b=zCPifQ2QYF5gkpS4u6wOt75nMQ
	hyeirsrwyGrnYQotclkxLITrIslAMIlWqX2WKUa3D+pgyk4PqbX+rmgQPitG3rvO4nMYvMlxBZBC9
	7JNjeqVVqloRLmBzvcwQnWKsicNu8EdqHPZ9/79UUnd7u1tTWen2Y4LVyu4SvC8EJeCFn1OW14qK9
	ssVjqMnZOkQ+ECISmVzMxYEaBTzdYeGtB1e0RWRc/xYA6zschjiTO/2/e5ZtOJlhpkCOUXPMJZvcl
	wQoh5U4fRsXPWH+iPMeWIYWZGbgjLXJ34il1//fL8DMIlKh28Vqnlw6PMfnW2iCR3L5DR+OHu9u0G
	y22qoVjQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tdclW-00000009hNk-28F8;
	Thu, 30 Jan 2025 22:12:02 +0000
Received: from mailout.nod.at ([116.203.167.152] helo=lithops.sigma-star.at)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tdclT-00000009hN9-3c6a
	for linux-um@lists.infradead.org;
	Thu, 30 Jan 2025 22:12:01 +0000
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id B30762D99A1;
	Thu, 30 Jan 2025 23:11:58 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id T4gBdwkU6e-S; Thu, 30 Jan 2025 23:11:58 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 55B9F2D99A3;
	Thu, 30 Jan 2025 23:11:58 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id CiQBvjWkWIkJ; Thu, 30 Jan 2025 23:11:58 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 3460F2D99A1;
	Thu, 30 Jan 2025 23:11:58 +0100 (CET)
Date: Thu, 30 Jan 2025 23:11:58 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: torvalds <torvalds@linux-foundation.org>
Cc: linux-um <linux-um@lists.infradead.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <1821733080.304331864.1738275118129.JavaMail.zimbra@nod.at>
Subject: [GIT PULL] UML changes for v6.14
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF133 (Linux)/8.8.12_GA_3809)
Thread-Index: v88nChWzqiiR35i8gNV/Qi+JAxAQgQ==
Thread-Topic: UML changes for v6.14
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250130_141200_047700_09640744 
X-CRM114-Status: UNSURE (   4.71  )
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

The following changes since commit fc033cf25e612e840e545f8d5ad2edd6ba613ed5:

  Linux 6.13-rc5 (2024-12-29 13:15:45 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git tags/uml-for-linus-6.14-rc1

for you to fetch changes up to 2d2b61ae38bd91217ea7cc5bc700a2b9e75b3937:

  um: Remove unused asm/archparam.h header (2025-01-13 17:19:43 +0100)

----------------------------------------------------------------
This pull request contains the following changes for UML:

- hostfs: Convert to writepages
- Many cleanups: Removal of dead macros, missing __init

----------------------------------------------------------------
Benjamin Berg (1):
      um: rtc: use RTC time when calculating the alarm

Matthew Wilcox (Oracle) (1):
      hostfs: Convert to writepages

Tiwei Bie (14):
      um: Remove unused MODULES_LEN macro
      um: Remove obsolete fixmap support
      um: Count iomem_size only once in physmem calculation
      um: Mark parse_host_cpu_flags as __init
      um: Mark parse_cache_line as __init
      um: Mark get_top_address as __init
      um: Mark set_stklim as __init
      um: Mark install_fatal_handler as __init
      um: Mark setup_env_path as __init
      um: Remove unused PGD_BOUND macro
      um: Remove unused THREAD_NAME_LEN macro
      um: Remove unused user_context function
      um: Include missing headers in asm/pgtable.h
      um: Remove unused asm/archparam.h header

 arch/um/drivers/rtc_kern.c         |  7 +++--
 arch/um/include/asm/fixmap.h       | 56 --------------------------------------
 arch/um/include/asm/pgtable.h      |  7 ++---
 arch/um/kernel/mem.c               | 15 +++-------
 arch/um/kernel/process.c           |  8 ------
 arch/um/kernel/um_arch.c           | 12 ++++----
 arch/um/os-Linux/main.c            |  8 ++----
 arch/x86/um/asm/archparam.h        | 20 --------------
 arch/x86/um/shared/sysdep/ptrace.h |  2 --
 fs/hostfs/hostfs_kern.c            | 54 +++++++++++++++++-------------------
 10 files changed, 46 insertions(+), 143 deletions(-)
 delete mode 100644 arch/um/include/asm/fixmap.h
 delete mode 100644 arch/x86/um/asm/archparam.h

