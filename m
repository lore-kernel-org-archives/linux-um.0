Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30C30CA5FFF
	for <linux-um@archiver.kernel.org>; Wed,  7 Oct 2026 04:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:References:In-Reply-To:Message-Id:Cc:To:From:Date:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9S5NccjG3n1fFQc9t/+Xwyj0iezJs8kEGC0cyk8cO98=; b=aSkcr7fvTaFoMEVBUHLB/KQJPc
	tGNo7uEvdX5bcMv8CXXGF6zb7SCLxW9Cg2NAS8tajlEhUBrXD6h4k7J/ckVvS3FNeyf2WmsP9mWDp
	y+7k5Ko377EgpNPzsJja2e2xPXTkrmvzjn9XlFai+9VC1oj/WMCdsryQZE4EjvwDjW1SNYyRc+vOF
	yqjpvBb1FtRDbKgH4d67FhJcaYzhd0dxZYWVI78RzYLnKSt8iRGcDagRZcH7GpZ1IyhlCSmolhIIk
	LqH2x+G8CEFNS17M321Uh+Wa0d5b066iRHgzoYktKanPN9eh/Tbp/MZHyK0Qg8GIJQyE+jQnBTrqZ
	rx4XqDrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xEJ6q-00000001guT-3Bvq;
	Wed, 07 Oct 2026 04:18:28 +0000
Received: from flow-a6-smtp.messagingengine.com ([103.168.172.141])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xEJ6V-00000001gu4-1JF0
	for linux-um@lists.infradead.org;
	Wed, 07 Oct 2026 04:18:09 +0000
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailflow.phl.internal (Postfix) with ESMTP id 7AAFA138040E
	for <linux-um@lists.infradead.org>; Wed,  7 Oct 2026 00:18:05 -0400 (EDT)
Received: from phl-imap-03 ([10.202.2.93])
  by phl-compute-03.internal (MEProxy); Wed, 07 Oct 2026 00:18:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolber.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1791346685;
	 x=1791353885; bh=9S5NccjG3n1fFQc9t/+Xwyj0iezJs8kEGC0cyk8cO98=; b=
	IQZA88iK7AJYt5pzO6v4OKlxB3zQGobNkO7OIHqiX0niMzVRTeE15KVD7DwHdhm1
	T3hBM2Guz9u/tqjqQ07x9VU3Y/njy5jetotWs8uJZzcUFYiG9NCTgVA8/RiIovrD
	x/gAoeKpTtuRHaAhb6qMBxMHOkNCnvd7+9IfWvKpillkzcdHW6pf/pQV3mbawk9r
	rDrlamaA0yKnZPHZBED087B4lbSvZDyGStLi9VJ+sobUyguSNc+zEIUb+db9eDQR
	8l7fU9lR06hYhSJITZPxvuoWEFczbVQfGS0iLr0rEb5apEhUffLfVFepmJ51JSXJ
	0VsXCAY4xXjLdLupZPS49Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791346685; x=
	1791353885; bh=9S5NccjG3n1fFQc9t/+Xwyj0iezJs8kEGC0cyk8cO98=; b=O
	BqaJc0AxDCjGpknaYYzeKKbnfIkl50X1+ZQBb60RCaPciCQtFpBBRu42u9/seknA
	246dvLoNBUIPtHPCJE2SnUPA6zr0i7qmjp/XcS85wRcqBBRohJ3nWiEYakLe7wDy
	GkIBMxHS1P3gvF76xpM6edc+7jqcrhRVUCnJYdw6eX/i5ObvLhRXNs8GJzKpLpJa
	7ZZ+T+773L2DXaBLaQqyXPwwsMaBQgWy+lcXd2aU6FQoeu08kPgFmpAYcpvr7Opi
	QSPRfLpoE8pV4+mBPXHIF25nYhxHofGRgt0UyzAy46jc8K/3DNfsgKi0FmNGah4e
	PyzQy0wRu7aWDswkueJXw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=wolber.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791346685; d=wolber.net;
	mf=PGNodWNrQHdvbGJlci5uZXQ+;
	rt=PGxpbnV4LXVtQGxpc3RzLmluZnJhZGVhZC5vcmc+;
	s=fm3:rsa-sha256:P35k/GtfcTOYlqu30Soc2RPzS7BUMDQMecouhSLa2QaAgeT
	KcOREUdfRucZtzSbZnBoVenomKHY5h4fuK0QawHC5b1Jnchlzvdxw/zWqnw8qnBU
	fX+07mBoggS5s9B3R/hKwVOXheEuWbYuxZUbsVF33/5ivFcEDCL3M0O/8E7UbTiL
	rKOMXTNuuj5ZpdueabopwdRgmHuOyhFD6+4+zy2NXSEsAok4e9n6PD1FRhBc7Q7w
	cYuBSssvS45SMqnxA+tIzJHuy+XnFF/2nuZKjt/pE4/5MzM+S76gk/XN6SDduREr
	8c1TGF5a+5GyemKeFw/77S7f/kVNupSAz88izZg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:69WtHAdzzGt++L0dmN+dpT9JdF3kbS7Kh70yb3qik2c=:9S5NccjG3n1fFQc9t/+Xwyj0iezJs8kEGC0cyk8cO98=;
