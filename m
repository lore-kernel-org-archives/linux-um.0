Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E66C9C77B78
	for <linux-um@archiver.kernel.org>; Wed,  3 May 2023 19:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:Message-ID:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=ZCVVLgOK67bCHQdynASyolrZrkiEF1ZyGHBNfc6eG3I=; b=tX3Ftj6+17qCTC
	yT1rZc+78blqLcqDL/8P5s782Ux6xFNVwq4EVyu00RexQ9ZOwJBfikBc/emwuqrNYz337zdh0BwED
	/NEjKskgMT02KLOdhwCBNh69I5QqX+mIgDx3Uzd8f6otzMrpN6m+yAVwosfddO4LD1vKVxh0h1dzA
	jQrF9zboq+tNFJdVy+fm1rqX8OXa/SEuUBS8EF2ovtfwsSNWHdhcMxFb2HZudtYolwZF14iZRTM9s
	ZSVW/LSmdLG+zt3J6lUF4j5ZARBjBC070I46r23eYm+Jfh1L3/K9pks6ZXRGNm6DAk+sZOBw2o9IH
	th/9c+Gm1hgB9MY5kvkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1puI75-005aTC-06;
	Wed, 03 May 2023 19:26:07 +0000
Received: from lithops.sigma-star.at ([195.201.40.130])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1puI6z-005aOg-33
	for linux-um@lists.infradead.org;
	Wed, 03 May 2023 19:26:05 +0000
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id DC45562E1A88;
	Wed,  3 May 2023 21:25:46 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id NgIMzGpBMDA5; Wed,  3 May 2023 21:25:46 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 9056362E1A8B;
	Wed,  3 May 2023 21:25:46 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id kIWJ4Yhy4vqi; Wed,  3 May 2023 21:25:46 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 7688D62E1A88;
	Wed,  3 May 2023 21:25:46 +0200 (CEST)
Date: Wed, 3 May 2023 21:25:46 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-um <linux-um@lists.infradead.org>
Message-ID: <1396818281.2692347.1683141946452.JavaMail.zimbra@nod.at>
Subject: [GIT PULL] UML changes for v6.4
MIME-Version: 1.0
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Index: UBzrUyVu13WtK84om5FO5dxIQ5FWlA==
Thread-Topic: UML changes for v6.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230503_122602_154397_9513B8C7 
X-CRM114-Status: UNSURE (   6.58  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

Linus,

The following changes since commit 7e364e56293bb98cae1b55fd835f5991c4e96e7d:

  Linux 6.3-rc5 (2023-04-02 14:29:29 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git tags/uml-for-linus-6.4-rc1

for you to fetch changes up to 6032aca0deb9c138df122192f8ef02de1fdccf25:

  um: make stub data pages size tweakable (2023-04-20 23:08:43 +0200)

----------------------------------------------------------------
This pull request contains the following changes for UML:

- Make stub data pages configurable
- Make it harder to mix user and kernel code by accident

----------------------------------------------------------------
Johannes Berg (6):
      um: add __weak for exported functions
      um: hostfs: define our own API boundary
      um: don't export printf()
      um: further clean up user_syms
      um: prevent user code in modules
      um: make stub data pages size tweakable

 arch/um/include/shared/as-layout.h  |   3 +-
 arch/um/kernel/skas/clone.c         |   5 +-
 arch/um/kernel/skas/mmu.c           |   6 +--
 arch/um/kernel/um_arch.c            |  10 ++--
 arch/um/os-Linux/skas/process.c     |   6 +--
 arch/um/os-Linux/user_syms.c        | 104 ++++++------------------------------
 arch/um/scripts/Makefile.rules      |   4 +-
 arch/x86/um/shared/sysdep/stub_32.h |   8 +--
 arch/x86/um/shared/sysdep/stub_64.h |   8 +--
 arch/x86/um/stub_segv.c             |   2 +-
 fs/Makefile                         |   2 +-
 fs/hostfs/Makefile                  |   6 ++-
 fs/hostfs/hostfs_user_exp.c         |  28 ++++++++++
 13 files changed, 78 insertions(+), 114 deletions(-)
 create mode 100644 fs/hostfs/hostfs_user_exp.c

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
