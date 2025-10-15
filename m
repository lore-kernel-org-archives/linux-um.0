Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5A33CCD193
	for <linux-um@archiver.kernel.org>; Wed, 15 Oct 2025 08:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:Cc:To
	:From:Subject:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=t5nJJ2CgRu6lm+HZXXoNQXnHJygS4YGR2lcUURAIT6U=; b=BUHhksoUkK0KpXRCsm5z/fltU3
	q/d69yDPSCX//jcaPOd07uv5mpYRILrK8xeKr4tJ3LW88vuxNUX/m7d+FpDpMPSXzJGYYGi3gno2P
	0Qj/K0z99e+bF7WPFtirEZr29kyI44EiyrrhScp7Ep1TGvFO8v1ZpFMzswfm8Ku1kaVYxiGtz+F1A
	q9qOlqTtKpQS9dBZkNONFHOm4etCnyT2ndal6oFZz+pK2YK2cPxZYJRuqvJ9k0bM+Zq5/L48aU3LC
	/zXjKl1Pu7gxVbm7EhNM/qONOIADeDdicaq60UKSVX2G8DOJ8a+XC07KLY9OK0ow/Kab3pGFd7MLe
	OC/gEXXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8wqa-00000000u5p-292W;
	Wed, 15 Oct 2025 08:27:00 +0000
Received: from flow-a5-smtp.messagingengine.com ([103.168.172.140])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8wqX-00000000u4e-1BQA
	for linux-um@lists.infradead.org;
	Wed, 15 Oct 2025 08:26:59 +0000
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.phl.internal (Postfix) with ESMTP id 9BBEE13800A9;
	Wed, 15 Oct 2025 04:26:53 -0400 (EDT)
Received: from phl-imap-03 ([10.202.2.93])
  by phl-compute-02.internal (MEProxy); Wed, 15 Oct 2025 04:26:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolber.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1760516813;
	 x=1760524013; bh=t5nJJ2CgRu6lm+HZXXoNQXnHJygS4YGR2lcUURAIT6U=; b=
	Gd5NeiJZJnXq59Lbe+HDax/gkj3d9zlfofnCdcXpaXjwnpV8DKvxwo0r3eQIMgIF
	r4C9S+b6Amt3tumpZ2x7tGP4WK3Ss34L1o8FbYk28cQ639q5iZ8F7ZHLwL5DNWuQ
	zb5ZMeXyeWYsWlNULdvQ2EL2Kckn4aWUhIKjCCBgN/Of3Kh4MmCJg15VVo1MKq80
	u6Qi5XuFkRIjgI1dLljT6JINSEhdPN0v1L9ME1Evo4G80OflccZ3IXVQm8MKe/Zp
	Ix5r61uzqYNbSpEJXLArwUNQmpSwp1g9YUTrQCRMCeO0gnnWMn+NqYTJbAShaMBd
	LyfuahOvwobaoV9iedCosQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760516813; x=
	1760524013; bh=t5nJJ2CgRu6lm+HZXXoNQXnHJygS4YGR2lcUURAIT6U=; b=s
	lVqLMoMQwoArypuRWQHBYR4UNUxJVViWJF/QAB8BDOoZ0rkuYy51oLamjfyxFONw
	bCpYpk9bs1hcs1R4qK7emmEDhoKFp7APFDdtyPWvgVkQ4XNdebQ0ZtDgI0I0mXcH
	7FNL2DyL5C5998zXAQ9sC0l8yLUTMuBx+748u1DUjKW3EJQU2kI3KsGEtedkjUJL
	oUHcp2GokZJ3y2I8DcN7jbC696R9qX4i8i4CYN3BsHodOPTWqygx/1u6/YqdFEAj
	Y31CU3eCfSsZrC9C0AcLTw5/bmgMGdWKRLP6fN1VZgfCDGJesS1BGyAE35s0l1DF
	Vhbtp/PT/RPM5CT/L/CeQ==
