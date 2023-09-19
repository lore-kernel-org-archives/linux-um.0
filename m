Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C2F3CD5BCE
	for <linux-um@archiver.kernel.org>; Tue, 19 Sep 2023 14:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0ajKeV8XFtYB+f+fLl+jZ/0VNVDoKVatTacEDSGHON4=; b=mwkE3car1107fB
	iBpcawqaXPw97V0bvJB7EMb9OiTTdQKkTa8sdwCvUNRixLuk5cE0mWxf7lz/GTEhZQYkDwaTobBEF
	uJHsnFBneJWbrp3JAYPECDWTQwX9XEHzY1Om0SXtJXFWW1205GTliD6oaG0FwLCwhAPDGCAjdTimR
	njDpVTjtYhhsPdtLqnyVM/V9IHP+qrN2Fj8ZM/0s3QvXFB3suc8/RE+J1oIcdp/m/+hcdFTp5M/QO
	xjsRLd5UMYaqUSYHVMi5Gi3RwCtzsSyfl/UouEbsxaRay+vwZxqvZw9Gfl4j/6GR0UIYYUl2vA3sM
	wnNRh3m4fQ8xNjF7elow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qic3l-000hRy-00;
	Tue, 19 Sep 2023 14:50:41 +0000
Received: from ns1.kot-begemot.co.uk ([217.160.28.25] helo=www.kot-begemot.co.uk)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qic3h-000hQd-39
	for linux-um@lists.infradead.org;
	Tue, 19 Sep 2023 14:50:39 +0000
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1qibbi-002SAY-6X; Tue, 19 Sep 2023 14:21:42 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
	by jain.kot-begemot.co.uk with esmtp (Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1qibbf-00FmyT-Fd; Tue, 19 Sep 2023 15:21:41 +0100
Message-ID: <bd664a61-4506-bab0-19c3-0011f57005b5@cambridgegreys.com>
Date: Tue, 19 Sep 2023 15:21:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: Arches that don't support PREEMPT
Content-Language: en-US
To: Peter Zijlstra <peterz@infradead.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Matthew Wilcox <willy@infradead.org>, Thomas Gleixner
 <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>,
 Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, x86@kernel.org, akpm@linux-foundation.org,
 luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
 mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 mgorman@suse.de, rostedt@goodmis.org, jon.grimm@amd.com, bharata@amd.com,
 raghavendra.kt@amd.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
 jgross@suse.com, andrew.cooper3@citrix.com,
 Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@lists.linux-m68k.org,
 Richard Weinberger <richard@nod.at>,
 Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org,
 Brian Cain <bcain@quicinc.com>, linux-hexagon@vger.kernel.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner
 <mattst88@gmail.com>, linux-alpha@vger.kernel.org
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
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
In-Reply-To: <20230919134218.GA39281@noisy.programming.kicks-ass.net>
X-Clacks-Overhead: GNU Terry Pratchett
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230919_075038_011690_EEF9DD1C 
X-CRM114-Status: GOOD (  18.07  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org



On 19/09/2023 14:42, Peter Zijlstra wrote:
> On Tue, Sep 19, 2023 at 03:37:24PM +0200, John Paul Adrian Glaubitz wrote:
>> On Tue, 2023-09-19 at 14:00 +0100, Matthew Wilcox wrote:
>>> On Tue, Sep 19, 2023 at 02:30:59PM +0200, Thomas Gleixner wrote:
>>>> Though it just occured to me that there are dragons lurking:
>>>>
>>>> arch/alpha/Kconfig:     select ARCH_NO_PREEMPT
>>>> arch/hexagon/Kconfig:   select ARCH_NO_PREEMPT
>>>> arch/m68k/Kconfig:      select ARCH_NO_PREEMPT if !COLDFIRE
>>>> arch/um/Kconfig:        select ARCH_NO_PREEMPT
>>>
>>> Sounds like three-and-a-half architectures which could be queued up for
>>> removal right behind ia64 ...
>>
>> The agreement to kill off ia64 wasn't an invitation to kill off other stuff
>> that people are still working on! Can we please not do this?
> 
> If you're working on one of them, then surely it's a simple matter of
> working on adding CONFIG_PREEMPT support :-)

In the case of UML adding preempt will be quite difficult. I looked at this a few years back.

At the same time it is used for kernel test and other stuff. It is not exactly abandonware on a CPU found in archaeological artifacts of past civilizations like ia64.

> 
> _______________________________________________
> linux-um mailing list
> linux-um@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-um
> 

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
