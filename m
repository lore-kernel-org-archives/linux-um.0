Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43AD0C5B572
	for <linux-um@archiver.kernel.org>; Wed, 19 Aug 2026 07:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=EQY4lYfSjKr4PpB6AAQMW75bVYVGW3TtlFS7Uv6QJ14=; b=xxUmcnjhmRnxCgBy0q5tiKEr0/
	zkN8gty2xP5+jN3eH9OmjmP0RtyLKn4W2j35OCR3yVsrNilDAQPMYnaKHGWdejvlHZ38o3eurJtUM
	fNcubXlsX9VWkcsNUgnS+555ExjnIgS3v002TTzE21+tq99YfpuUEfWe9RWCqeb6GlIzQdd14wBzg
	CnxKdapyuOIpNvweqF+wUXd1upDpsdthGp+s23B2dfwQZruiHeZlVNfeokbahf8kd+Q77seZieGQf
	r2KyFdSKxFBnzyZSTHTVZYVGg/hBYVSTCTPWiXcwlXEFiWZjG7wQ3yN53H8xQfQQ1HV/4Ru42CxwJ
	oP+EueHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwafK-00000009BeE-1T1z;
	Wed, 19 Aug 2026 07:24:50 +0000
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwafG-00000009Bc3-1L1k
	for linux-um@lists.infradead.org;
	Wed, 19 Aug 2026 07:24:49 +0000
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1787124280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EQY4lYfSjKr4PpB6AAQMW75bVYVGW3TtlFS7Uv6QJ14=;
	b=TtcHsrtd7LbciiPT5CqZqexhBQjrlgMhzYINjW4Pb1YTBgpOpDKwbBCmfVeN8Pd3JxhdKW
	CsisCSJZV6KnZ4SsVuhAa+e94llPwie34FOyyT+vs544x25iUNz3Hj+BxMip3JzqME/Prm
	uKihQnerJTr2816KWg5V0x0KZNzJXdF/dhZ6sODKXdVsOrQ+xwWuT2kXEfjGtJnNbhg01g
	ETLwhOkn3JE9YbKk5nJQXwQUjX5oDNfPfFhAwapCoNqRH8Csrt8nAbwq48fGKi2Od/QyUz
	Xdnh2BFuAZj8UURbflyXhkTTS6t5tSP/TYm8MzetZTQXLcIfGwT49dr2I17vtg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1787124280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EQY4lYfSjKr4PpB6AAQMW75bVYVGW3TtlFS7Uv6QJ14=;
	b=mmfQEFEfG/xsZBOYmmPu8SU4yNC7SC3aWrotjSczwy1U+1hjYipi9hF4MzwRjanE4+CBtq
	F7BF3B0pDWd+BHBw==
Date: Wed, 19 Aug 2026 09:24:21 +0200
Subject: [PATCH] um: Use asm-generic/timex.h over the host architecture one
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260819-uml-timex-fix-v1-1-f690b514fc9f@linutronix.de>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDC0NL3dLcHN2SzNzUCt20TCBOTk4yMk+zTE40NVQC6ikoSgUKg82Ljq2
 tBQC5DzQaXwAAAA==
X-Change-ID: 20260819-uml-timex-fix-fccb27f9ca51
To: Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787124280; l=4020;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=tHDwcgAZMoxa8cs//lflo9gpD1lGzjqnAoYCTvKTzLA=;
 b=bMCjxOBKdO0QmnI3s6XYe1DjHkSVnVI58xDDVJ90V4v7jHaD9r2GyogQW8ruH8657HOQheQwu
 IRxM44uZVy0DZf7pPO4JTmR0CKmku62KCj5RjpZhW8P9b9RqD5IYHEn
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260819_002446_525819_0A072CEE 
X-CRM114-Status: UNSURE (   9.73  )
X-CRM114-Notice: Please train this message.
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

The removal of the architecture-specific asm/timex.h was meant to fall
back to asm-generic/timex.h. However on UML, the host architecture
headers are earlier on the include path and therefore asm/timex.h from
the host architecture is used.
On x86 that header in turn requires the generation of cpufeaturemasks.h,
which is not set up for UML and the build fails.

