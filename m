Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33802CDE010
	for <linux-um@archiver.kernel.org>; Fri, 26 Jun 2026 04:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=EThdRu/11wp6N0JSfRIxy1kA6W323gFL4ICwbKnuv1w=; b=J04JLF/BiiXk+UqheOWMq9vmN6
	2zpjuFaKNq3bH5XvRJoe7tqOPW69/ei+FRAlOkSq5ET96Hkdtaa0W6RaK8tqRyuszeuAsUaTQ/1y0
	e5hattqmz/dyjaBCuyp/frPBIouNLY7v6lTEJEz2PwqtkkPO+pgo4x0o6s3llc9jfE0kPjYUYZtKw
	obGzvHHf3g1ljj8MgwWAF3RN2QfUl/QpisCfQY+NDWAgYNhg4o4KAkeDggD6cTj7zvSHsQ3SgQMx2
	T0d+a/QWDN2bmcdR5w72puJv8faGpI0Q9MTcnPMSTTFeiJLzyOd0b1L9G9odEYr0if/gLJMWbJoDk
	AyqgbHfg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcyLf-0000000ATYF-0FZe;
	Fri, 26 Jun 2026 04:39:27 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcyLd-0000000ATXZ-0vUZ
	for linux-um@lists.infradead.org;
	Fri, 26 Jun 2026 04:39:25 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 3F29D60098;
	Fri, 26 Jun 2026 04:39:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4AA91F000E9;
	Fri, 26 Jun 2026 04:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782448764;
	bh=EThdRu/11wp6N0JSfRIxy1kA6W323gFL4ICwbKnuv1w=;
	h=From:To:Cc:Subject:Date;
	b=ij6vpCDhyTlRwiqupSK0EHeAXKevHJCyIHbjmW2s/O85CCp68rYWWunAGtELDSHzF
	 tuw7kMRdbe5vx/ULc8iV7pybd4jEEPz/BTc/5b1rEXDNzrisDikUTO+2n9KeN1fjxY
	 vb9lJbaDgvQGbn9hlJ02dZ7FiL95jp5wGu+kl+MKL5QkGNUv+K4hve8OEGtNtNXTAo
	 X8VNIRH//W5F0MnZQSigvXDTODiV/rTsZqwOSM/nKjOIO8lwkRfNQgpeT8lmghCYqy
	 074dsVHwlftgIusGkl0Oaqm8eAzif6n6YIif2LUYi+sm8Zt6/KAJboYJU2dxkvyk8a
	 Ao8VCKNR4Sgjg==
From: Eric Biggers <ebiggers@kernel.org>
To: x86@kernel.org
Cc: linux-um@lists.infradead.org,
	linux-raid@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 0/8] x86: Remove cpu_has_xfeatures() and add AVX-512 xor_gen()
Date: Thu, 25 Jun 2026 21:37:23 -0700
Message-ID: <20260626043731.319287-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.54.0
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

My patch "lib/raid/xor: x86: Add AVX-512 optimized xor_gen()"
(https://lore.kernel.org/r/20260615190338.26581-1-ebiggers@kernel.org/)
still seems to be blocked on a Sashiko comment about cpu_has_xfeatures()
not being called.

However, the x86-optimized RAID library code supports UML, and currently
UML doesn't implement cpu_has_xfeatures().  That's perhaps why the
existing AVX-512 optimized RAID6 code doesn't check it either.

In fact, it seems to have been getting by fine without it, which
suggests that it's not truly needed.

But to eliminate any doubts, I've had a go at fully resolving the
situation by making both native x86 and UML explicitly clear any
X86_FEATURE_* flags at boot time whose xfeatures are missing.

Then, cpu_has_xfeatures() is entirely removed from the kernel.

The last patch adds the AVX-512 optimized xor_gen().  I do still think
it would be fine to proceed with it without the rest.  But if there are
any doubts, we can take this more comprehensive cleanup route.

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
 arch/x86/kernel/fpu/xstate.c               |  63 ++++-------
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
 lib/raid/xor/x86/xor_arch.h                |  24 ++--
 29 files changed, 264 insertions(+), 194 deletions(-)
 create mode 100644 lib/raid/xor/x86/xor-avx512.c


base-commit: 4edcdefd4083ae04b1a5656f4be6cd83ae919ef4
-- 
2.54.0


