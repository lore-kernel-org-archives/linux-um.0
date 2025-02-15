Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 763F8C021A0
	for <linux-um@archiver.kernel.org>; Sat, 15 Feb 2025 22:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:Message-ID:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=qy8F3mkitBmvsEUQUvqtzz2l1D25l71LhejRke+8Oio=; b=wE+Odxhiv1IU8zsMUHi4k/PFbw
	ukU5BoDwG1r4aDzpYn4PPAphvYX912zgX74VMRA3lhxC627M6LtmWa59b4C7sUh0hZWVu3CpxoAKn
	xokRQBtn4PVJSB1nv42skAZrrmoP+3QIY40uCwUEbq6iSgWNAh4EQ/B07o52/oP75A/1zd5W4TH48
	v5NYPkPqORoIjW9DGMHLLfGfIcTn2JfzGItrwmw6JUMuLBQvGSJF3V+XvHtf71AkJxCE9ec4xIt/g
	WCcRLDiTLZcUtmi59PhWutCRugPocTo4x5Jxz7XV0Ij4bPg9DRIe7UwNB28bT+fpqIzGREiyOtt9Z
	BUZP38dg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tjQXG-00000000pHw-1UMy;
	Sat, 15 Feb 2025 22:21:18 +0000
Received: from mailout.nod.at ([116.203.167.152] helo=lithops.sigma-star.at)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tjQXD-00000000pHF-03JP
	for linux-um@lists.infradead.org;
	Sat, 15 Feb 2025 22:21:16 +0000
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 3B83D2F332B;
	Sat, 15 Feb 2025 23:21:04 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id LVFoHIv9BJ5s; Sat, 15 Feb 2025 23:21:04 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id E4B912B4F6A;
	Sat, 15 Feb 2025 23:21:03 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id WNNxbRAQ5ZXY; Sat, 15 Feb 2025 23:21:03 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id CD1132B03C5;
	Sat, 15 Feb 2025 23:21:03 +0100 (CET)
Date: Sat, 15 Feb 2025 23:21:03 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: torvalds <torvalds@linux-foundation.org>
Cc: linux-um <linux-um@lists.infradead.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <153400218.11019314.1739658063786.JavaMail.zimbra@nod.at>
Subject: [GIT PULL] UML fixes for v6.14-rc3
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF135 (Linux)/8.8.12_GA_3809)
Thread-Index: Py+j5YggKIhDLYY1onwnBXiaHHPABg==
Thread-Topic: UML fixes for v6.14-rc3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250215_142115_228015_2B88ED96 
X-CRM114-Status: UNSURE (   3.49  )
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

The following changes since commit a64dcfb451e254085a7daee5fe51bf22959d52d3:

  Linux 6.14-rc2 (2025-02-09 12:45:03 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git tags/uml-for-linus-6.14-rc3

for you to fetch changes up to 96178631c3f53398044ed437010f7632ad764bf8:

  um: convert irq_lock to raw spinlock (2025-02-12 23:40:59 +0100)

----------------------------------------------------------------
This pull request contains the following bug fixes for UML:

- Align signal stack correctly
- Convert to raw spinlocks where needed (irq and virtio)
- FPU related fixes

----------------------------------------------------------------
Benjamin Berg (4):
      um: add back support for FXSAVE registers
      um: avoid copying FP state from init_task
      um: properly align signal stack on x86_64
      um: fix execve stub execution on old host OSs

Johannes Berg (3):
      um: virt-pci: don't use kmalloc()
      um: virtio_uml: use raw spinlock
      um: convert irq_lock to raw spinlock

 arch/um/drivers/virt-pci.c       | 198 ++++++++++++++++++++-------------------
 arch/um/drivers/virtio_uml.c     |   8 +-
 arch/um/kernel/irq.c             |  79 +++++++++-------
 arch/um/kernel/process.c         |  10 +-
 arch/um/os-Linux/skas/process.c  |  16 +++-
 arch/x86/um/os-Linux/registers.c |  21 ++++-
 arch/x86/um/signal.c             |  13 ++-
 7 files changed, 203 insertions(+), 142 deletions(-)

