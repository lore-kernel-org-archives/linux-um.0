Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A63C3C46CA1
	for <linux-um@archiver.kernel.org>; Mon, 18 Sep 2023 17:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:Cc:From
	:To:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=4xpyOjfy7LOaB0/f8enqFgIp0XvH6tjWNFXl7IQXSF4=; b=Am6rdp9PcpdqaA
	BvIOmWL8wc7GEV2TiQJfkUX/l3+REpdqaoxnat29V2qkC1smm/o6CU8m+RcRU7vpKb62r8V7dMeDH
	HqkUhDAnaDKrogeMB8RlhTb+edU6mYXigjuYwVkZJKZh84KTS+A9X5gb8wqT9f0dAGjQQw2P8WcD4
	uc97ARJnxSdyfrTbwN2A0iwd/H/H6RfqJlZJYvs6T8ocbyXPH0gAocAjRyBom+VayletTN2/st+U/
	Q4EbK+Xz/lMwr8tV6anVuwzYqSNeQwMcxIXMyRTRbudhUWjwYnkDrgRzLK1UsEJ+FlgipnnCNK2iP
	OZV8IFlE7EwciWEc+Kqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qiIU2-00G1FI-0n;
	Mon, 18 Sep 2023 17:56:30 +0000
Received: from mail-4323.proton.ch ([185.70.43.23])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qiITw-00G1EG-1x
	for linux-um@lists.infradead.org;
	Mon, 18 Sep 2023 17:56:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=n8pjl.ca;
	s=protonmail2; t=1695059779; x=1695318979;
	bh=KDmGL0149HMvYz0D68P8rK9iJncYI66ZFd51OEaftAc=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=XDyAGqfxs1IhZyrSbs3kXmWVIDtAAGsbXg/jRzsX7fuS5Oxw4QNBzYWsvFGPZ+ksw
	 S5Zcze4DfsU+j4F71vMZOBVGe3BZKYabMh1wfnbZ2ABquD3iq/MryJ0VB04GGHqRW3
	 gnQBHdLwQI3E7N3+pV5UgFQGhEjTazGFHroCb4KlhwP9A18gG508T7Pqs5jbffIgxO
	 cUkXsv81IXGY6O6u6TWRNYFNwN9rAhwcn1b7zAnxuUbHTSaeD2idJu0SKxFygNCYtF
	 S9e7CJc5qlz+kEo5lV3WyEyT1tOTgZkgAyKcyZB3b18aHv/xFJwzM9+FJT8sFeXCTe
	 SfZ1idLrRGTVw==
Date: Mon, 18 Sep 2023 17:56:09 +0000
To: reiserfs-devel@vger.kernel.org
From: Peter Lafreniere <peter@n8pjl.ca>
Cc: Peter Lafreniere <peter@n8pjl.ca>, jack@suse.cz, linux-kernel@vger.kernel.org, richard@nod.at, anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net, linuxppc-dev@lists.ozlabs.org, linux-um@lists.infradead.org, linux-sh@vger.kernel.org, tsbogend@alpha.franken.de, linux-mips@vger.kernel.org, linux-m68k@lists.linux-m68k.org, geert@linux-m68k.org, linux-arm-kernel@lists.infradead.org, linux@armlinux.org.uk, linux-alpha@vger.kernel.org, richard.henderson@linaro.org, ink@jurassic.park.msu.ru
Subject: [PATCH 0/7] arch/*: config: Remove ReiserFS from defconfig
Message-ID: <20230918175529.19011-1-peter@n8pjl.ca>
Feedback-ID: 53133685:user:proton
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230918_105626_076479_F8C18564 
X-CRM114-Status: UNSURE (   4.66  )
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

ReiserFS has been considered deprecated for 19 months since commit
eb103a51640e ("reiserfs: Deprecate reiserfs"). However, there are
several architectures that still build it into their defconfig kernels.

As ReiserFS will be removed in 2025, delete all ReiserFS-related options
from defconfig files before the filesystem's removal.

The series is intended to be approved/rejected on an arch-by-arch basis.
No patch is dependant upon another in the series.

See discussion originating in,
Link: https://lore.kernel.org/linux-um/20230918125744.4342-1-peter@n8pjl.ca/

Peter Lafreniere (7):
  arch: um: remove ReiserFS from defconfig
  arch: powerpc: remove ReiserFS from defconfig
  arch: sh: remove ReiserFS from defconfig
  arch: mips: remove ReiserFS from defconfig
  arch: m68k: remove ReiserFS from defconfig
  arch: arm: remove ReiserFS from defconfig
  arch: alpha: remove ReiserFS from defconfig

 arch/alpha/configs/defconfig                | 1 -
 arch/arm/configs/pxa_defconfig              | 4 ----
 arch/m68k/configs/amiga_defconfig           | 1 -
 arch/m68k/configs/apollo_defconfig          | 1 -
 arch/m68k/configs/atari_defconfig           | 1 -
 arch/m68k/configs/bvme6000_defconfig        | 1 -
 arch/m68k/configs/hp300_defconfig           | 1 -
 arch/m68k/configs/mac_defconfig             | 1 -
 arch/m68k/configs/multi_defconfig           | 1 -
 arch/m68k/configs/mvme147_defconfig         | 1 -
 arch/m68k/configs/mvme16x_defconfig         | 1 -
 arch/m68k/configs/q40_defconfig             | 1 -
 arch/m68k/configs/sun3_defconfig            | 1 -
 arch/m68k/configs/sun3x_defconfig           | 1 -
 arch/mips/configs/fuloong2e_defconfig       | 1 -
 arch/mips/configs/jazz_defconfig            | 4 ----
 arch/mips/configs/lemote2f_defconfig        | 3 ---
 arch/mips/configs/malta_defconfig           | 5 -----
 arch/mips/configs/malta_kvm_defconfig       | 5 -----
 arch/mips/configs/maltaup_xpa_defconfig     | 5 -----
 arch/mips/configs/rm200_defconfig           | 4 ----
 arch/powerpc/configs/44x/sam440ep_defconfig | 1 -
 arch/powerpc/configs/g5_defconfig           | 4 ----
 arch/powerpc/configs/ppc64e_defconfig       | 4 ----
 arch/powerpc/configs/ppc6xx_defconfig       | 5 -----
 arch/sh/configs/landisk_defconfig           | 1 -
 arch/sh/configs/titan_defconfig             | 1 -
 arch/um/configs/i386_defconfig              | 1 -
 arch/um/configs/x86_64_defconfig            | 1 -
 29 files changed, 62 deletions(-)

-- 
2.42.0



_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
