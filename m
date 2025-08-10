Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44617C87FCA
	for <linux-um@archiver.kernel.org>; Sun, 10 Aug 2025 13:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=fLpTR6tAuSk7MmdRr1bx3cY7Ji1Fi9DhOlpvPdNYklM=; b=I+DjzlXT09KINZy8doQaV2MB3/
	JiwDQrkeiLnT1HmsPZfZZxxj80EsW5HjeTnOy6awofG1VV58+uUmHMlXR+3jGlXTVdwExCycqW+Vz
	7UqT2Rgo0DPxKGXeNBDUfIfAgmQytoiUKy8QOX97u5R+4Lewyobje+id8NfQety/PtvqJQh6E6nK0
	S5p/9g3vCjszraeGVxmmR+LHYoIiI0kj9m+BL08DkBvRtjW+aw9ooeGagXwwurm6Z+OPml5oVW86/
	5nzCon4DGq/ei5HyX8Cu1QBWWGezLUmSfhIN5jFeHRjPUejYYiQqduIrZ4c+Wkex917nDVDkDd0bR
	dPEZq+qA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ul5fE-00000005cCY-1hOL;
	Sun, 10 Aug 2025 13:00:40 +0000
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ul5cf-00000005bpZ-2oIq;
	Sun, 10 Aug 2025 12:58:02 +0000
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-3322a34e84fso31114311fa.0;
        Sun, 10 Aug 2025 05:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754830680; x=1755435480; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fLpTR6tAuSk7MmdRr1bx3cY7Ji1Fi9DhOlpvPdNYklM=;
        b=ATFz32WbzUsoQ06slxk9Hk6UHv1BHW9BDNnSsOgJax7R02MWtTGRkUTNs+Ufzn17Sd
         sV9FOWFI5nPSemMr/xMi6g5UAnoMZElWv3MXzeqsD0BXZYF+Nxnma4EcKVc7l2CjDH5r
         7WdQRRLXN1BWDdIQgmcii5fCmauKH7J6kJIn7fNaeLmQMeJGAr90PuuEWTRgG6uASXoQ
         oCGGw/oDZqRFnhQ0AaO4hEQqJ/USeNn2eJbFWbee6RECAdsHUEowSV8ydOVjnqIFq7xU
         f7m/sWqHkOy6mPDOHX+aQ9e5I4fubaU+NMtDaWboVQF1zV1Ax2BUMKTsQ73u8G+0eEhw
         NuNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754830680; x=1755435480;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fLpTR6tAuSk7MmdRr1bx3cY7Ji1Fi9DhOlpvPdNYklM=;
        b=IxpckORTgV5kWZQ4vvZt5cPNnVjIwOnfZmPWODvGrBynjDESHFUbG7jV4Sw0OLazPw
         ifytpVtB++81qbu+D/gdxPrgntJXyO+4F+hW1m0mNwmKEnJ31wCcpPYZh3gC31Y4QvRr
         Zm1/p0/5WbGmRFKzLRhylS4FUBObjMM23SGQWnPzTb2jEtTyGRUf2C/4shZqlr1ivTv4
         HlYAyeF4PuFfIRLj95m4Rrd8qt7OyZBZB9xBN2P1Z0GqaKdR56KIBgQV32hIKjwyoQ4r
         mZHnewfoypodFSIx8u6bfhdaFZtVewLeAZ1jqdVTVDDwMO3FY1QEfiwyd4yRRy4Lth/G
         4Siw==
X-Forwarded-Encrypted: i=1; AJvYcCVICUmO1V1XUODCZMEQOc5kMyaPTtJuviaaREMRYIadmyla5G+gBGRZcInzv/PJrmNx+ujNseL2dws=@lists.infradead.org, AJvYcCWRvYkWwwpO82J+6TcuZNoZy6tFsth5R4zZ0WsU4Qa/LCirOQEiAGATWNtyKBEjg1uLmjYW+24zjLcC77A=@lists.infradead.org, AJvYcCXgKm3U4dVkVw0t/Nu9L/OWDa+esjSGVJWsSDMPut/GwOxXUtnvVuE5GPPSwf+bje7QxgDe/l1dcdsnzyN2Pk6l@lists.infradead.org
X-Gm-Message-State: AOJu0YzomYYOtpvC9nIKEGxrvJp3lVXuvSZOfvnjLqyCkHG0qMz7WxKu
	9PLocixrywDfCXEKLypLZ+aP/tDbT+r5SQkrEl89Lj0rkl1t43od15Tp
