Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9508FF30262
	for <linux-um@archiver.kernel.org>; Sun, 15 Mar 2026 14:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=skGShgRopWYLAHQVMA1zpv2Nb5W8Z646MfW2V64tqwk=; b=wiyCz5n3spehED4ujRq2lFDH6k
	rAvU+u5g3GvpRFun3ORw87SWZWZVPz4c204TPKq8FX7XrMWCpqHvIIcBkvvN5m75pVwgxd5n/aDYW
	m1a3guenTQFdDRR3pUqGCAVm0juBJ79vHBgdDliUt6EQEt6YTzuKg3O1b3/zQBxwGaZ0yVuUU/6Iq
	Pl7m7NPzo+b/U4SzYDbH0Jeb/oZJXoZFL7iEHAb2Kh98/lzpV/pSDT33mN/6oqA89W82ww32WHs9C
	wd6jMEEOsKvmQm6Xl3XE/QAjoDoSvCLJNpeMgwwpnnLx4guI5mvJPeK31DI/6Qqs12Zj+1yjST9Nx
	SJr0QAAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w1mGJ-00000002ehW-2CYv;
	Sun, 15 Mar 2026 14:16:11 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w1mGG-00000002eh5-3vnd
	for linux-um@lists.infradead.org;
	Sun, 15 Mar 2026 14:16:10 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id E0D074411F;
	Sun, 15 Mar 2026 14:15:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DF01C4CEF7;
	Sun, 15 Mar 2026 14:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773584159;
	bh=agFxp7/+DmzOfwyTxuEGMhbMU3mctxR6EiAxomWVZjA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=roL1M/sncI7syFKC+9EAQl1eCZCHmJRgd6pDWPCUMZ1EXZw6eMIBYdBqGlooV8+Cz
	 WG3hLBXqLVlZAyHyTeksN6hrbhZxwYTrK7Wd4q8RIbgN1JcM0aQkL0CIRTAxbnky/N
	 llZEm7aaanH9Q+Arg3PCOb5TdJxe8lOcuZ9t2ijKVqCKiy04H4pgFLSfDUtojc9k84
	 4MyFWx4I3cT5s7XGmir14ybXW295nx5o76Zy7Dtz1gMlHGjQhEZSFXCwkwP5OrFRgK
	 kkqBIrGUBwc5g+NXoR9z7J1yP9qE+pYk0UY42I+bT0OuTv4iqeWqi3wwSlE1yzF+3m
	 2I9oF3TCISnKw==
Date: Sun, 15 Mar 2026 10:15:58 -0400
From: Sasha Levin <sashal@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Chuck Wolber <chuck@wolber.net>, nathan@kernel.org,
	Matt.Kelly2@boeing.com, akpm@linux-foundation.org,
	andrew.j.oppelt@boeing.com, anton.ivanov@cambridgegreys.com,
	ardb@kernel.org, arnd@arndb.de, bhelgaas@google.com, bp@alien8.de,
	chuck.wolber@boeing.com, dave.hansen@linux.intel.com,
	dvyukov@google.com, hpa@zytor.com, jinghao7@illinois.edu,
	johannes@sipsolutions.net, jpoimboe@kernel.org,
	justinstitt@google.com, kees@kernel.org, kent.overstreet@linux.dev,
	linux-arch@vger.kernel.org, linux-efi@vger.kernel.org,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-um@lists.infradead.org,
	llvm@lists.linux.dev, luto@kernel.org, marinov@illinois.edu,
	masahiroy@kernel.org, maskray@google.com,
	mathieu.desnoyers@efficios.com, matthew.l.weber3@boeing.com,
	mhiramat@kernel.org, mingo@redhat.com, morbo@google.com,
	ndesaulniers@google.com, oberpar@linux.ibm.com, paulmck@kernel.org,
	richard@nod.at, rostedt@goodmis.org, samitolvanen@google.com,
	samuel.sarkisian@boeing.com, steven.h.vanderleest@boeing.com,
	tglx@linutronix.de, tingxur@illinois.edu, tyxu@illinois.edu,
	wentaoz5@illinois.edu, x86@kernel.org
Subject: Re: [RFC PATCH 0/4] Enable Clang's Source-based Code Coverage and
 MC/DC for x86-64
Message-ID: <aba_HgSbzLGm6VBQ@laps>
References: <20250829181007.GA468030@ax162>
 <20251014232639.673260-1-sashal@kernel.org>
 <20251015073701.GZ3419281@noisy.programming.kicks-ass.net>
 <DDIR4HE5C74G.1U5TA0KDN9O5J@wolber.net>
 <20251015092145.GB3419281@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251015092145.GB3419281@noisy.programming.kicks-ass.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260315_071609_023911_261AD23E 
X-CRM114-Status: UNSURE (   9.37  )
X-CRM114-Notice: Please train this message.
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

On Wed, Oct 15, 2025 at 11:21:45AM +0200, Peter Zijlstra wrote:
>On Wed, Oct 15, 2025 at 08:26:50AM +0000, Chuck Wolber wrote:
>> Optimization makes it nearly impossible to correlate GCov results back to
>> actual lines of source. llvm-cov instruments at the AST level which enables
>> precise mapping back to source code regardless of optimization level.
>>
>>
>> A detailed rundown on this issue can be found here[1], with the most relevant
>> excerpt reproduced here:
>
>Yes read and understand this, but that doesn't mean you have to have 3
>different kernel interfaces for all of this, right?

To clarify, are you suggesting that we'll have something like a single
/sys/kernel/debug/coverage interface that is producing the same structured
output whether we use gcov or llvm?

-- 
Thanks,
Sasha

