Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0615FC27C76
	for <linux-um@archiver.kernel.org>; Wed, 25 Jan 2023 09:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4lj1DKObptEDruogMWxxS667+/mmYn/jL6XkJX6ast0=; b=KPJ837KYToY6pR
	X3XE34J4MCBd/Rtd/JLnRKajxFY5EYKurCfjCJCYmmz3rxzqL/P2adbmhx+ucsGYuAnm+u6YqcRRB
	jGbTQgqhdOPTOUe/dsWsKK+R4eT3oLBsw1OVGulPYZVXmy6rCnO5sNGSj+yz9veRVq0/jLwmHeXw3
	O6pEktAE1C/+PQoH/TBNXl3xMsWfV9GRemHpfduAjFwDHXhT1k+E7Hh0nD7mZimwvoj71KCM64F+U
	mUzKv+Bzqmk6/QjUBmS0HXhPku8wx7Dz8vpgJbjlgmMDs++cygP74adbGC4ydXJOvSqzINcgqP4ld
	5ckUuGSNy7xYhURfAohw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pKbg6-006WiN-FH; Wed, 25 Jan 2023 09:02:46 +0000
Received: from foss.arm.com ([217.140.110.172])
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pHnzt-00ErI2-AH; Tue, 17 Jan 2023 15:35:40 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 94F4F12FC;
	Tue, 17 Jan 2023 07:36:16 -0800 (PST)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.31.153])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ACA663F67D;
	Tue, 17 Jan 2023 07:35:17 -0800 (PST)
Date: Tue, 17 Jan 2023 15:35:10 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, richard.henderson@linaro.org,
	ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@kernel.org,
	linux@armlinux.org.uk, nsekhar@ti.com, brgl@bgdev.pl,
	ulli.kroll@googlemail.com, linus.walleij@linaro.org,
	shawnguo@kernel.org, Sascha Hauer <s.hauer@pengutronix.de>,
	kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
	tony@atomide.com, khilman@kernel.org,
	krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com,
	catalin.marinas@arm.com, will@kernel.org, guoren@kernel.org,
	bcain@quicinc.com, chenhuacai@kernel.org, kernel@xen0n.name,
	geert@linux-m68k.org, sammy@sammy.net, monstr@monstr.eu,
	tsbogend@alpha.franken.de, dinguyen@kernel.org, jonas@southpole.se,
	stefan.kristiansson@saunalahti.fi, shorne@gmail.com,
	James.Bottomley@hansenpartnership.com, deller@gmx.de,
	mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com, svens@linux.ibm.com,
	ysato@users.sourceforge.jp, dalias@libc.org, davem@davemloft.net,
	richard@nod.at, anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, acme@kernel.org, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, namhyung@kernel.org, jgross@suse.com,
	srivatsa@csail.mit.edu, amakhalov@vmware.com, pv-drivers@vmware.com,
	boris.ostrovsky@oracle.com, chris@zankel.net, jcmvbkbc@gmail.com,
	rafael@kernel.org, lenb@kernel.org, pavel@ucw.cz,
	gregkh@linuxfoundation.org, mturquette@baylibre.com,
	sboyd@kernel.org, daniel.lezcano@linaro.org, lpieralisi@kernel.org,
	agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
	anup@brainfault.org, thierry.reding@gmail.com, jonathanh@nvidia.com,
	jacob.jun.pan@linux.intel.com, atishp@atishpatra.org,
	Arnd Bergmann <arnd@arndb.de>, yury.norov@gmail.com,
	andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
	dennis@kernel.org, tj@kernel.org, cl@linux.com, rostedt@goodmis.org,
	mhiramat@kernel.org, frederic@kernel.org, paulmck@kernel.org,
	pmladek@suse.com, senozhatsky@chromium.org,
	john.ogness@linutronix.de, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
	vschneid@redhat.com, ryabinin.a.a@gmail.com, glider@google.com,
	andreyknvl@gmail.com, dvyukov@google.com, vincenzo.frascino@arm.com,
	Andrew Morton <akpm@linux-foundation.org>, jpoimboe@kernel.org,
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
	virtualization@lists.linux-foundation.org,
	linux-xtensa@linux-xtensa.org, linux-acpi@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org, kasan-dev@googlegroups.com
