Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE82CCE79A8
	for <linux-um@archiver.kernel.org>; Tue, 19 Sep 2023 18:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NL/19ww2o1V53Ss1J5dJgREB5GrXozlzOBv0pWaKWKA=; b=0RLZwwJ5Yi4myW
	23aRt4TMobIafUolIe1jQVuYXwZQ1Jc23W4HZNNBhq01xoKcBjMVxnzhL6aSkX0li89QNq4m6pBwL
	Qgvvk8Id4QIfJpNPdFJAI7kWnwOtVKoMfp/RPdLL+PbMIugEK4GnfVvh2nFO2oBzWRAGPSLfOvZHp
	mhc2C8BgLiFQLrGKydt+MNl8fQwn7CeQ4LCShlcpuwguWaaxbKrae5XDW53mungkxF6XILdFu2ZKV
	ZEDX+blc91yraRMCUcjpl+dXwdAMWwB3jNYA66c29H7FW9qXKut6Qjvg4ZHg4VcMKl8PayZojFDYr
	x/anUunW+LQQvo1dQUcw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qifVv-0014xl-2g;
	Tue, 19 Sep 2023 18:31:59 +0000
Received: from galois.linutronix.de ([193.142.43.55])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qifVs-0014w0-29
	for linux-um@lists.infradead.org;
	Tue, 19 Sep 2023 18:31:58 +0000
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1695148311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mKyOmmSSJD2Ws4VR+XqPS/XNP5VPNOwNw6yDdf2ZDQU=;
	b=xXqJqYUZla9VpgC4S4ShTGkMIL3gkkhNvGjlWhi5L1gkuz5icUdocjTZfEjeUV9x1XfF1d
	9gCf9onnbE0u4V9GNNs47U9xjPBMw2DWytTSoQsodttKIzqkL+7HlaYEWW4FSVqwFkxP9b
	m3N7cld1jgwk+v3jf2F2vowyOYzbp0oeTYfBdyMg3skppXJK7mZs9rhgY8B0yUaEjzj5rv
	eNPjV+ty7EkQisVX1wCgp5HdgxQTcki84SeKDSqMlKMRQ4Dwk5yJNMqTIIkjzdPuUEmZXw
	ZLXZiD6XCNIDxdM95XJgYydUDvKFSGuDWDp3q+ZqWzDj1uSibW0RuXplJpLfmA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1695148311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mKyOmmSSJD2Ws4VR+XqPS/XNP5VPNOwNw6yDdf2ZDQU=;
	b=HSw+FE/2ECBsn8P+jBW//lrHd8c9W9Bxp5rJpQcF0U/qlJOFxqfRtQIDeqJGdvK2cG7ELT
	v2DdyOFXFBXeLSDg==
To: Linus Torvalds <torvalds@linux-foundation.org>, John Paul Adrian
 Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Peter Zijlstra <peterz@infradead.org>, Matthew Wilcox
 <willy@infradead.org>, Ankur Arora <ankur.a.arora@oracle.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
 akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
 juri.lelli@redhat.com, vincent.guittot@linaro.org, mgorman@suse.de,
 rostedt@goodmis.org, jon.grimm@amd.com, bharata@amd.com,
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
Date: Tue, 19 Sep 2023 20:31:50 +0200
Message-ID: <87pm2eui95.ffs@tglx>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230919_113156_842797_C4A4B12C 
X-CRM114-Status: GOOD (  22.22  )
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

On Tue, Sep 19 2023 at 10:25, Linus Torvalds wrote:
> On Tue, 19 Sept 2023 at 06:48, John Paul Adrian Glaubitz
> <glaubitz@physik.fu-berlin.de> wrote:
>>
>> As Geert poined out, I'm not seeing anything particular problematic with the
>> architectures lacking CONFIG_PREEMPT at the moment. This seems to be more
>> something about organizing KConfig files.
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
>
> I do think we'd need to basically continue to support ARCH_NO_PREEMPT
> - and such architectures migth end up with the worst-cast latencies of
> only scheduling at return to user space.

The only thing these architectures should gain is the preempt counter
itself, but yes the extra preemption points are not mandatory to
have, i.e. we simply do not enable them for the nostalgia club.

The removal of cond_resched() might cause latencies, but then I doubt
that these museus pieces are used for real work :)

Thanks,

        tglx

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
