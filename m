Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18938C87FCF
	for <linux-um@archiver.kernel.org>; Thu,  7 Aug 2025 19:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ZxujgbgbPZueP+pnQ5s6H3MUryeO1an975QxEYXuWHk=; b=g/6zXvSEUFznXlB1RE6kbguv+t
	z6ZtZd1SvLSPlyhXpBGsZ+13GpmDKNpfXpCi0pdITtwLe9otQy0kLLpLzyinQ7LPJFH54VM/UAfh4
	0inunUs9q4+JnMY8MjlushKQKRK/kkNQ9cQTx0wI+KrODeQVZihPnbXKujn200XDw15yiAebCk1zd
	txE6QV93ESOj3r51Yv5uRqZodrr1Sq9Sb0M4OJlYZ+Z3UJ0Tm7kCwLKGsBhNaPwF0uNe0XEZnbccs
	Rp+EE6WAXe6JDPfInt41J5OfES2NvH5bxn+FybXHWbWEqUnOf3ZTKaF9YzPPvH/ux/2z0IkF0A5jV
	7JWniORg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uk6Vy-00000001Q57-2Cs7;
	Thu, 07 Aug 2025 19:43:02 +0000
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uk6TN-00000001PfZ-36ty;
	Thu, 07 Aug 2025 19:40:23 +0000
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-3322a34e84fso12584761fa.0;
        Thu, 07 Aug 2025 12:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754595619; x=1755200419; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZxujgbgbPZueP+pnQ5s6H3MUryeO1an975QxEYXuWHk=;
        b=NWoTb6dnOE2vLMS6dU+ybkKd5/Z31IfhtWuyJMQDb7LLUN2uA8qfYHPm03Ds5azUDy
         LpntT+Q69aRlWsj9EnAJ2amLz4lkIE0Vidk7qyH60JVnhiIam7IMPUfIC1Jcx4r35ksa
         Pqs+WNQmf/CdEmk5sC0/T13pNIvFRLWaDJETCpyJQizLwsgItYm4cvPqoDQgxaqmkgej
         TS89KsZoPz9dlqC/yNLsoO+zhiqoNe7XfZMl/2cLJd2bP9XwSZZq+OfdY0kWH2qQgCCT
         nLvUiw6y9DfoU7WkauLD6krcjZKDgIKhJk8DMXfeXSILtV+8ayTZ64ikrJWGHYdDC9tU
         sE5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754595619; x=1755200419;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZxujgbgbPZueP+pnQ5s6H3MUryeO1an975QxEYXuWHk=;
        b=QToJ4I0auCxk2SdB88Y7Lj7zEK+uvFdc0tqG0tMpQsqfkrzdW9GcLeQ4MbE1/A3UmP
         o+lYv1Xj18Rg3Yr9ZfBgwfnJLftzQ8/8mccVZQ6pq+ZSTTrfjue3NQiSB27kwomzsKb0
         02y2DDiWbJknOqegqB6kB2VeURD4Mb2Yr19RNOafvU/zUxyyN30ZBkguo5N/5GgUZflT
         3ugVMHMYh02I+aTLh1UG8XGlYqqG/psBZyYOmP0IZnRUUoDYr89iQdOryTSBU6hgQ8Dh
         fQbnnh/OCag854ojoZ4PCu0McVz5QCSefkcj14hjSnTtAvO2ZRQk21PCxJSAP7ER0LjV
         r0TQ==
X-Forwarded-Encrypted: i=1; AJvYcCVv0m3oiXWbgCL/aJJCKsnh2U1vbdx7WnElD4RFoTMjifk8R68zOIT5CjCUsPa+NyqjXhmXTgGa/EFkaUg=@lists.infradead.org, AJvYcCWGA9W5Kq4YwftpClPtnQyNrUbt3wkeiiS01UHrbmHDmaB2p8D8kClcMXjh17WdwQ00lo1S5NJ748s=@lists.infradead.org, AJvYcCXngPySY7dQ1Yizd1fK3pw0uEDVpEVXngHRS+qe49VG3/Ec530dMGAG8jOGS0mHzDzQ515wv0bEUPEDLeXOWjIR@lists.infradead.org
X-Gm-Message-State: AOJu0YyceaRINpA0wVzHzsPhkuDofq6M1KmPhXDw/uYmjzen3WZz1Pf/
	dj4BjUEf2h/ym/P18yhk5cGwGzIhz7Mia4ynFtBh+yEtX189tWykincv
