Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14967CA5FFF
	for <linux-um@archiver.kernel.org>; Wed,  7 Oct 2026 02:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=u9Jzggo5Sk1RIZ8WfB+NnbFsVZN8V/kovGtc4d+jfE4=; b=4FNtHcbzoJChCzCJRo39e6Djls
	keAD/B5noipVdv6xznLm8mvQePMihWPE8kJomwVWDCY8I43ZB5UAbqlxRrv88tMoyCT68zc02jky6
	5uKx1xfx2rTQmbIHZAaacfohFJb2PBERyiuSpJa55FGdVznIqcvtKYAiFvwLT70CY7LRLOxUncKtY
	fU/LE9reX1npuE1UX+q4psggAPp0NT3+Cpwgr/rxdmBcGbfzGZe5eiAUb6DypHrD0mW0AJW2YoFM6
	Gf8JlFdIojzXwJiDLfW3OTA24VVFO93lI8vwoL4GMLWfkL2V1oUK9ykrQLZIDJLNj/ZUHOqMicUoJ
	7mFqGPgQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xEHQp-00000001e3C-01DR;
	Wed, 07 Oct 2026 02:30:59 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xEHQn-00000001e35-3JWJ
	for linux-um@lists.infradead.org;
	Wed, 07 Oct 2026 02:30:57 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id E0D62600C8;
	Wed,  7 Oct 2026 02:30:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04BD71F0089B;
	Wed,  7 Oct 2026 02:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791340255;
	bh=u9Jzggo5Sk1RIZ8WfB+NnbFsVZN8V/kovGtc4d+jfE4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=J9Fpa3LcaeRJJ0NN9pOs90uK8L5DfSIm6mAjBw3gmroRxWWWbxFb2QBY7xicSVbTY
	 kbT+6EbbrPeXqPTzIZSl5/gq1BAb/eOayV7XE6ey3RwmBfWTB/v8VEyyTyoAPPCrA0
	 cri8dcOXQ4A0qnYtSKy+NgeB4uPoFvN8orlfSO6E0eSFWRtrdwF2a402XVtWbKvh06
	 lRSjh3VEzncBxVqPnfDnS6lW0nafLoHm9hnGRK/TzY+qZEDFBRoQzJvP8LcOcuGEQ4
	 hQFNwpwttAKu5D3ATtRtUDpP6pXX3rhBtplR2oet7NU6iXQYKvGbkYwoqZeZiWZCOd
	 Nvx4c87Puw11A==
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: chuck@wolber.net
Cc: Marco Elver <elver@google.com>, kasan-dev@googlegroups.com,
 nathan@kernel.org, akpm@linux-foundation.org, anton.ivanov@cambridgegreys.com,
 oberpar@linux.ibm.com, ardb@kernel.org, arnd@arndb.de, bhelgaas@google.com,
 bp@alien8.de, dave.hansen@linux.intel.com, dvyukov@google.com, hpa@zytor.com,
 jinghao7@illinois.edu, johannes@sipsolutions.net, jpoimboe@kernel.org,
 justinstitt@google.com, kees@kernel.org, kent.overstreet@linux.dev,
 linux-arch@vger.kernel.org, linux-efi@vger.kernel.org,
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-um@lists.infradead.org,
 llvm@lists.linux.dev, luto@kernel.org, marinov@illinois.edu,
 masahiroy@kernel.org, maskray@google.com, mathieu.desnoyers@efficios.com,
 mhiramat@kernel.org, mingo@redhat.com, morbo@google.com,
 Nick Desaulniers <ndesaulniers@google.com>,
 "Paul E. McKenney" <paulmck@kernel.org>, richard@nod.at,
 Steven Rostedt <rostedt@goodmis.org>, samitolvanen@google.com,
 tglx@linutronix.de, tingxur@illinois.edu, tyxu@illinois.edu,
 wentaoz5@illinois.edu, x86@kernel.org, peterz@infradead.org,
 Sasha Levin <sashal@kernel.org>, Aleksandr Nogikh <nogikh@google.com>,
 Taras Madan <tarasmadan@google.com>, Alexander Potapenko <glider@google.com>
Subject: Re: [PROPOSAL] Replace gcov and kcov with llvm-cov
Date: Wed, 07 Oct 2026 02:30:42 +0000
In-Reply-To: <41913a77-5c57-4967-8166-765dd5dde1bf@app.fastmail.com>
References: 00ed0b57-ad05-4c5d-b152-7c81df94b23a@app.fastmail.com
 CANpmjNOaykC4McAj=gZghqPSQc9aGBP_CjgKmp3n2yjeJTxDSA@mail.gmail.com
 <41913a77-5c57-4967-8166-765dd5dde1bf@app.fastmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Message-Id: <20261007023045.04BD71F0089B@smtp.kernel.org>
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

On Tue, 06 Oct 2026 16:27:11 +0000, Chuck Wolber <chuck@wolber.net> wrote:
> On Tue, Oct 6, 2026, at 4:10 PM, Marco Elver wrote:
> > On Tue, 6 Oct 2026 at 17:14, Chuck Wolber <chuck@wolber.net> wrote:

> >> If there is a desire to take this in pieces or implement other
> >> intermediate steps, let me know. Otherwise I can generate a
> >> monolithic set all at once.
> >>
> >> [1] https://lore.kernel.org/lkml/20240905043245.1389509-1-wentaoz5@illinois.edu/
> >
> > llvm-cov is generally useful to have; llvm-cov is closest to gcov, so
> > that might make sense to replace.
>
> Swapping llvm-cov for gcov to start with is pretty straightforward, so I
> can aim my initial patch set there.

Hmm, is it necessary to remove gcov? Would it be difficult to simply add
support for llvm-cov and enable (make kconfig selectable) one or the other
depending on the compiler?

Thanks,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

