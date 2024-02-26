Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16265C54E4A
	for <linux-um@archiver.kernel.org>; Mon, 26 Feb 2024 16:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3wyrgywYZHl7/A9Ukk2gWYi1jSb3cWkq9VxgHuqOsg0=; b=qsL+7hsZyuDFQCJhzHWfAPa48A
	SdOSuuX3pRcsbkB38BnSFHq4nCFNAcNM++oNkdxc2fwA1YYk8qjg4hQWprW28DyGC8D3MK3gx96lu
	e6KWSbvEswFHUr4Idunkvt3o78WRwx110hrhfGPExXRjn+F/2xKcbMKIdcTb5rKZzGYZEl+ANmA8M
	1xU/I7YdHWPTP65XobjzIszgXqVbKBvePdg27It05SwX3/2aIbz1adn7eC3oS5MiYdOydx2MxK8hj
	XF3yLFZ80TdkLUGbTmwTYOygSkWmfaGtYXvjhClJhed8FNaYHlkUhd9/Cq1zbLYxH599jNKhMC9Eh
	GFrPkp7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1reddz-00000001br0-0eNp;
	Mon, 26 Feb 2024 16:15:55 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1reddJ-00000001bNQ-2v5Z;
	Mon, 26 Feb 2024 16:15:18 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id C2BDDCE18A4;
	Mon, 26 Feb 2024 16:15:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC888C433B2;
	Mon, 26 Feb 2024 16:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708964110;
	bh=AO14Twor4Epqfova99BdXRAOjLIWQcQyPi3BUqYZmuA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZiZAMuXYiDyR2hDknZ4xgVy8TWczoqlYaz+54BPEoKIfJs4BSV182oJ1ZYu9Y5JbD
	 WmVlYt52eCJD6AGhn7U0y3EC75bLKVFGbI7wGmXiVDKgZPTwDaVuTJTSVkJKvUISzS
	 2XRA3a5n6YOmUElWz/EoUJbwtBXGMm0MnBobEcfj+6UoFFgUN+ewdn1/f3BBURGCAf
	 oK4FRWPsN9e+IXZu64v2vjYmcNQRQ8eM254ceqdZ/GIQhQ58ktIQY1PjwK8pNlnHUX
	 azFtrkzqYG46sjmhqFVs4snXAZo3hTMRuuCQkCC5flzHnC0ice4Qu8BYIkByoxWD5F
	 EP1u+qVkKv5IQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Kees Cook <keescook@chromium.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Matt Turner <mattst88@gmail.com>,
	Vineet Gupta <vgupta@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Guo Ren <guoren@kernel.org>,
	Brian Cain <bcain@quicinc.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Michal Simek <monstr@monstr.eu>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Helge Deller <deller@gmx.de>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Andreas Larsson <andreas@gaisler.com>,
	Richard Weinberger <richard@nod.at>,
	x86@kernel.org,
	Max Filippov <jcmvbkbc@gmail.com>,
	Andy Lutomirski <luto@kernel.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Kieran Bingham <kbingham@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	linux-alpha@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-um@lists.infradead.org,
	Linux Kernel Functional Testing <lkft@linaro.org>
Subject: [PATCH 4/4] vdso: avoid including asm/page.h
Date: Mon, 26 Feb 2024 17:14:14 +0100
Message-Id: <20240226161414.2316610-5-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240226161414.2316610-1-arnd@kernel.org>
References: <20240226161414.2316610-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240226_081514_400896_DAD0BABB 
X-CRM114-Status: GOOD (  12.07  )
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

From: Arnd Bergmann <arnd@arndb.de>

The recent change to the vdso_data_store broke building compat VDSO
on at least arm64 because it includes headers outside of the include/vdso/
namespace:

In file included from arch/arm64/include/asm/lse.h:5,
                 from arch/arm64/include/asm/cmpxchg.h:14,
                 from arch/arm64/include/asm/atomic.h:16,
                 from include/linux/atomic.h:7,
                 from include/asm-generic/bitops/atomic.h:5,
                 from arch/arm64/include/asm/bitops.h:25,
                 from include/linux/bitops.h:68,
                 from arch/arm64/include/asm/memory.h:209,
                 from arch/arm64/include/asm/page.h:46,
                 from include/vdso/datapage.h:22,
                 from lib/vdso/gettimeofday.c:5,
                 from <command-line>:
arch/arm64/include/asm/atomic_ll_sc.h:298:9: error: unknown type name 'u128'
  298 |         u128 full;

Use an open-coded page size calculation based on the new CONFIG_PAGE_SHIFT
Kconfig symbol instead.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Fixes: a0d2fcd62ac2 ("vdso/ARM: Make union vdso_data_store available for all architectures")
Link: https://lore.kernel.org/lkml/CA+G9fYtrXXm_KO9fNPz3XaRxHV7UD_yQp-TEuPQrNRHU+_0W_Q@mail.gmail.com/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/vdso/datapage.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
index 7ba44379a095..2c39a67d7e23 100644
--- a/include/vdso/datapage.h
+++ b/include/vdso/datapage.h
@@ -19,8 +19,6 @@
 #include <vdso/time32.h>
 #include <vdso/time64.h>
 
-#include <asm/page.h>
-
 #ifdef CONFIG_ARCH_HAS_VDSO_DATA
 #include <asm/vdso/data.h>
 #else
@@ -128,7 +126,7 @@ extern struct vdso_data _timens_data[CS_BASES] __attribute__((visibility("hidden
  */
 union vdso_data_store {
 	struct vdso_data	data[CS_BASES];
-	u8			page[PAGE_SIZE];
+	u8			page[1ul << CONFIG_PAGE_SHIFT];
 };
 
 /*
-- 
2.39.2


