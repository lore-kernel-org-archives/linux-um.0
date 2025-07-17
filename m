Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0742EC83F34
	for <linux-um@archiver.kernel.org>; Thu, 17 Jul 2025 15:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=S1+MAZvM+N/4+avawJ7fodWecsPBgKeK+9BQEGE2Ung=; b=qAnxaUD4Aj/eCMsZsByREuBMCx
	d6kBGQVjH4dVkt6eSJDISLt/seHZRDp+cznlPedhwcM3nGqhAIX9iF+Pdp9zaa8qYGkSw1ww4UwKg
	I6URsvScOEDNyM5YjbQ2rEYRSHjkTelh+NqNG2TqPnMX8jeMRa9NRlLL9Xty2SF6g92wLKJGK50kw
	SJ53GnG97+16GYs2O3r5kj5jFWrywbEIAbOVHu65JWmaYm1C5yVK4pDr8LgOOMpGZQEN7nIixpyMb
	vl0v0Lq0E9n5Q8CN1wKxHSIq2aa9PFFFmejBUR34E7+WqQ1QK7y7ubRI6cbhUSIXuP7+TLEFUafwP
	LtbP8aiQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ucQ8x-0000000AS72-09Gx;
	Thu, 17 Jul 2025 15:03:31 +0000
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ucPaJ-0000000AMuw-23oA;
	Thu, 17 Jul 2025 14:27:44 +0000
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-55a2604ebc1so1000054e87.0;
        Thu, 17 Jul 2025 07:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752762461; x=1753367261; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S1+MAZvM+N/4+avawJ7fodWecsPBgKeK+9BQEGE2Ung=;
        b=O8Cp9TwQYDFuC1yfe3F/4fGm93Lm49NZ9moXciRo71ipO77fxtm2O/xZVBKs+SRdI4
         h5p+Fw2otKRUBtHrAtaWBN/Hsyy0Ta65mMTMmx29wdTv1SNxY3lteXLQKiecM7ibgS6v
         leu+twS3BmMoYTaDCYMl4wybzTv0iQdeuBjbxlkJNo60RTP00+O0EIrlfWnpURout6k7
         nFgANoFj9IPzKWyqb8AcpA1XK1yOwDTHZwYYVFxPqgG6YKv6a8D/VwPKhALgnEs5YXqH
         YZpXU0tNNYZNoqrr8atjuRM4JaiEEXMfPUjlYImI0MlQarANoitFixCzf3TrZp1Mg8SU
         4VPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752762461; x=1753367261;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S1+MAZvM+N/4+avawJ7fodWecsPBgKeK+9BQEGE2Ung=;
        b=lzSS2jE7dmI8i3qZaAz+i9nasfrYrBsXhkRmdBu/PlqRdSaCa/hu6Nfxasdm04Avw6
         3ghKHlZkB59mbzo5tdqftxGvgQ1nG/KzIz2quGa5Yq9gDBcruU+ydB9o0kEoEo/eZhqF
         tuaz5UgMeZd86hSIIKAYVMwykIUryY/FNd7nZZwcMzUv39RqplR6foWN5oGXMF774eio
         TOFxhXmKD2hpe1UOP7kPzSBk80Eul5GHsv2sakXLliNWFCuke/2oSdxuvyrUTGafTeYV
         ++yvuV3Aju9VbR+rNtyYYSGjGUWBiYLCf0inColcwDufskxr5HcFkwLUTL5iQYAc4Vuw
         UlgA==
X-Forwarded-Encrypted: i=1; AJvYcCU/lGA5TPMy6pB+SaN6B/NL7LQxg6jWbpvM27pDvYWh/5aMSLz1MnrljVu8S8ieKYGs+PeU3lj/5CA=@lists.infradead.org, AJvYcCUZKKi6gbTnJdVaqcJIlMkaq1B0eLXiiiYX0O8ehQXJogyx6h1GjoSguSPr/yKfn/Bu1oc4MMaa+nmwoQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YxVTLLZ21we+3vA+8W6UFW/PXeUnoQKmUnFcQSnYmGag8UclEt+
	ko5mXEs0I+wYjBJQhq0jeRb2EyMIdpMxL3pJ63MzXpxnLNhUhn2JwFcm5VdBHafgXg0=
X-Gm-Gg: ASbGncuby3PJfWsjk3PV2iReydIZz1Nyx2/Uil1RakBUXlmHXSArmMtiQVIbXBkU581
	N7gM9wy2XpIRZ4Axo9CyRvIxHrPab75j1VaRs0LDzIGPbnEuQZSOInd5N5KdbYVNfNxXA0tq1Ie
	NADlietvldWhODSizis9LYhMNeas1VZHx5C8R9EQyD8dtbj5mkhu3CU0Mq408vVSD6nDeX2hAcQ
	RHNYm33lSBfrO7/FKziGWlxICJADOb1+ORlmagfYuZxM2TvjD6g4WaE9m96W3wvb14zN8eVr3e1
	M5O1AixQO05X7bKgGL/H4AlKwc+NW9Ft5Vz0EEbK+IMiGNTI/5XkMxMXI9aHRr/ccp4uPGn/rYm
	VxzxtEuF2mM/5Nju5XOJ2fJAeT7d52L5w8cMrXS+5ixWyg/2VAUQ/3o/MnxSaiU8oaM+C
