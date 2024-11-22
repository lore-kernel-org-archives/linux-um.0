Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 529E4D75E32
	for <linux-um@archiver.kernel.org>; Fri, 22 Nov 2024 12:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0kGSHw8JTyuHlCkouecYymNm2X42fBKssXcFo3omKQc=; b=jbgM8W7B6I9vD1DMU39vVFr7pd
	1CDK2B3HEY8ruP0e7Zg3+ASN1K1JtxS31L9i264fOxWl5TpCfCKnqPvLFWHVubMc45Ay5XRP2SURg
	HlO0ge3j0U3g4vgU0609+/wygjZ2X57GojJYwmhn33shrE8IQFF4YZ8zkLaJ3LrgSQvF2v/rpD/51
	cKg89pWh6ukpOhvyYM0/2ycTYrxJQJSGFFi0guKNZOoUpeAbKTvVhyrWd34LKsOG7clFRBVrqzAIA
	9kM0rcu+IIhq4J0LCo6/X5BWsVxeZnwYKtGD9MDbX8gDmat7xV1Sh/xm+Pw4H/c4BHEaV3K0D3j1W
	Gv4Q0L0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tESkl-00000002Rvx-2LrJ;
	Fri, 22 Nov 2024 12:27:15 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tESkk-00000002RvJ-1Lms
	for linux-um@bombadil.infradead.org;
	Fri, 22 Nov 2024 12:27:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0kGSHw8JTyuHlCkouecYymNm2X42fBKssXcFo3omKQc=; b=LQQILLiKYSM3aRqMyif85PqZM8
	g+46MJsI6aZvdT+t7iqH03XXfsjBleDyps7waXsLLQ+pNGWuMUkV+AHXnqwTkVqN5y6XqNOIPQV9I
	FhBcPw0n9AYFeONmqGBOlLQEnqviwwcx/A5ibdcdi78J/DhlhstftDI6WnCczfzFFAIzYSJyhwjCw
	m2ZRVvpUZnb6mJLPpkh7Vr3l8qdHWfDEZ7+3DRFMeUpI9VQzUX+bzHkd1TBi7oTgOGVrGfH6r+VEP
	BkPpm7G9DK5B6zS1b9UKLCNZIck4BLXsmuygD8rmMbIQwo+KRr1uVKl/WETCy5X6f4SDP8Ze7BNS2
	oQbg1QbQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tESka-00000000hcd-0TQO;
	Fri, 22 Nov 2024 12:27:04 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B386A30066A; Fri, 22 Nov 2024 13:27:03 +0100 (CET)
Date: Fri, 22 Nov 2024 13:27:03 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Wentao Zhang <wentaoz5@illinois.edu>, Matt.Kelly2@boeing.com,
	akpm@linux-foundation.org, andrew.j.oppelt@boeing.com,
	anton.ivanov@cambridgegreys.com, ardb@kernel.org, arnd@arndb.de,
	bhelgaas@google.com, bp@alien8.de, chuck.wolber@boeing.com,
	dave.hansen@linux.intel.com, dvyukov@google.com, hpa@zytor.com,
	jinghao7@illinois.edu, johannes@sipsolutions.net,
	jpoimboe@kernel.org, justinstitt@google.com, kees@kernel.org,
	kent.overstreet@linux.dev, linux-arch@vger.kernel.org,
	linux-efi@vger.kernel.org, linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-um@lists.infradead.org, llvm@lists.linux.dev, luto@kernel.org,
	marinov@illinois.edu, masahiroy@kernel.org, maskray@google.com,
	mathieu.desnoyers@efficios.com, matthew.l.weber3@boeing.com,
	mhiramat@kernel.org, mingo@redhat.com, morbo@google.com,
	ndesaulniers@google.com, oberpar@linux.ibm.com, paulmck@kernel.org,
	richard@nod.at, rostedt@goodmis.org, samitolvanen@google.com,
	samuel.sarkisian@boeing.com, steven.h.vanderleest@boeing.com,
	tglx@linutronix.de, tingxur@illinois.edu, tyxu@illinois.edu,
	x86@kernel.org
Subject: Re: [PATCH v2 0/4] Enable measuring the kernel's Source-based Code
 Coverage and MC/DC with Clang
Message-ID: <20241122122703.GW24774@noisy.programming.kicks-ass.net>
References: <20241002045347.GE555609@thelio-3990X>
 <20241002064252.41999-1-wentaoz5@illinois.edu>
 <20241003232938.GA1663252@thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003232938.GA1663252@thelio-3990X>
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

On Thu, Oct 03, 2024 at 04:29:38PM -0700, Nathan Chancellor wrote:

> $ /usr/bin/time -v make -skj"$(nproc)" ARCH=x86_64 LLVM=1 mrproper {def,amd_mem_encrypt.,fortify_source.,llvm_cov.}config bzImage
> ...
> vmlinux.o: warning: objtool: __sev_es_nmi_complete+0x6e: call to kasan_check_write() leaves .noinstr.text section
> vmlinux.o: warning: objtool: do_syscall_64+0x141: call to lockdep_hardirqs_off() leaves .noinstr.text section
> vmlinux.o: warning: objtool: do_int80_emulation+0x138: call to lockdep_hardirqs_off() leaves .noinstr.text section
> vmlinux.o: warning: objtool: handle_bug+0x5: call to kmsan_unpoison_entry_regs() leaves .noinstr.text section
> vmlinux.o: warning: objtool: syscall_enter_from_user_mode_prepare+0x105: call to lockdep_hardirqs_off() leaves .noinstr.text section
> vmlinux.o: warning: objtool: syscall_exit_to_user_mode+0x73: call to user_enter_irqoff() leaves .noinstr.text section
> vmlinux.o: warning: objtool: irqentry_enter_from_user_mode+0x105: call to lockdep_hardirqs_off() leaves .noinstr.text section
> vmlinux.o: warning: objtool: irqentry_exit_to_user_mode+0x62: call to user_enter_irqoff() leaves .noinstr.text section
> vmlinux.o: warning: objtool: irqentry_enter+0x45: call to lockdep_hardirqs_off() leaves .noinstr.text section
> vmlinux.o: warning: objtool: irqentry_exit+0x4a: call to lockdep_hardirqs_on() leaves .noinstr.text section
> vmlinux.o: warning: objtool: irqentry_nmi_enter+0x4: call to lockdep_off() leaves .noinstr.text section
> vmlinux.o: warning: objtool: irqentry_nmi_exit+0x67: call to lockdep_on() leaves .noinstr.text section
> vmlinux.o: warning: objtool: enter_s2idle_proper+0xb5: call to lockdep_hardirqs_off() leaves .noinstr.text section
> vmlinux.o: warning: objtool: cpuidle_enter_state+0x113: call to lockdep_hardirqs_off() leaves .noinstr.text section
> vmlinux.o: warning: objtool: default_idle_call+0xad: call to lockdep_hardirqs_on() leaves .noinstr.text section
> vmlinux.o: warning: objtool: cpu_idle_poll+0x29: call to lockdep_hardirqs_on() leaves .noinstr.text section
> vmlinux.o: warning: objtool: acpi_idle_enter_bm+0x118: call to lockdep_hardirqs_on() leaves .noinstr.text section
> vmlinux.o: warning: objtool: acpi_idle_do_entry+0x4: call to perf_lopwr_cb() leaves .noinstr.text section

Just saw this fly by, that looks like something is buggered bad. Notably
lockdep_hardirqs_{on,off}() are noinstr.

Is this patch-set causing this, or what?

