Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4103BC7EE31
	for <linux-um@archiver.kernel.org>; Thu, 26 Jun 2025 16:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=YMfAvEP2mtW3abNAfjIslAPajM3CO1XTnrCn/94UwT0=; b=qNSeoI07qP9e5W85W30ZG+Lews
	pcNznl91F+KlLiaZO6lJD9F1PvahWn2KWOsF+y0N/uPpqcrSIGcLx8pjlm5Fxqc7Wg/2tAL8Vuqmz
	0BRBUUkrk1uS2Ynk6E7lvgDq6XNndPyIewinW8QYfmgpa6dOlFk0MahvM5HeGPGoBSczn9X016xcG
	Kla1Z0rR/hzSFKLdvoTd7tTHL01CLV/gaYO4PufmQ1QaHbocZTqNRCly6ESoxXCA0SQU2IN5BhqWO
	YXXzEIbPy3i/z8Jqry/WPAWXfYVo6Rec6HNgQCVBtcNuk97uKK9luypFpwYIfAP0XQQ5RnHTHq5cO
	FMM5craw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUpKY-0000000CFEx-3Dnz;
	Thu, 26 Jun 2025 16:20:06 +0000
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUoa6-0000000C7lq-2iGk;
	Thu, 26 Jun 2025 15:32:08 +0000
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-553c31542b1so1269362e87.2;
        Thu, 26 Jun 2025 08:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750951925; x=1751556725; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YMfAvEP2mtW3abNAfjIslAPajM3CO1XTnrCn/94UwT0=;
        b=MLFMQ+UoyRgsxXAGyguQlA3i/VtCbdWtbRc7XxRuircJCNAxoAvBWXPjwQw9HZMDGe
         cdYYIDON9NfBtpwEx3DWtXwg2PHRtkj4j+R7nXLq2Ne+vk7VirJZ/us8dFLL/QmDpGmi
         LjumIiCMt3kBtNvQv4whnnhNHkj04Z7he0VSwgPeYg9xs5odTfqP8jqmwdr7VtQroxw1
         WDBL1T3dPLa4w4qd55oKmKH8YYjuGiXLLk8smdXdFBsRi1Y445NnJe7/nXww+qNKjCpA
         6GhYPekNlvrcFOxRMSMiApr78kBHWXF3lv1k/LRQ6EWZYBIcLJiYiRNt6jb/0+nRwmKZ
         mQgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750951925; x=1751556725;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YMfAvEP2mtW3abNAfjIslAPajM3CO1XTnrCn/94UwT0=;
        b=OoT1b9oiCwv9S5GRYMmFwNBrMPj+kTnDAYCDN786WKzYd6EeujJeDH8xbuxyu26Xkn
         fznCFBS21Q8DEyC9+4klC90tN+u79E+cyyZ9wT3gsh4dHxMrR+pVhh5hSjrvgbYp1Sey
         i9ex9ySNgDOiyZdzbYfDwJWqPn0xyfNVOWVwcvr6/NeOtnY0vRl9ckA/LbTKF4HWQ+T4
         dC0WnmiHWymPAiKJ9iLy313x19NVF3avCgTHZUvhX3u3NMzX8kfCcD15+yUWiR/zKlQI
         G8u2BxkNIbTl+L6zqHFWrECJ8TC0JA+axmv2Kz/q5ySa4CftalvzyahnowcfxRNKUmVe
         tpCA==
X-Forwarded-Encrypted: i=1; AJvYcCVeinYwbsWicW9Moi/qMvDph5yAk/3EJ5+xL4TSJRy0KZRaxZP0BB1G/ApzKfzoQGzbgLlg3OlNEdd6R6NHFGPy@lists.infradead.org, AJvYcCVxyQ0gE1ftalPDPHUKVGe0n8MTL+wutJewYPBmEtH1dgbVCo4V2b7vYdGDvQaBmIEsDqrE4cEubN0=@lists.infradead.org, AJvYcCXICkR9zzwEAKLzLI9Ub5rzOuGSiFTs8I2LCmdslHp0JvnijHknqYN/nLzBPbhFicBB+t6xnN7mgwIcGc4=@lists.infradead.org
X-Gm-Message-State: AOJu0YwYSeFWhbD/MAV2LMlfAEigmfvbBqGfK/Z5kp1GhaTJ/jwPlYJa
	IBWWFLKoMqbPODmMRZOA9LQFhdr56Ff5/mMJfuHUHrENEaOrvEsyLDin