X-Gm-Gg: ASbGnctvThiWOLmWHzSLG7/3Zs8c8EyAZ4yfsyC423gTTAjUtqWQcUbRYrJY5kh+BX8
	GJDlXT6rSW747eY7cw8NN+EmzAGym8IVlpLw/+sw7Ooi832DAC27DvDECOQ9ZlohMqeEZ7UFARu
	yLJ8q9EpoIYtL/devcQWyoYFwbG24CuWld700qeqh6+GOLbSNPc2Ew64SPdnrDMMQHi7usWcCIg
	SHJ9KEcKrpAQ9O2tZz0AX0YY489c3ZlM3bUaHN0gZEFozHxhx0y91Y8W+A/Rgq0TVrladVQcfIt
	rbLEZEvTMYtIi5GeQcgtuShgWBBPd3fhNHJKKJOGA1a0RXBQWBEPCvjN48SQMgRem3NwVwyNjYn
	mQe+bxk44EUnRqpZb0W0Me2Sr/k9buTmV4uhJSN1V70Fl3ghYl+qbUZ6FZgmau8dFl0B33g==
X-Google-Smtp-Source: AGHT+IE3k4ZwCdWcT+X+hcq7vhHbrmZfaduJaslrnOP/WdlfOXcdLd8Kfq+JS+ZAkrsMnQsJjZ39NA==
X-Received: by 2002:a05:6512:3d09:b0:55b:57e8:16c4 with SMTP id 2adb3069b0e04-55cc012c003mr7357e87.30.1754595619107;
        Thu, 07 Aug 2025 12:40:19 -0700 (PDT)
Received: from localhost.localdomain (178.90.89.143.dynamic.telecom.kz. [178.90.89.143])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b88c98c2asm2793570e87.77.2025.08.07.12.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 12:40:18 -0700 (PDT)
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
To: ryabinin.a.a@gmail.com,
	bhe@redhat.com,
	hca@linux.ibm.com,
	christophe.leroy@csgroup.eu,
	andreyknvl@gmail.com,
	akpm@linux-foundation.org,
	zhangqing@loongson.cn,
	chenhuacai@loongson.cn,
	davidgow@google.co,
	glider@google.com,
	dvyukov@google.com
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
Subject: [PATCH v5 0/2] kasan: unify kasan_enabled() and remove arch-specific implementations
Date: Fri,  8 Aug 2025 00:40:10 +0500
Message-Id: <20250807194012.631367-1-snovitoll@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250807_124021_782994_51C052A1 
X-CRM114-Status: GOOD (  13.46  )
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
 arch/um/kernel/mem.c                   | 10 ++++++--
 arch/x86/mm/kasan_init_64.c            |  2 +-
 arch/xtensa/mm/kasan_init.c            |  2 +-
 include/linux/kasan-enabled.h          | 32 ++++++++++++++++++--------
 include/linux/kasan.h                  |  6 +++++
 lib/Kconfig.kasan                      |  8 +++++++
 mm/kasan/common.c                      | 17 ++++++++++----
 mm/kasan/generic.c                     | 19 +++++++++++----
 mm/kasan/hw_tags.c                     |  9 +-------
 mm/kasan/kasan.h                       |  8 ++++++-
 mm/kasan/shadow.c                      | 12 +++++-----
 mm/kasan/sw_tags.c                     |  1 +
 mm/kasan/tags.c                        |  2 +-
 27 files changed, 107 insertions(+), 76 deletions(-)

-- 
2.34.1