X-ME-Sender: <xms:-sfFankfTAViNMv3UaVgC4c0bF7lgovEdmDD_sRDZXzkQMDkyDLGqQ>
    <xme:-sfFalrwynIQj1LZPsQuJfCtOgQDOh3qGJL5Ht1D6bxg3tkZmYGYqz8Wls_ixoI4W
    yOq9NoxMqduXWAUvGFM9Q1Oez4If0imMVPLeXkTdr2Q-0pt4Z7WhNUE>
X-ME-Proxy-Cause: dmFkZTGMWFIAehxsmdq4ynFlrmrbbKja5RPgzcPokhGUAyn4XwkA+/i+RzCPcfSVyyv1sF
    pvH5x0fdtSQTSOL1Ie1RGCryBqw4p8+JTrlkCzXTJjeB2LTHc2y/IhYfsZc/v7gKPn1GgF
    LOpV9hAc96CGDI3kIaAH2g4lcCJ8eJO8UaW8jQygRRjRzdD50EOOrRpyv399w60Bpma9hG
    dbJ/PQRa6wxx5LBjtxjhrUYNvUmb1w23fhUz343gRmuzl0ey4+vwOyNSWO5QE2Gbxpeim3
    chPU/Ad1oAucTj/8Ox4TZLoFR9dmZED//6gQojakDPoH3DJ6dB4s/Zn7buUz1WHEl0ItdQ
    jTXho14WghAZB50Nxe0TxBDRIEJ/JOXdG4tdfo59QeG5vvEZmcpCDhr1AGb4rJEVoiKbRA
    M0C8QvLxZ1tHd8P6Va810oBmIt53Kpqwt31IOTWoV3VKEJR7OshUBbuXxpPJHEcKKeAdR9
    PMIE1XUDGOXkuBoLXxrnR/Yu7d9M2SJhsr0vP+BEBtSODX6lrEZXZ9fkj4pnyAbFaEtA2k
    5jZ3Jz2FekmPVGRVXixhFSNiw1uZUCuk6ZD1oj8kcaWlofoxAQzrwvVhsALXOoqfYYXmm9
    tjR8Q2NiaTcJkwEjLnuU9tBRlaZk8a0X45tOls3RbVeE1JQX1mky/6o+kELg
X-ME-Proxy: <xmx:-sfFarCebjcIJ7C8C31f800cCyhpG0g0wAfK8PHBEUXN3qDPePrWsw>
    <xmx:-sfFaq3dnhm_VNN38CWghMHp1GOfYjtWJ93pIek88XAgz6KQD2XU9g>
    <xmx:-sfFalUbx3PLJSGF---EunyZ0kdq-Sf0NkmApNCdzh0FQlay8lnzmQ>
    <xmx:-sfFaoxRjhTrC2EHqQUkWimeN4LBGAmXHVrYSa1EOoATTC8ALNDmKQ>
    <xmx:_cfFajZ_NsPKILnROCJCcMFnrB-e_Q_hRFyKz_eQdfYJutKOPj4EfuIp>
