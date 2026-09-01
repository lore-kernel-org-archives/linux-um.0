Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 100E7C624D3
	for <linux-um@archiver.kernel.org>; Tue,  1 Sep 2026 14:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=iUpjiTv1KRvFABoYYph8lVPGE+bZqchdutvEQG6SYQI=; b=ViqAjG1K2/fXurnPl2Kaq57UjX
	E0lHcXAfjahQ+Xz/wq72C+Uq+2vxPNVWTPRpr74yDg7rl0u0vhUjooDZUQqK6/detFIBu5nRY6Zt6
	CwqM/8uNjdb+GndTKjn1X6UtJlc2w60S2BD0KUC9lziYs7f/+FLY4LNy81QvzHNu3GRuZG0yoj5W1
	2yorV5/GkQGl4k3g6vhUmigJcTcq40sO7KXo4uqqZpVe6m2pf1A/+Z2i3gjolhTYEB/pnYU6T7Xqn
	18B9qq61rCDhgfV4Tnmk+ucOb4EneaKTJtxaUii/PRFFNU9DbugBz4hVnTpH60sNeWKpmBlBD24PL
	7q7u60xg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1PwE-0000000COUb-1hIZ;
	Tue, 01 Sep 2026 14:58:14 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1PwD-0000000COU7-2cUy
	for linux-um@lists.infradead.org;
	Tue, 01 Sep 2026 14:58:13 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id BA2CD6013A;
	Tue,  1 Sep 2026 14:58:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3573A1F000E9;
	Tue,  1 Sep 2026 14:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788274692;
	bh=iUpjiTv1KRvFABoYYph8lVPGE+bZqchdutvEQG6SYQI=;
	h=From:To:Cc:Subject:Date;
	b=hSmZEpipj6ibJ/5DHn71+dcqM3a8A0IRF+6SKnv018OiWNgwKD6W6tTBe/4ljcULg
	 dLoEAdMBZgUJPLm/f9deS/q4OirmzNLs0IlmRHjRgE7MTNhMQFbyZEz7mp1gJMqs2V
	 IyKJVxwWwMgbnXNLLQOEb3zXGB+omA6fos0RdiczaNc1di9yOPE/iZmc1NkicK3/Rf
	 aekc8fEDWh0e8iusb1w5e88WMt5jLecI1HUkP00GCsq/LMSYFcdcLYE2gdv8S8FCYv
	 sToypstdm6rsI2Jt9K09+tSTD//r1pyD7jiM2KTuZWsm3ZjuFKKD6RbmS/9TFP6YLa
	 UXU//mxVpX1hw==
From: Eric Biggers <ebiggers@kernel.org>
To: x86@kernel.org
Cc: linux-um@lists.infradead.org,
	linux-raid@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH v5 0/8] x86: Remove cpu_has_xfeatures() and add AVX-512 xor_gen()
Date: Tue,  1 Sep 2026 07:57:32 -0700
Message-ID: <20260901145740.42337-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.55.0
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

This series consolidates and cleans up how the kernel handles CPU
feature flags for AVX and AVX-512 when the underlying OS or hypervisor
(if any) doesn't enable the required xstate features in XCR0.

Specifically, it makes the checks for xstate features be done in a
single place at boot time for both UML and native x86, instead of
everywhere kernel code wants to check for AVX or AVX-512 support.

Patch 8 then adds an AVX-512 optimized implementation of xor_gen() for
RAID, which had been blocked on confusion around cpu_has_xfeatures() and
its lack of implementation on UML.

Please consider this series for the x86 tree for 7.4.

Changed in v5:
  - Replaced benchmark results with the new xor_benchmark
  - Consolidated the vzeroupper in xor-avx512.c into one location

Changed in v4:
  - Added missing vzeroupper instructions in xor-avx512.c

Changed in v3:
  - Updated the implementation of fpu__init_system_xstate() as suggested
    by Borislav
  - Added Acked-by tags
  - Used "xor:" commit subject

Changed in v2:
  - Made x86 clear the AVX* bits if FPU or XSAVE features are missing.
  - Updated comment in x86 arch_xor_init().
  - Updated commit message for the UML commit to clarify that checking
    XCR0 is standard practice in userspace


Eric Biggers (8):
  x86/fpu: Check for missing AVX and AVX-512 xstate bits
  um: Check for missing AVX and AVX-512 xstate bits
  crypto: x86 - Stop using cpu_has_xfeatures()
  lib/crypto: x86: Stop using cpu_has_xfeatures()
  lib/crc: x86: Stop using cpu_has_xfeatures()
  x86/fpu: Remove cpu_has_xfeatures()
  xor: Remove redundant X86_FEATURE_OSXSAVE check
  xor: Add AVX-512 optimized xor_gen()

 arch/um/kernel/um_arch.c                   |  78 ++++++++++++-
 arch/x86/crypto/aegis128-aesni-glue.c      |   3 +-
 arch/x86/crypto/aesni-intel_glue.c         |   7 +-
 arch/x86/crypto/aria_aesni_avx2_glue.c     |  11 +-
 arch/x86/crypto/aria_aesni_avx_glue.c      |  11 +-
 arch/x86/crypto/aria_gfni_avx512_glue.c    |  11 +-
 arch/x86/crypto/camellia_aesni_avx2_glue.c |  11 +-
 arch/x86/crypto/camellia_aesni_avx_glue.c  |  11 +-
 arch/x86/crypto/cast5_avx_glue.c           |   7 +-
 arch/x86/crypto/cast6_avx_glue.c           |   7 +-
 arch/x86/crypto/serpent_avx2_glue.c        |   9 +-
 arch/x86/crypto/serpent_avx_glue.c         |   7 +-
 arch/x86/crypto/sm4_aesni_avx2_glue.c      |  11 +-
 arch/x86/crypto/sm4_aesni_avx_glue.c       |  11 +-
 arch/x86/crypto/twofish_avx_glue.c         |   6 +-
 arch/x86/include/asm/fpu/api.h             |   9 --
 arch/x86/kernel/fpu/xstate.c               |  69 +++++-------
 lib/crc/x86/crc-pclmul-template.h          |   6 +-
 lib/crypto/x86/blake2s.h                   |   4 +-
 lib/crypto/x86/chacha.h                    |   3 +-
 lib/crypto/x86/nh.h                        |   4 +-
 lib/crypto/x86/poly1305.h                  |   7 +-
 lib/crypto/x86/sha1.h                      |   4 +-
 lib/crypto/x86/sha256.h                    |   4 +-
 lib/crypto/x86/sha512.h                    |   3 +-
 lib/crypto/x86/sm3.h                       |   3 +-
 lib/raid/xor/Makefile                      |   2 +-
 lib/raid/xor/x86/xor-avx512.c              | 122 +++++++++++++++++++++
 lib/raid/xor/x86/xor_arch.h                |  31 ++++--
 29 files changed, 276 insertions(+), 196 deletions(-)
 create mode 100644 lib/raid/xor/x86/xor-avx512.c


base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
-- 
2.55.0


