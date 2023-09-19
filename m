Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40826CD5BC7
	for <linux-um@archiver.kernel.org>; Tue, 19 Sep 2023 14:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZsDJG3QawXObeX7J4/44KhBtG3sKtvqdCHD26kfjIxs=; b=2T8ob7KGdE4Sl2
	4oFcg5eDQnR2I0+XufhUjv4uJtDJw4w2iFv68Qzwm1PmQkYzsCp6C11mo2Gv3TGcb4C38aPEfrgbB
	qcbFewTKArGH6IwvRpTnzAjlx6ef+800ZtPKqSlYihPFkFG6RPcZK6c2UrzA1N64AYJnw+aKhpEr/
	ovt1Kmu/gt3YXkYFqtCI9dxR92vHQa/gQog65fXAzoSoY+smsK4uBDx0DbAmWD9pxRFHqWmHhoBXa
	wSqSTRwierrD3wKwu4vIHgmksD0MsjOfdBPeo82urbM6D0i2ysXo+XqR3HpaKcn6/bW8ERtgAse8W
	gEnYdDjv+u3nzxfW3jAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qibWl-000cxw-1Q;
	Tue, 19 Sep 2023 14:16:35 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qibWk-000cxe-1F
	for linux-um@bombadil.infradead.org;
	Tue, 19 Sep 2023 14:16:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=umXyPhqUhgAa/i7oZDEoLO+OY12DhrXYf7b1iez55DA=; b=S8Yyhj6JzhXJmoAwhs9b2qBktW
	fJkjw962R22KizD1SPZA6XyfLVfg+wxDfeyqXE/qEzvzBbAOB0JWJH//8CZCPxjiIEGIhQgdHdQ5A
	kGjcyLQCnV5P6UMmmGVM11jwFbT4Wv9ktgTd9HBewq4Nmx/jNT8q+hUrefFMjapXmG8GusMzqkNj6
	tHrNwPiNaq5/zTsX//Ipcjt6B59N1SKwf8J2lXnVBG3e3pPa9EdK+WSuaebSS/RAaWRT/B6c0t9Co
	jicMyJ60XWmWzfmF4HbA9MU7TD3bBgj7+/utf/2imNYSgV7I/4G7VVWP3rtJmKPASr/9YGRlK1yTB
	hGxidcNQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qibWc-00DegS-0S;
	Tue, 19 Sep 2023 14:16:27 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 3C68C300585; Tue, 19 Sep 2023 16:16:27 +0200 (CEST)
Date: Tue, 19 Sep 2023 16:16:27 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Matthew Wilcox <willy@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Ankur Arora <ankur.a.arora@oracle.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
	akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
	juri.lelli@redhat.com, vincent.guittot@linaro.org, mgorman@suse.de,
	rostedt@goodmis.org, jon.grimm@amd.com, bharata@amd.com,
	raghavendra.kt@amd.com, boris.ostrovsky@oracle.com,
	konrad.wilk@oracle.com, jgross@suse.com, andrew.cooper3@citrix.com,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-m68k@lists.linux-m68k.org,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org, Brian Cain <bcain@quicinc.com>,
	linux-hexagon@vger.kernel.org,
	Richard Henderson <richard.henderson@linaro.org>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org
Subject: Re: Arches that don't support PREEMPT
Message-ID: <20230919141627.GB39281@noisy.programming.kicks-ass.net>
References: <20230911150410.GC9098@noisy.programming.kicks-ass.net>
 <87h6o01w1a.fsf@oracle.com>
 <20230912082606.GB35261@noisy.programming.kicks-ass.net>
 <87cyyfxd4k.ffs@tglx>
 <CAHk-=whnwC01m_1f-gaM1xbvvwzwTiKitrWniA-ChZv+bM03dg@mail.gmail.com>
 <87led2wdj0.ffs@tglx>
 <ZQmbhoQIINs8rLHp@casper.infradead.org>
 <0e69f7df80dc5878071deb0d80938138d19de1d1.camel@physik.fu-berlin.de>
 <20230919134218.GA39281@noisy.programming.kicks-ass.net>
 <a6c84803274116ec827cd4bdd4e72a8d0c304c27.camel@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a6c84803274116ec827cd4bdd4e72a8d0c304c27.camel@physik.fu-berlin.de>
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

On Tue, Sep 19, 2023 at 03:48:09PM +0200, John Paul Adrian Glaubitz wrote:
> On Tue, 2023-09-19 at 15:42 +0200, Peter Zijlstra wrote:
> > > The agreement to kill off ia64 wasn't an invitation to kill off other stuff
> > > that people are still working on! Can we please not do this?
> > 
> > If you're working on one of them, then surely it's a simple matter of
> > working on adding CONFIG_PREEMPT support :-)
> 
> As Geert poined out, I'm not seeing anything particular problematic with the
> architectures lacking CONFIG_PREEMPT at the moment. This seems to be more
> something about organizing KConfig files.

The plan in the parent thread is to remove PREEMPT_NONE and
PREEMPT_VOLUNTARY and only keep PREEMPT_FULL.

> I find it a bit unfair that maintainers of architectures that have huge companies
> behind them use their manpower to urge less popular architectures for removal just
> because they don't have 150 people working on the port so they can keep up with
> design changes quickly.

PREEMPT isn't something new. Also, I don't think the arch part for
actually supporting it is particularly hard, mostly it is sticking the
preempt_schedule_irq() call in return from interrupt code path.

If you convert the arch to generic-entry (a much larger undertaking)
then you get this for free.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