X-Google-Smtp-Source: AGHT+IHqw++1wkJOZK6ynl4Q5tnH7hMmNdvDCLMPwyvX9yJ+k47Bz9P2wFC8+PCgt0lXOF+TLWoP4g==
X-Received: by 2002:a05:6512:b17:b0:553:ad81:4de1 with SMTP id 2adb3069b0e04-55a23f2d227mr2243765e87.24.1752762460660;
        Thu, 17 Jul 2025 07:27:40 -0700 (PDT)
Received: from localhost.localdomain (178.90.89.143.dynamic.telecom.kz. [178.90.89.143])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55989825fe3sm3022975e87.223.2025.07.17.07.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 07:27:39 -0700 (PDT)
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
To: hca@linux.ibm.com,
	christophe.leroy@csgroup.eu,
	andreyknvl@gmail.com,
	agordeev@linux.ibm.com,
	akpm@linux-foundation.org
Cc: ryabinin.a.a@gmail.com,
	glider@google.com,
	dvyukov@google.com,
	kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-mm@kvack.org,
	snovitoll@gmail.com
Subject: [PATCH v3 00/12] kasan: unify kasan_arch_is_ready() and remove arch-specific implementations
Date: Thu, 17 Jul 2025 19:27:20 +0500
Message-Id: <20250717142732.292822-1-snovitoll@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250717_072743_533891_9BC039E6 
X-CRM114-Status: GOOD (  13.29  )
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

This patch series addresses the fragmentation in KASAN initialization
across architectures by introducing a unified approach that eliminates
duplicate static keys and arch-specific kasan_arch_is_ready()
implementations.

The core issue is that different architectures have inconsistent approaches
to KASAN readiness tracking:
- PowerPC, LoongArch, and um arch, each implement own kasan_arch_is_ready()
- Only HW_TAGS mode had a unified static key (kasan_flag_enabled)
- Generic and SW_TAGS modes relied on arch-specific solutions
  or always-on behavior

This series implements two-level approach:
1. kasan_enabled() - compile-time check for KASAN configuration
2. kasan_shadow_initialized() - runtime check for shadow memory readiness

Key improvements:
- Unified static key infrastructure across all KASAN modes
- Runtime overhead only for architectures that actually need it
- Compile-time optimization for arch. with early KASAN initialization
- Complete elimination of arch-specific kasan_arch_is_ready()
- Consistent interface and reduced code duplication

Previous v2 thread: https://lore.kernel.org/all/20250626153147.145312-1-snovitoll@gmail.com/

Changes in v3 (sorry for the 3-week gap):

0. Included in TO, CC only KASAN devs and people who commented in v2.

1. Addressed Andrey Konovalov's feedback:
   - Kept separate kasan_enabled() and kasan_shadow_initialized() functions
   - Added proper __wrapper functions with clean separation

2. Addressed Christophe Leroy's performance comments:
   - CONFIG_ARCH_DEFER_KASAN is only selected by architectures that need it
   - No static key overhead for architectures that can enable KASAN early
   - PowerPC 32-bit and book3e get compile-time optimization

3. Addressed Heiko Carstens and Alexander Gordeev s390 comments:
   - s390 doesn't select ARCH_DEFER_KASAN (no unnecessary static key overhead)
   - kasan_enable() is a no-op for architectures with early KASAN setup

4. Improved wrapper architecture:
   - All existing wrapper functions in include/linux/kasan.h now check both
     kasan_enabled() && kasan_shadow_initialized()
   - Internal implementation functions focus purely on core functionality
   - Shadow readiness logic is centralized in headers per Andrey's guidance

Architecture-specific changes:
- PowerPC radix MMU: selects ARCH_DEFER_KASAN for runtime control
- LoongArch: selects ARCH_DEFER_KASAN, removes custom kasan_early_stage
- um: selects ARCH_DEFER_KASAN, removes kasan_um_is_ready
- Other architectures: get compile-time optimization, no runtime overhead

The series maintains full backward compatibility while providing optimal
performance for each architecture's needs.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217049

=== Current mainline KUnit status

To see if there is any regression, I've tested via compiling a kernel
with CONFIG_KASAN_KUNIT_TEST and running QEMU VM. There are failing tests
in SW_TAGS and GENERIC modes in arm64:

arm64 CONFIG_KASAN_HW_TAGS:
	# kasan: pass:62 fail:0 skip:13 total:75
	# Totals: pass:62 fail:0 skip:13 total:75
	ok 1 kasan

