Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDA42C433FE
	for <linux-um@archiver.kernel.org>; Fri, 14 Oct 2022 21:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:Message-ID:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=N2jdW7d5YnObDgvy/V8Sv+KsYmkoS8ym/d4SAcX1OkY=; b=w+aG4BqZBaNLe9
	rzomC12Xy8wxzuPHBqGLHL+q5YRwHVSv8hMELcMQSPViNiwu0BzJcY8qw96UVpgBgIFiFl1/yfwDe
	d0xf+T1I97J2oVhGNhPn0ArdnQ40XEOd8jDv1j78Afc4OoPXthOf+v1fFhAnXzOZ4XxFSG609JIqw
	zxVp1BXglDHhxoaV/fvKLcEHczhxVMtFAf/FFfHojhWSIe09P6wFlYnidpItpcBnv4MSBmg81j/Vw
	3cGjRVt0OCkbQWqScmhyrKElWQMeZyQ8zAsf0hKXh/RHw6AcP/Zp+Y8Y2fQkK317MQzkX9i8wsSs4
	R/5fKn2Urbc2BKhJZ6yw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ojS3i-00FyTm-0P; Fri, 14 Oct 2022 21:17:34 +0000
Received: from lithops.sigma-star.at ([195.201.40.130])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ojS3a-00FyOw-1e
	for linux-um@lists.infradead.org; Fri, 14 Oct 2022 21:17:28 +0000
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 7CDF7642172E;
	Fri, 14 Oct 2022 23:17:15 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id EueKNQ03VQhz; Fri, 14 Oct 2022 23:17:15 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 395E3642172F;
	Fri, 14 Oct 2022 23:17:15 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id sKScj7yUuC4f; Fri, 14 Oct 2022 23:17:15 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 243B7642172E;
	Fri, 14 Oct 2022 23:17:15 +0200 (CEST)
Date: Fri, 14 Oct 2022 23:17:15 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: torvalds <torvalds@linux-foundation.org>
Cc: linux-um <linux-um@lists.infradead.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <1664125781.30715.1665782235123.JavaMail.zimbra@nod.at>
Subject: [GIT PULL] UML updates for 6.1-rc1
MIME-Version: 1.0
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Index: eu8Lr/WFHSi3zrjtn8iP5stRMfVGvQ==
Thread-Topic: UML updates for 6.1-rc1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221014_141726_274145_20CAEF93 
X-CRM114-Status: UNSURE (   5.57  )
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

The following changes since commit 521a547ced6477c54b4b0cc206000406c221b4d6:

  Linux 6.0-rc6 (2022-09-18 13:44:14 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git tags/for-linus-6.1-rc1

for you to fetch changes up to 193cb8372424184dde28088a4230a5fed0afb0ad:

  uml: Remove the initialization of statics to 0 (2022-09-19 23:10:07 +0200)

----------------------------------------------------------------
This pull request contains the following changes for UML:

- Move to strscpy()
- Improve panic notifiers
- Fix NR_CPUS usage
- Fixes for various comments
- Fixes for virtio driver

----------------------------------------------------------------
Benjamin Beichler (1):
      um: read multiple msg from virtio slave request fd

Christian Lamparter (1):
      um: increase default virtual physical memory to 64 MiB

Gaosheng Cui (1):
      um: remove unused reactivate_chan() declaration

Guilherme G. Piccoli (1):
      um: Improve panic notifiers consistency and ordering

Huacai Chen (1):
      UM: cpuinfo: Fix a warning for CONFIG_CPUMASK_OFFSTACK

Jason Wang (1):
      um: Fix comment typo

Shaomin Deng (1):
      uml: Remove the initialization of statics to 0

Wolfram Sang (2):
      um: move from strlcpy with unused retval to strscpy
      hostfs: move from strlcpy with unused retval to strscpy

Xin Gao (1):
      um: Do not initialise statics to 0.

Xiu Jianfeng (2):
      um: virt-pci: add __init/__exit annotations to module init/exit funcs
      um: mmaper: add __exit annotations to module exit funcs

 arch/um/drivers/chan.h          |  1 -
 arch/um/drivers/mconsole_kern.c |  9 +++---
 arch/um/drivers/mmapper_kern.c  |  2 +-
 arch/um/drivers/net_kern.c      |  2 +-
 arch/um/drivers/ssl.c           |  2 +-
 arch/um/drivers/stdio_console.c |  2 +-
 arch/um/drivers/ubd_kern.c      |  2 +-
 arch/um/drivers/vector_kern.c   |  2 +-
 arch/um/drivers/virt-pci.c      |  4 +--
 arch/um/drivers/virtio_uml.c    | 71 +++++++++++++++++++++--------------------
 arch/um/kernel/physmem.c        |  2 +-
 arch/um/kernel/um_arch.c        | 14 ++++----
 arch/um/kernel/umid.c           |  2 +-
 fs/hostfs/hostfs_kern.c         |  2 +-
 14 files changed, 59 insertions(+), 58 deletions(-)

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
