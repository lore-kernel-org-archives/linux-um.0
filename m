Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AB7CCD5BB3
	for <linux-um@archiver.kernel.org>; Tue, 19 Sep 2023 13:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0mZ8ACdsK+VaAg7kKPasqutxqQcWQOsH9cuSizg07kA=; b=sq/syEJ+wc6LZ6
	aZoF9JDbkMqNWC5RT/Vcm9ESyO9/ReHxT2aTS/HGr6l5VKInsIno6aWquCS8M2tiET2T5nTatwoLn
	6MF3HwOv+lt2xjMLqEf523vXchaObHMkDzADE4ickyu2AfbluHAI0CoIFZe1k1EJfb5W6pJhyHLD6
	dvXTLOvDeYGbGZwteD+IJLXj/mqzw4XA7GXX1xokvclW1esPK64wQj9utE2FMeVFSnFgjvWLl12oz
	WVWIAGiOged+KbdQWZ50G3In0pnRhq4sIC1zhlJs8qKwXXNJ2o+qHV8TSD9M+QdzBbJdN7SuSy0if
	ucD7y0xyWSiM34bMG7jg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qiaLh-000TkM-12;
	Tue, 19 Sep 2023 13:01:05 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qiaLg-000TkC-1K
	for linux-um@bombadil.infradead.org;
	Tue, 19 Sep 2023 13:01:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=UQqbtC4LU7CWz7n0Qti5YLvSVy7RAt2aZ0CW6vnfgZE=; b=Re/9h8bA2l5R9rS+t5jWP44yYf
	BD+D17QDievItTZT8XCUjAygltixoCakyWJVYollwPJN+8J4YpztmZA/sMcUv90RlabAnSY9WQ4Q5
	kljuiW6Cp/gHdVwZuPoajR8jGbsUenSGzi9mEG6tIRVZj0rpmnWEoTdwR4IlnbCmrhYh71f/ffZwD
	zA71QJEsU16dBg8UTSfZAHBIFPXxlH+0HL85WXEeFNsoDqUzKX5tjdXYgp/4e6wfzSGAKQCk05a4i
	Klv/roly2FY9BRa21dQGgYeEcWYYb7A4C+ID92Ny/pq8ytpWrLKuBOGrdB94Fc5u0I/Yvk/fJrDb0
	xGCYQG0g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1qiaLW-00HLve-Gs; Tue, 19 Sep 2023 13:00:54 +0000
Date: Tue, 19 Sep 2023 14:00:54 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
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
Subject: Arches that don't support PREEMPT
Message-ID: <ZQmbhoQIINs8rLHp@casper.infradead.org>
References: <87edj64rj1.fsf@oracle.com>
 <CAHk-=wi0bXpgULVVLc2AdJcta-fvQP7yyFQ_JtaoHUiPrqf--A@mail.gmail.com>
 <87zg1u1h5t.fsf@oracle.com>
 <CAHk-=whMkp68vNxVn1H3qe_P7n=X2sWPL9kvW22dsvMFH8FcQQ@mail.gmail.com>
 <20230911150410.GC9098@noisy.programming.kicks-ass.net>
 <87h6o01w1a.fsf@oracle.com>
 <20230912082606.GB35261@noisy.programming.kicks-ass.net>
 <87cyyfxd4k.ffs@tglx>
 <CAHk-=whnwC01m_1f-gaM1xbvvwzwTiKitrWniA-ChZv+bM03dg@mail.gmail.com>
 <87led2wdj0.ffs@tglx>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87led2wdj0.ffs@tglx>
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

On Tue, Sep 19, 2023 at 02:30:59PM +0200, Thomas Gleixner wrote:
> Though it just occured to me that there are dragons lurking:
> 
> arch/alpha/Kconfig:     select ARCH_NO_PREEMPT
> arch/hexagon/Kconfig:   select ARCH_NO_PREEMPT
> arch/m68k/Kconfig:      select ARCH_NO_PREEMPT if !COLDFIRE
> arch/um/Kconfig:        select ARCH_NO_PREEMPT

Sounds like three-and-a-half architectures which could be queued up for
removal right behind ia64 ...

I suspect none of these architecture maintainers have any idea there's a
problem.  Look at commit 87a4c375995e and the discussion in
https://lore.kernel.org/lkml/20180724175646.3621-1-hch@lst.de/

Let's cc those maintainers so they can remove this and fix whatever
breaks.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