Feedback-ID: i5cf64821:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 6407D18E006C; Wed,  7 Oct 2026 00:18:02 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: A8p1gvDKPv03
Date: Wed, 07 Oct 2026 04:17:42 +0000
From: "Chuck Wolber" <chuck@wolber.net>
To: "Masami Hiramatsu" <mhiramat@kernel.org>
Cc: "Marco Elver" <elver@google.com>, kasan-dev@googlegroups.com,
 nathan@kernel.org, akpm@linux-foundation.org,
 anton.ivanov@cambridgegreys.com, oberpar@linux.ibm.com, ardb@kernel.org,
 arnd@arndb.de, bhelgaas@google.com, bp@alien8.de,
 dave.hansen@linux.intel.com, dvyukov@google.com, hpa@zytor.com,
 jinghao7@illinois.edu, johannes@sipsolutions.net, jpoimboe@kernel.org,
 justinstitt@google.com, kees@kernel.org, kent.overstreet@linux.dev,
 linux-arch@vger.kernel.org, linux-efi@vger.kernel.org,
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-um@lists.infradead.org,
 llvm@lists.linux.dev, luto@kernel.org, marinov@illinois.edu,
 masahiroy@kernel.org, maskray@google.com, mathieu.desnoyers@efficios.com,
 mingo@redhat.com, morbo@google.com,
 "Nick Desaulniers" <ndesaulniers@google.com>,
 "Paul E. McKenney" <paulmck@kernel.org>, richard@nod.at,
 "Steven Rostedt" <rostedt@goodmis.org>, samitolvanen@google.com,
 tglx@linutronix.de, tingxur@illinois.edu, tyxu@illinois.edu,
 wentaoz5@illinois.edu, x86@kernel.org, peterz@infradead.org,
 "Sasha Levin" <sashal@kernel.org>,
 "Aleksandr Nogikh" <nogikh@google.com>,
 "Taras Madan" <tarasmadan@google.com>,
 "Alexander Potapenko" <glider@google.com>
Message-Id: <c84149c4-26c3-476e-93d5-4fe72f7c708b@app.fastmail.com>
In-Reply-To: <20261007023045.04BD71F0089B@smtp.kernel.org>
References: <00ed0b57-ad05-4c5d-b152-7c81df94b23a@app.fastmail.comCANpmjNOaykC4McAj=gZghqPSQc9aGBP_CjgKmp3n2yjeJTxDSA@mail.gmail.com<41913a77-5c57-4967-8166-765dd5dde1bf@app.fastmail.com>>
 <20261007023045.04BD71F0089B@smtp.kernel.org>
Subject: Re: [PROPOSAL] Replace gcov and kcov with llvm-cov
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261006_211807_787643_E0DAFA52 
X-CRM114-Status: GOOD (  22.76  )
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
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

On Wed, Oct 7, 2026, at 2:30 AM, Masami Hiramatsu wrote:
> On Tue, 06 Oct 2026 16:27:11 +0000, Chuck Wolber <chuck@wolber.net> wrote:
>> On Tue, Oct 6, 2026, at 4:10 PM, Marco Elver wrote:
>> > On Tue, 6 Oct 2026 at 17:14, Chuck Wolber <chuck@wolber.net> wrote:
>
>> >> If there is a desire to take this in pieces or implement other
>> >> intermediate steps, let me know. Otherwise I can generate a
>> >> monolithic set all at once.
>> >>
>> >> [1] https://lore.kernel.org/lkml/20240905043245.1389509-1-wentaoz5@illinois.edu/
>> >>
>> > >> > llvm-cov is generally useful to have; llvm-cov is closest to
>> > >> > gcov, so that might make sense to replace.
>>
>> Swapping llvm-cov for gcov to start with is pretty straightforward,
>> so I can aim my initial patch set there.
>
> Hmm, is it necessary to remove gcov? Would it be difficult to simply
> add support for llvm-cov and enable (make kconfig selectable) one or
> the other depending on the compiler?

Not strictly necessary, no. And what you are describing is what our
original patches do.

The concern was why we would want to have three separate code coverage
tools in the kernel. Each has their own way of doing things, and they
can all live together in the kernel harmoniously.

But the concern was raised so I am trying to find a way forward.

The llvm-cov approach gives results that are reliably tied to actual
lines of source, so that is the one I reflexively reach for any time I
need code coverage. I am at a loss (but definitely willing to be
educated) as to what value gcov style coverage provides in comparison.

I also found some interesting possibilities using intrinsics to enable
boot time tracing with llvm-cov. That is, of course, experimental and
not something I am considering for the intial patch-set. But it got me
thinking about broader configurability that supports more granular forms
of coverage that _may_ address kcov needs in the long term.

I have been working on this off-and on for a few years and still really
want to see this idea succeed. Any guidance on a workable path forward
would be greatly appreciated.

Another option, proposed by Sasha Levin[1], was to use a single
/sys/kernel/debug/coverage interface, quoting him here:

"To clarify, are you suggesting that we'll have something like a single
 /sys/kernel/debug/coverage interface that is producing the same structured
 output whether we use gcov or llvm?"

I am not sure it is feasible to use the same structured ouput, but it
would isolate things down to a single interface with KConfig knobs being
used to select which coverage data one can expect to find there.


[1] https://lore.kernel.org/lkml/aba_HgSbzLGm6VBQ@laps/


Thank you,

..Ch:W..

