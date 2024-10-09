Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66A18CEDD88
	for <linux-um@archiver.kernel.org>; Wed,  9 Oct 2024 12:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=kWHm4EzhmcRIg2+TkegJgMDV+hPGEBlUxndw3Jlx9rs=; b=qS2RhK/me6E6ivVlHgmve1tYiA
	eRke4Fn9Roxio+cYi0pqUE6KRfoA2mtU6iYBhpx1U8X7VDuqbSPdjCRHev7rfU+WutAQbXwpD0hAX
	4Z7HYMgLXeFUOoIwerN0RjKkrw0Gm7urExuI7NxY6d68Xu5+meDeEbOsi7W2WTZatBNwMpUgUX/Cu
	9Fm2PUUyoIiMwWdtievnVbu6X+0ogxqkhACFvRcubBARVPIBKhDD8IVSuqZgOAGi7D28582T2rcLG
	YJoGJZvUJJWNuxBXY0zh7aNsT8BcLd9aTpCNWMpGHF4nyte+4S24p0zrgO7A8cbcWjYukqsq3oRRI
	n+dR0KRg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1syVMf-0000000993z-25tO;
	Wed, 09 Oct 2024 12:00:25 +0000
Received: from 2a02-8389-2341-5b80-164d-fdb4-bac5-9f5e.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:164d:fdb4:bac5:9f5e] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1syV6O-000000095ov-1DQp;
	Wed, 09 Oct 2024 11:43:36 +0000
From: Christoph Hellwig <hch@lst.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-arch@vger.kernel.org
Subject: provide generic page_to_phys and phys_to_page implementations
Date: Wed,  9 Oct 2024 13:43:21 +0200
Message-ID: <20241009114334.558004-1-hch@lst.de>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

page_to_phys is duplicated by all architectures, and from some strange
reason placed in <asm/io.h> where it doesn't fit at all.  

phys_to_page is only provided by a few architectures despite having a lot 
of open coded users.

Provide generic versions in <asm-generic/memory_model.h> to make these
helpers more easily usable.

Diffstat:
 arch/alpha/include/asm/io.h         |    1 -
 arch/arc/include/asm/io.h           |    3 ---
 arch/arm/include/asm/memory.h       |    6 ------
 arch/arm64/include/asm/memory.h     |    6 ------
 arch/csky/include/asm/page.h        |    3 ---
 arch/hexagon/include/asm/page.h     |    6 ------
 arch/loongarch/include/asm/page.h   |    3 ---
 arch/m68k/include/asm/virtconvert.h |    3 ---
 arch/microblaze/include/asm/page.h  |    1 -
 arch/mips/include/asm/io.h          |    5 -----
 arch/nios2/include/asm/io.h         |    3 ---
 arch/openrisc/include/asm/page.h    |    2 --
 arch/parisc/include/asm/page.h      |    1 -
 arch/powerpc/include/asm/io.h       |   12 ------------
 arch/riscv/include/asm/page.h       |    3 ---
 arch/s390/include/asm/page.h        |    2 --
 arch/sh/include/asm/page.h          |    1 -
 arch/sparc/include/asm/page.h       |    2 --
 arch/um/include/asm/pgtable.h       |    2 --
 arch/x86/include/asm/io.h           |    5 -----
 arch/xtensa/include/asm/page.h      |    1 -
 include/asm-generic/memory_model.h  |    3 +++
 22 files changed, 3 insertions(+), 71 deletions(-)

