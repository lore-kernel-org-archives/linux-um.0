Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B2EAD374A2
	for <linux-um@archiver.kernel.org>; Thu, 17 Oct 2024 14:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0RENO6sDDMYvvOCfRHws5B4+D5uhU/+pdf+qOzKG6CE=; b=v6ACQmsfuWBPWQosluRWOH08qX
	Xj3VdyaS8trLLZbeQBgARuGFUUbAVcEYSE43dW50GDI+UtNf+OpFx1yukqJa9Ip7M3ZTHSt3MjciJ
	0S6gR5zNrj1WuFqmJ7oayexel98O2BRStIreSdz7D1Mm2uACroOoP7SR0f/E4ET2s2P4qWCNksLt6
	G5ZwubW6QhOd3IKL+5ah+mPM5PC3OYk/5vOY3aKVPha55OjLByTzvy8l1v46pFPk6/N0dUZ+eSLZO
	cW6P78p5tYGCs82Wyipan96m2IWfGRuTlV7hGwRm7MoUDkUoNvz9JOr4KvZKjOgNghxYT3zgp5eNG
	cvri4U2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t1RJb-0000000F5Gc-3QGt;
	Thu, 17 Oct 2024 14:17:23 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t1RJC-0000000F54T-00d7;
	Thu, 17 Oct 2024 14:16:59 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id AEE875C4F0A;
	Thu, 17 Oct 2024 14:16:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E652CC4CEC3;
	Thu, 17 Oct 2024 14:16:49 +0000 (UTC)
Date: Thu, 17 Oct 2024 10:17:12 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Luis Chamberlain
 <mcgrof@kernel.org>, Andreas Larsson <andreas@gaisler.com>, Andy Lutomirski
 <luto@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann
 <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Brian Cain
 <bcain@quicinc.com>, Catalin Marinas <catalin.marinas@arm.com>, Christoph
 Hellwig <hch@infradead.org>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Dave Hansen <dave.hansen@linux.intel.com>,
 Dinh Nguyen <dinguyen@kernel.org>, Geert Uytterhoeven
 <geert@linux-m68k.org>, Guo Ren <guoren@kernel.org>, Helge Deller
 <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar
 <mingo@redhat.com>, Johannes Berg <johannes@sipsolutions.net>, John Paul
 Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Kent Overstreet
 <kent.overstreet@linux.dev>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Mark Rutland <mark.rutland@arm.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Matt Turner <mattst88@gmail.com>, Max Filippov
 <jcmvbkbc@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Michal Simek
 <monstr@monstr.eu>, Oleg Nesterov <oleg@redhat.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Peter Zijlstra <peterz@infradead.org>, Richard
 Weinberger <richard@nod.at>, Russell King <linux@armlinux.org.uk>, Song Liu
 <song@kernel.org>, Stafford Horne <shorne@gmail.com>, Suren Baghdasaryan
 <surenb@google.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Thomas Gleixner <tglx@linutronix.de>, Uladzislau Rezki <urezki@gmail.com>,
 Vineet Gupta <vgupta@kernel.org>, Will Deacon <will@kernel.org>,
 bpf@vger.kernel.org, linux-alpha@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, linux-mm@kvack.org,
 linux-modules@vger.kernel.org, linux-openrisc@vger.kernel.org,
 linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-sh@vger.kernel.org, linux-snps-arc@lists.infradead.org,
 linux-trace-kernel@vger.kernel.org, linux-um@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
 sparclinux@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v6 6/8] x86/module: prepare module loading for ROX
 allocations of text
Message-ID: <20241017101712.5a052712@gandalf.local.home>
In-Reply-To: <20241016170128.7afeb8b0@gandalf.local.home>
References: <20241016122424.1655560-1-rppt@kernel.org>
	<20241016122424.1655560-7-rppt@kernel.org>
	<20241016170128.7afeb8b0@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241017_071658_170360_A91704AF 
X-CRM114-Status: GOOD (  16.88  )
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

On Wed, 16 Oct 2024 17:01:28 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> If this is only needed for module load, can we at least still use the
> text_poke_early() at boot up?
> 
>  	if (ftrace_poke_late) {
>  		text_poke_queue((void *)ip, new_code, MCOUNT_INSN_SIZE, NULL);
> 	} else if (system_state == SYSTEM_BOOTING) {
> 		text_poke_early((void *)ip, new_code, MCOUNT_INSN_SIZE);
>  	} else {
>  		mutex_lock(&text_mutex);
>  		text_poke((void *)ip, new_code, MCOUNT_INSN_SIZE);
>  		mutex_unlock(&text_mutex);
>  	}
> 
> ?
> 
> The above if statement looks to slow things down just slightly, but only by
> 2ms, which is more reasonable.

I changed the above to this (yes it's a little hacky) and got my 2ms back!

-- Steve

DEFINE_STATIC_KEY_TRUE(ftrace_modify_boot);

static int __init ftrace_boot_init_done(void)
{
	static_branch_disable(&ftrace_modify_boot);
	return 0;
}
/* Ftrace updates happen before core init */
core_initcall(ftrace_boot_init_done);

/*
 * Marked __ref because it calls text_poke_early() which is .init.text. That is
 * ok because that call will happen early, during boot, when .init sections are
 * still present.
 */
static int __ref
ftrace_modify_code_direct(unsigned long ip, const char *old_code,
			  const char *new_code)
{
	int ret = ftrace_verify_code(ip, old_code);

	if (ret)
		return ret;

	/* replace the text with the new text */
	if (static_branch_unlikely(&ftrace_modify_boot)) {
		text_poke_early((void *)ip, new_code, MCOUNT_INSN_SIZE);
	} else if (ftrace_poke_late) {
		text_poke_queue((void *)ip, new_code, MCOUNT_INSN_SIZE, NULL);
	} else {
		mutex_lock(&text_mutex);
		text_poke((void *)ip, new_code, MCOUNT_INSN_SIZE);
		mutex_unlock(&text_mutex);
	}
	return 0;
}

