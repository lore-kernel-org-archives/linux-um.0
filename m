Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB4A8C531D0
	for <linux-um@archiver.kernel.org>; Tue, 28 Jul 2026 02:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=3GT4DkuXPLrNuHBtj16uB1HtM7QTZwonA+LlCLJaorI=; b=QtQD65ciogYZEqDmwP2yBpamfJ
	fQHl3R05La8WiVxt/NHRwBEzsDeebzN/bI8CB8k4yLfYhqkNbp29TyhDZ2KJjItEOkSjeBIjJqzpD
	phcPjoXBKy63lhz++37xkMGLH1NSKcvIwjuboedO3AMCOWj67wuPp01oiNiG6l75XPDWRbdTokBWj
	T3SdVed6VcrKxHKDB2zv3kc/g54xVAdpBrxUOQoqkCtGEdck6Dl/tcEZSOykc1pLCygY3LD+N+A+G
	DhVhOH9gETkD281EXLwb9krR8hqCrs265E0LH83C+hGSHMT3TcGKQyakI3HAsF0uE0aaQje7mf2HG
	qoRh0hcw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woXPa-00000004Fdm-1Nez;
	Tue, 28 Jul 2026 02:19:18 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woXPZ-00000004FdJ-19pK
	for linux-um@lists.infradead.org;
	Tue, 28 Jul 2026 02:19:17 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id AFDFF43B45;
	Tue, 28 Jul 2026 02:19:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E1331F000E9;
	Tue, 28 Jul 2026 02:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785205156;
	bh=3GT4DkuXPLrNuHBtj16uB1HtM7QTZwonA+LlCLJaorI=;
	h=From:To:Cc:Subject:Date;
	b=c8TOFlLlA45pS17ZPF7tHUHXPBvFoBoL0bXs1CuDyAPgKS+zZTIS0CwgmJgkr6s1s
	 X3y3D1dzNqLjYEvGkRH7P4ejs4Qfrl+WYtt3N+W9ZBi7GqimpBT6JqfhWkWPA/5K6W
	 GvBwbYOh87HPlIQaTAylCZcA5HsXA8KgCRYioCGbG7wqIY/Jr+aqPXE8vlL6j416fB
	 PgRRW0prjr0DcVwfZ0yEEx8WolrNAnxdNiVMBpogwjasaJZJWTDE1Mkyn7ZHcTgUCP
	 v7zpzPQVPwLBD6Wu0npbGDXLrou6DbPDWNbauOQQEya49tQvbst17QDtF4AciWCCdw
	 4Jd8v0pduC7dw==
From: Eric Biggers <ebiggers@kernel.org>
To: x86@kernel.org
Cc: linux-um@lists.infradead.org,
	linux-raid@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH v2 0/8] x86: Remove cpu_has_xfeatures() and add AVX-512 xor_gen()
Date: Mon, 27 Jul 2026 19:15:55 -0700
Message-ID: <20260728021603.79870-1-ebiggers@kernel.org>
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
  lib/raid/xor: x86: Remove redundant X86_FEATURE_OSXSAVE check
  lib/raid/xor: x86: Add AVX-512 optimized xor_gen()

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
 arch/x86/kernel/fpu/xstate.c               |  65 ++++-------
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
 lib/raid/xor/x86/xor-avx512.c              | 121 +++++++++++++++++++++
 lib/raid/xor/x86/xor_arch.h                |  31 ++++--
 29 files changed, 273 insertions(+), 194 deletions(-)
 create mode 100644 lib/raid/xor/x86/xor-avx512.c


base-commit: f5098b6bae761e346ebcd9da7f95622c04733cff
-- 
2.55.0


