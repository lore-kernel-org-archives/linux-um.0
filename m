Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19F08CAC5B8
	for <linux-um@archiver.kernel.org>; Mon,  6 Oct 2025 09:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=XjIum+QqMpnb0kQoQ3QYCrvzzB3cnWXUx/4S7ppsB5w=; b=itMEwDROMEs4luL0PiRje/384W
	4Odq1hLtDvBG9PDs6CUEx+LVa6bGTO8pWfUOdaOaia2ds01jHPgfdHRJNrg+rHsXQFGSdhIx1XFBr
	nhch4dZ+Y5lNrXA7gohX/U8R1Oeaf8m0xoBlX0Hh8YZ/4QFqgEFpfx/B/4dPefoMK+O/9hidXVH6C
	RyZmyz2o4y7yUMicC7vvCuF4sRqZuYk0nFtmYqPVuEIZd1oFqrS4WZFsRDvw5BACM4O6RzFy5Izgq
	Lbxa1Z05tInNf29ozFSk2eKG3e1SVOy4IcrGmdc/Jj5tESj5vrDLG7pC4X50YbHeFK1JWkAXYYstX
	rPj+ugwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v5hdh-0000000HFUH-2pTY;
	Mon, 06 Oct 2025 09:36:17 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v5hdc-0000000HFSR-0X1s
	for linux-um@lists.infradead.org;
	Mon, 06 Oct 2025 09:36:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=XjIum+QqMpnb0kQoQ3QYCrvzzB3cnWXUx/4S7ppsB5w=; t=1759743372; x=1760952972; 
	b=x5+PMZNzKaGku4iTANNR2Op3AUGCEwU97CnF4jCg1spq/tlAI6oV++CYboH6o1ERRrObppq/Cql
	ECfgoBVQmpOR8ghZksvpbA+hnJAGaMnQ81SxnMDjGfzIp/KFjE5EZFTTYLalmXl++7OehZyvIXxGF
	DhF+EGM8qsHzsZl5EybBpRbBBt2/dUnaMq/Eu8IghZclJieqSgbzE5W0OFbS7FYKTNk6NuPLyrO/h
	7NXWi5bAuFt/iNwaAd1IQ1Skj9kjw1gFdZMj7nxPgTFLvO42ajDMdeGxbeI7c+bRxq82AXzn8wdJw
	T7swugy89Q+JLcQeQVjQokpwNXzgfjLBvd1A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1v5hdV-0000000EV8A-0Ltv;
	Mon, 06 Oct 2025 11:36:05 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-um@lists.infradead.org,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>
Subject: [GIT PULL] uml 6.18-rc1
Date: Mon,  6 Oct 2025 11:34:50 +0200
Message-ID: <20251006093601.33082-3-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251006_023612_191047_770922C0 
X-CRM114-Status: GOOD (  10.47  )
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

Hi Linus,

UML doesn't have a lot of changes this time around, as you
can see in the diffstat and tag message below. I tested a
merged and booted it, there should be no conflicts.

Please pull and let us know if there's any problem.

Thanks,
johannes



The following changes since commit 76eeb9b8de9880ca38696b2fb56ac45ac0a25c6c:

  Linux 6.17-rc5 (2025-09-07 14:22:57 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git tags/uml-for-linux-6.18-rc1

for you to fetch changes up to e66ae377fe219c98d3d5b8a0d35da4413a5390ca:

  um: Remove unused ipi_pipe field from cpuinfo_um (2025-09-10 14:23:58 +0200)

----------------------------------------------------------------
updates for UML, notably
 - minor preparations for SMP support
 - SPARSE_IRQ support for kunit
 - help output cleanups

----------------------------------------------------------------
Johannes Berg (1):
      um: virtio-pci: implement .shutdown()

Sinan Nalkaya (1):
      um: Support SPARSE_IRQ

Tiwei Bie (10):
      um: Add missing trailing newline to help messages
      um: vector: Fix indentation for help message
      um: Fix help message for ssl-non-raw
      um: Indent time-travel help messages
      um: Remove unused offset and child_err fields from stub_data
      um: Remove outdated comment about STUB_DATA_PAGES
      um: Centralize stub size calculations
      um: Stop tracking virtual CPUs via mm_cpumask()
      um: Remove unused cpu_data and current_cpu_data macros
      um: Remove unused ipi_pipe field from cpuinfo_um

 arch/um/Kconfig                         |  1 +
 arch/um/drivers/ssl.c                   |  5 ++++-
 arch/um/drivers/ubd_kern.c              |  2 +-
 arch/um/drivers/vector_kern.c           |  2 +-
 arch/um/drivers/virtio_pcidev.c         |  6 ++++++
 arch/um/include/asm/mmu_context.h       | 11 ----------
 arch/um/include/asm/processor-generic.h |  3 ---
 arch/um/include/shared/as-layout.h      |  5 +++--
 arch/um/include/shared/skas/stub-data.h |  3 +--
 arch/um/kernel/dtb.c                    |  2 +-
 arch/um/kernel/irq.c                    |  5 +++++
 arch/um/kernel/time.c                   | 37 +++++++++++++++++----------------
 arch/um/kernel/um_arch.c                |  7 +------
 arch/um/os-Linux/skas/process.c         |  2 +-
 arch/x86/um/shared/sysdep/stub_32.h     |  2 +-
 arch/x86/um/shared/sysdep/stub_64.h     |  2 +-
 16 files changed, 46 insertions(+), 49 deletions(-)

