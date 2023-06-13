Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DCD6C001B0
	for <linux-um@archiver.kernel.org>; Tue, 13 Jun 2023 23:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:MIME-Version:References:Subject:Cc
	:To:From:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=YJyxiX03Ty/K6+unBYhTWw9xl4/5SwTHTbyqMtVUws0=; b=PQj4eRF1oGHAf9
	kLyVXmUFYBvbHY/EU8jLbAYo+4DtDq9yobr0nqM5kZaFQnluzULwZgamH8sykArKJ2nZ5i8ZsnThG
	K1dREZE+9QQAlO/SmTyS371+M5mDPzhmUhbMfjLQ6tNtfmm3ehrVt/g6Yw0lVD3uzJ1V+3gui/HYX
	Al4q1p/GkYTcMFfke+/trHucj6xd/VQcHuJQyUNmORoVRDSkN5REkBDckxB2xRJ78VG7nBjAMgAKA
	h4+spAFyLS6F/8DSw4VcHuNj+WC3Y9ISn2YlVwvxv0PTEMQ0Fihd/to07/ZyPzTnwNtDW4NON5AIF
	1CSIEg8vtxn5ewwMgu8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q9Dcc-009RzD-05;
	Tue, 13 Jun 2023 23:40:22 +0000
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q9Dbu-009RNG-1G;
	Tue, 13 Jun 2023 23:39:48 +0000
Message-ID: <20230613224545.493148694@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1686699577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=lUDXX8ko/KTY3Fmll0qcD/JZgWuXrZZ2If6VXK8TUa4=;
	b=ArkztmtVLr3xVxaqYrS8WoFCX53KbdJb76bpB2UundZYc1fDeHsn7vlQ8Qnk0H6lgWS+xg
	1/YkdQdsguLbon5owD0gZyyLfrOqL1/0924vPfQu6loPVZT902dG1DjCOkvKL3WHvGXCd9
	kARO1P5fNBmxeLuHrOu72Ti7cHlr7FBwXSV6pA4+F0ZJInTWFjMMz14xAuSSAtWDoJZW98
	BordYwd3JAkB7P6QYHb8lN/vDY6K4dGNEK6lsQvXTHlyfCo7BgwCj8eYUrG8ZlNOhuL1pn
	u6cLS9XnfPA4ZGvJ9aNZdTv+ys/Km6CLvkq80JO3Nu/ZgHBw/AsN712sOdLZmA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1686699577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=lUDXX8ko/KTY3Fmll0qcD/JZgWuXrZZ2If6VXK8TUa4=;
	b=e9amJQKHZkUpaaomQ1NYmqFdC+msPtjjGEras5FqpvKNXcBc9xqq+1Cwq8OBPViAjP+9Ya
	rK2vv0C5jO38/fAA==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Nikolay Borisov <nik.borisov@suse.com>,
 "Ahmed S. Darwish" <darwi@linutronix.de>,
 Arnd Bergmann <arnd@arndb.de>,
 Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 linux-um@lists.infradead.org,
 Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org,
 linux-ia64@vger.kernel.org,
 Huacai Chen <chenhuacai@kernel.org>,
 WANG Xuerui <kernel@xen0n.name>,
 loongarch@lists.linux.dev,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-m68k@lists.linux-m68k.org,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 linux-mips@vger.kernel.org,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Rich Felker <dalias@libc.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 linux-sh@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>,
 sparclinux@vger.kernel.org,
 Richard Henderson <richard.henderson@linaro.org>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Chris Zankel <chris@zankel.net>,
 Tom Lendacky <thomas.lendacky@amd.com>
Subject: [patch 10/17] um/cpu: Switch to arch_cpu_finalize_init()
References: <20230613223827.532680283@linutronix.de>
MIME-Version: 1.0
Date: Wed, 14 Jun 2023 01:39:36 +0200 (CEST)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230613_163938_601733_1F604D38 
X-CRM114-Status: UNSURE (   9.93  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

check_bugs() is about to be phased out. Switch over to the new
arch_cpu_finalize_init() implementation.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-um@lists.infradead.org
---
 arch/um/Kconfig            |    1 +
 arch/um/include/asm/bugs.h |    7 -------
 arch/um/kernel/um_arch.c   |    3 ++-
 3 files changed, 3 insertions(+), 8 deletions(-)

--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -6,6 +6,7 @@ config UML
 	bool
 	default y
 	select ARCH_EPHEMERAL_INODES
+	select ARCH_HAS_CPU_FINALIZE_INIT
 	select ARCH_HAS_FORTIFY_SOURCE
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_HAS_KCOV
--- a/arch/um/include/asm/bugs.h
+++ /dev/null
@@ -1,7 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __UM_BUGS_H
-#define __UM_BUGS_H
-
-void check_bugs(void);
-
-#endif
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2000 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
  */
 
+#include <linux/cpu.h>
 #include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/mm.h>
@@ -430,7 +431,7 @@ void __init setup_arch(char **cmdline_p)
 	}
 }
 
-void __init check_bugs(void)
+void __init arch_cpu_finalize_init(void)
 {
 	arch_check_bugs();
 	os_check_bugs();


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
