Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D243CE79A8
	for <linux-um@archiver.kernel.org>; Tue, 19 Sep 2023 17:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=b47csQ0LtMzrFaQuU4CBlEyxEMSHAP6zD9tHpzh/xZk=; b=H7NWIRkHDt8FsQ
	VDkrWb7I0BwxhwnoSyEVYbdFtA9HTbnY/kZCESdIHFGgp4cYyJe83GBw6yEV7PnqnmGe8/4h/udU0
	66ZV0fl6B4b1dUcajEo8NSLYeY/wDYheeB7Y9KbAG5rA3IZQno+vXL22HDfuurMQM+/MJHlkLn15p
	xysIk/+b55YdHs4jgXtvn5zNgcQK4xkGDSZ0cK//dHysr801//WiD2Olp3X4tzXEVGNmuxZNpPTnI
	iLdBGWQVSJScCslz+hxwMDIZBWeaMhO+lrQyxl6LqX6gQc+hwM6entfCNK3QV7Zm8OtybNWBBa++8
	JIs6GxWyW5thgSrGuIgg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qif0B-0011H5-02;
	Tue, 19 Sep 2023 17:59:11 +0000
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qif08-0011Fm-0G
	for linux-um@lists.infradead.org;
	Tue, 19 Sep 2023 17:59:09 +0000
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1qieza-002CLX-Et; Tue, 19 Sep 2023 19:58:34 +0200
Received: from p5b13a40a.dip0.t-ipconnect.de ([91.19.164.10] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1qieza-002eoT-1f; Tue, 19 Sep 2023 19:58:34 +0200
Message-ID: <64746d98b60f1677cecd26501511f140688801e1.camel@physik.fu-berlin.de>
Subject: Re: Arches that don't support PREEMPT
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Matthew Wilcox
 <willy@infradead.org>,  Thomas Gleixner <tglx@linutronix.de>, Ankur Arora
 <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, x86@kernel.org, akpm@linux-foundation.org,
 luto@kernel.org,  bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
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
Date: Tue, 19 Sep 2023 19:58:31 +0200
In-Reply-To: <CAHk-=wgUimqtF7PqFfRw4Ju5H1KYkp6+8F=hBz7amGQ8GaGKkA@mail.gmail.com>
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
	 <a6c84803274116ec827cd4bdd4e72a8d0c304c27.camel@physik.fu-berlin.de>
	 <CAHk-=wgUimqtF7PqFfRw4Ju5H1KYkp6+8F=hBz7amGQ8GaGKkA@mail.gmail.com>
User-Agent: Evolution 3.48.4 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 91.19.164.10
X-ZEDAT-Hint: PO
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230919_105908_264467_C5152A4B 
X-CRM114-Status: GOOD (  21.83  )
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

Hi Linus!

On Tue, 2023-09-19 at 10:25 -0700, Linus Torvalds wrote:
> On Tue, 19 Sept 2023 at 06:48, John Paul Adrian Glaubitz
> <glaubitz@physik.fu-berlin.de> wrote:
> > 
> > As Geert poined out, I'm not seeing anything particular problematic with the
> > architectures lacking CONFIG_PREEMPT at the moment. This seems to be more
> > something about organizing KConfig files.
> 
> It can definitely be problematic.
> 
> Not the Kconfig file part, and not the preempt count part itself.
> 
> But the fact that it has never been used and tested means that there
> might be tons of "this architecture code knows it's not preemptible,
> because this architecture doesn't support preemption".
> 
> So you may have basic architecture code that simply doesn't have the
> "preempt_disable()/enable()" pairs that it needs.
> 
> PeterZ mentioned the generic entry code, which does this for the entry
> path. But it actually goes much deeper: just do a
> 
>     git grep preempt_disable arch/x86/kernel
> 
> and then do the same for some other architectures.
> 
> Looking at alpha, for example, there *are* hits for it, so at least
> some of the code there clearly *tries* to do it. But does it cover all
> the required parts? If it's never been tested, I'd be surprised if
> it's all just ready to go.

Thanks for the detailed explanation.

> I do think we'd need to basically continue to support ARCH_NO_PREEMPT
> - and such architectures migth end up with the worst-cast latencies of
> only scheduling at return to user space.

Great to hear, thank you.

And, yes, eventually I would be happy to help get alpha and m68k converted.

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
