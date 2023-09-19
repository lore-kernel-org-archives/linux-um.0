Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07EA3CD5BDC
	for <linux-um@archiver.kernel.org>; Tue, 19 Sep 2023 15:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WHSx455S3CJO1UvMr2GThPcHZg0HVqyJRCnhaR4NUIQ=; b=wf1Edbq4N4WX0l
	gs21sml+vTWBkN/w4b8Js00OOOEHfOv9qr48yE/AO1qwADoPmdqqvLInjGveFlhvdQeOMq2BAbRcU
	plqOx8QQoZlhesq8IV7qeRs5MspHNiYRiPrZjRZxYHZI+ZfmFGDCa37Mj/F3EHkSNP/piGDWKhRfC
	vycTiejQ8ot8Wsoldm7zrZYbQnNcWY4gHTKCfgiIMHZ3dtg8rU2EeX1gIdy1SdJmHtVlL1QztOytw
	owPYIRVkCyyQxGyrcAT42UU+yWn+f5TfMR79/f7XRpjQLSZLhp4H5zcq54jXz1XNpGA4g5SIoG86J
	U7C5uUSGjS54s4GSaZOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qicgf-000ldI-0J;
	Tue, 19 Sep 2023 15:30:53 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qicgc-000lam-1L
	for linux-um@lists.infradead.org;
	Tue, 19 Sep 2023 15:30:51 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 9E551B81612;
	Tue, 19 Sep 2023 15:30:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A377C433CA;
	Tue, 19 Sep 2023 15:30:35 +0000 (UTC)
Date: Tue, 19 Sep 2023 11:31:08 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Peter Zijlstra
 <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Linus
 Torvalds <torvalds@linux-foundation.org>, Ankur Arora
 <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, x86@kernel.org, akpm@linux-foundation.org,
 luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
 mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 mgorman@suse.de, jon.grimm@amd.com, bharata@amd.com,
 raghavendra.kt@amd.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
 jgross@suse.com, andrew.cooper3@citrix.com, Geert Uytterhoeven
 <geert@linux-m68k.org>, linux-m68k@lists.linux-m68k.org, Richard Weinberger
 <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes
 Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org, Brian Cain
 <bcain@quicinc.com>, linux-hexagon@vger.kernel.org, Richard Henderson
 <richard.henderson@linaro.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
 Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org
Subject: Re: Arches that don't support PREEMPT
Message-ID: <20230919113108.1c988906@gandalf.local.home>
In-Reply-To: <ZQmw5dUzcFOWjHdB@casper.infradead.org>
References: <20230912082606.GB35261@noisy.programming.kicks-ass.net>
	<87cyyfxd4k.ffs@tglx>
	<CAHk-=whnwC01m_1f-gaM1xbvvwzwTiKitrWniA-ChZv+bM03dg@mail.gmail.com>
	<87led2wdj0.ffs@tglx>
	<ZQmbhoQIINs8rLHp@casper.infradead.org>
	<0e69f7df80dc5878071deb0d80938138d19de1d1.camel@physik.fu-berlin.de>
	<20230919134218.GA39281@noisy.programming.kicks-ass.net>
	<a6c84803274116ec827cd4bdd4e72a8d0c304c27.camel@physik.fu-berlin.de>
	<20230919141627.GB39281@noisy.programming.kicks-ass.net>
	<a428516ebeae71e33635edc83052c972ce40c85d.camel@physik.fu-berlin.de>
	<ZQmw5dUzcFOWjHdB@casper.infradead.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230919_083050_590693_DA56552C 
X-CRM114-Status: GOOD (  17.22  )
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

On Tue, 19 Sep 2023 15:32:05 +0100
Matthew Wilcox <willy@infradead.org> wrote:

> On Tue, Sep 19, 2023 at 04:24:48PM +0200, John Paul Adrian Glaubitz wrote:
> > If the conversion isn't hard, why is the first reflex the urge to remove an architecture
> > instead of offering advise how to get the conversion done?  
> 
> Because PREEMPT has been around since before 2005 (cc19ca86a023 created
> Kconfig.preempt and I don't need to go back further than that to make my
> point), and you haven't done the work yet.  Clearly it takes the threat
> of removal to get some kind of motion.

Or the use case of a preempt kernel on said arch has never been a request.
Just because it was available doesn't necessarily mean it's required.

Please, let's not jump to threats of removal just to get a feature in.
Simply ask first. I didn't see anyone reaching out to the maintainers
asking for this as it will be needed for a new feature that will likely
make maintaining said arch easier.

Everything is still in brainstorming mode.

-- Steve

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
