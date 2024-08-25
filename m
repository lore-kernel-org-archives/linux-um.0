Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E82FC5321E
	for <linux-um@archiver.kernel.org>; Sun, 25 Aug 2024 11:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=l4ldBgTs8Tk2fbqUbBu8bF82g0r8dVN8CCueqSsUf5M=; b=cZJmnhm3jnZBYcaU+GAuyX8uzn
	1/k9IZcy6VaHtcjEWpiaVrtiU6nqBNBu745Nc7uEbb85IopVdq3LbkKolMWhFV22lsJWrsmObQt8+
	KgUaeZ5LH0oCzKRxAe2mI2S/QkWt7UGqnQOHQenJYDzMyv4OlFBneSkSHYcObTlRaUtKDcOwVuDMt
	cqOfjaZfPv4nLnf/TdE/vVtUqCFrRtjWLSRJ4n4VDKDZU4q26zwBz5o+Sab24HdHt8EDTSrHOVvFv
	clllC9ddOm16Ur8P/tNTj3nbGeqz4GxNGU1XSwNMcCEp2hOVpryhuIx5Y3XVz02ObdIOHLZuxRxap
	JuJ+Q7IA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1siBnO-00000004Eh2-094A;
	Sun, 25 Aug 2024 11:52:34 +0000
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1siBnI-00000004Ef3-3A1Y
	for linux-um@lists.infradead.org;
	Sun, 25 Aug 2024 11:52:31 +0000
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724586746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l4ldBgTs8Tk2fbqUbBu8bF82g0r8dVN8CCueqSsUf5M=;
	b=oQ2h2jQM93DzsxgJjVsgviGy1RNH/XdCWJdNvahneWZQju/i0dcSNeReXz1Tm93C6YNmIR
	gvvL5eqL3Q7zLRJ0nOndWmVSTaoR/4sEZIs5PVI4I8/jq3FMuBZ+0ROiotbd6Kkt0bvSJg
	vtYjtp7w52XXTGmEsKSw9iCON+MP7IqwnqmhX5JSHNWsEl0erRhJPnijoppWsVeiqvwBPQ
	t8jPmgpRL9hIRn9KRLL3le3uOnQPARvfnvihwe03+iud1IBGSgf1dPwnjnO2c7t5e/spS7
	IltNumUbVNOIz6WAzp/JWk0U0/u0MRe9JJztGPSFCtqb3OOv082o2/OfC3LFCw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724586746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l4ldBgTs8Tk2fbqUbBu8bF82g0r8dVN8CCueqSsUf5M=;
	b=DL289A9EY5v+PCgODp7o87ZmPdhY4czZmZ+XJrpwdjxWFC8KGEUs8DdIRZCJVaroUQJYth
	dH91vnXc9X4DQIDQ==
To: Wentao Zhang <wentaoz5@illinois.edu>, linux-kbuild@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
 linux-um@lists.infradead.org, linux-arch@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, llvm@lists.linux.dev, x86@kernel.org
Cc: wentaoz5@illinois.edu, marinov@illinois.edu, tyxu@illinois.edu,
 jinghao7@illinois.edu, tingxur@illinois.edu,
 steven.h.vanderleest@boeing.com, chuck.wolber@boeing.com,
 matthew.l.weber3@boeing.com, Matt.Kelly2@boeing.com,
 andrew.j.oppelt@boeing.com, samuel.sarkisian@boeing.com, morbo@google.com,
 samitolvanen@google.com, masahiroy@kernel.org, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, luto@kernel.org,
 ardb@kernel.org, richard@nod.at, anton.ivanov@cambridgegreys.com,
 johannes@sipsolutions.net, arnd@arndb.de, rostedt@goodmis.org,
 mhiramat@kernel.org, oberpar@linux.ibm.com, akpm@linux-foundation.org,
 paulmck@kernel.org, bhelgaas@google.com, kees@kernel.org,
 jpoimboe@kernel.org, peterz@infradead.org, kent.overstreet@linux.dev,
 nathan@kernel.org, hpa@zytor.com, mathieu.desnoyers@efficios.com,
 ndesaulniers@google.com, justinstitt@google.com, maskray@google.com,
 dvyukov@google.com
Subject: Re: [RFC PATCH 1/3] llvm-cov: add Clang's Source-based Code
 Coverage support
In-Reply-To: <20240824230641.385839-2-wentaoz5@illinois.edu>
References: <20240824230641.385839-1-wentaoz5@illinois.edu>
 <20240824230641.385839-2-wentaoz5@illinois.edu>
Date: Sun, 25 Aug 2024 13:52:26 +0200
Message-ID: <87bk1gg6px.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240825_045228_954187_34BDFF5C 
X-CRM114-Status: UNSURE (   7.29  )
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

On Sat, Aug 24 2024 at 18:06, Wentao Zhang wrote:
>  Makefile                          |   3 +
>  arch/Kconfig                      |   1 +
>  arch/x86/Kconfig                  |   1 +
>  arch/x86/kernel/vmlinux.lds.S     |   2 +
>  include/asm-generic/vmlinux.lds.h |  38 +++++
>  kernel/Makefile                   |   1 +
>  kernel/llvm-cov/Kconfig           |  29 ++++
>  kernel/llvm-cov/Makefile          |   5 +
>  kernel/llvm-cov/fs.c              | 253 ++++++++++++++++++++++++++++++
>  kernel/llvm-cov/llvm-cov.h        | 156 ++++++++++++++++++
>  scripts/Makefile.lib              |  10 ++
>  scripts/mod/modpost.c             |   2 +

Please split this into two parts:

   1) Add the infrastructure
   2) Enable it on x86

Also the ordering of this patch series is wrong.

First you enable it on x86 and then you mark the places which cannot be
instrumented. You really want to do this in this order:

   1) Add the infrastructure
   2) Prevent instrumentation in drivers/firmware
   3) Prevent instrumentation in kernel/trace
   4) Prevent instrumentation in modfinal
   5) Prevent instrumentation in x86
   6) Enable it on x86

Thanks,

        tglx


