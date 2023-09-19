Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45EFFCD5BBD
	for <linux-um@archiver.kernel.org>; Tue, 19 Sep 2023 13:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ibEkJS3IOI/+PF4u7FFi2sInH8i+7E50ecpI3fVQXto=; b=HK2mTA0xUah9DU
	Ftaco37wIHAE2s19NLM/rof6YPLSVmiv71FFaa7j0zH+8m6nLR+VO71AF3weNZ9hEAbGwXP55lgKY
	FWtToETwCAoHvLsDrWpjnD+ZTjPvSJKzhHYQSbofbEJNopYcSf1rGqtN5jZ9JNaOuO8WZjEiuiet3
	cgUsMJWaneGGLpNkoxySb1d8lpzTZwWP9zUxd59kgchJE9Xy94RshQs3pfjEuhaT4ws2fh8sO+SA5
	aRLq6Vjf1ENF6r6o14WWXWsU0uR5xjMqKmu7bavmkK7JcDiIF9+izPoiED8Wn2l0Td3NcfXK1NMq+
	yuM1ReGQQPFZ//Z0HhpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qib5k-000ZdW-0q;
	Tue, 19 Sep 2023 13:48:40 +0000
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qib5i-000Zd6-0G
	for linux-um@lists.infradead.org;
	Tue, 19 Sep 2023 13:48:39 +0000
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1qib5H-000y1u-E7; Tue, 19 Sep 2023 15:48:11 +0200
Received: from p5b13a40a.dip0.t-ipconnect.de ([91.19.164.10] helo=[192.168.178.81])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1qib5H-001yAy-4e; Tue, 19 Sep 2023 15:48:11 +0200
Message-ID: <a6c84803274116ec827cd4bdd4e72a8d0c304c27.camel@physik.fu-berlin.de>
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
Date: Tue, 19 Sep 2023 15:48:09 +0200
In-Reply-To: <20230919134218.GA39281@noisy.programming.kicks-ass.net>
References: <87zg1u1h5t.fsf@oracle.com>
	 <CAHk-=whMkp68vNxVn1H3qe_P7n=X2sWPL9kvW22dsvMFH8FcQQ@mail.gmail.com>
	 <20230911150410.GC9098@noisy.programming.kicks-ass.net>
	 <87h6o01w1a.fsf@oracle.com>
	 <20230912082606.GB35261@noisy.programming.kicks-ass.net>
	 <87cyyfxd4k.ffs@tglx>
	 <CAHk-=whnwC01m_1f-gaM1xbvvwzwTiKitrWniA-ChZv+bM03dg@mail.gmail.com>
	 <87led2wdj0.ffs@tglx> <ZQmbhoQIINs8rLHp@casper.infradead.org>
	 <0e69f7df80dc5878071deb0d80938138d19de1d1.camel@physik.fu-berlin.de>
	 <20230919134218.GA39281@noisy.programming.kicks-ass.net>
User-Agent: Evolution 3.48.4 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 91.19.164.10
X-ZEDAT-Hint: PO
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230919_064838_288481_91EE9F1D 
X-CRM114-Status: GOOD (  10.65  )
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

On Tue, 2023-09-19 at 15:42 +0200, Peter Zijlstra wrote:
> > The agreement to kill off ia64 wasn't an invitation to kill off other stuff
> > that people are still working on! Can we please not do this?
> 
> If you're working on one of them, then surely it's a simple matter of
> working on adding CONFIG_PREEMPT support :-)

As Geert poined out, I'm not seeing anything particular problematic with the
architectures lacking CONFIG_PREEMPT at the moment. This seems to be more
something about organizing KConfig files.

I find it a bit unfair that maintainers of architectures that have huge companies
behind them use their manpower to urge less popular architectures for removal just
because they don't have 150 people working on the port so they can keep up with
design changes quickly.

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
