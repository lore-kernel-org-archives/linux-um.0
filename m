Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E0D5CD5BBD
	for <linux-um@archiver.kernel.org>; Tue, 19 Sep 2023 13:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=eAr4UojNIrdsBAkPP7hBmDJmWusNx7G1vPES0XAA2VM=; b=oDkKoQjsVxBo/Q
	MlJb+rY3qyv3n+5LfJQkgcF1IKchvMBnVHUgTTaPgsd4MiijKWdDqU56qIw4bVFuT/mznoBZS4wWt
	FKfok3/YHHQYXVfPPwhKZYXQ0YtYDKSkXsATj9gfBzklUXaye3rj8Rty2Rd09f1ZWgNK8KUytyk4d
	+sUOdaLin9UZQefc7DRVaUkZ6pM6ndMrBdCN78dS+728igtNnN2+PMrlsvnVlFwlayjy8oXIG6CAP
	sDIOnMdR14CmsDQDYj/ahSnmB+WQx4oQqNhxvbZAHOsbJtc39m/rCRneaDGJCPbLTSPbaQcSCNbi6
	IQ3fqxRxBb6XL2LOFEOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qiaw1-000YEx-15;
	Tue, 19 Sep 2023 13:38:37 +0000
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qiavz-000YES-0z
	for linux-um@lists.infradead.org;
	Tue, 19 Sep 2023 13:38:36 +0000
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1qiaus-000uPZ-85; Tue, 19 Sep 2023 15:37:26 +0200
Received: from p5b13a40a.dip0.t-ipconnect.de ([91.19.164.10] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1qiaur-001w4I-UQ; Tue, 19 Sep 2023 15:37:26 +0200
Message-ID: <0e69f7df80dc5878071deb0d80938138d19de1d1.camel@physik.fu-berlin.de>
Subject: Re: Arches that don't support PREEMPT
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Matthew Wilcox <willy@infradead.org>, Thomas Gleixner
 <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra
 <peterz@infradead.org>, Ankur Arora <ankur.a.arora@oracle.com>, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org, 
 akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de, 
 dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com, 
 juri.lelli@redhat.com, vincent.guittot@linaro.org, mgorman@suse.de, 
 rostedt@goodmis.org, jon.grimm@amd.com, bharata@amd.com,
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
Date: Tue, 19 Sep 2023 15:37:24 +0200
In-Reply-To: <ZQmbhoQIINs8rLHp@casper.infradead.org>
References: <87edj64rj1.fsf@oracle.com>
	 <CAHk-=wi0bXpgULVVLc2AdJcta-fvQP7yyFQ_JtaoHUiPrqf--A@mail.gmail.com>
	 <87zg1u1h5t.fsf@oracle.com>
	 <CAHk-=whMkp68vNxVn1H3qe_P7n=X2sWPL9kvW22dsvMFH8FcQQ@mail.gmail.com>
	 <20230911150410.GC9098@noisy.programming.kicks-ass.net>
	 <87h6o01w1a.fsf@oracle.com>
	 <20230912082606.GB35261@noisy.programming.kicks-ass.net>
	 <87cyyfxd4k.ffs@tglx>
	 <CAHk-=whnwC01m_1f-gaM1xbvvwzwTiKitrWniA-ChZv+bM03dg@mail.gmail.com>
	 <87led2wdj0.ffs@tglx> <ZQmbhoQIINs8rLHp@casper.infradead.org>
User-Agent: Evolution 3.48.4 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 91.19.164.10
X-ZEDAT-Hint: PO
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230919_063835_490671_7F4BAAA3 
X-CRM114-Status: GOOD (  10.45  )
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

On Tue, 2023-09-19 at 14:00 +0100, Matthew Wilcox wrote:
> On Tue, Sep 19, 2023 at 02:30:59PM +0200, Thomas Gleixner wrote:
> > Though it just occured to me that there are dragons lurking:
> > 
> > arch/alpha/Kconfig:     select ARCH_NO_PREEMPT
> > arch/hexagon/Kconfig:   select ARCH_NO_PREEMPT
> > arch/m68k/Kconfig:      select ARCH_NO_PREEMPT if !COLDFIRE
> > arch/um/Kconfig:        select ARCH_NO_PREEMPT
> 
> Sounds like three-and-a-half architectures which could be queued up for
> removal right behind ia64 ...

The agreement to kill off ia64 wasn't an invitation to kill off other stuff
that people are still working on! Can we please not do this?

Thanks,
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
