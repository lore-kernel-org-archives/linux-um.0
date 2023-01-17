Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 365EDC27C76
	for <linux-um@archiver.kernel.org>; Wed, 25 Jan 2023 09:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Message-Id:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=o4T341mTta+oFuYl4MezjZt892rOjzSkQIqS/j/WWEs=; b=XGlHPZ2gE2OJI5
	QKRiGNQEMOk7J2csWKOcdJ9979J49qU9A7Dg/4yozMw/NMVLl06znpJAuHwzv+ysZBPPSNISePTLX
	ECofndNVk8as0vj+WUsCrr+01WRWgUYtE/YAGE0VCf6liNKrAQ4WXqj3R4nHuf2pDpm9/POQW5b84
	FFEseNtbUY3sG9M+uIz1ASVtDCRYGMs4XzTXxt90kNbLbIxQ5BiIZsskJJu+vY2rq5y/YX4Qh9WEb
	F7Gfo6vS2MXcV5T4sR2I67s37VBqcOGzV5GCRN04BipqYdKUyHYLRIzugjQkiQokn8WqWYwppJxf6
	rmHnon3LDzxBjNQpwHyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pKbg4-006WhX-QR; Wed, 25 Jan 2023 09:02:44 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pHdX8-00CsMv-Nq; Tue, 17 Jan 2023 04:25:16 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 4844EB81060;
	Tue, 17 Jan 2023 04:25:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0701C433EF;
	Tue, 17 Jan 2023 04:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1673929510;
	bh=LKPfAbcdavLMCpifQk05Aqw+1tD2xg5qsuB6VorVVnI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rvDfVQk7Tsas4+LZFK04iCV/SqfYXmqYXLFi42JOngYW1dOP0QSo6CLiBkpjYosKx
	 nKUcD4fx6Lu1RT5hJ5yblHd47Jqpvv59kmEAKtriWUWkTZ7hmC4Za3q3BgpEtr891G
	 Uhe5azCk4FahsTTDCEc3lE2+MzsUQWKU5CAcTO6IYBsGKCz8NivYw+lk7qeBhykDxt
	 x23XNA0A5LxituWhIHyg6sCe7NTSUKsY2ON6C3g6I/nFT8i/VEH7jmIvKLWoo8AYZN
	 JlOlRfIFLAGKs5+FVWy9q/WwqqbuzK/Mvbqfsgyxm4gYqDdXx2B1Vx+ckQBMj8vEfk
	 ICBnmkeUNpdwg==
Date: Tue, 17 Jan 2023 13:24:46 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: richard.henderson@linaro.org, ink@jurassic.park.msu.ru,
 mattst88@gmail.com, vgupta@kernel.org, linux@armlinux.org.uk,
 nsekhar@ti.com, brgl@bgdev.pl, ulli.kroll@googlemail.com,
 linus.walleij@linaro.org, shawnguo@kernel.org, Sascha Hauer
 <s.hauer@pengutronix.de>, kernel@pengutronix.de, festevam@gmail.com,
 linux-imx@nxp.com, tony@atomide.com, khilman@kernel.org,
 krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com,
 catalin.marinas@arm.com, will@kernel.org, guoren@kernel.org,
 bcain@quicinc.com, chenhuacai@kernel.org, kernel@xen0n.name,
 geert@linux-m68k.org, sammy@sammy.net, monstr@monstr.eu,
 tsbogend@alpha.franken.de, dinguyen@kernel.org, jonas@southpole.se,
 stefan.kristiansson@saunalahti.fi, shorne@gmail.com,
 James.Bottomley@HansenPartnership.com, deller@gmx.de, mpe@ellerman.id.au,
 npiggin@gmail.com, christophe.leroy@csgroup.eu, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, hca@linux.ibm.com,
 gor@linux.ibm.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
 svens@linux.ibm.com, ysato@users.sourceforge.jp, dalias@libc.org,
 davem@davemloft.net, richard@nod.at, anton.ivanov@cambridgegreys.com,
 johannes@sipsolutions.net, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 acme@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
 jolsa@kernel.org, namhyung@kernel.org, jgross@suse.com,
 srivatsa@csail.mit.edu, amakhalov@vmware.com, pv-drivers@vmware.com,
 boris.ostrovsky@oracle.com, chris@zankel.net, jcmvbkbc@gmail.com,
 rafael@kernel.org, lenb@kernel.org, pavel@ucw.cz,
 gregkh@linuxfoundation.org, mturquette@baylibre.com, sboyd@kernel.org,
 daniel.lezcano@linaro.org, lpieralisi@kernel.org, sudeep.holla@arm.com,
 agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
 anup@brainfault.org, thierry.reding@gmail.com, jonathanh@nvidia.com,
 jacob.jun.pan@linux.intel.com, atishp@atishpatra.org, Arnd Bergmann
 <arnd@arndb.de>, yury.norov@gmail.com, andriy.shevchenko@linux.intel.com,
 linux@rasmusvillemoes.dk, dennis@kernel.org, tj@kernel.org, cl@linux.com,
 rostedt@goodmis.org, mhiramat@kernel.org, frederic@kernel.org,
 paulmck@kernel.org, pmladek@suse.com, senozhatsky@chromium.org,
 john.ogness@linutronix.de, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, bsegall@google.com,
 mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
 ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com,
 dvyukov@google.com, vincenzo.frascino@arm.com, Andrew Morton
 <akpm@linux-foundation.org>, jpoimboe@kernel.org,
 linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, linux-omap@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, linux-csky@vger.kernel.org,
 linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
 loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, openrisc@lists.librecores.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-um@lists.infradead.org, linux-perf-users@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-xtensa@linux-xtensa.org,
 linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
 kasan-dev@googlegroups.com
