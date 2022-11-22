Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27BB7C433FE
	for <linux-um@archiver.kernel.org>; Tue, 22 Nov 2022 20:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Nj5lfWR8eQomNexMpbXVKNJqv8tgFbdotteK79LTP8k=; b=kd0c8QAX0AVcsX
	b8tgUTFZyaFEz47nuSggdtszuj7EULozJZoZtFPJjdnHN4N4cF32eGD6GkLDy6H/CUh7x4OKi0N3U
	t1/yCxv/hsFpVRJujV7JQeLbJI893vBgrNeK9zwX093zyhnR24yUBJTIPRnnSKzZTdqU6knvJhnBD
	NjKes7Pa8ymNJOQPK+2jcaVeQSWjrKXpm91OqEbnWNf3s2VvuntLcRTp0qtv3TBtTVB4QupyziODA
	4YzeJOuH7AGrCKje8VlaD7mohAgMSxOMDey24DEPLZxNopIKaydgapfWOx6E5q73nS6vvEt9PrYDi
	oT3aIUGfQIXMyZTFntzA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxZst-00BnrP-PE; Tue, 22 Nov 2022 20:28:47 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxZsJ-00BnY6-Fb; Tue, 22 Nov 2022 20:28:14 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id DCE09B81D90;
	Tue, 22 Nov 2022 20:28:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A07EEC433D6;
	Tue, 22 Nov 2022 20:28:06 +0000 (UTC)
Date: Tue, 22 Nov 2022 15:28:05 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Arnd Bergmann" <arnd@arndb.de>
Cc: "Nadav Amit" <nadav.amit@gmail.com>, "Thomas Gleixner"
 <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
 linux-um@lists.infradead.org, Linux-Arch <linux-arch@vger.kernel.org>,
 linux-mm@kvack.org, "Andy Lutomirski" <luto@kernel.org>, "Ingo Molnar"
 <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>, "Dave Hansen"
 <dave.hansen@linux.intel.com>, x86@kernel.org, "Richard Weinberger"
 <richard@nod.at>, "Anton Ivanov" <anton.ivanov@cambridgegreys.com>,
 "Johannes Berg" <johannes@sipsolutions.net>, "Andrew Morton"
 <akpm@linux-foundation.org>, "Nadav Amit" <namit@vmware.com>, Peter
 Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 3/3] compiler: inline does not imply notrace
Message-ID: <20221122152805.6d16afc8@gandalf.local.home>
In-Reply-To: <de999ab8-78ff-44f7-aacc-68561897c6e2@app.fastmail.com>
References: <20221122195329.252654-1-namit@vmware.com>
	<20221122195329.252654-4-namit@vmware.com>
	<de999ab8-78ff-44f7-aacc-68561897c6e2@app.fastmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221122_122811_705523_798E4D0C 
X-CRM114-Status: GOOD (  28.30  )
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

On Tue, 22 Nov 2022 21:09:08 +0100
"Arnd Bergmann" <arnd@arndb.de> wrote:

> On Tue, Nov 22, 2022, at 20:53, Nadav Amit wrote:
> > From: Nadav Amit <namit@vmware.com>
> >
> > Functions that are marked as "inline" are currently also not tracable.
> > Apparently, this has been done to prevent differences between different
> > configs that caused different functions to be tracable on different
> > platforms.
> >
> > Anyhow, this consideration is not very strong, and tying "inline" and
> > "notrace" does not seem very beneficial. The "inline" keyword is just a
> > hint, and many functions are currently not tracable due to this reason.  
> 
> The original reason was listed in 93b3cca1ccd3 ("ftrace: Make all
> inline tags also include notrace"), which describes
> 
>     Commit 5963e317b1e9d2a ("ftrace/x86: Do not change stacks in DEBUG when
>     calling lockdep") prevented lockdep calls from the int3 breakpoint handler
>     from reseting the stack if a function that was called was in the process
>     of being converted for tracing and had a breakpoint on it. The idea is,
>     before calling the lockdep code, do a load_idt() to the special IDT that
>     kept the breakpoint stack from reseting. This worked well as a quick fix
>     for this kernel release, until a certain config caused a lockup in the
>     function tracer start up tests.
>     
>     Investigating it, I found that the load_idt that was used to prevent
>     the int3 from changing stacks was itself being traced!
> 
> and this sounds like a much stronger reason than what you describe,
> and I would expect your change to cause regressions in similar places.
> 
> It's possible that the right answer is that the affected functions
> should be marked as __always_inline. 

Actually, this requirement may not be as needed as much today. There's been
a lot of work in the last 10 years (when that commit was added) to make
ftrace much more robust.

We could remove the notrace from inline and then see where it breaks ;-)

But I'm guessing that it's probably not as much of an issue as it was
before. Although, it may cause some splats with noinstr but I think that
will be caught at compile time.

-- Steve

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
