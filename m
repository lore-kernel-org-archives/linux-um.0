Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33655CF318A
	for <linux-um@archiver.kernel.org>; Wed,  2 Oct 2024 01:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=p8H2NLD073LnEtOKntiXdn22CETWYXKyhoCioHNFhO8=; b=ofmLqP4wfLLjw6Uk/s1dwNEGL5
	BTWlRtduWyHPLVY2FJpaPX21At0UcFbWBVLexDQBQsW7FLy2RK17+rI5XPNQ3sgKwFoIdNjrscQFq
	0EW/+JSeP36rC2S+OyQMad7yyz3BZCb4eAkenmTlo5Gx1lnDcBnzZIUCNKynD0JZMY8nT0fez8xuE
	VfeA8LXTIdl/G6Q1jP7tGNCGKxSWZ4Y8kXg2fDe3HIyX/c/bHuIdyDnpTf2v0axgd7ezNAOp7pJgJ
	S/Hs2pqTxkv2bNgc2pGlj/SHehp7wZSsPOmSXi+MGbzH8wCFbOU1eyQadWBnhlDl1PduMakqTuUXJ
	6ROcrOeQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1svnzv-00000004WyN-2iNB;
	Wed, 02 Oct 2024 01:17:47 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1svnzt-00000004WxJ-1RCL
	for linux-um@lists.infradead.org;
	Wed, 02 Oct 2024 01:17:46 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 626A95C5475;
	Wed,  2 Oct 2024 01:17:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FDCCC4CEC6;
	Wed,  2 Oct 2024 01:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727831864;
	bh=18sIvN/b40KUR8Z6IAlfjZJPkiV7wOxyLv5Q7q6Bu04=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mtnS6zyoFjLo0cC9ECwBxydPekHreMYtE0eg9Lo+D5KH5g6Q4DoCzzOgYnaQjv/jC
	 ObI1KHaJ7eIek7vhT5MV8wW3Wlpfxc3xHaF4cVXIisrUDJYAwbwt+19TBicGMY62z3
	 gavMEUSI+xZuLPKPzl7m4Lc91dkWZtT5cerz3DsyO9GCvh1CNtYwtgFdzdhH4c1AHy
	 mN+uEip3HTKgRlPHybFSXiLY6oaek6tSQQ7905hBVoxESfzLtm8EEBMUE+SE2Xt05n
	 tKBiU9uiw8DP9z/YFjwewvhl7KvZfeQ0U+WZVKN4OsLL0xHXdjFORm1Mq9/g4lQtPl
	 RplIJZ5yhUwpw==
Date: Tue, 1 Oct 2024 18:17:39 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Wentao Zhang <wentaoz5@illinois.edu>
Cc: Matt.Kelly2@boeing.com, akpm@linux-foundation.org,
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
	peterz@infradead.org, richard@nod.at, rostedt@goodmis.org,
	samitolvanen@google.com, samuel.sarkisian@boeing.com,
	steven.h.vanderleest@boeing.com, tglx@linutronix.de,
	tingxur@illinois.edu, tyxu@illinois.edu, x86@kernel.org
Subject: Re: [PATCH v2 3/4] x86: disable llvm-cov instrumentation
Message-ID: <20241002011739.GC555609@thelio-3990X>
References: <20240824230641.385839-1-wentaoz5@illinois.edu>
 <20240905043245.1389509-1-wentaoz5@illinois.edu>
 <20240905043245.1389509-4-wentaoz5@illinois.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905043245.1389509-4-wentaoz5@illinois.edu>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241001_181745_455842_558B097B 
X-CRM114-Status: GOOD (  13.62  )
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

On Wed, Sep 04, 2024 at 11:32:44PM -0500, Wentao Zhang wrote:
> Disable instrumentation for arch/x86/crypto/curve25519-x86_64.c. Otherwise
> compilation would fail with "error: inline assembly requires more registers
> than available".
> 
> Similar behavior was reported with gcov as well. See c390c452ebeb ("crypto:
> x86/curve25519 - disable gcov").
> 
> Signed-off-by: Wentao Zhang <wentaoz5@illinois.edu>
> Reviewed-by: Chuck Wolber <chuck.wolber@boeing.com>
> Tested-by: Chuck Wolber <chuck.wolber@boeing.com>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  arch/x86/crypto/Makefile | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/crypto/Makefile b/arch/x86/crypto/Makefile
> index 53b4a2778..57f3d4921 100644
> --- a/arch/x86/crypto/Makefile
> +++ b/arch/x86/crypto/Makefile
> @@ -119,5 +119,6 @@ quiet_cmd_perlasm = PERLASM $@
>  $(obj)/%.S: $(src)/%.pl FORCE
>  	$(call if_changed,perlasm)
>  
> -# Disable GCOV in odd or sensitive code
> +# Disable GCOV and llvm-cov in odd or sensitive code
>  GCOV_PROFILE_curve25519-x86_64.o := n
> +LLVM_COV_PROFILE_curve25519-x86_64.o := n
> -- 
> 2.45.2
> 

