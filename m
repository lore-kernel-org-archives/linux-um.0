Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C2F4C43458
	for <linux-um@archiver.kernel.org>; Tue,  7 Jul 2026 19:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:Subject:Cc:To:From:Message-ID:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=hxSnO03KgHWOZGMce0tACqpsA4dr5cG/I6UVdKHVTVw=; b=omMtmH6f6WSQKf
	ZhyuUWjNsu0Q2zFAOTWk3IDOt0B11EPrYpS/XDUaLU53ogsoyjzVw32wJcst6D5B2K2B9vjBnLNIl
	nE6BQgc+eMmnWL1yFim4lO8LTcIbTFD4EEE8oyUIvGKV8czy/h47rTyTrHW13b5jF/ONe0vUwmd8N
	1nXO8L09573AuZzhvPqA3BTt0G/7Bbk4KFdbayeJhes0YHEVg3Xkj8E4XLgTjfbyhHB9k3/7Pc2pN
	lgdzYLNVFsUfukeHK2GUvQ4e7IPyPAMGuWLvlFvoGuO75WR+U1DoXu9/Aqd4u6mXuI1UKZY2dtbeL
	S1S4wJH0zWac2A8HCaBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whB7T-0000000FglU-0vN5;
	Tue, 07 Jul 2026 19:06:11 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whB7K-0000000Fggz-1uHt;
	Tue, 07 Jul 2026 19:06:05 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 7D4B3601ED;
	Tue,  7 Jul 2026 19:06:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B8731F000E9;
	Tue,  7 Jul 2026 19:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783451161;
	bh=hxSnO03KgHWOZGMce0tACqpsA4dr5cG/I6UVdKHVTVw=;
	h=Date:From:To:Cc:Subject:References;
	b=XjLMGEZIqo7ptFMh+dt6XLydZgtGilujB6Pr3G5Xs8jTgXHjTmjHbXax45A1Irn7Q
	 ZoKgOQ+erxKpVuTEY1CN+p5oa4NISG5yLBcptFbbuZ5Smi9OI4/1GT5wKmBvG/kUCm
	 Kb++/j50MCS4Bd4ZIaLeUp05IkQ8BBoXhS1+C2Dfdb2Px/6YBrEpRHirZkoMvFkjrB
	 Esy2/NvwC38v686eB+S6XqRLlxxoxacZU7i1j9g0fzbALa1yDrWEDepcbm0R60qZn9
	 YK/VjvOicJpHE846L2yVE16swnlEjzi7zlbAJYmhCaJqshy4C6LdDpsWMl5NR0b1d9
	 qdpIAZc9XtCbQ==
Date: Tue, 07 Jul 2026 21:05:58 +0200
Message-ID: <20260707190253.718191130@kernel.org>
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
Subject: [patch 01/18] powerpc: Move stack randomization after
 syscall_enter_from_user_mode()
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

add_random_kstack_offset() is invoked before syscall_enter_from_user_mode()
establishes state. That's wrong because add_random_kstack_offset() calls
into instrumentable code.

Move it after syscall_enter_from_user_mode() to ensure that state is
correctly established.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/kernel/syscall.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/powerpc/kernel/syscall.c
+++ b/arch/powerpc/kernel/syscall.c
@@ -19,8 +19,8 @@ notrace long system_call_exception(struc
 	long ret;
 	syscall_fn f;
 
-	add_random_kstack_offset();
 	r0 = syscall_enter_from_user_mode(regs, r0);
+	add_random_kstack_offset();
 
 	if (unlikely(r0 >= NR_syscalls)) {
 		if (unlikely(trap_is_unsupported_scv(regs))) {