X-Gm-Gg: ASbGncvcopbb7JaxZ+ju6dMId0vVFDJQFdt9qXmZTC7LkV/Ux5Y2+ONBZXrzupn/xrk
	rMxuoKZTWHhkKdpkKcyIKZaEy1tfFhkrbxt0BvFhT9+xkstSN2dJfI42S+FdV4WyJtKpqlWTkGN
	7ogpMJM1g9vXo05w7xmG/nt626A8M09RruyAGuyPmtYYpakDywCv198mneOGemWkjmfb7WVffSl
	qc5lhzTeF1WX7azHT0caH8lfK3I4s9jtfWOEyENIiNaUpt0O8zWs2wq1VnLMAKwiUeZVgw+/t6t
	P5uwyLw1XbMIi8ahsQShbg/hihu/RlycKVMp3lNkGcfDx52GMsbmTGeOdQXguN+QDXlPfRyTUcf
	ly9S5Xzxslh10QprUZtc57C+Hyb2IobgtygEBwhHc
X-Google-Smtp-Source: AGHT+IHpXirYmk7XDZLOi1Ssi0yS8Ocf718QqXqkpNJ7oPQlT+uR1sIDO9gdQg1tyNmCsb6VEaTfFA==
X-Received: by 2002:a05:6512:1589:b0:554:f76a:baba with SMTP id 2adb3069b0e04-554fdcbb935mr2999055e87.3.1750951924452;
        Thu, 26 Jun 2025 08:32:04 -0700 (PDT)
Received: from localhost.localdomain (2.135.54.165.dynamic.telecom.kz. [2.135.54.165])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5550b2ce1fasm42792e87.174.2025.06.26.08.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 08:32:03 -0700 (PDT)
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
To: ryabinin.a.a@gmail.com,
	glider@google.com,
	andreyknvl@gmail.com,
	dvyukov@google.com,
	vincenzo.frascino@arm.com,
	linux@armlinux.org.uk,
	catalin.marinas@arm.com,
	will@kernel.org,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	christophe.leroy@csgroup.eu,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	dave.hansen@linux.intel.com,
	luto@kernel.org,
	peterz@infradead.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	x86@kernel.org,
	hpa@zytor.com,
	chris@zankel.net,
	jcmvbkbc@gmail.com,
	akpm@linux-foundation.org,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	morbo@google.com,
	justinstitt@google.com
Cc: arnd@arndb.de,
	rppt@kernel.org,
	geert@linux-m68k.org,
	mcgrof@kernel.org,
	guoweikang.kernel@gmail.com,
	tiwei.btw@antgroup.com,
	kevin.brodsky@arm.com,
	benjamin.berg@intel.com,
	kasan-dev@googlegroups.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-mm@kvack.org,
	llvm@lists.linux.dev,
	snovitoll@gmail.com
Subject: [PATCH v2 00/11] kasan: unify kasan_arch_is_ready with kasan_enabled
Date: Thu, 26 Jun 2025 20:31:36 +0500
Message-Id: <20250626153147.145312-1-snovitoll@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250626_083206_686883_E4AA6673 
X-CRM114-Status: GOOD (  14.86  )
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

This patch series unifies the kasan_arch_is_ready() and kasan_enabled()
interfaces by extending the existing kasan_enabled() infrastructure to
work consistently across all KASAN modes (Generic, SW_TAGS, HW_TAGS).

Currently, kasan_enabled() only works for HW_TAGS mode using a static key,
while other modes either return IS_ENABLED(CONFIG_KASAN) (compile-time
constant) or rely on architecture-specific kasan_arch_is_ready()
implementations with custom static keys and global variables.

This leads to:
- Code duplication across architectures  
- Inconsistent runtime behavior between KASAN modes
- Architecture-specific readiness tracking