X-ME-Sender: <xms:y1rvaCDqsRMKROR0N_cZx5Xpx6j3dJ_022ISU3jkIlNRiO7_IUwyVg>
    <xme:y1rvaHVDKKwbAOGfyyEJJcwasTlxvmFCGLeO5xo9A6MWeDHwlR5tiHLTs9FT-ztm0
    K7eQQ-U2blgzDrRtEHqCTw42aB7SxSKpEd3iSJ251YOuxEY9bOdGA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvddvleefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofgggfgtfffkuffhvfevofhfjgesthhqredtredtjeenucfhrhhomhepfdevhhhu
    tghkucghohhlsggvrhdfuceotghhuhgtkhesfiholhgsvghrrdhnvghtqeenucggtffrrg
    htthgvrhhnpeevudduteduieegvdelvedugedtfeegjeegteevgfelgeetueetuedvtedt
    vdeuieenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheptghhuhgtkhesfiholhgsvghrrdhnvght
    pdhnsggprhgtphhtthhopeehtddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsg
    hpsegrlhhivghnkedruggvpdhrtghpthhtoheprghrnhgusegrrhhnuggsrdguvgdprhgt
    phhtthhopehmrghtthdrkhgvlhhlhidvsegsohgvihhnghdrtghomhdprhgtphhtthhope
    grnhgurhgvfidrjhdrohhpphgvlhhtsegsohgvihhnghdrtghomhdprhgtphhtthhopegt
    hhhutghkrdifohhlsggvrhessghovghinhhgrdgtohhmpdhrtghpthhtohepmhgrthhthh
    gvfidrlhdrfigvsggvrhefsegsohgvihhnghdrtghomhdprhgtphhtthhopehsrghmuhgv
    lhdrshgrrhhkihhsihgrnhessghovghinhhgrdgtohhmpdhrtghpthhtohepshhtvghvvg
    hnrdhhrdhvrghnuggvrhhlvggvshhtsegsohgvihhnghdrtghomhdprhgtphhtthhopegr
    nhhtohhnrdhivhgrnhhovhestggrmhgsrhhiughgvghgrhgvhihsrdgtohhm
X-ME-Proxy: <xmx:y1rvaOYJlMD8DHKGrnv6rhDc3RTrkWoOZC-i7EIiqNKs-vBNGYY7jA>
    <xmx:y1rvaDZiYZOM4hjcm13H7w3UEARIoGgIa0uj0uzPcJzFYICN5ZQK6Q>
    <xmx:y1rvaNQJtk4pthMkt-tCyJ9iG-MLlHeKUWmW3NL-7bD-w1uzNFdDHA>
    <xmx:y1rvaI3Dqhl9l4nYXMT1TbpmBVLh1Plq2X__JCJ0Gn-4GJ-dXXU9ng>
    <xmx:zVrvaCz3CLUWWXRj_ZMqZVOaIMLmXf8FqrY9YtloQg9nbnG_TW2UrMFj>
Feedback-ID: i5cf64821:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E888718E0054; Wed, 15 Oct 2025 04:26:50 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 15 Oct 2025 08:26:50 +0000
Message-Id: <DDIR4HE5C74G.1U5TA0KDN9O5J@wolber.net>
Subject: Re: [RFC PATCH 0/4] Enable Clang's Source-based Code Coverage and
 MC/DC for x86-64
From: "Chuck Wolber" <chuck@wolber.net>
To: "Peter Zijlstra" <peterz@infradead.org>, "Sasha Levin"
 <sashal@kernel.org>
Cc: <nathan@kernel.org>, <Matt.Kelly2@boeing.com>,
 <akpm@linux-foundation.org>, <andrew.j.oppelt@boeing.com>,
 <anton.ivanov@cambridgegreys.com>, <ardb@kernel.org>, <arnd@arndb.de>,
 <bhelgaas@google.com>, <bp@alien8.de>, <chuck.wolber@boeing.com>,
 <dave.hansen@linux.intel.com>, <dvyukov@google.com>, <hpa@zytor.com>,
 <jinghao7@illinois.edu>, <johannes@sipsolutions.net>,
 <jpoimboe@kernel.org>, <justinstitt@google.com>, <kees@kernel.org>,
 <kent.overstreet@linux.dev>, <linux-arch@vger.kernel.org>,
 <linux-efi@vger.kernel.org>, <linux-kbuild@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
 <linux-um@lists.infradead.org>, <llvm@lists.linux.dev>,
 <luto@kernel.org>, <marinov@illinois.edu>, <masahiroy@kernel.org>,
 <maskray@google.com>, <mathieu.desnoyers@efficios.com>,
 <matthew.l.weber3@boeing.com>, <mhiramat@kernel.org>, <mingo@redhat.com>,
 <morbo@google.com>, <ndesaulniers@google.com>, <oberpar@linux.ibm.com>,
 <paulmck@kernel.org>, <richard@nod.at>, <rostedt@goodmis.org>,
 <samitolvanen@google.com>, <samuel.sarkisian@boeing.com>,
 <steven.h.vanderleest@boeing.com>, <tglx@linutronix.de>,
 <tingxur@illinois.edu>, <tyxu@illinois.edu>, <wentaoz5@illinois.edu>,
 <x86@kernel.org>
X-Mailer: aerc 0.21.0
References: <20250829181007.GA468030@ax162>
 <20251014232639.673260-1-sashal@kernel.org>
 <20251015073701.GZ3419281@noisy.programming.kicks-ass.net>
In-Reply-To: <20251015073701.GZ3419281@noisy.programming.kicks-ass.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251015_012657_790709_A6DE1308 
X-CRM114-Status: GOOD (  22.33  )
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

