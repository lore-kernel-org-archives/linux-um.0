Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C85D7CE79A8
	for <linux-um@archiver.kernel.org>; Tue, 19 Sep 2023 19:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fjU9HRovra5yibcoHGEo91c1puma2b1NjARtxBrotSs=; b=UhYBSiUipl1hUH
	VYCQNXkvHcPIlwR4bAmXUbGrg4iK8dOLkEohglqBf8CC0cRyv7cfPGA8j31iQRODnQpO1cGlhj7Jy
	9Pj9P1JBZar57ild5OnRDICVqnrNpnaWGShdnm5d8mhSeObV6OwFr2X2c4V1+v6MRNsVGWs4vOX/M
	a+b0flFli1ds0Re3O0zQO6i5r5ecd4OkN2xmGMoDibf1FWG5u6zvRW3cylHZAuX2qSL6BFWjlvQ0C
	Zv1/7JY86QfTjN784SOzv/wgcPDy/NtKvJCXPeefGf6IAxg5GuL/N+ujHtVqrRaY8+pRrTc9p8PT9
	D5DyZ98QA8pkneSKY56Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qigmX-001Bdq-1h;
	Tue, 19 Sep 2023 19:53:13 +0000
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qigmV-001Bco-1A
	for linux-um@lists.infradead.org;
	Tue, 19 Sep 2023 19:53:12 +0000
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1695153187;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z6MR2qg7K68Ikjp5YKoXbgk+KfdFV5OyH5X+XZI8Hys=;
	b=mOb/eNZUdC0Wj3l6CxvHBXP8mwAJuYFnOVgDDGyXCVGfE9qGC/lTBJMdjrY5OSdh22ztlP
	0pmpPVdeREqTDHGNAEeNvS1DieP+VUS9naCyvjQLxXHFNIP7ZMrmMpAb/G7OBUsq8HkoXh
	Cf2s4EE0LCAMh9WCn8yLJcvMdWe4fgVs+RUHjyvJHQe1wc5lXIfPpDuHsf3M3vaqIXgsMB
	c1zOM7RIRJi9+pTWs8ld1rHuTaEkuhd5s6SL99eLVBOi2BmjT9kDN+s+XFm70ynEg0DH68
	vw1rGuAKizG2OM9QTS2IvcNs1PTtQ9WH7K2vOYlgdiHCWVPYnna48qBKdgNrMA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1695153187;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z6MR2qg7K68Ikjp5YKoXbgk+KfdFV5OyH5X+XZI8Hys=;
	b=L3qg/U5CuhkLaMEQDfDZJ0Bp292wap1ObMBS0Fd+vVbQEdDuD8p1gEYpDfgtKABKvVsKv+
	70jMfd8FpBl2jmDQ==
To: Linus Torvalds <torvalds@linux-foundation.org>, Steven Rostedt
 <rostedt@goodmis.org>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Peter Zijlstra
 <peterz@infradead.org>, Matthew Wilcox <willy@infradead.org>, Ankur Arora
 <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, x86@kernel.org, akpm@linux-foundation.org,
 luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
 mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 mgorman@suse.de, jon.grimm@amd.com, bharata@amd.com,
 raghavendra.kt@amd.com, boris.ostrovsky@oracle.com,
 konrad.wilk@oracle.com, jgross@suse.com, andrew.cooper3@citrix.com, Geert
 Uytterhoeven <geert@linux-m68k.org>, linux-m68k@lists.linux-m68k.org,
 Richard Weinberger <richard@nod.at>, Anton Ivanov
 <anton.ivanov@cambridgegreys.com>, Johannes Berg
 <johannes@sipsolutions.net>, linux-um@lists.infradead.org, Brian Cain
 <bcain@quicinc.com>, linux-hexagon@vger.kernel.org, Richard Henderson
 <richard.henderson@linaro.org>, Ivan Kokshaysky
 <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>,
 linux-alpha@vger.kernel.org
Subject: Re: Arches that don't support PREEMPT
In-Reply-To: <CAHk-=wizB-G40OxALNnz3-uNxuEAPf95H9hubAPeG2r2mrhwHA@mail.gmail.com>
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
 <87pm2eui95.ffs@tglx> <20230919143816.1741760a@gandalf.local.home>
 <CAHk-=wizB-G40OxALNnz3-uNxuEAPf95H9hubAPeG2r2mrhwHA@mail.gmail.com>
Date: Tue, 19 Sep 2023 21:53:07 +0200
Message-ID: <87jzsmueho.ffs@tglx>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230919_125311_548184_0809C282 
X-CRM114-Status: GOOD (  10.92  )
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

On Tue, Sep 19 2023 at 11:52, Linus Torvalds wrote:
> On Tue, 19 Sept 2023 at 11:37, Steven Rostedt <rostedt@goodmis.org> wrote:
>>
>> We could simply leave the cond_resched() around but defined as nops for
>> everything but the "nostalgia club" to keep them from having any regressions.
>
> I doubt the nostalgia club cares about some latencies (that are
> usually only noticeable under extreme loads anyway).
>
> And if they do, maybe that would make somebody sit down and look into
> doing it right.
>
> So I think keeping it around would actually be both useless and
> counter-productive.

Amen to that.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
