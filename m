Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8375C43602
	for <linux-um@archiver.kernel.org>; Tue,  7 Jul 2026 19:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:Subject:Cc:To:From:Message-ID:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=On6NfRZNP83GQAwWkJi2QY5gy7RW6c7PPEtomv7P1Dc=; b=TbFVSNKisHkcHz
	c4naTX2U1UzSV39+UexGLsXPorUpNsg9ay5cxnYH6o2rXncM1QUW/0puhm9vxtu5NTH0jhzyfgNj3
	M1giOAVa4PNrvcHb9mkNVLlL591Y3YGxBuR7eqCoNclhONl/HXImjs/t+GTqgXXVKaMbAWVzp7M7X
	2o+xEelSNCVuYHY814MFKSqGeDInODxRiBpi3aqevK+KSsgAUJ8L8cJXamGQGL3LvsNPWCO95M/JN
	g4291KOUf8F7W4suztPO4SbA4L6bJ4Ogwu9KHW6+GfW2nP4M9mUh4eN0PCTI4hav9pm1I1tQBOioE
	/fqJM7wX+IEKziNFMvHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whB7V-0000000FgnT-22EW;
	Tue, 07 Jul 2026 19:06:13 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whB7O-0000000Fghv-1jSF;
	Tue, 07 Jul 2026 19:06:06 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id A2DD86138A;
	Tue,  7 Jul 2026 19:06:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 836131F00A3A;
	Tue,  7 Jul 2026 19:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783451165;
	bh=On6NfRZNP83GQAwWkJi2QY5gy7RW6c7PPEtomv7P1Dc=;
	h=Date:From:To:Cc:Subject:References;
	b=Kyf4FHpFsIS+Ydmvpd4dDjaw6LA3z5qA3tk9jQCRiEW5qX1inNO9gy7FOgieh3baY
	 hYOJJlHaPUBmLHJ7GT1+snJJu9GDe/I9LBY8DO5JtbHEjuAUTNBhEUGadk4Jt3mT6M
	 jfM460+qa8cBdINqLxhonst5REsB87hmc78d5eqMEOoD5gBYWK0lJNv1XzAl9UsuvK
	 VcyLhfQ5RZnjt+w12lkO4zxWbhBNKXx+std7IviKWtj5txrPrCsYKXUlRXGm9L5b6C
	 x3lWCb9/6igNz1lMUWNia6Ofl2ESSU4en1Tc99OlWes1QnxVBl0HIc9O5ffHHzCd75
	 Lv0AL/D7KjB7Q==
Date: Tue, 07 Jul 2026 21:06:02 +0200
Message-ID: <20260707190253.768842729@kernel.org>
User-Agent: quilt/0.69
From: Thomas Gleixner <tglx@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Kees Cook <kees@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Shrikanth Hegde <sshegde@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org,
 Huacai Chen <chenhuacai@kernel.org>,
 loongarch@lists.linux.dev,
 Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 linux-riscv@lists.infradead.org,
 Sven Schnelle <svens@linux.ibm.com>,
 linux-s390@vger.kernel.org,
 x86@kernel.org,
 Mark Rutland <mark.rutland@arm.com>,
 Jinjie Ruan <ruanjinjie@huawei.com>,
 Andy Lutomirski <luto@kernel.org>,
 Oleg Nesterov <oleg@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Guo Ren <guoren@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Helge Deller <deller@gmx.de>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Richard Weinberger <richard@nod.at>,
 Chris Zankel <chris@zankel.net>,
 linux-arm-kernel@lists.infradead.org,
 linux-alpha@vger.kernel.org,
 linux-csky@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org,
 linux-sh@vger.kernel.org,
 linux-um@lists.infradead.org,
 Arnd Bergmann <arnd@arndb.de>,
 Vineet Gupta <vgupta@kernel.org>,
 Will Deacon <will@kernel.org>,
 Brian Cain <bcain@kernel.org>,
 Michal Simek <monstr@monstr.eu>,
 Dinh Nguyen <dinguyen@kernel.org>,
 "David S. Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>,
 linux-snps-arc@lists.infradead.org,
 linux-hexagon@vger.kernel.org,
 linux-openrisc@vger.kernel.org,
 sparclinux@vger.kernel.org,
 linux-arch@vger.kernel.org,
 =?UTF-8?q?Michal=20Such=C3=A1nek?= <msuchanek@suse.de>,
 Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org
Subject: [patch 02/18] randomize_kstack: Provide
 add_random_kstack_offset_irqsoff()
References: <20260707181957.433213175@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

add_random_kstack_offset() uses get/put_cpu_var() which is pointless
overhead when it is invoked from low level entry code with interrupts
disabled.

Provide a irqsoff() variant, which avoids that.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: Kees Cook <kees@kernel.org>
---
 include/linux/randomize_kstack.h |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

--- a/include/linux/randomize_kstack.h
+++ b/include/linux/randomize_kstack.h
@@ -77,8 +77,27 @@ static __always_inline u32 get_kstack_of
 	}								\
 } while (0)
 
+/**
+ * add_random_kstack_offset_irqsoff - Increase stack utilization by a random offset.
+ *
+ * This should be used in the syscall entry path after user registers have been
+ * stored to the stack. Interrupts must be still disabled.
+ */
+#define add_random_kstack_offset_irqsoff()					\
+do {										\
+	lockdep_assert_irqs_disabled();						\
+	if (static_branch_maybe(CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT,		\
+				&randomize_kstack_offset)) {			\
+		u32 offset = prandom_u32_state(raw_cpu_ptr(&kstack_rnd_state));	\
+		u8 *ptr = __kstack_alloca(KSTACK_OFFSET_MAX(offset));		\
+		/* Keep allocation even after "ptr" loses scope. */		\
+		asm volatile("" :: "r"(ptr) : "memory");			\
+	}									\
+} while (0)
+
 #else /* CONFIG_RANDOMIZE_KSTACK_OFFSET */
 #define add_random_kstack_offset()		do { } while (0)
+#define add_random_kstack_offset_irqsoff()	do { } while (0)
 #endif /* CONFIG_RANDOMIZE_KSTACK_OFFSET */
 
 #endif


