Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8783CF3195
	for <linux-um@archiver.kernel.org>; Wed,  2 Oct 2024 04:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=B2ZAQKodtjVu7cBwU2oU+uI8JVPYDT8FSzV0LYMamag=; b=Gkhhj0QKfisYlijnpCmYIMscYA
	CAIxk/tk2ylwCGyTtsiN8w52K0IFmURAo7EhZvxjSV9nletBgfbhte6EEAO69jx5v3bEP1smcLtEb
	2gX9jMpXFHC89oVOPyUW7d6Mu/wSNF2WslROjg9rwX0pdyT6LA6Nu8dxE8IG4kJXlZsY9lgyeOhoV
	ebkCmbIr5CHhkkGOaFrdcAnaZL4smaGr5XK5o4VuQH7q0nG4XzCeNXxcoJWxtZYDEWMqmH9n+y8p7
	KvHdgqQG51bFNKjoBa+WdM+zeKrKOcsR8X6eQYc5aI/cj2eHgSkUlVuaxLbdt2xoTuYIRtfxA71al
	hXZtimGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1svrN7-00000004o0s-0vMN;
	Wed, 02 Oct 2024 04:53:57 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1svrN3-00000004nzt-44Tc
	for linux-um@lists.infradead.org;
	Wed, 02 Oct 2024 04:53:55 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 078A0A436C3;
	Wed,  2 Oct 2024 04:53:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31909C4CEC5;
	Wed,  2 Oct 2024 04:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727844831;
	bh=B2ZAQKodtjVu7cBwU2oU+uI8JVPYDT8FSzV0LYMamag=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CEkKxegfpkX4Zw2CaHm5skQNLmPRJhWvRWrfwNVlh+TFSz9BPuRZdgUJT+gZ23vFJ
	 IxhXfrAdi/5Tzs2K9tvjU3gGZB7VVKI4WK6iDn0vYP8Or/TvoXD3w3WnjkCdL7pIqo
	 yAvyTAGmv5OmjrtPe8R7vrLNoxKPxUOfc15RGQ+nZr1J+I99IYLiEMGzK5HchaL0Rb
	 fCgXSnWAkdoQPpNtPUVza5lz7aLWm5cSFY86HH4WWW1emta+IbTxS2QRhxf7N54ops
	 vKi+l2ymUNL9BK54SZfzJOyLLVNlGP4C8ThAbAA+5rGKWDt7DLBpJn9rzmHQgg9i3o
	 dEWzEr1A+63LQ==
Date: Tue, 1 Oct 2024 21:53:47 -0700
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
Subject: Re: [PATCH v2 0/4] Enable measuring the kernel's Source-based Code
 Coverage and MC/DC with Clang
Message-ID: <20241002045347.GE555609@thelio-3990X>
References: <20240824230641.385839-1-wentaoz5@illinois.edu>
 <20240905043245.1389509-1-wentaoz5@illinois.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905043245.1389509-1-wentaoz5@illinois.edu>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241001_215354_146149_876C3565 
X-CRM114-Status: GOOD (  17.46  )
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

Hi Wentao,

I took this series for a spin on next-20241001 with LLVM 19.1.0 using a
distribution configuration tailored for a local development VM using
QEMU. You'll notice on the rebase for 6.12-rc1 but there is a small
conflict in kernel/Makefile due to commit 0e8b67982b48 ("mm: move
kernel/numa.c to mm/").

I initially did the build on one of my test machines which has 16
threads with 32GB of RAM and ld.lld got killed while linking vmlinux.o.
Is your comment in the MC/DC patch "more memory is consumed if larger
decisions are getting counted" relevant here or is that talking about
runtime memory on the target device? I assume the latter but I figured I
would make sure. If not, it might be worth a comment somewhere that this
can also require some heftier build resources possibly? If that is not
expected, I am happy to help look into why it is happening.

I was able to successfully build that same configuration and setup with
my primary workstation, which is much beefier. Unfortunately, the
resulting kernel did not boot with my usual VM testing setup. I will see
if I can narrow down a particular configuration option that causes this
tomorrow because I did a test with defconfig +
CONFIG_LLVM_COV_PROFILE_ALL and it booted fine. Perhaps some other
option that is not compatible with this? I'll follow up with more
information as I have it.

On the integration front, I think the -mm tree, run by Andrew Morton,
would probably be the best place to land this with Acks from the -tip
folks for the x86 bits? Once the issue above has been understood, I
think you can send v3 with any of the comments I made addressed and a
potential fix for the above issue if necessary directly to him, instead
of just on cc, so that it gets his attention. Other maintainers are free
to argue that it should go through their trees instead but I think it
would be good to decide on that sooner rather than later so this
patchset is not stuck in limbo.

Cheers,
Nathan

