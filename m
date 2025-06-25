Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91007C7EE30
	for <linux-um@archiver.kernel.org>; Wed, 25 Jun 2025 11:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=7imy3yTxK1noZpQDmXpRegf9/Y5dUmZKs6ukLVxlc1E=; b=kgsZqsQldMdV/qfrIQ/CO+7KW2
	xNFABaQcoCwWBP/DrP9qzkljsbn9xvntofxaAViWEIVBVt5wTGez8ryBiogRHXcxr7kQrCNOai0Pq
	zJZ+3+GA0O0ro9YSAYBUgJTmad5Y5RxteK51ihTmSew4/dEPCamh/+0CKZF5HTXeG7ruolgGOuBGk
	w+wdFsZJDuS9/LQk6h91GRdj7SdHqJnOa9+RSc48+NULn98Wq1WS0ifdpedR+bDGumGTzOKBHcB7I
	NDImVt/+7wOc1eaA3GOu5cSMRFUI2T03xM0dz/iXxPpKoN6i1CSMHxkrF8qXKEjaInsnAW8JaYtEe
	mfknN2LQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUNw0-00000008PYY-0f6i;
	Wed, 25 Jun 2025 11:04:56 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUMoC-00000008Clk-41gO;
	Wed, 25 Jun 2025 09:52:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=7imy3yTxK1noZpQDmXpRegf9/Y5dUmZKs6ukLVxlc1E=; b=eIGitfsPe+d9McJQJGyc8D1MKt
	TB1o8gpaLfIBnjhbUmdd5C3q5sXGuZMKjsYkVf0sf+nHb3dmKdk0cf1MvIsKB/RhDKlNCBKeHxvq6
	lMx9XgySY+MErfHqEi3PzoO6fkO3de023iad8HqOJp91aXUGXJ9vPddoOy6a10RQqQalPj0y4ocTg
	GV7gCdS+MVu9lySbd+iA90U+vM/Po/RsL+o3gfKN078v5xnuEKPLuPs35wR3kR+QJduERS9ZjrBi/
	HzQVnQXyZwRqqO2eLlSKWf5mshJ4lleG3lf8iHamXZ/ItL9WKr9if1WMzTl8mU/BoQUoX1AGsC3tE
	evlM4Waw==;
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUMo9-00000005l8S-1mLZ;
	Wed, 25 Jun 2025 09:52:48 +0000
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-32ade3723adso74264711fa.0;
        Wed, 25 Jun 2025 02:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750845162; x=1751449962; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7imy3yTxK1noZpQDmXpRegf9/Y5dUmZKs6ukLVxlc1E=;
        b=IqSF83ogCKsdBsJvnY+ltPbAX3pBy+mUUHM4/BNxa8Tf1giSG/xBASHx9+nWPdEIUy
         QnCfY8KXzitecUQi46dijrSEHItpU/VSbT+h42yJOjfQRdBriw2E1GIS3ukGurZeXtJe
         nn1+FFhyZMpmXI7WlPfxHibBvP1vRPJbyB+IEnOWlEJcSWtvMDjagAW5KuoL9bk1um9I
         o5XjkjZV/fpiiapXQG9H3+yIHFR/61tf/XhrffJAaFIpH+X0Pe3Ita8B4EvnPun78HA6
         Y6BeYoS7Oj3rA7cIsvsU9KugqPY76blbs/N1OQmbW3s8hXViQhFmVySWeclrzW7/iaDr
         hflw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750845162; x=1751449962;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7imy3yTxK1noZpQDmXpRegf9/Y5dUmZKs6ukLVxlc1E=;
        b=t6ePQDIIf1l+9nWIUpjz/ak/qigs8WnVkOU1bFOXYGh3uojmJxbIswzl68WYa/KEWs
         MZUcJwUwjcCKTgybJTwYHG2KFTuZBycA9CtIcxHpbE9Lgwg3bcojlwj11/0H6X+w/0iM
         EeZUi/86iGEoNoA3rYKm9CvF3RxThNa8IH5pGFxvSdlYywFs5iclThySGLXy/wHXRFif
         iaxnxU4VpYwKu2ae6UFb04XaHvWiAFAnuCzU61fEpWRXlnxr5e2BnnLrgbtHvkSVBKS8
         EpdEU78AKvxtJwslHcYvpTvrljYJJtEH+6MOjEBcat2/8AEnaNaAvMU/O1khWZtuhJtM
         zHuA==
