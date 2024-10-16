Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BE77D206BC
	for <linux-um@archiver.kernel.org>; Wed, 16 Oct 2024 21:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Mf3R/3S0MCI5tF4BhQ2U7wtgZrq3J6u/Z05NpnyO0ck=; b=L716XzZSTHI10kwCEftdPyUP85
	T6tWEfEBr72dmF+lWQeo4BFUDag3SWtz/bxk0g4Fkcb988JihiHSgByier+7WA2eiP0HG3KIA1JKA
	nTC/Ppf3sYhmCcDfHxzvCn7fVFf0lJYkf7Yl6UPuTQfVmDc4n/5D+HG61pfoSpiBKL7MTNUoZaPVt
	xvH1z8AhSHC+zcVrum5z5rj/4UUMIUpyzjBV/BOWsjTPWQzWhe+f9Zp3W/GGk4bVM8D8VjxYGB/ni
	49T5V736Z8viSgNHmyGLVIk2j2Y9kXZ7rXO0m0UcpvTku01gIaOR11wd6kGv0Inaoo2LvUZlTZ63a
	vL9050GQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t1B8y-0000000D0lI-1F9U;
	Wed, 16 Oct 2024 21:01:20 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t1B8t-0000000D0iE-36na;
	Wed, 16 Oct 2024 21:01:17 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 7A965A427EA;
	Wed, 16 Oct 2024 21:01:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 368BFC4CEC5;
	Wed, 16 Oct 2024 21:01:07 +0000 (UTC)
Date: Wed, 16 Oct 2024 17:01:28 -0400
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
Message-ID: <20241016170128.7afeb8b0@gandalf.local.home>
In-Reply-To: <20241016122424.1655560-7-rppt@kernel.org>
References: <20241016122424.1655560-1-rppt@kernel.org>
	<20241016122424.1655560-7-rppt@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241016_140115_917979_D08E17D8 
X-CRM114-Status: GOOD (  23.34  )
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

On Wed, 16 Oct 2024 15:24:22 +0300
Mike Rapoport <rppt@kernel.org> wrote:

> diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
> index 8da0e66ca22d..b498897b213c 100644
> --- a/arch/x86/kernel/ftrace.c
> +++ b/arch/x86/kernel/ftrace.c
> @@ -118,10 +118,13 @@ ftrace_modify_code_direct(unsigned long ip, const char *old_code,
>  		return ret;
>  
>  	/* replace the text with the new text */
> -	if (ftrace_poke_late)
> +	if (ftrace_poke_late) {
>  		text_poke_queue((void *)ip, new_code, MCOUNT_INSN_SIZE, NULL);
> -	else
> -		text_poke_early((void *)ip, new_code, MCOUNT_INSN_SIZE);
> +	} else {
> +		mutex_lock(&text_mutex);
> +		text_poke((void *)ip, new_code, MCOUNT_INSN_SIZE);
> +		mutex_unlock(&text_mutex);
> +	}
>  	return 0;
>  }

So this slows down the boot by over 30ms. That may not sound like much, but
we care very much about boot times. This code is serialized with boot and
runs whenever ftrace is configured in the kernel. The way I measured this,
was that I added:

diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index 4dd0ad6c94d6..b72bb9943140 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -104,6 +104,8 @@ static int ftrace_verify_code(unsigned long ip, const char *old_code)
 	return 0;
 }
 
+u64 sdr_total;
+
 /*
  * Marked __ref because it calls text_poke_early() which is .init.text. That is
  * ok because that call will happen early, during boot, when .init sections are
@@ -114,6 +116,8 @@ ftrace_modify_code_direct(unsigned long ip, const char *old_code,
 			  const char *new_code)
 {
 	int ret = ftrace_verify_code(ip, old_code);
+	u64 start, stop;
+
 	if (ret)
 		return ret;
 
@@ -121,9 +125,12 @@ ftrace_modify_code_direct(unsigned long ip, const char *old_code,
 	if (ftrace_poke_late) {
 		text_poke_queue((void *)ip, new_code, MCOUNT_INSN_SIZE, NULL);
 	} else {
+		start = trace_clock_local();
 		mutex_lock(&text_mutex);
 		text_poke((void *)ip, new_code, MCOUNT_INSN_SIZE);
 		mutex_unlock(&text_mutex);
+		stop = trace_clock_local();
+		sdr_total += stop - start;
 	}
 	return 0;
 }
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index c01375adc471..93284557144d 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -10738,6 +10738,11 @@ __init static int tracer_alloc_buffers(void)
 
 	register_snapshot_cmd();
 
+	{
+		extern u64 sdr_total;
+		printk("SDR TOTAL: %lld\n", sdr_total);
+	}
+
 	test_can_verify();
 
 	return 0;


And did the same before this patch. I ran it three times and have the
following numbers (all in nanoseconds):

before: 11356637	11863526	11507750
 after: 43978750	41293162	42741067

Before this patch, the total updates took 11ms. After the patch it takes
around 42ms. This is because we are patching 59 thousand sites with this.

# dmesg |grep ftrace
[    1.620569] ftrace: allocating 59475 entries in 233 pages
[    1.667178] ftrace: allocated 233 pages with 5 groups


If this is only needed for module load, can we at least still use the
text_poke_early() at boot up?

 	if (ftrace_poke_late) {
 		text_poke_queue((void *)ip, new_code, MCOUNT_INSN_SIZE, NULL);
	} else if (system_state == SYSTEM_BOOTING) {
		text_poke_early((void *)ip, new_code, MCOUNT_INSN_SIZE);
 	} else {
 		mutex_lock(&text_mutex);
 		text_poke((void *)ip, new_code, MCOUNT_INSN_SIZE);
 		mutex_unlock(&text_mutex);
 	}

?

The above if statement looks to slow things down just slightly, but only by
2ms, which is more reasonable.

-- Steve

