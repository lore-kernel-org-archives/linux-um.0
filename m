Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80441C63797
	for <linux-um@archiver.kernel.org>; Thu, 12 Jan 2023 22:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:To:Cc:From:Subject:References:
	In-Reply-To:MIME-Version:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mTyYwbJ8xq8FL5Ggq8ZuWPW58A2ba0MuCy05OL85/h8=; b=xvT5Vl2syZNNXm
	wvQA7H2YVjL83zXQiLaiwQpG2zLpfslZWC5gC05UGXmgLSz5b8/uLQ5z564BGTXCryke4VO1/LEdm
	0FJVEMa6CsBAkElxmkfgxKBz/jtEtdWGDrETYwIsRm5AFiFbpTiJwQxoWsL7iGOXP8qe3jb8mjvR4
	zTQJ5YBKhlppWUNQBeAkbB9mWZuMxQaOYUc6Wia77EyMT1tzJHvLlAWVIH4HlYoGoMlpzNnF6n38k
	+FxqfUln9aZYChqycQa56TYEueX+jfVpJRKNMER6vBBkmUBMCWNTUPwg2C6SujftuEnrC5I66giwW
	otSZj/qCOEUYTmTjbMaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pG5dW-00HJaR-RY; Thu, 12 Jan 2023 22:01:26 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pG4Bu-00Gv1H-78; Thu, 12 Jan 2023 20:28:51 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 9D4D4B82014;
	Thu, 12 Jan 2023 20:28:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08847C433EF;
	Thu, 12 Jan 2023 20:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1673555327;
	bh=ZbPNLkIUkQwHXCbvQoI2XLaF4ww/POIlS320Sa4a75I=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=Ew9S6ssyQxA/qOEa20QKNGKB4XNqKcj4gZvqGJH+zAG+P+Etqd7vw/znf/4NWIiTQ
	 Bk5xIf0TF8vpJTdsWmpqMzyz2u9CW3n58vVXYINgKQ8Ys9ny0OlUoy7YWJiSRsWGNl
	 RTVY7ppda94AJFEtcKo4HqFchiKjjT19SH8zBk8fjiY0YWgeKj83yZBlXudb2eSa64
	 q4IvtFH0u1VXC5cZIoMU1HyoWnUF84ag01Ib966jn6Jq4C3CU5IEq54tzZpHoOhssE
	 fZa0d21POZJLgjX5QB2TV2LFJLbEPppv5c9Y86RzgOUX6eeUDwPcIKdJkOiovDkAI3
	 X6K2ZCEAo7m+Q==
Message-ID: <cd75c97ac883283fb0764f5862a6377f.sboyd@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230112195541.844982902@infradead.org>
References: <20230112194314.845371875@infradead.org> <20230112195541.844982902@infradead.org>
Subject: Re: [PATCH v3 41/51] cpuidle,clk: Remove trace_.*_rcuidle()
From: Stephen Boyd <sboyd@kernel.org>
Cc: richard.henderson@linaro.org, ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@kernel.org, linux@armlinux.org.uk, nsekhar@ti.com, brgl@bgdev.pl, ulli.kroll@googlemail.com, linus.walleij@linaro.org, shawnguo@kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, tony@atomide.com, khilman@kernel.org, krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com, catalin.marinas@arm.com, will@kernel.org, guoren@kernel.org, bcain@quicinc.com, chenhuacai@kernel.org, kernel@xen0n.name, geert@linux-m68k.org, sammy@sammy.net, monstr@monstr.eu, tsbogend@alpha.franken.de, dinguyen@kernel.org, jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com, James.Bottomley@HansenPartnership.com, deller@gmx.de, mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu, paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.
 com, svens@linux.ibm.com, ysato@users.sourceforge.jp, dalias@libc.org, davem@davemloft.net, richard@nod.at, anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, acme@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, namhyung@kernel.org, jgross@suse.com, srivatsa@csail.mit.edu, amakhalov@vmware.com, pv-drivers@vmware.com, boris.ostrovsky@oracle.com, chris@zankel.net, jcmvbkbc@gmail.com, rafael@kernel.org, lenb@kernel.org, pavel@ucw.cz, gregkh@linuxfoundation.org, mturquette@baylibre.com, daniel.lezcano@linaro.org, lpieralisi@kernel.org, sudeep.holla@arm.com, agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org, anup@brainfault.org, thierry.reding@gmail.com, jonathanh@nvidia.com, jacob.jun.pan@linux.intel.com, atishp@atishpatra.org, Arnd Bergmann <arnd@arndb.de>, yury.norov@gmail.com, andriy.shevchenko@linux.intel.com
 , linux@rasmusvillemoes.dk, dennis@kernel.org, tj@kernel.org, cl@linux.com, rostedt@goodmis.org, mhiramat@kernel.org, frederic@kernel.org, paulmck@kernel.org, pmladek@suse.com, senozhatsky@chromium.org, john.ogness@linutronix.de, juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com, ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com, dvyukov@google.com, vincenzo.frascino@arm.com, Andrew Morton <akpm@linux-foundation.org>, jpoimboe@kernel.org, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv
 @lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, linux-perf-users@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-xtensa@linux-xtensa.org, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, kasan-dev@googlegroups.com, Ulf Hansson <ulf.hansson@linaro.org>, Rafael J. Wysocki <rafael.j.wysocki@intel.com>
To: peterz@infradead.org
Date: Thu, 12 Jan 2023 12:28:44 -0800
User-Agent: alot/0.10
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230112_122850_612940_385B4775 
X-CRM114-Status: UNSURE (   7.46  )
X-CRM114-Notice: Please train this message.
X-Mailman-Approved-At: Thu, 12 Jan 2023 14:00:43 -0800
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

Quoting Peter Zijlstra (2023-01-12 11:43:55)
> OMAP was the one and only user.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Acked-by: Frederic Weisbecker <frederic@kernel.org>
> Tested-by: Tony Lindgren <tony@atomide.com>
> Tested-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