Subject: Re: [PATCH v3 00/51] cpuidle,rcu: Clean up the mess
Message-ID: <Y8bALvyrPpdg++/J@FVFF77S0Q05N.cambridge.arm.com>
References: <20230112194314.845371875@infradead.org>
 <Y8WCWAuQSHN651dA@FVFF77S0Q05N.cambridge.arm.com>
 <Y8Z31UbzG3LJgAXE@hirez.programming.kicks-ass.net>
 <Y8afpbHtDOqAHq9M@FVFF77S0Q05N.cambridge.arm.com>
 <20230117142140.g423hxisv7djudof@bogus>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230117142140.g423hxisv7djudof@bogus>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230117_073537_475706_33E4F0FE 
X-CRM114-Status: GOOD (  33.69  )
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

On Tue, Jan 17, 2023 at 02:21:40PM +0000, Sudeep Holla wrote:
> On Tue, Jan 17, 2023 at 01:16:21PM +0000, Mark Rutland wrote:
> > On Tue, Jan 17, 2023 at 11:26:29AM +0100, Peter Zijlstra wrote:
> > > On Mon, Jan 16, 2023 at 04:59:04PM +0000, Mark Rutland wrote:
> > > 
> > > > I'm sorry to have to bear some bad news on that front. :(
> > > 
> > > Moo, something had to give..
> > > 
> > > 
> > > > IIUC what's happenign here is the PSCI cpuidle driver has entered idle and RCU
> > > > is no longer watching when arm64's cpu_suspend() manipulates DAIF. Our
> > > > local_daif_*() helpers poke lockdep and tracing, hence the call to
> > > > trace_hardirqs_off() and the RCU usage.
> > > 
> > > Right, strictly speaking not needed at this point, IRQs should have been
> > > traced off a long time ago.
> > 
> > True, but there are some other calls around here that *might* end up invoking
> > RCU stuff (e.g. the MTE code).
> > 
> > That all needs a noinstr cleanup too, which I'll sort out as a follow-up.
> > 
> > > > I think we need RCU to be watching all the way down to cpu_suspend(), and it's
> > > > cpu_suspend() that should actually enter/exit idle context. That and we need to
> > > > make cpu_suspend() and the low-level PSCI invocation noinstr.
> > > > 
> > > > I'm not sure whether 32-bit will have a similar issue or not.
> > > 
> > > I'm not seeing 32bit or Risc-V have similar issues here, but who knows,
> > > maybe I missed somsething.
> > 
> > I reckon if they do, the core changes here give us the infrastructure to fix
> > them if/when we get reports.
> > 
> > > In any case, the below ought to cure the ARM64 case and remove that last
> > > known RCU_NONIDLE() user as a bonus.
> > 
> > The below works for me testing on a Juno R1 board with PSCI, using defconfig +
> > CONFIG_PROVE_LOCKING=y + CONFIG_DEBUG_LOCKDEP=y + CONFIG_DEBUG_ATOMIC_SLEEP=y.
> > I'm not sure how to test the LPI / FFH part, but it looks good to me.
> > 
> > FWIW:
> > 
> > Reviewed-by: Mark Rutland <mark.rutland@arm.com>
> > Tested-by: Mark Rutland <mark.rutland@arm.com>
> > 
> > Sudeep, would you be able to give the LPI/FFH side a spin with the kconfig
> > options above?
> > 
> 
> Not sure if I have messed up something in my mail setup, but I did reply
> earlier.

Sorry, that was my bad; I had been drafting my reply for a while and forgot to
re-check prior to sending.

> I did test both DT/cpuidle-psci driver and  ACPI/LPI+FFH driver
> with the fix Peter sent. I was seeing same splat as you in both DT and
> ACPI boot which the patch fixed it. I used the same config as described by
> you above.

Perfect; thanks!

Mark.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