X-Forwarded-Encrypted: i=1; AJvYcCUnoCjI9iDRT+8LoaZrhtbyF7mhtf8Dh8e6xhG87pgb2QtsikO5yS8Kgyr3dEAYSF0CIGA+gkdWJ+Q=@lists.infradead.org, AJvYcCW9EBhLRQJSM7qIs2Y4wcCR/e9RUIdIk+CB0C0fKLmPg9vRQqLc1YnE1h6E4A0YGngR4IG9apktgwnAYDIbM3V/@lists.infradead.org
X-Gm-Message-State: AOJu0YzyvMSRyz0eAak9Bdx4pOorMicL8ovQhDvvgT6uoUU4/Hdqlc38
	15SHHzj/93n8fyQcjS6c1vfFvPg1tkW/prWtseMTqMIhMTWf5gA8RBdA
X-Gm-Gg: ASbGncvjGr9+IfcNyVHxY5QfhXGqwtota2uHVqCrdo5Rj1m/ieUDvuoz1lumuieRBkU
	u86hGh8mszVxTSCiJCfDYkCP0P+ErFBbEie0CoFIOckuAlN847mmHj6s7BUEMlaxNt3O6Iavspg
	xmXEBhqeTgzNVxWzhd5Tak15vxG0rTVtzfdVoJUDnKDN7x/DvO4naWZJ5CX1hEBWuHYzKUa7UZK
	iqVtAKdh1NcPvS3/CRx+3rDCFV5WxRuKw07k2j5PV6A41kWNbyuQpddxavMWyNyqmv2JbEHrvp0
	M6e/kIxzW6CKEKrIGUgdiVw59Vj1M8vWAB4C6dNPnVKh3sOIeGw6LMU6z52FZcrlKRwmqkUSSTD
	vq+cv3ECyFmLpzuonyD9zWvdBYRvYiA==
X-Google-Smtp-Source: AGHT+IH5ApOZ+lbBvE2ggWIBLKt7ZlvSOrm/LIiyhhxX4cx6KdoLX4TpLfXvTX3dCD4pGEuZuPz4ow==
X-Received: by 2002:a2e:be03:0:b0:32b:3879:ce7f with SMTP id 38308e7fff4ca-32cc63451f0mr7075061fa.0.1750845161589;
        Wed, 25 Jun 2025 02:52:41 -0700 (PDT)
Received: from localhost.localdomain (2.135.54.165.dynamic.telecom.kz. [2.135.54.165])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32b980a36c0sm19311851fa.62.2025.06.25.02.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 02:52:41 -0700 (PDT)
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
To: ryabinin.a.a@gmail.com,
	glider@google.com,
	andreyknvl@gmail.com,
	dvyukov@google.com,
	vincenzo.frascino@arm.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	christophe.leroy@csgroup.eu,
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
	akpm@linux-foundation.org
Cc: guoweikang.kernel@gmail.com,
	geert@linux-m68k.org,
	rppt@kernel.org,
	tiwei.btw@antgroup.com,
	richard.weiyang@gmail.com,
	benjamin.berg@intel.com,
	kevin.brodsky@arm.com,
	kasan-dev@googlegroups.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-mm@kvack.org,
	snovitoll@gmail.com
Subject: [PATCH 0/9] kasan: unify kasan_arch_is_ready with kasan_enabled
Date: Wed, 25 Jun 2025 14:52:15 +0500
Message-Id: <20250625095224.118679-1-snovitoll@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250625_105245_513013_030918D6 
X-CRM114-Status: GOOD (  10.79  )
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

=== Testing with the patches:

* arm64  (GENERIC, HW_TAGS, SW_TAGS): no regression, same above results.
* x86_64 (GENERIC): no regression, no errors

=== NB

I haven't tested on the following arch. due to the absence of qemu-system-
support on those arch on my machine. So I defer this to relevant arch
people to test KASAN initialization:
- loongarch
- s390
- um
- xtensa
- powerpc

Sabyrzhan Tasbolatov (9):
  kasan: unify static kasan_flag_enabled across modes
  kasan: replace kasan_arch_is_ready with kasan_enabled
  kasan/arm64: call kasan_init_generic in kasan_init
  kasan/xtensa: call kasan_init_generic in kasan_init
  kasan/loongarch: call kasan_init_generic in kasan_init
  kasan/um: call kasan_init_generic in kasan_init
  kasan/x86: call kasan_init_generic in kasan_init
  kasan/s390: call kasan_init_generic in kasan_init
  kasan/powerpc: call kasan_init_generic in kasan_init

 arch/arm64/mm/kasan_init.c             |  4 +---
 arch/loongarch/include/asm/kasan.h     |  7 -------
 arch/loongarch/mm/kasan_init.c         |  7 ++-----
 arch/powerpc/include/asm/kasan.h       | 14 --------------
 arch/powerpc/mm/kasan/init_book3s_64.c |  6 +-----
 arch/s390/kernel/early.c               |  2 +-
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
 18 files changed, 61 insertions(+), 82 deletions(-)

-- 
2.34.1


