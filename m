Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99F5FC43602
	for <linux-um@archiver.kernel.org>; Tue,  7 Jul 2026 19:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:Subject:Cc:To:From:Message-ID:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=bqcx1niI7ioy3DW+/gZQ2MbLYJEE35hyG+fCdizbDSo=; b=YeW+c87CE1+LaH
	iDTfFBg/Fy/odgU/iUT4qTosdadMF1za5FF7wtprQAEqvMpPxkqmcYGoRGkZenFn5RDXCsPDg8AKh
	7rfMJU2Zc3ZJEbt0avqoDRpobrr+ahy3bFl9+CFBdkqQpjBJkBc3TYYACNEhXTxaJ9JVWuXTUry3E
	BGmxRVMXTgRo+7eFiNqJ5EJDqYthKwpc7Nfo2GCP5zfFlzs4FI5DJAigkpghN0brlZ/rZvyyb+Tks
	FLYzJYxJrypO4ll0fXeB3KxWESqjQGH/BSoFnQWKFINj1fDBEtO0/Sywrv6zsk791NXGbWXpqo72R
	gsuxWL7SWs3a2v7P7TjQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whB7n-0000000Fh4m-1anT;
	Tue, 07 Jul 2026 19:06:31 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whB7a-0000000Fgux-37Eh;
	Tue, 07 Jul 2026 19:06:18 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 2C56B601EC;
	Tue,  7 Jul 2026 19:06:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14E0D1F00A3A;
	Tue,  7 Jul 2026 19:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783451177;
	bh=bqcx1niI7ioy3DW+/gZQ2MbLYJEE35hyG+fCdizbDSo=;
	h=Date:From:To:Cc:Subject:References;
	b=aJaRZSNFmGdCFvruVG7x5xRrvggSIGN0GND+eCq7/up7llJN2RLb5yTt7nKiF5bMl
	 dDjbHacdEwTpP5I1/lusznloh2jALXKsApluk4rrQ6UjQSVw3qYVOOw6/ktRrDvDFv
	 6mM4CdAeBuHePM8toFrWSjVi5vf12es33TiR0Erbaqy0+HMgOhtPrzfLuSaVmJcBBf
	 Qwx11aY+YPFSRPD5t62E+zU8M90fmxRE9JPIpsU8ZmTyzhptaz9i1jNQWCYVnDIzEX
	 +BqGBqk3JLQ87YaLjGkYNumyEdOthBs5KZUcJ25lEB3+VQ9NuYSR6XQbeSkS9Uk7wj
	 gTZuo3rzjPU7w==
Date: Tue, 07 Jul 2026 21:06:15 +0200
Message-ID: <20260707190253.918861529@kernel.org>
User-Agent: quilt/0.69
From: Thomas Gleixner <tglx@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Shrikanth Hegde <sshegde@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org,
 Kees Cook <kees@kernel.org>,
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
Subject: [patch 05/18] powerpc/syscall: Use
 syscall_enter_from_user_mode_randomize_stack()
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

syscall_enter_from_user_mode_randomize_stack() replaces
syscall_enter_from_user_mode() and the subsequent invocation of
add_random_kstack_offset().

The advantage is that it applies the stack randomization right after
enter_from_user_mode() and thereby avoids the overhead of get/put_cpu_var()
as that code is invoked with interrupts disabled.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/kernel/syscall.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/arch/powerpc/kernel/syscall.c
+++ b/arch/powerpc/kernel/syscall.c
@@ -2,7 +2,6 @@
 
 #include <linux/compat.h>
 #include <linux/context_tracking.h>
-#include <linux/randomize_kstack.h>
 #include <linux/entry-common.h>
 
 #include <asm/interrupt.h>
@@ -19,8 +18,7 @@ notrace long system_call_exception(struc
 	long ret;
 	syscall_fn f;
 
-	r0 = syscall_enter_from_user_mode(regs, r0);
-	add_random_kstack_offset();
+	r0 = syscall_enter_from_user_mode_randomize_stack(regs, r0);
 
 	if (unlikely(r0 >= NR_syscalls)) {
 		if (unlikely(trap_is_unsupported_scv(regs))) {