After this series:
- All KASAN modes use the same kasan_flag_enabled static key
- Consistent runtime enable/disable behavior across modes
- Simplified architecture code with unified kasan_init_generic() calls
- Elimination of arch specific kasan_arch_is_ready() implementations
- Unified vmalloc integration using kasan_enabled() checks

This addresses the bugzilla issue [1] about making
kasan_flag_enabled and kasan_enabled() work for Generic mode,
and extends it to provide true unification across all modes.

[1] https://bugzilla.kernel.org/show_bug.cgi?id=217049

=== Current mainline KUnit status

To see if there is any regression, I've tested first on the following
commit 739a6c93cc75 ("Merge tag 'nfsd-6.16-1' of
git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux").

Tested via compiling a kernel with CONFIG_KASAN_KUNIT_TEST and running
QEMU VM. There are failing tests in SW_TAGS and GENERIC modes in arm64:

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

Testing in v2:

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

=== NB

I haven't tested the kernel boot on the following arch. due to the absence
of qemu-system- support on those arch on my machine, so I defer this to
relevant arch people to test KASAN initialization:
- loongarch
- s390
- um
- xtensa
- powerpc
- riscv

Code changes in v2:
- Replace the order of patches. Move "kasan: replace kasan_arch_is_ready
	with kasan_enabled" at the end to keep the compatibility.
- arch/arm, arch/riscv: add 2 arch. missed in v1
- arch/powerpc: add kasan_init_generic() in other kasan_init() calls:
	arch/powerpc/mm/kasan/init_32.c
	arch/powerpc/mm/kasan/init_book3e_64.c
- arch/um: add the proper header `#include <linux/kasan.h>`. Tested
	via compiling with no errors. In the v1 arch/um changes were acked-by
	Johannes Berg, though I don't include it due to the changed code in v2.
- arch/powerpc: add back `#ifdef CONFIG_KASAN` deleted in v1 and tested
	the compilation.
- arch/loongarch: update git commit message about non-standard flow of
	calling kasan_init_generic()

Sabyrzhan Tasbolatov (11):
  kasan: unify static kasan_flag_enabled across modes
  kasan/arm64: call kasan_init_generic in kasan_init
  kasan/arm: call kasan_init_generic in kasan_init
  kasan/xtensa: call kasan_init_generic in kasan_init
  kasan/loongarch: call kasan_init_generic in kasan_init
  kasan/um: call kasan_init_generic in kasan_init
  kasan/x86: call kasan_init_generic in kasan_init
  kasan/s390: call kasan_init_generic in kasan_init
  kasan/powerpc: call kasan_init_generic in kasan_init
  kasan/riscv: call kasan_init_generic in kasan_init
  kasan: replace kasan_arch_is_ready with kasan_enabled

 arch/arm/mm/kasan_init.c               |  2 +-
 arch/arm64/mm/kasan_init.c             |  4 +---
 arch/loongarch/include/asm/kasan.h     |  7 -------
 arch/loongarch/mm/kasan_init.c         |  7 ++-----
 arch/powerpc/include/asm/kasan.h       | 13 -------------
 arch/powerpc/mm/kasan/init_32.c        |  2 +-
 arch/powerpc/mm/kasan/init_book3e_64.c |  2 +-
 arch/powerpc/mm/kasan/init_book3s_64.c |  6 +-----
 arch/riscv/mm/kasan_init.c             |  1 +
 arch/s390/kernel/early.c               |  3 ++-
 arch/um/include/asm/kasan.h            |  5 -----
 arch/um/kernel/mem.c                   |  4 ++--
 arch/x86/mm/kasan_init_64.c            |  2 +-
 arch/xtensa/mm/kasan_init.c            |  2 +-
 include/linux/kasan-enabled.h          | 22 ++++++++++++++++------
 include/linux/kasan.h                  |  6 ++++++
 mm/kasan/common.c                      | 15 +++++++++++----
 mm/kasan/generic.c                     | 17 ++++++++++++++---
 mm/kasan/hw_tags.c                     |  7 -------
 mm/kasan/kasan.h                       |  6 ------
 mm/kasan/shadow.c                      | 15 +++------------
 mm/kasan/sw_tags.c                     |  2 ++
 22 files changed, 66 insertions(+), 84 deletions(-)

-- 
2.34.1


