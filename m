Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 213D9C43602
	for <linux-um@archiver.kernel.org>; Tue,  7 Jul 2026 19:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:Subject:Cc:To:From:Message-ID:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=EqhpiB2ZofNX2Hns8Xgz4OVDOubexQBaPatIimxnT/c=; b=OjO3sZUDGG4yPE
	l2x7tWGrR+f9iL5vCgnlPQlEisrvxfWVtNYzUAIpGrLBwDggn9QD/gOUrhgCuHP3o1xHv1+8vtrIw
	L2NpMKIbT26xCyGvYwDJuyPm15vYU/0oiC+IrW5nzDbUH+VJBpHo1LzZEY5QqTVP0wnIRl2f1ssuk
	jh8fkCKxams64KINKRh8marBBPKkgUk37ZCGeWFJN+yKZOGPj74VYe4qmusxmajht6g0rU8v4tG/I
	gnmfk1x54pPdpatTrJ+JcDY6LfmnqQGe5Ch1kyxIdbddAKmoSvHxWCMSXfYpT8FN7479iry1+RG1P
	zTghY97jTRvAOnygZKtA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whB7w-0000000FhGg-2AuH;
	Tue, 07 Jul 2026 19:06:40 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whB7j-0000000Fh1U-0SGd;
	Tue, 07 Jul 2026 19:06:27 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 8777661385;
	Tue,  7 Jul 2026 19:06:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FC491F000E9;
	Tue,  7 Jul 2026 19:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783451186;
	bh=EqhpiB2ZofNX2Hns8Xgz4OVDOubexQBaPatIimxnT/c=;
	h=Date:From:To:Cc:Subject:References;
	b=OAQsikH32zcXysH6hCjDCdC0GZdQsSYEYwKYLO4211wdV8Gx5U5QTVE1+P//2FXpn
	 uIqA0JY8lGaPQiDHJVOdRGZSp+QbqEjfTrKS3EEXVNmeOvIQBrVQEfC4uIvhb5uzt+
	 eT9i9M6+UlE8GQ+lRJyRHgkq+kITYoE5ZzhOkYUKb2PU4bWHESCf+nr7SFJdz6XhZt
	 2iGqe+3vU4x0dhlP0lRwEovJHlRUe0zFn5tWw2ueZ7uZSvdCbVVh6SrVwQHTuvbp8Z
	 nNfr1ROiFTyIDkK/ZvtATvAtmDATTdK6yv/sLVE04ZyzvrA9oLmxeUKMvdWrrAByna
	 52gUU2XWEgjgQ==
Date: Tue, 07 Jul 2026 21:06:23 +0200
Message-ID: <20260707190254.030598804@kernel.org>
User-Agent: quilt/0.69
From: Thomas Gleixner <tglx@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Sven Schnelle <svens@linux.ibm.com>,
 linux-s390@vger.kernel.org,
 Michael Ellerman <mpe@ellerman.id.au>,
 Shrikanth Hegde <sshegde@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org,
 Kees Cook <kees@kernel.org>,
 Huacai Chen <chenhuacai@kernel.org>,
 loongarch@lists.linux.dev,
 Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 linux-riscv@lists.infradead.org,
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
Subject: [patch 07/18] s390/syscall: Use
 enter_from_user_mode_randomize_stack()
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

enter_from_user_mode_randomize_stack() replaces enter_from_user_mode() and
the subsequent invocation of add_random_kstack_offset_irqsoff().

As a bonus this avoids the overhead of get/put_cpu_var() in
add_random_kstack_offset().

No functional change.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
---
 arch/s390/kernel/syscall.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/s390/kernel/syscall.c
+++ b/arch/s390/kernel/syscall.c
@@ -97,8 +97,8 @@ void noinstr __do_syscall(struct pt_regs
 {
 	unsigned long nr;
 
-	enter_from_user_mode(regs);
-	add_random_kstack_offset();
+	enter_from_user_mode_randomize_stack(regs);
+
 	regs->psw = get_lowcore()->svc_old_psw;
 	regs->int_code = get_lowcore()->svc_int_code;
 	update_timer_sys();