In file included from ../arch/x86/include/asm/tsc.h:9,
                 from ../arch/x86/include/asm/timex.h:6,
                 from ../include/linux/timex.h:67,
                 from ../include/linux/time32.h:13,
                 from ../include/linux/time.h:60,
                 from ../include/linux/jiffies.h:10,
                 from ../include/linux/ktime.h:25,
                 from ../include/linux/timer.h:6,
                 from ../include/linux/uprobes.h:18,
                 from ../include/linux/mm_types.h:16,
                 from ../include/linux/mmzone.h:22,
                 from ../include/linux/gfp.h:7,
                 from ../include/linux/slab.h:17,
                 from ../include/linux/crypto.h:18,
                 from ../arch/um/kernel/asm-offsets.c:6:
arch/x86/include/asm/tsc.h: In function ‘get_cycles’:
arch/um/include/asm/cpufeature.h:52:39: error: implicit declaration of function ‘DISABLED_MASK_BIT_SET’ [-Wimplicit-function-declaration]
   52 |         (__builtin_constant_p(bit) && DISABLED_MASK_BIT_SET(bit) ? 0 : _static_cpu_has(bit))
      |                                       ^~~~~~~~~~~~~~~~~~~~~
arch/x86/include/asm/tsc.h:79:14: note: in expansion of macro ‘cpu_feature_enabled’
   79 |         if (!cpu_feature_enabled(X86_FEATURE_TSC))
      |              ^~~~~~~~~~~~~~~~~~~
arch/um/include/asm/cpufeature.h:115:17: error: implicit declaration of function ‘_static_cpu_has’ [-Wimplicit-function-declaration]
  115 |                 _static_cpu_has(bit)                            \
      |                 ^~~~~~~~~~~~~~~
arch/um/include/asm/cpufeature.h:52:72: note: in expansion of macro ‘_static_cpu_has’
   52 |         (__builtin_constant_p(bit) && DISABLED_MASK_BIT_SET(bit) ? 0 : _static_cpu_has(bit))
      |                                                                        ^~~~~~~~~~~~~~~
arch/x86/include/asm/tsc.h:79:14: note: in expansion of macro ‘cpu_feature_enabled’
   79 |         if (!cpu_feature_enabled(X86_FEATURE_TSC))
      |              ^~~~~~~~~~~~~~~~~~~
arch/um/include/asm/cpufeature.h:115:17: note: ‘_static_cpu_has’ is a function-like macro and might be used incorrectly
arch/um/include/asm/cpufeature.h:52:72: note: in expansion of macro ‘_static_cpu_has’
   52 |         (__builtin_constant_p(bit) && DISABLED_MASK_BIT_SET(bit) ? 0 : _static_cpu_has(bit))
      |                                                                        ^~~~~~~~~~~~~~~
arch/x86/include/asm/tsc.h:79:14: note: in expansion of macro ‘cpu_feature_enabled’
   79 |         if (!cpu_feature_enabled(X86_FEATURE_TSC))
      |              ^~~~~~~~~~~~~~~~~~~

The x86-specific timex.h also doesn't make sense on UML in general.

Reintroduce the UML-specific asm/timex.h and add a comment to document
its necessity.

Fixes: 3ed403bbc967 ("treewide: Remove CLOCK_TICK_RATE")
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/um/include/asm/timex.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/um/include/asm/timex.h b/arch/um/include/asm/timex.h
new file mode 100644
index 000000000000..dfb4f460fb87
--- /dev/null
+++ b/arch/um/include/asm/timex.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __UM_TIMEX_H
+#define __UM_TIMEX_H
+
+/* Do not fall back to the host architecture header. */
+#include <asm-generic/timex.h>
+
+#endif

---
base-commit: bd5f485f3f026225b86573e559af0b7254ef4184
change-id: 20260819-uml-timex-fix-fccb27f9ca51

Best regards,
--  
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


