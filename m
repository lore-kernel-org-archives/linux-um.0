Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7641CD5BC0
	for <linux-um@archiver.kernel.org>; Tue, 19 Sep 2023 13:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=THwnAJC5YQbioj0041PCz+s4SQRfAFp/x517xPEog3U=; b=0O2AxMdUkGeOI0
	ka4f0Dl270VXkz4re3qObxOYe2TGXRA78pkzimrCK9uVgYPHqRJHoNz8rx6m+fovaaR73N3WBtBax
	mRV+Ce64Dbub/TCWekm6FUnR8Ci550k05G5zUXfaVDkI7VIdaPLrgP6m23pM8yZEZ8qrieur47UFn
	7Cq1jFCnv1eTFbWxZ0FwNYoRCtDFuYuW0WOeUu3eABwzy0F0uoOYLKJCoSTK8FjrOKGHPX8UYrbpH
	ICdjEYQlmPzcVUguRPrZ2QOdHYuvTAo7vv0IIv1TYXQvSE9aywCcvQhMHn1QdpnQUCPwbBoIVUzG1
	ObahQwr3d+92H/BgRKOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qiazp-000Yu5-1f;
	Tue, 19 Sep 2023 13:42:33 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qiazn-000Yt1-2G
	for linux-um@bombadil.infradead.org;
	Tue, 19 Sep 2023 13:42:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xF9/8QKvWWkbeOJr21JLbJCynp3yqjzThzTACYbxHTg=; b=haZzJuTZBCZsOTNcMz6ga4dc9s
	gPbmwmK5daZnt7lwf0QPIOwrHm1HLUNltZ5eyE7kwaAHo437epvLvvbzCxKSKbClSjly0J6iO9U3b
	2kE1iDoDjDVteIas0Hrdvw+mKegt5l3ahQOD8ROwy0dNBYdx5nyfI2MgkQbm1ywCSrKpMQQOJ03ry
	fMO9W8zUlfaxtXOtSOifpGhKXDQC78ttaD5wvdJrMOlfoZ6h4lc4Ci+ktx1zVTf3yZSfsmPXvx846
	2ADzJq0jb+18JXgy/PoeRUfMkREC/wv/U6mZE4obztCo1xpba1RDNlGOmFJ0zI1uUNmc+WjwUgXaS
	YwmBv/0Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qiazZ-00De9q-3B;
	Tue, 19 Sep 2023 13:42:19 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 18E1E300585; Tue, 19 Sep 2023 15:42:19 +0200 (CEST)
Date: Tue, 19 Sep 2023 15:42:18 +0200
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
Message-ID: <20230919134218.GA39281@noisy.programming.kicks-ass.net>
References: <87zg1u1h5t.fsf@oracle.com>
 <CAHk-=whMkp68vNxVn1H3qe_P7n=X2sWPL9kvW22dsvMFH8FcQQ@mail.gmail.com>
 <20230911150410.GC9098@noisy.programming.kicks-ass.net>
 <87h6o01w1a.fsf@oracle.com>
 <20230912082606.GB35261@noisy.programming.kicks-ass.net>
 <87cyyfxd4k.ffs@tglx>
 <CAHk-=whnwC01m_1f-gaM1xbvvwzwTiKitrWniA-ChZv+bM03dg@mail.gmail.com>
 <87led2wdj0.ffs@tglx>
 <ZQmbhoQIINs8rLHp@casper.infradead.org>
 <0e69f7df80dc5878071deb0d80938138d19de1d1.camel@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0e69f7df80dc5878071deb0d80938138d19de1d1.camel@physik.fu-berlin.de>
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

On Tue, Sep 19, 2023 at 03:37:24PM +0200, John Paul Adrian Glaubitz wrote:
> On Tue, 2023-09-19 at 14:00 +0100, Matthew Wilcox wrote:
> > On Tue, Sep 19, 2023 at 02:30:59PM +0200, Thomas Gleixner wrote:
> > > Though it just occured to me that there are dragons lurking:
> > > 
> > > arch/alpha/Kconfig:     select ARCH_NO_PREEMPT
> > > arch/hexagon/Kconfig:   select ARCH_NO_PREEMPT
> > > arch/m68k/Kconfig:      select ARCH_NO_PREEMPT if !COLDFIRE
> > > arch/um/Kconfig:        select ARCH_NO_PREEMPT
> > 
> > Sounds like three-and-a-half architectures which could be queued up for
> > removal right behind ia64 ...
> 
> The agreement to kill off ia64 wasn't an invitation to kill off other stuff
> that people are still working on! Can we please not do this?

If you're working on one of them, then surely it's a simple matter of
working on adding CONFIG_PREEMPT support :-)

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
