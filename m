Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9646ACD5BCA
	for <linux-um@archiver.kernel.org>; Tue, 19 Sep 2023 14:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=58EioyO5jGMJ+9kppcyLUcl2SDL+o1rEremVzRmYDM8=; b=PM3zUHcexX5gFb
	vBbRH5y3AaV1BFkUcpraZzftxkR7tKozjA6TWk1MAf9B3UBtqZxn5ux0ACEhLoSfxCKcqK3cY1S3S
	1mHP6yUVix75CajpaVW0Eyj8T2K0zP0Pk9L+OV/VUHypX6uIXB6DuCWctNBIH4c+KuuT6mq1iNf7o
	/a2hfjli2X4GXo1svUZ6+nS7tthG5i7HqULrRp441HRofyZw3DDgtWNpXLorqV1BtsCloWJydL9C7
	ME/injCSoqIQ1ZlNx9TNGCQwJjHXSaLNSKLXW4aI/JxNdoTKlf/r8kqWE7g1X6bdKttkNEp2jfnpn
	+GbSkAba4VNCio2Ougmg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qibfE-000eNY-2D;
	Tue, 19 Sep 2023 14:25:20 +0000
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qibfC-000eMP-0B
	for linux-um@lists.infradead.org;
	Tue, 19 Sep 2023 14:25:19 +0000
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1qibek-001CsS-ED; Tue, 19 Sep 2023 16:24:50 +0200
Received: from p5b13a40a.dip0.t-ipconnect.de ([91.19.164.10] helo=[192.168.178.81])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1qibek-0024rB-4a; Tue, 19 Sep 2023 16:24:50 +0200
Message-ID: <a428516ebeae71e33635edc83052c972ce40c85d.camel@physik.fu-berlin.de>
Subject: Re: Arches that don't support PREEMPT
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Matthew Wilcox <willy@infradead.org>, Thomas Gleixner
 <tglx@linutronix.de>,  Linus Torvalds <torvalds@linux-foundation.org>,
 Ankur Arora <ankur.a.arora@oracle.com>,  linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, x86@kernel.org,  akpm@linux-foundation.org,
 luto@kernel.org, bp@alien8.de,  dave.hansen@linux.intel.com, hpa@zytor.com,
 mingo@redhat.com,  juri.lelli@redhat.com, vincent.guittot@linaro.org,
 mgorman@suse.de,  rostedt@goodmis.org, jon.grimm@amd.com, bharata@amd.com,
 raghavendra.kt@amd.com,  boris.ostrovsky@oracle.com,
 konrad.wilk@oracle.com, jgross@suse.com,  andrew.cooper3@citrix.com, Geert
 Uytterhoeven <geert@linux-m68k.org>,  linux-m68k@lists.linux-m68k.org,
 Richard Weinberger <richard@nod.at>, Anton Ivanov
 <anton.ivanov@cambridgegreys.com>, Johannes Berg
 <johannes@sipsolutions.net>,  linux-um@lists.infradead.org, Brian Cain
 <bcain@quicinc.com>,  linux-hexagon@vger.kernel.org, Richard Henderson
 <richard.henderson@linaro.org>,  Ivan Kokshaysky
 <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>,
 linux-alpha@vger.kernel.org
Date: Tue, 19 Sep 2023 16:24:48 +0200
In-Reply-To: <20230919141627.GB39281@noisy.programming.kicks-ass.net>
References: <20230911150410.GC9098@noisy.programming.kicks-ass.net>
	 <87h6o01w1a.fsf@oracle.com>
	 <20230912082606.GB35261@noisy.programming.kicks-ass.net>
	 <87cyyfxd4k.ffs@tglx>
	 <CAHk-=whnwC01m_1f-gaM1xbvvwzwTiKitrWniA-ChZv+bM03dg@mail.gmail.com>
	 <87led2wdj0.ffs@tglx> <ZQmbhoQIINs8rLHp@casper.infradead.org>
	 <0e69f7df80dc5878071deb0d80938138d19de1d1.camel@physik.fu-berlin.de>
	 <20230919134218.GA39281@noisy.programming.kicks-ass.net>
	 <a6c84803274116ec827cd4bdd4e72a8d0c304c27.camel@physik.fu-berlin.de>
	 <20230919141627.GB39281@noisy.programming.kicks-ass.net>
User-Agent: Evolution 3.48.4 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 91.19.164.10
X-ZEDAT-Hint: PO
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230919_072518_241082_809CFC74 
X-CRM114-Status: GOOD (  12.20  )
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

On Tue, 2023-09-19 at 16:16 +0200, Peter Zijlstra wrote:
> > I find it a bit unfair that maintainers of architectures that have huge companies
> > behind them use their manpower to urge less popular architectures for removal just
> > because they don't have 150 people working on the port so they can keep up with
> > design changes quickly.
> 
> PREEMPT isn't something new. Also, I don't think the arch part for
> actually supporting it is particularly hard, mostly it is sticking the
> preempt_schedule_irq() call in return from interrupt code path.
> 
> If you convert the arch to generic-entry (a much larger undertaking)
> then you get this for free.

If the conversion isn't hard, why is the first reflex the urge to remove an architecture
instead of offering advise how to get the conversion done?

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
