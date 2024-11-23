Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C136E6ADD9
	for <linux-um@archiver.kernel.org>; Sat, 23 Nov 2024 03:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PmlOqUo2xu33LO/zptsiR3e79fiEn3WXPVU8241XsqM=; b=b3CJ43z4pVYLIgsNR+gwR+amp6
	lClzwAgCZFIPFiUyvFUwvpPxTdKi/TXLk/q0pRfhXkqzm05RCg2YL56+FUKCC9kfVQMbNzW5tPj11
	ZKMnRG0LdQvXx1NnqxL4yoZe8IPu7Zv/wWg9r94mnlWxS9AxA1xRpX04otPr2h+H6GSETOKDTsPgF
	MdXpOaY+Uc99RsVREHhiQK11u2bMyl7rySTi5YhNYDzrDEwr4v7Hab8Fq2kN3PIWZvWA0Kjc1zUFl
	q3rXih/zeZ5CQ+Bu1hyYoSCFdblEiJS51Pia5SY7MSOBKOUuaIaB+ESm7BjloopnBq6F7FlIh/SO4
	KxF0hb3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tEgWS-00000003h9q-1Hox;
	Sat, 23 Nov 2024 03:09:24 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tEgWP-00000003h8r-3MAz
	for linux-um@lists.infradead.org;
	Sat, 23 Nov 2024 03:09:22 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 4FDD25C5977;
	Sat, 23 Nov 2024 03:08:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28A6BC4CECE;
	Sat, 23 Nov 2024 03:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732331359;
	bh=xTIHzGabawTieoNHPmY6TAGibaQ4jK9SnDJEWSTFpxE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rb2mV5E+AX3UHtwVJrGvMLxMzSAQmyj1gb9WqUzDmisEbMoiww63NDH3or1xk6CYs
	 fbJi3gb+WJLWuYsSWxKalwT/Wiw91Hn6Q8cfHKNebAnw9llm9PKT7tAsrMzPu9Ibkd
	 hJZOSmKoEoYS3P+aFcphSAjnEMqNI0h4kvT+2Yi73LNk509HDO0ozBlEUXk0woux73
	 HCBRiJXcgt6w6zBWcHf9bxIMdCX/GP9cvSV0vO1N+JQghu6PCmmR7UJVk4Xv7PLbD0
	 TyH9F+FH3fx6Q+bf0OJo5wXMB/Ld5Yme3wtp6hcTGyaXPgUqDKNtDlO8fANt2obQnD
	 pL+/7UoZOQhrA==
Date: Fri, 22 Nov 2024 20:09:15 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
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
Message-ID: <20241123030915.GA1020125@thelio-3990X>
References: <20241002045347.GE555609@thelio-3990X>
 <20241002064252.41999-1-wentaoz5@illinois.edu>
 <20241003232938.GA1663252@thelio-3990X>
 <20241122122703.GW24774@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241122122703.GW24774@noisy.programming.kicks-ass.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241122_190921_923623_1B025A13 
X-CRM114-Status: GOOD (  11.27  )
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

On Fri, Nov 22, 2024 at 01:27:03PM +0100, Peter Zijlstra wrote:
> On Thu, Oct 03, 2024 at 04:29:38PM -0700, Nathan Chancellor wrote:
> 
> > $ /usr/bin/time -v make -skj"$(nproc)" ARCH=x86_64 LLVM=1 mrproper {def,amd_mem_encrypt.,fortify_source.,llvm_cov.}config bzImage
> > ...
> > vmlinux.o: warning: objtool: __sev_es_nmi_complete+0x6e: call to kasan_check_write() leaves .noinstr.text section
> > vmlinux.o: warning: objtool: do_syscall_64+0x141: call to lockdep_hardirqs_off() leaves .noinstr.text section
> > vmlinux.o: warning: objtool: do_int80_emulation+0x138: call to lockdep_hardirqs_off() leaves .noinstr.text section
> > vmlinux.o: warning: objtool: handle_bug+0x5: call to kmsan_unpoison_entry_regs() leaves .noinstr.text section
> > vmlinux.o: warning: objtool: syscall_enter_from_user_mode_prepare+0x105: call to lockdep_hardirqs_off() leaves .noinstr.text section
> > vmlinux.o: warning: objtool: syscall_exit_to_user_mode+0x73: call to user_enter_irqoff() leaves .noinstr.text section
> > vmlinux.o: warning: objtool: irqentry_enter_from_user_mode+0x105: call to lockdep_hardirqs_off() leaves .noinstr.text section
> > vmlinux.o: warning: objtool: irqentry_exit_to_user_mode+0x62: call to user_enter_irqoff() leaves .noinstr.text section
> > vmlinux.o: warning: objtool: irqentry_enter+0x45: call to lockdep_hardirqs_off() leaves .noinstr.text section
> > vmlinux.o: warning: objtool: irqentry_exit+0x4a: call to lockdep_hardirqs_on() leaves .noinstr.text section
> > vmlinux.o: warning: objtool: irqentry_nmi_enter+0x4: call to lockdep_off() leaves .noinstr.text section
> > vmlinux.o: warning: objtool: irqentry_nmi_exit+0x67: call to lockdep_on() leaves .noinstr.text section
> > vmlinux.o: warning: objtool: enter_s2idle_proper+0xb5: call to lockdep_hardirqs_off() leaves .noinstr.text section
> > vmlinux.o: warning: objtool: cpuidle_enter_state+0x113: call to lockdep_hardirqs_off() leaves .noinstr.text section
> > vmlinux.o: warning: objtool: default_idle_call+0xad: call to lockdep_hardirqs_on() leaves .noinstr.text section
> > vmlinux.o: warning: objtool: cpu_idle_poll+0x29: call to lockdep_hardirqs_on() leaves .noinstr.text section
> > vmlinux.o: warning: objtool: acpi_idle_enter_bm+0x118: call to lockdep_hardirqs_on() leaves .noinstr.text section
> > vmlinux.o: warning: objtool: acpi_idle_do_entry+0x4: call to perf_lopwr_cb() leaves .noinstr.text section
> 
> Just saw this fly by, that looks like something is buggered bad. Notably
> lockdep_hardirqs_{on,off}() are noinstr.
> 
> Is this patch-set causing this, or what?

These warnings are not present without CONFIG_LLVM_COV_PROFILE_ALL, so
it certainly seems related to this patchset. In this configuration,
CONFIG_KASAN and CONFIG_LOCKDEP are disabled, so these functions are
simple 'static inline' functions. An immediate theory is that because
this instrumentation is applied by the frontend, these functions will
not actually be empty or simple, which may affect the ability to inline
them and eliminate the instrumentation by the __no_profile from noinstr?
It definitely seems like this should probably be investigated...

Cheers,
Nathan

