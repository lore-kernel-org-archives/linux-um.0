Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B70CC5DF66
	for <linux-um@archiver.kernel.org>; Thu, 13 Aug 2026 02:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=/zNmD9B/x2+gqm/TQnDXsoFe7SLMMlZBmFWol8zSk7o=; b=W5MRWvO4YJo0uXv5eWDJ9TF8/J
	CCAB+FS0DgqIuNVuCbmbHU5xj5zP8WrIDIHaDANr5doNlufWtbiM9zOGI3uUniw8NuoASI+VOhE3J
	j7M+8oN/NyNYp/uSf54kLe+e1Q89/P0B/CwnvqnBuEU/LvQrUyDliJEW81ICta7HzuV/gpDd1KR1z
	uUANEg/KRzpUE2Yj1vSRb+DXPUcE+AKp1GerNJAPGldAF+WKyGbRcKXqbX0ZykKTIlujQO5d5YScM
	fzqt8nvGwiQCPAQOrDK707o3U/Ma7ptURi0sSFQHFzU8TEhP/e/AprHYJRwEh5+UgW85NFM5n8wZY
	/N4ObQRg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuL3M-0000000HGuL-28lx;
	Thu, 13 Aug 2026 02:20:20 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuL3L-0000000HGu2-2d0D
	for linux-um@lists.infradead.org;
	Thu, 13 Aug 2026 02:20:19 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id E65F441890;
	Thu, 13 Aug 2026 02:20:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C0B81F000E9;
	Thu, 13 Aug 2026 02:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786587618;
	bh=/zNmD9B/x2+gqm/TQnDXsoFe7SLMMlZBmFWol8zSk7o=;
	h=From:To:Cc:Subject:Date;
	b=ejmlk6Sv3jcbV5bE+4pHEkNBfN9RU954ynU40fQc0I1vrwz3rz4GfmUVYsi/d2skM
	 FjOfiSbcBvd2V7PfIuudRruKDpobVFrZMH4omgOCUguaiMgbPHlFAvGAPGhcCQblhV
	 oI9g/xOtB/Kh2ue0/nxqHvP3pHDTRP4QOledcVy526zmUEDASzeawMGRjC4rt8L2Iz
	 YEvhdItLR2UB/2DqxQY639BOly62lAUfJlgnNxjr9MP+rwZkQmOZJTBnMqjjYn3IHL
	 c8bF/Wf58YSXpqSLgRv5VWfjwJJF4CAMihf99Mk5OuQXbVwho1J87BWpzDLBXUkwPZ
	 pW77YIDeL3OAw==
From: Eric Biggers <ebiggers@kernel.org>
To: x86@kernel.org
Cc: linux-um@lists.infradead.org,
	linux-raid@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH v3 0/8] x86: Remove cpu_has_xfeatures() and add AVX-512 xor_gen()
Date: Wed, 12 Aug 2026 19:14:58 -0700
Message-ID: <20260813021506.55129-1-ebiggers@kernel.org>
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
 lib/raid/xor/x86/xor-avx512.c              | 121 +++++++++++++++++++++
 lib/raid/xor/x86/xor_arch.h                |  31 ++++--
 29 files changed, 275 insertions(+), 196 deletions(-)
 create mode 100644 lib/raid/xor/x86/xor-avx512.c


base-commit: db2ddb87143519e20a95aa36c60b36107b736a58
-- 
2.55.0


