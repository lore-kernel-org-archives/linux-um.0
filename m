Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32939C5DF81
	for <linux-um@archiver.kernel.org>; Sun, 23 Aug 2026 20:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=MfartcHqwqCIhFwvC4CwiIrHlgQajx9zG1o6pHu7jNE=; b=yjuq7HNkXNzuvNRrYrxCZmtvdm
	fGo7gf6TG+XcO9srreQu2IHAfmSNzsJAEAv8d4lOuZOXxbYVQ5i12/HJozTnNJsRDp/eN7HqJ4kEC
	xTE+jGi4sSHlB67MgXa20dfhRyigavF/hRn7SzSt3KTcE3NQlz0Rmbp0apqgHpKgtnKLYS63COPEO
	Nj278YgmaQuB1w6niYEKw6kk6STTOE4mteCNhKID+2KFNTlVA9r79kFWOtrsQB2zczu2WMWinWrbS
	sZGI3aEsmXaakwlV/ywjAR+4hOVLtcp0szmDnZYegagtC+Agc5z+4CaU3PVdbGOTAKR1lKeKMadl3
	/Q7DACQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyEc5-0000000FanX-1cFT;
	Sun, 23 Aug 2026 20:16:17 +0000
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyEc0-0000000Fan2-3NEH
	for linux-um@lists.infradead.org;
	Sun, 23 Aug 2026 20:16:15 +0000
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-c15d111ca99so323199566b.0
        for <linux-um@lists.infradead.org>; Sun, 23 Aug 2026 13:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isomorphic-ai.com; s=google; t=1787516170; x=1788120970; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MfartcHqwqCIhFwvC4CwiIrHlgQajx9zG1o6pHu7jNE=;
        b=kLUveqahCr0T3Woyx8lYXFk8poff7xEDZcI+L+kKOeKqe1Ctn5l5gslFVOILps0gHN
         YUab2uaxMFvmLkUGEewqrg9GRnIMIW7LjQ4DP42N64j5CkDF0yYN7ZiVz1oOluOy5lpU
         k8aE9jkzNEWCW0sy57W8ETt1tMx7z1glBUVCWQjxFTRLUb4FA8VXYnZexPuVeeUm3wmC
         BRyJCBtpM/ZBSO5qphimMOy2tm12hFC75XmYgrGnniLJmBRvdU0l74PmX187mfp2O6/S
         9gmcUrYVkGMBzK7TQ2TiVMd3q7lMe4eopFY+XOBMiLhnAUOmmkT3701IDXnz/z2NymhA
         CDhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787516170; x=1788120970;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MfartcHqwqCIhFwvC4CwiIrHlgQajx9zG1o6pHu7jNE=;
        b=RGSvEICmjJxaymwqFVOP7aQUKBKAOAfqXBsmruIB7L85KacCCIGTntJWDoSO39KK3C
         RpuDYojeq9534WmcO3uNgvfQ2pCl2G4806y8qEcOw2fAQM8vWnW1iAtaBMGCeG2Ovv47
         vZeggLDKzHLQhogKQh8TJJHUKnnbOznlzv07FL/CRq+Nx/m4DP2a7BhSOuisvYRUxuqc
         6J53q4KNu2PeUcvdTISaz3JgggBh4Lcm9gEyqHtNK2svNJ6JPTKyQETQarlIkn+tYzXU
         F8NW1SMYseV2Cs7MZImj4KPSWOmiJQKSaCXhbciAai8rEFKqpfk6wJfQIBBU/E1adhra
         WBOg==
X-Forwarded-Encrypted: i=1; AHgh+Rr5okrxTJIlcgcv4mAeycIy4gs4D6mKzY3TDza76SQYh3qdReWfUXzWL2wyTbCDXXXV8Ns3zKqtMg==@lists.infradead.org
X-Gm-Message-State: AFuF++nT0pKU8F5nYFm27xHdeSYoCUvjPM4Rfl+imVkA1gId9NwW22gy
	lKqfw+j64uduCLz23ZCW3f14tu/CfVj7PP3a5X6gCn2LsH675SHy+5+KLtxJBL+zfro=