arm64 CONFIG_KASAN_SW_TAGS=y:
	# kasan: pass:65 fail:1 skip:9 total:75
	# Totals: pass:65 fail:1 skip:9 total:75
	not ok 1 kasan
	# kasan_strings: EXPECTATION FAILED at mm/kasan/kasan_test_c.c:1598
	KASAN failure expected in "strscpy(ptr, src + KASAN_GRANULE_SIZE, KASAN_GRANULE_SIZE)", but none occurred

arm64 CONFIG_KASAN_GENERIC=y, CONFIG_KASAN_OUTLINE=y:
	# kasan: pass:61 fail:1 skip:13 total:75
	# Totals: pass:61 fail:1 skip:13 total:75
	not ok 1 kasan
	# same failure as above

x86_64 CONFIG_KASAN_GENERIC=y:
	# kasan: pass:58 fail:0 skip:17 total:75
	# Totals: pass:58 fail:0 skip:17 total:75
	ok 1 kasan

=== Testing with patches

Testing in v3:

- Compiled every affected arch with no errors:

$ make CC=clang LD=ld.lld AR=llvm-ar NM=llvm-nm STRIP=llvm-strip \
	OBJCOPY=llvm-objcopy OBJDUMP=llvm-objdump READELF=llvm-readelf \
	HOSTCC=clang HOSTCXX=clang++ HOSTAR=llvm-ar HOSTLD=ld.lld \
	ARCH=$ARCH

$ clang --version
ClangBuiltLinux clang version 19.1.4
Target: x86_64-unknown-linux-gnu
Thread model: posix

- make ARCH=um produces the warning during compiling:
	MODPOST Module.symvers
	WARNING: modpost: vmlinux: section mismatch in reference: \
		kasan_init+0x43 (section: .ltext) -> \
		kasan_init_generic (section: .init.text)

AFAIU, it's due to the code in arch/um/kernel/mem.c, where kasan_init()
is placed in own section ".kasan_init", which calls kasan_init_generic()
which is marked with "__init".

- Booting via qemu-system- and running KUnit tests:

* arm64  (GENERIC, HW_TAGS, SW_TAGS): no regression, same above results.
* x86_64 (GENERIC): no regression, no errors

Sabyrzhan Tasbolatov (12):
  lib/kasan: introduce CONFIG_ARCH_DEFER_KASAN option
  kasan: unify static kasan_flag_enabled across modes
  kasan/powerpc: select ARCH_DEFER_KASAN and call kasan_init_generic
  kasan/arm64: call kasan_init_generic in kasan_init
  kasan/arm: call kasan_init_generic in kasan_init
  kasan/xtensa: call kasan_init_generic in kasan_init
  kasan/loongarch: select ARCH_DEFER_KASAN and call kasan_init_generic
  kasan/um: select ARCH_DEFER_KASAN and call kasan_init_generic
  kasan/x86: call kasan_init_generic in kasan_init
  kasan/s390: call kasan_init_generic in kasan_init
  kasan/riscv: call kasan_init_generic in kasan_init
  kasan: add shadow checks to wrappers and rename kasan_arch_is_ready

 arch/arm/mm/kasan_init.c               |  2 +-
 arch/arm64/mm/kasan_init.c             |  4 +--
 arch/loongarch/Kconfig                 |  1 +
 arch/loongarch/include/asm/kasan.h     |  7 -----
 arch/loongarch/mm/kasan_init.c         |  7 ++---
 arch/powerpc/Kconfig                   |  1 +
 arch/powerpc/include/asm/kasan.h       | 12 --------
 arch/powerpc/mm/kasan/init_32.c        |  2 +-
 arch/powerpc/mm/kasan/init_book3e_64.c |  2 +-
 arch/powerpc/mm/kasan/init_book3s_64.c |  6 +---
 arch/riscv/mm/kasan_init.c             |  1 +
 arch/s390/kernel/early.c               |  3 +-
 arch/um/Kconfig                        |  1 +
 arch/um/include/asm/kasan.h            |  5 ---
 arch/um/kernel/mem.c                   |  4 +--
 arch/x86/mm/kasan_init_64.c            |  2 +-
 arch/xtensa/mm/kasan_init.c            |  2 +-
 include/linux/kasan-enabled.h          | 34 ++++++++++++++++-----
 include/linux/kasan.h                  | 42 ++++++++++++++++++++------
 lib/Kconfig.kasan                      |  8 +++++
 mm/kasan/common.c                      | 18 +++++++----
 mm/kasan/generic.c                     | 23 ++++++++------
 mm/kasan/hw_tags.c                     |  9 +-----
 mm/kasan/kasan.h                       | 36 ++++++++++++++++------
 mm/kasan/shadow.c                      | 32 +++++---------------
 mm/kasan/sw_tags.c                     |  2 ++
 26 files changed, 146 insertions(+), 120 deletions(-)

-- 
2.34.1


