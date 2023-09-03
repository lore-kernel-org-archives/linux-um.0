Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B8F2C83F2D
	for <linux-um@archiver.kernel.org>; Sun,  3 Sep 2023 19:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:Message-ID:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=K6EfIpiJ85L/byTpfqU1pFG/0o/Hp+ye+GuLJBbof4c=; b=YJ6jCevywapmcV
	jPs95Hy3hozywYRgC5Hl6QT8/pL6fRI8ofM9ROH3PgAUHHp+9oc5RZk1CzUf9lmLmlPgNOEELRRUi
	EeyMAN1vnfytqlsqbvz63VDk3B0Voqa5zng2evHp4L2dbhHojVNUnyR7oSnh5BMmrxSsQG1xNuwKi
	IIVvGiMrWHxDb506eyt+uuNuJ3sobudRwJpsqk1O+KuTVXywE4D1e2X41DJQz9Z1Din6j1FXlnw4G
	ApdwgYVhBWp8+ELVLVAToudLP3Cf5Yzln9mo1RrzeLxZr+l1f6e5qN/AeblILWItF+4KLrofibpfD
	E01Zefc76ysW0z7LuTzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qcsY0-002pmq-2b;
	Sun, 03 Sep 2023 19:14:12 +0000
Received: from lithops.sigma-star.at ([195.201.40.130])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qcsXw-002pmR-0E
	for linux-um@lists.infradead.org;
	Sun, 03 Sep 2023 19:14:10 +0000
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id A43AF623488E;
	Sun,  3 Sep 2023 21:13:54 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 4suBvoeprK1D; Sun,  3 Sep 2023 21:13:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 35E52623488F;
	Sun,  3 Sep 2023 21:13:54 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ea5wIfuo781e; Sun,  3 Sep 2023 21:13:54 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 175C0623488E;
	Sun,  3 Sep 2023 21:13:54 +0200 (CEST)
Date: Sun, 3 Sep 2023 21:13:54 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: torvalds <torvalds@linux-foundation.org>
Cc: linux-um <linux-um@lists.infradead.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <1189803925.12843.1693768434048.JavaMail.zimbra@nod.at>
Subject: [GIT PULL] UML Changes for v6.6-rc1
MIME-Version: 1.0
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Index: ghDboZa1hFHmnDsq+KMITPB5MegcYA==
Thread-Topic: UML Changes for v6.6-rc1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230903_121408_431262_EF87B8FC 
X-CRM114-Status: UNSURE (   6.67  )
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

The following changes since commit 2ccdd1b13c591d306f0401d98dedc4bdcd02b421:

  Linux 6.5-rc6 (2023-08-13 11:29:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git tags/uml-for-linus-6.6-rc1

for you to fetch changes up to 974b808d85abbc03c3914af63d60d5816aabf2ca:

  um: virt-pci: fix missing declaration warning (2023-08-26 22:49:49 +0200)

----------------------------------------------------------------
This pull request contains the following changes for UML:

- Drop 32-bit checksum implementation and re-use it from arch/x86
- String function cleanup
- Fixes for -Wmissing-variable-declarations and -Wmissing-prototypes builds

----------------------------------------------------------------
Azeem Shaikh (1):
      um: Remove strlcpy usage

David Gow (2):
      asm-generic: current: Don't include thread-info.h if building asm
      um: Use the x86 checksum implementation on 32-bit

Justin Stitt (2):
      um: vector: refactor deprecated strncpy
      um: Refactor deprecated strncpy to memcpy

Masahiro Yamada (2):
      um: Hard-code the result of 'uname -s'
      um: use obj-y to descend into arch/um/*/

Nick Desaulniers (3):
      uml: audio: fix -Wmissing-variable-declarations
      um: port_kern: fix -Wmissing-variable-declarations
      um: fix 3 instances of -Wmissing-prototypes

Randy Dunlap (1):
      um: Fix hostaudio build errors

Vincent Whitchurch (1):
      um: virt-pci: fix missing declaration warning

YueHaibing (1):
      um: Remove unsued extern declaration ldt_host_info()

 arch/um/Kbuild                    |   2 +
 arch/um/Makefile                  |   9 +-
 arch/um/configs/i386_defconfig    |   1 +
 arch/um/configs/x86_64_defconfig  |   1 +
 arch/um/drivers/Kconfig           |  16 +--
 arch/um/drivers/Makefile          |   2 +-
 arch/um/drivers/hostaudio_kern.c  |   2 +-
 arch/um/drivers/mconsole_kern.c   |   4 +-
 arch/um/drivers/port_kern.c       |   2 +-
 arch/um/drivers/slirp_kern.c      |   2 +-
 arch/um/drivers/vector_user.c     |   4 +-
 arch/um/drivers/virt-pci.c        |   2 +
 arch/um/drivers/xterm_kern.c      |   1 +
 arch/um/include/shared/irq_kern.h |   1 +
 arch/um/include/shared/user.h     |   1 -
 arch/um/kernel/irq.c              |   2 -
 arch/um/os-Linux/umid.c           |   6 +-
 arch/x86/um/Makefile              |   5 +-
 arch/x86/um/asm/mm_context.h      |   2 -
 arch/x86/um/checksum_32.S         | 214 --------------------------------------
 include/asm-generic/current.h     |   2 +
 sound/Kconfig                     |   2 +-
 22 files changed, 30 insertions(+), 253 deletions(-)
 delete mode 100644 arch/x86/um/checksum_32.S

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