X-Gm-Gg: AR+sD12em4HJO3FkG0CBRR/W9PBGKxzOQz+24A0Y35mFVVv9G3ADCY356K53mrSu8XZ
	sPZJd/Ymh30iSiGbzyTJJ2LQ6UA5TZ+OxNDNc5tjE9en9Zn+PwxmVeAoNz/8cnFc9+kieV9XeBj
	vV83YvSgjI64Y/oaSVG5RuD3vPuEbDoze4H5sSIKoDcVsMvAZCY0rBQakwErE1stuNjtSG1ZVcY
	Nnk9V1uhdBkW7gKPuNafN7MvSEeyLC26eFVIWQj0yXwTjeIAsWUh3lbdnE/+Bvl8yFzHebO1dEb
	lOIBCwgQNHS5orpYYH5ewq1KXzskwV+3Bascc9BvRB6xlWx4GdnUC4Mrdlc7efhw+N6iUH7fa1c
	ObyFP83r7HiHieVztfWTTXcext8y3QKCKlrC+S+IGEoYRMMNYrBP50m/K1+HEfM8RuuE5NFQdXF
	6xw/XYmFeKpEEaes6yO8byQF+Q5zy3maAsNpMs9FVh8lPeTAdvCm9/ot9RXEQ4tQ5jyL12/rVKT
	WWkLqW8FJgWU7/QaR/hT+oY7Z892CugiZyPSpoiOsak8LnoAn52ihPpqL0GUI7+wBB7a7mozp0a
	TZwX0HGBvF46w5ezr30fPH+7TZSmdf1tgRVHfyCpibKMqARvifWa2m1hTA==
X-Received: by 2002:a17:907:c8c6:b0:c1f:1520:4de5 with SMTP id a640c23a62f3a-c249257c128mr1492980966b.1.1787516169331;
        Sun, 23 Aug 2026 13:16:09 -0700 (PDT)
Received: from ms-103.premium-rootserver.net ([193.32.222.77])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c249606a8fasm1010651166b.8.2026.08.23.13.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 13:16:08 -0700 (PDT)
From: Fabian Franz <fabian@isomorphic-ai.com>
To: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Fabian Franz <fabian@isomorphic-ai.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	"Xin Li (Intel)" <xin@zytor.com>,
	Ingo Molnar <mingo@kernel.org>
Cc: Claude Fable 5 <noreply@anthropic.com>,
	linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH REGRESSION] um: Fix cpu_feature_enabled() build breakage
Date: Sun, 23 Aug 2026 22:14:58 +0200
Message-ID: <20260823201521.2576344-1-fabian@isomorphic-ai.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260823_131612_898044_58E7D74A 
X-CRM114-Status: GOOD (  17.48  )
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

Since commit 3ed403bbc967 ("treewide: Remove CLOCK_TICK_RATE") deleted
the (otherwise empty) arch/um/include/asm/timex.h, UML builds resolve
<asm/timex.h> to arch/x86/include/asm/timex.h via the HEADER_ARCH
include path.  That pulls <asm/tsc.h>, whose get_cycles() uses
cpu_feature_enabled(), into virtually every translation unit, starting
with asm-offsets.c.  This newly expands parts of UML's copy of
<asm/cpufeature.h> that no longer compile, and "make ARCH=um" now dies
in prepare0:

  arch/um/include/asm/cpufeature.h:52:39: error: implicit declaration
    of function 'DISABLED_MASK_BIT_SET'
  arch/um/include/asm/cpufeature.h:115:17: error: implicit declaration
    of function '_static_cpu_has'; did you mean '__static_cpu_has'?

Two independent breakages meet here:

 1. cpu_feature_enabled() and this_cpu_has() still test
    DISABLED_MASK_BIT_SET()/REQUIRED_MASK_BIT_SET().  Those used to
    come from <asm/disabled-features.h>/<asm/required-features.h> via
    <asm/cpufeatures.h>, but since commit 8f97566c8a81
    ("x86/cpufeatures: Remove {disabled,required}-features.h") they
    live in the generated <asm/cpufeaturemasks.h>, which only the
    arch/x86 archprepare rule generates.  ARCH=um never generates nor
    includes it, so the references have been dangling since then.

 2. The _static_cpu_has() macro expands to itself.  Commit
    3eaa50e1e255 ("x86/cpu: Hide and rename static_cpu_has()") renamed
    the inline function _static_cpu_has() -> __static_cpu_has() and
    the macro static_cpu_has() -> _static_cpu_has(), but in the UML
    header the macro's out-of-line branch kept calling
    _static_cpu_has(), which now names the macro itself and is left
    unexpanded by the preprocessor.