Subject: Re: [PATCH v3 35/51] trace,hardirq: No moar _rcuidle() tracing
Message-Id: <20230117132446.02ec12e4c10718de27790900@kernel.org>
In-Reply-To: <20230112195541.477416709@infradead.org>
References: <20230112194314.845371875@infradead.org>
	<20230112195541.477416709@infradead.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230116_202515_134720_E008D5E9 
X-CRM114-Status: GOOD (  21.84  )
X-Mailman-Approved-At: Wed, 25 Jan 2023 01:02:42 -0800
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

Hi Peter,

On Thu, 12 Jan 2023 20:43:49 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> Robot reported that trace_hardirqs_{on,off}() tickle the forbidden
> _rcuidle() tracepoint through local_irq_{en,dis}able().
> 
> For 'sane' configs, these calls will only happen with RCU enabled and
> as such can use the regular tracepoint. This also means it's possible
> to trace them from NMI context again.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

The code looks good to me. I just have a question about comment.

> ---
>  kernel/trace/trace_preemptirq.c |   21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
> 
> --- a/kernel/trace/trace_preemptirq.c
> +++ b/kernel/trace/trace_preemptirq.c
> @@ -20,6 +20,15 @@
>  static DEFINE_PER_CPU(int, tracing_irq_cpu);
>  
>  /*
> + * ...

Is this intended? Wouldn't you leave any comment here?

Thank you,

> + */
> +#ifdef CONFIG_ARCH_WANTS_NO_INSTR
> +#define trace(point)	trace_##point
> +#else
> +#define trace(point)	if (!in_nmi()) trace_##point##_rcuidle
> +#endif
> +
> +/*
>   * Like trace_hardirqs_on() but without the lockdep invocation. This is
>   * used in the low level entry code where the ordering vs. RCU is important
>   * and lockdep uses a staged approach which splits the lockdep hardirq
> @@ -28,8 +37,7 @@ static DEFINE_PER_CPU(int, tracing_irq_c
>  void trace_hardirqs_on_prepare(void)
>  {
>  	if (this_cpu_read(tracing_irq_cpu)) {
> -		if (!in_nmi())
> -			trace_irq_enable(CALLER_ADDR0, CALLER_ADDR1);
> +		trace(irq_enable)(CALLER_ADDR0, CALLER_ADDR1);
>  		tracer_hardirqs_on(CALLER_ADDR0, CALLER_ADDR1);
>  		this_cpu_write(tracing_irq_cpu, 0);
>  	}
> @@ -40,8 +48,7 @@ NOKPROBE_SYMBOL(trace_hardirqs_on_prepar
>  void trace_hardirqs_on(void)
>  {
>  	if (this_cpu_read(tracing_irq_cpu)) {
> -		if (!in_nmi())
> -			trace_irq_enable_rcuidle(CALLER_ADDR0, CALLER_ADDR1);
> +		trace(irq_enable)(CALLER_ADDR0, CALLER_ADDR1);
>  		tracer_hardirqs_on(CALLER_ADDR0, CALLER_ADDR1);
>  		this_cpu_write(tracing_irq_cpu, 0);
>  	}
> @@ -63,8 +70,7 @@ void trace_hardirqs_off_finish(void)
>  	if (!this_cpu_read(tracing_irq_cpu)) {
>  		this_cpu_write(tracing_irq_cpu, 1);
>  		tracer_hardirqs_off(CALLER_ADDR0, CALLER_ADDR1);
> -		if (!in_nmi())
> -			trace_irq_disable(CALLER_ADDR0, CALLER_ADDR1);
> +		trace(irq_disable)(CALLER_ADDR0, CALLER_ADDR1);
>  	}
>  
>  }
> @@ -78,8 +84,7 @@ void trace_hardirqs_off(void)
>  	if (!this_cpu_read(tracing_irq_cpu)) {
>  		this_cpu_write(tracing_irq_cpu, 1);
>  		tracer_hardirqs_off(CALLER_ADDR0, CALLER_ADDR1);
> -		if (!in_nmi())
> -			trace_irq_disable_rcuidle(CALLER_ADDR0, CALLER_ADDR1);
> +		trace(irq_disable)(CALLER_ADDR0, CALLER_ADDR1);
>  	}
>  }
>  EXPORT_SYMBOL(trace_hardirqs_off);
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
