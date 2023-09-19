Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7A90CD5BDD
	for <linux-um@archiver.kernel.org>; Tue, 19 Sep 2023 15:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VzQ0/z6zycceauwhDJsAX+LQE6YG+D88R1dyQCI+hX8=; b=XphWAbBvvHBQfp
	tZGrCJAyzpBcOrFEebeggNe0j7lZvodr0zfqIvixg3wnX6jz9Jj8+7ValoOL/tB6HBvfql1UJnRib
	zVXY3tgxMqGJzVVDYZeNt4I2kzOPJbaGN0DnNnBqlJHGxB3oEGWHOHoocJGVGxlylF9wTbWVrFCLP
	6/5zrODljiM0ev4HpixwL050VVjApdFDBEHt/E/xlrmd92ziqkA6KtgZPUA0qKgtGL9EuSzMQZOgb
	vxQkL58Kkkusa1h624BZPYgwWzoPax73aWVmCtvDYCayY5stwRad0LGRHH6ndhP3ah7dZDCjCAleM
	YVF2+Bge6wZ+WaZ4NWjw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qicYP-000kmY-2J;
	Tue, 19 Sep 2023 15:22:21 +0000
Received: from ns1.kot-begemot.co.uk ([217.160.28.25] helo=www.kot-begemot.co.uk)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qicYN-000kla-00
	for linux-um@lists.infradead.org;
	Tue, 19 Sep 2023 15:22:20 +0000
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1qicXc-002SL8-Lu; Tue, 19 Sep 2023 15:21:32 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
	by jain.kot-begemot.co.uk with esmtp (Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1qicXZ-00Ft9g-WC; Tue, 19 Sep 2023 16:21:32 +0100
Message-ID: <9a5c0856-d542-9912-7494-53d7fe4538a3@cambridgegreys.com>
Date: Tue, 19 Sep 2023 16:21:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: Arches that don't support PREEMPT
Content-Language: en-US
To: Thomas Gleixner <tglx@linutronix.de>,
 Peter Zijlstra <peterz@infradead.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Matthew Wilcox <willy@infradead.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
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
 <bd664a61-4506-bab0-19c3-0011f57005b5@cambridgegreys.com>
 <87y1h2ur98.ffs@tglx>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
In-Reply-To: <87y1h2ur98.ffs@tglx>
X-Clacks-Overhead: GNU Terry Pratchett
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230919_082219_041241_96C5359E 
X-CRM114-Status: GOOD (  12.56  )
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


On 19/09/2023 16:17, Thomas Gleixner wrote:
> On Tue, Sep 19 2023 at 15:21, Anton Ivanov wrote:
>> On 19/09/2023 14:42, Peter Zijlstra wrote:
>>> If you're working on one of them, then surely it's a simple matter of
>>> working on adding CONFIG_PREEMPT support :-)
>> In the case of UML adding preempt will be quite difficult. I looked at
>> this a few years back.
> What's so difficult about it?

It's been a while. I remember that I dropped it at the time, but do not remember the full details.

There was some stuff related to FP state and a few other issues I ran into while rewriting the interrupt controller. Some of it may be resolved by now as we are using host cpu flags, etc.

I can give it another go :)

>
> Thanks,
>
>          tglx
>
-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