Fix the macro to call __static_cpu_has(), as the x86 header does, and
drop the mask based short-circuits from cpu_feature_enabled() and
this_cpu_has().  UML has no compile-time feature masking to express:
capabilities are copied from the host's CPUID at boot, see commit
d8fb32f4790f ("um: Add support for host CPU flags and alignment"),
and generating cpufeaturemasks.h from a UML .config would wrongly
mark features disabled simply because the gating CONFIG_X86_* symbols
do not exist for ARCH=um.

Fixes: 3eaa50e1e255 ("x86/cpu: Hide and rename static_cpu_has()")
Fixes: 8f97566c8a81 ("x86/cpufeatures: Remove {disabled,required}-features.h")
Signed-off-by: Fabian Franz <fabian@isomorphic-ai.com>
Assisted-By: Claude Fable 5 <noreply@anthropic.com>
---
 arch/um/include/asm/cpufeature.h | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/um/include/asm/cpufeature.h b/arch/um/include/asm/cpufeature.h
index f7770083c0a4..20b2c7ead62e 100644
--- a/arch/um/include/asm/cpufeature.h
+++ b/arch/um/include/asm/cpufeature.h
@@ -37,8 +37,7 @@ extern const char * const x86_bug_flags[NBUGINTS*32];
 	 test_cpu_cap(c, bit)
 
 #define this_cpu_has(bit)						\
-	(__builtin_constant_p(bit) && REQUIRED_MASK_BIT_SET(bit) ? 1 :	\
-	 x86_this_cpu_test_bit(bit, cpu_info.x86_capability))
+	 x86_this_cpu_test_bit(bit, cpu_info.x86_capability)
 
 /*
  * This macro is for detection of features which need kernel
@@ -48,8 +47,7 @@ extern const char * const x86_bug_flags[NBUGINTS*32];
  * supporting a possible guest feature where host support for it
  * is not relevant.
  */
-#define cpu_feature_enabled(bit)	\
-	(__builtin_constant_p(bit) && DISABLED_MASK_BIT_SET(bit) ? 0 : _static_cpu_has(bit))
+#define cpu_feature_enabled(bit)	_static_cpu_has(bit)
 
 #define boot_cpu_has(bit)	cpu_has(&boot_cpu_data, bit)
 
@@ -112,7 +110,7 @@ static __always_inline bool __static_cpu_has(u16 bit)
 (								\
 	__builtin_constant_p(boot_cpu_has(bit)) ?		\
 		boot_cpu_has(bit) :				\
-		_static_cpu_has(bit)				\
+		__static_cpu_has(bit)				\
 )
 
 #define cpu_has_bug(c, bit)		cpu_has(c, (bit))
-- 
2.43.0

Every ARCH=um build has failed since the 7.3 merge window.

#regzbot introduced: 3ed403bbc967

Steps to reproduce on master:

make ARCH=um O=/tmp/um-build defconfig
make ARCH=um O=/tmp/um-build -j$(nproc)

fails with:

/home/ubuntu/projects/linux/arch/x86/include/asm/tsc.h: In function ‘get_cycles’:
/home/ubuntu/projects/linux/arch/um/include/asm/cpufeature.h:52:39: error: implicit declaration of function ‘DISABLED_MASK_BIT_SET’ [-Werror=implicit-function-declaration]
   52 |         (__builtin_constant_p(bit) && DISABLED_MASK_BIT_SET(bit) ? 0 : _static_cpu_has(bit))
      |                                       ^~~~~~~~~~~~~~~~~~~~~
/home/ubuntu/projects/linux/arch/x86/include/asm/tsc.h:79:14: note: in expansion of macro ‘cpu_feature_enabled’
   79 |         if (!cpu_feature_enabled(X86_FEATURE_TSC))
      |              ^~~~~~~~~~~~~~~~~~~
/home/ubuntu/projects/linux/arch/um/include/asm/cpufeature.h:115:17: error: implicit declaration of function ‘_static_cpu_has’; did you mean ‘__static_cpu_has’? [-Werror=implicit-function-declaration]
  115 |                 _static_cpu_has(bit)                            \
      |                 ^~~~~~~~~~~~~~~
/home/ubuntu/projects/linux/arch/um/include/asm/cpufeature.h:52:72: note: in expansion of macro ‘_static_cpu_has’
   52 | builtin_constant_p(bit) && DISABLED_MASK_BIT_SET(bit) ? 0 : _static_cpu_has(bit))
      |                                                             ^~~~~~~~~~~~~~~

If this is known please disregard. I am also not 100% sure if this is the right fix or if it's better to bring back the macros to um.

In any case it would be good for um to build again on the master branch out of the box.

Thanks,
Fabian