X-Gm-Gg: ASbGncsNQAAXU9IJamjGfu6KTHGZvNtD0RMxMyRcXHzNclv3pKaMwx0k+MjE/1qGr74
	vkVIEx0u1J1p7o8NfLXYSJLi9H+iUTO6BywtG3bjfoA9taY1CLBvmIPoMuVzjmpHmrBASmX3QpZ
	A9gDYn7cU3PK7QAYEmstJUp0A0txOFUx/Z7hmdiHKIWuW5PchwUJFIsIDzMBZ1CpcYUmObKzwqm
	/R//NJz21YdDd5WYSYfA4MDj3nwvynxU/ViGcLLPFKhF6o4D4JSHWIiYw1srziUmW4txoMzXxqm
	FlZ6STqJD25r/CpyjcIICN7ISMwCCX4I2AVQVJ6QAqYNpCqxIBc5DJVvJyXN9Ov/V0dbmG9Jgvr
	VP9ZwL2Bl/7OpDih4v13uZTO5DYWpAe82idAXOA==
X-Google-Smtp-Source: AGHT+IGP/4+VH4qZJqmI6pqOQcdamwMMjmUjwyAr9JTcQGvwe1pb2iGdV8kKhr91VYx69eEOJbHKcQ==
X-Received: by 2002:a05:6512:2313:b0:55b:8397:cffd with SMTP id 2adb3069b0e04-55cc00ada77mr2589766e87.9.1754830679327;
        Sun, 10 Aug 2025 05:57:59 -0700 (PDT)
Received: from localhost.localdomain ([2a03:32c0:2e:37dd:bfc4:9fdc:ddc6:5962])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b88c9908esm3804561e87.76.2025.08.10.05.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 05:57:58 -0700 (PDT)
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
To: ryabinin.a.a@gmail.com,
	christophe.leroy@csgroup.eu,
	bhe@redhat.com,
	hca@linux.ibm.com,
	andreyknvl@gmail.com,
	akpm@linux-foundation.org,
	zhangqing@loongson.cn,
	chenhuacai@loongson.cn,
	davidgow@google.com,
	glider@google.com,
	dvyukov@google.com,
	alexghiti@rivosinc.com
Cc: alex@ghiti.fr,
	agordeev@linux.ibm.com,
	vincenzo.frascino@arm.com,
	elver@google.com,
	kasan-dev@googlegroups.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-mm@kvack.org,
	snovitoll@gmail.com
Subject: [PATCH v6 0/2] kasan: unify kasan_enabled() and remove arch-specific implementations
Date: Sun, 10 Aug 2025 17:57:44 +0500
Message-Id: <20250810125746.1105476-1-snovitoll@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250810_055801_712076_1FE5F340 
X-CRM114-Status: GOOD (  14.34  )
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
- PowerPC, LoongArch, and UML arch, each implement own kasan_arch_is_ready()
- Only HW_TAGS mode had a unified static key (kasan_flag_enabled)
- Generic and SW_TAGS modes relied on arch-specific solutions
  or always-on behavior

Changes in v6:
- Call kasan_init_generic() in arch/riscv _after_ local_flush_tlb_all()
- Added more details in git commit message
- Fixed commenting format per coding style in UML (Christophe Leroy)
- Changed exporting to GPL for kasan_flag_enabled (Christophe Leroy)
- Converted ARCH_DEFER_KASAN to def_bool depending on KASAN to avoid
        arch users to have `if KASAN` condition (Christophe Leroy)
- Forgot to add __init for kasan_init in UML

Changes in v5:
- Unified patches where arch (powerpc, UML, loongarch) selects
  ARCH_DEFER_KASAN in the first patch not to break
  bisectability. So in v5 we have 2 patches now in the series instead of 9.
- Removed kasan_arch_is_ready completely as there is no user
- Removed __wrappers in v4, left only those where it's necessary
  due to different implementations

Tested on:
- powerpc - selects ARCH_DEFER_KASAN
Built ppc64_defconfig (PPC_BOOK3S_64) - OK
Booted via qemu-system-ppc64 - OK

I have not tested in v4 powerpc without KASAN enabled.

