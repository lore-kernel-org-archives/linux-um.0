Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFC50CD5BCA
	for <linux-um@archiver.kernel.org>; Tue, 19 Sep 2023 14:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3qzZ5QqVlcO5mNfNGbmbRviUaDRQSDEdLZbqk184E1A=; b=xtUPR8v2fWZ9UX
	Kue1AZKdRwpF5gg5JzHwbpVtgIfYqTxVCb084Ot5Wwa2rt866WRxePy22TMT2e54+WwUo0mOjXXaB
	mI0gUaDCUQ7+sf3uBmBkenWsii91P02CHL6sjW2jl/GdpX5nFIzKyUK8W30NkNM/If8qAGfw0s7/u
	8KLmARxbBI1hS4GMweJGoCG8OmZntIeJqUW7WupW7y0uvItJcY/aUWcld84PrMnTwsZWEQGkRHdeh
	TH5Iwijt7zxgwUn0PKmaXppcHLhswkdZ9CThVYyMOKd1NELSrJVrBvS0qDv+OY/wX61sgb2YbOTvu
	AukqgfSWqceOwjiUSccg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qiblv-000fFB-2m;
	Tue, 19 Sep 2023 14:32:15 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qiblu-000fF1-0J
	for linux-um@bombadil.infradead.org;
	Tue, 19 Sep 2023 14:32:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=SidCZEV6eW0lcJ6NuB/uLvR734BxaKgfVBoDR9i1ilY=; b=wU6JouyF8Bxm56RpaenERGdpUO
	uCvAVUpRAqLEsiOGlctL7ZupHDmJIFbEljv7BpsiWCt0P+Eu8m9up5lt1qMWnxNwnJbtaVWvn2FQO
	4pKdpCBLaE5AaX6Gst2Xuv0aasi95ZnKa4+CkMPcsqW3PJEhR/eMlp/4usTSnSmznL5I2UfrU1dem
	V9TSusY7h9TQCeE1ORzWfmKqeJBq5CEAIc84YqLmNerMa9UNwMBCfOxHRGWc+rMCfeIV01jDcHqaB
	/apAzpnS4eTJSYIuKueYpJsctmmF6g8UbjSkd+Xp1I9U0O/06u6cqRSZD5goB0T09jgJOfd51cvIn
	2UW3Y5Cw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1qibll-0008Rn-TQ; Tue, 19 Sep 2023 14:32:05 +0000
Date: Tue, 19 Sep 2023 15:32:05 +0100
From: Matthew Wilcox <willy@infradead.org>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <ZQmw5dUzcFOWjHdB@casper.infradead.org>
References: <20230912082606.GB35261@noisy.programming.kicks-ass.net>
 <87cyyfxd4k.ffs@tglx>
 <CAHk-=whnwC01m_1f-gaM1xbvvwzwTiKitrWniA-ChZv+bM03dg@mail.gmail.com>
 <87led2wdj0.ffs@tglx>
 <ZQmbhoQIINs8rLHp@casper.infradead.org>
 <0e69f7df80dc5878071deb0d80938138d19de1d1.camel@physik.fu-berlin.de>
 <20230919134218.GA39281@noisy.programming.kicks-ass.net>
 <a6c84803274116ec827cd4bdd4e72a8d0c304c27.camel@physik.fu-berlin.de>
 <20230919141627.GB39281@noisy.programming.kicks-ass.net>
 <a428516ebeae71e33635edc83052c972ce40c85d.camel@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a428516ebeae71e33635edc83052c972ce40c85d.camel@physik.fu-berlin.de>
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

On Tue, Sep 19, 2023 at 04:24:48PM +0200, John Paul Adrian Glaubitz wrote:
> If the conversion isn't hard, why is the first reflex the urge to remove an architecture
> instead of offering advise how to get the conversion done?

Because PREEMPT has been around since before 2005 (cc19ca86a023 created
Kconfig.preempt and I don't need to go back further than that to make my
point), and you haven't done the work yet.  Clearly it takes the threat
of removal to get some kind of motion.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