On Wed Oct 15, 2025 at 7:41 AM UTC, Peter Zijlstra wrote:
> On Tue, Oct 14, 2025 at 07:26:35PM -0400, Sasha Levin wrote:
>> This series adds support for Clang's Source-based Code Coverage to the
>> Linux kernel, enabling more accurate coverage measurement at the source
>> level compared to gcov. This is particularly valuable for safety-critica=
l
>> use cases (automotive, medical, aerospace) where MC/DC coverage is requi=
red
>> for certification.
>>=20
>> Changes since previous patchset [1]:
>> - Rebased on v6.18-rc1
>> - Adapted to lib/crypto reorganization (curve25519 exclusion moved to
>>   lib/crypto/Makefile)
>> - Minor correctness fixes throughout the codebase
>>=20
>> The implementation has been tested with a kernel build using Clang 18+ a=
nd
>> boots successfully in a KVM environment with instrumentation enabled.
>>=20
>> [1] https://lore.kernel.org/all/20240905043245.1389509-1-wentaoz5@illino=
is.edu/
>>=20
>> Wentao Zhang (4):
>>   llvm-cov: add Clang's Source-based Code Coverage support
>>   llvm-cov: add Clang's MC/DC support
>>   x86: disable llvm-cov instrumentation
>>   x86: enable llvm-cov support
>>=20
>>  Makefile                          |   9 ++
>>  arch/Kconfig                      |   1 +
>>  arch/x86/Kconfig                  |   2 +
>>  arch/x86/crypto/Makefile          |   1 +
>>  arch/x86/kernel/vmlinux.lds.S     |   2 +
>>  include/asm-generic/vmlinux.lds.h |  36 +++++
>>  kernel/Makefile                   |   1 +
>>  kernel/llvm-cov/Kconfig           | 121 ++++++++++++++
>>  kernel/llvm-cov/Makefile          |   8 +
>>  kernel/llvm-cov/fs.c              | 253 ++++++++++++++++++++++++++++++
>>  kernel/llvm-cov/llvm-cov.h        | 157 ++++++++++++++++++
>>  lib/crypto/Makefile               |   3 +-
>>  scripts/Makefile.lib              |  23 +++
>>  scripts/mod/modpost.c             |   2 +
>
> I'm thinking I'm going to NAK this based on the fact that I'm not
> interested in playing file based games. As long as this thing doesn't
> honour noinstr I don't want this near x86.

I am working on a noinstr patchset that will precede this pachset. As it tu=
rns
out there are several areas of the kernel (128 that I have found so far) th=
at
are missing the noinstr attribute macro.

Example:

kernel/locking/lockdep.c:
	void noinstr lockdep_hardirqs_off(unsigned long ip)
include/linux/irqflags.h:
	static inline void lockdep_hardirqs_off(unsigned long ip) { }

The latter version is intended to be optimized out if the kernel is not
configured to use this feature. However when the kernel is instrumented for
profiling, the stub is not optimized out and ends up in the .text section
rather than the .noinstr.text section.


> And we have kcov support, and gcov and now llvm-cov, surely 3 coverage
> solutions is like 2 too many?

Optimization makes it nearly impossible to correlate GCov results back to
actual lines of source. llvm-cov instruments at the AST level which enables
precise mapping back to source code regardless of optimization level.


A detailed rundown on this issue can be found here[1], with the most releva=
nt
excerpt reproduced here:

> In the following gcov example from drivers/firmware/dmi_scan.c, an
> expression with four conditions is reported to have six branch outcomes,
> which is not ideally informative in many safety related use cases, such a=
s
> automotive, medical, and aerospace.
>=20
>         5: 1068:	if (s =3D=3D e || *e !=3D '/' || !month || month > 12) {
> branch  0 taken 5 (fallthrough)
> branch  1 taken 0
> branch  2 taken 5 (fallthrough)
> branch  3 taken 0
> branch  4 taken 0 (fallthrough)
> branch  5 taken 5
>=20
> On the other hand, Clang's Source-based Code Coverage instruments at the
> compiler frontend which maintains an accurate mapping from coverage
> measurement to source code location. Coverage reports reflect exactly how
> the code is written regardless of optimization and can present advanced
> metrics like branch coverage and MC/DC in a clearer way. Coverage report
> for the same snippet by llvm-cov would look as follows:
>=20
>  1068|      5|	if (s =3D=3D e || *e !=3D '/' || !month || month > 12) {
>   ------------------
>   |  Branch (1068:6): [True: 0, False: 5]
>   |  Branch (1068:16): [True: 0, False: 5]
>   |  Branch (1068:29): [True: 0, False: 5]
>   |  Branch (1068:39): [True: 0, False: 5]
>   ------------------


..Ch:W..



[1] https://lore.kernel.org/llvm/20240905043245.1389509-1-wentaoz5@illinois=
.edu/