In v4 arch/powerpc/Kconfig it was:
	select ARCH_DEFER_KASAN			if PPC_RADIX_MMU

and compiling with ppc64_defconfig caused:
  lib/stackdepot.o:(__jump_table+0x8): undefined reference to `kasan_flag_enabled'

I have fixed it in v5 via adding KASAN condition:
	select ARCH_DEFER_KASAN			if KASAN && PPC_RADIX_MMU

- um - selects ARCH_DEFER_KASAN

KASAN_GENERIC && KASAN_INLINE && STATIC_LINK
	Before:
		In file included from mm/kasan/common.c:32:
		mm/kasan/kasan.h:550:2: error: #error kasan_arch_is_ready only works in KASAN generic outline mode!
		550 | #error kasan_arch_is_ready only works in KASAN generic outline mode

	After (with auto-selected ARCH_DEFER_KASAN):
		./arch/um/include/asm/kasan.h:29:2: error: #error UML does not work in KASAN_INLINE mode with STATIC_LINK enabled!
		29 | #error UML does not work in KASAN_INLINE mode with STATIC_LINK enabled!

KASAN_GENERIC && KASAN_OUTLINE && STATIC_LINK && 
	Before:
		./linux boots.

	After (with auto-selected ARCH_DEFER_KASAN):
		./linux boots.

KASAN_GENERIC && KASAN_OUTLINE && !STATIC_LINK
	Before:
		./linux boots

	After (with auto-disabled !ARCH_DEFER_KASAN):
		./linux boots

- loongarch - selects ARCH_DEFER_KASAN
Built defconfig with KASAN_GENERIC - OK
Haven't tested the boot. Asking Loongarch developers to verify - N/A
But should be good, since Loongarch does not have specific "kasan_init()"
call like UML does. It selects ARCH_DEFER_KASAN and calls kasan_init()
in the end of setup_arch() after jump_label_init().

Previous v5 thread: https://lore.kernel.org/all/20250807194012.631367-1-snovitoll@gmail.com/
Previous v4 thread: https://lore.kernel.org/all/20250805142622.560992-1-snovitoll@gmail.com/
Previous v3 thread: https://lore.kernel.org/all/20250717142732.292822-1-snovitoll@gmail.com/
Previous v2 thread: https://lore.kernel.org/all/20250626153147.145312-1-snovitoll@gmail.com/

Sabyrzhan Tasbolatov (2):
  kasan: introduce ARCH_DEFER_KASAN and unify static key across modes
  kasan: call kasan_init_generic in kasan_init

 arch/arm/mm/kasan_init.c               |  2 +-
 arch/arm64/mm/kasan_init.c             |  4 +---
 arch/loongarch/Kconfig                 |  1 +
 arch/loongarch/include/asm/kasan.h     |  7 ------
 arch/loongarch/mm/kasan_init.c         |  8 +++----
 arch/powerpc/Kconfig                   |  1 +
 arch/powerpc/include/asm/kasan.h       | 12 ----------
 arch/powerpc/mm/kasan/init_32.c        |  2 +-
 arch/powerpc/mm/kasan/init_book3e_64.c |  2 +-
 arch/powerpc/mm/kasan/init_book3s_64.c |  6 +----
 arch/riscv/mm/kasan_init.c             |  1 +
 arch/s390/kernel/early.c               |  3 ++-
 arch/um/Kconfig                        |  1 +
 arch/um/include/asm/kasan.h            |  5 ++--
 arch/um/kernel/mem.c                   | 13 ++++++++---
 arch/x86/mm/kasan_init_64.c            |  2 +-
 arch/xtensa/mm/kasan_init.c            |  2 +-
 include/linux/kasan-enabled.h          | 32 ++++++++++++++++++--------
 include/linux/kasan.h                  |  6 +++++
 lib/Kconfig.kasan                      | 12 ++++++++++
 mm/kasan/common.c                      | 17 ++++++++++----
 mm/kasan/generic.c                     | 19 +++++++++++----
 mm/kasan/hw_tags.c                     |  9 +-------
 mm/kasan/kasan.h                       |  8 ++++++-
 mm/kasan/shadow.c                      | 12 +++++-----
 mm/kasan/sw_tags.c                     |  1 +
 mm/kasan/tags.c                        |  2 +-
 27 files changed, 113 insertions(+), 77 deletions(-)

-- 
2.34.1


