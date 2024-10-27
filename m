Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2200FD13587
	for <linux-um@archiver.kernel.org>; Sun, 27 Oct 2024 22:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=p5eicLyzZljQWRrpNEIGKE1Kmqqabzbp4y+NvUH5nzg=; b=LkHY8s2zKGKlLgNUYrecI+zXxr
	pQ2qquzsNrUSSBE7Ds455q48rwWV8fKuTnqccOYu9EYVDMdr5M0yBKaeVM4qaRewisJsRzMXxA352
	2lJULPpz4uLLMApmha7l/fElm1v7ou/v+VRmJOJreiNzx7fGBhEJ29PMxYU1GMXjkBGxyHdC8Iyxt
	GpOFGAGS7YVeFWIqI4xvP2gT9fzDffrJydv7dA87RlK12/pXt9JkegT6HaFmreuNYWL8mU/ib6AYX
	MtH9Y+9om/28Ilxd5+w65rtBCf0QUa8F0w4EYWChVLi4GkyOiqWM+wJTkwrKLB9iz8zG9Z1Q58Qbp
	yr8Q/umw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5BRo-00000008zVR-1HQw;
	Sun, 27 Oct 2024 22:09:20 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5BRk-00000008zUr-3HeF
	for linux-um@lists.infradead.org;
	Sun, 27 Oct 2024 22:09:18 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 87D0D5C022A;
	Sun, 27 Oct 2024 22:08:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03AEEC4CEC3;
	Sun, 27 Oct 2024 22:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730066955;
	bh=sTRtpE5GiPUcc/sl8dSORvSiQEatOJi7sQa+fPGObcQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MwiIivcZX+x0Dx8tZ/+dUlxFVIr1wo2kd7h49qVtCPfIuQ2mPzWOXe/UK8HyLd/4h
	 0SOn8NU0cbWbZfVJi2POPkydLL2TXFbgbdP6lAOdaRj455kiEwwAttxXP+XtRWdZkv
	 joclkUfks7a5pSUs7mOzSJrW1SDlxRLr22qNKq7vIOAuOphlOg9iY6GEzZN4tMZcL5
	 Y4LjBaSQajIjla1VHGPutBSKYkpWJr6VjCZJv1Pa21rXgLFPYvZ5FPoYD1lZUWkPtD
	 uVu71OKEQtZkOVtdZionxsGhPy9HN55GTabsyYBt4K6Mz+DTZfDksxtkqHmiwfBeSp
	 42e9cw1ikau5g==
Date: Sun, 27 Oct 2024 15:09:13 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-um@lists.infradead.org, benjamin@sipsolutions.net,
	Johannes Berg <johannes.berg@intel.com>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] um: fix stub exe build with CONFIG_GCOV
Message-ID: <20241027220913.GC2755311@thelio-3990X>
References: <20241025102700.9fbb9c34473f.I7f1537fe075638f8da64beb52ef6c9e5adc51bc3@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025102700.9fbb9c34473f.I7f1537fe075638f8da64beb52ef6c9e5adc51bc3@changeid>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241027_150916_997009_698124F0 
X-CRM114-Status: GOOD (  19.94  )
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

On Fri, Oct 25, 2024 at 10:27:01AM +0200, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> CONFIG_GCOV is special and only in UML since it builds the
> kernel with a "userspace" option. This is fine, but the stub
> is even more special and not really a full userspace process,
> so it then fails to link as reported.
> 
> For good measure, also remove the GPROF options, even though
> they don't seem to cause build failures now.
> 
> To be able to do this, export the specific options (GCOV_OPT
> and GPROF_OPT) but rename them so there's less chance of any
> conflicts.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202410242238.SXhs2kQ4-lkp@intel.com/
> Fixes: 32e8eaf263d9 ("um: use execveat to create userspace MMs")
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Tested-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  arch/um/Makefile-skas        | 14 +++++++-------
>  arch/um/kernel/skas/Makefile |  2 +-
>  2 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/um/Makefile-skas b/arch/um/Makefile-skas
> index 67323b028999..1a27e65bcb9c 100644
> --- a/arch/um/Makefile-skas
> +++ b/arch/um/Makefile-skas
> @@ -3,15 +3,15 @@
>  # Licensed under the GPL
>  #
>  
> -GPROF_OPT += -pg
> +export UM_GPROF_OPT += -pg
>  
>  ifdef CONFIG_CC_IS_CLANG
> -GCOV_OPT += -fprofile-instr-generate -fcoverage-mapping
> +export UM_GCOV_OPT += -fprofile-instr-generate -fcoverage-mapping
>  else
> -GCOV_OPT += -fprofile-arcs -ftest-coverage
> +export UM_GCOV_OPT += -fprofile-arcs -ftest-coverage
>  endif
>  
> -CFLAGS-$(CONFIG_GCOV) += $(GCOV_OPT)
> -CFLAGS-$(CONFIG_GPROF) += $(GPROF_OPT)
> -LINK-$(CONFIG_GCOV) += $(GCOV_OPT)
> -LINK-$(CONFIG_GPROF) += $(GPROF_OPT)
> +CFLAGS-$(CONFIG_GCOV) += $(UM_GCOV_OPT)
> +CFLAGS-$(CONFIG_GPROF) += $(UM_GPROF_OPT)
> +LINK-$(CONFIG_GCOV) += $(UM_GCOV_OPT)
> +LINK-$(CONFIG_GPROF) += $(UM_GPROF_OPT)
> diff --git a/arch/um/kernel/skas/Makefile b/arch/um/kernel/skas/Makefile
> index f6a219074772..3384be42691f 100644
> --- a/arch/um/kernel/skas/Makefile
> +++ b/arch/um/kernel/skas/Makefile
> @@ -24,7 +24,7 @@ $(obj)/stub_exe: $(obj)/stub_exe.dbg FORCE
>  
>  quiet_cmd_stub_exe = STUB_EXE $@
>        cmd_stub_exe = $(CC) -nostdlib -o $@ \
> -			   $(KBUILD_CFLAGS) $(STUB_EXE_LDFLAGS) \
> +			   $(filter-out $(UM_GPROF_OPT) $(UM_GCOV_OPT),$(KBUILD_CFLAGS)) $(STUB_EXE_LDFLAGS) \

Not that it matters much but it might be more readable to have
$(STUB_EXE_LDFLAGS) on its own line now.

>  			   $(filter %.o,$^)
>  
>  STUB_EXE_LDFLAGS = -Wl,-n -static
> -- 
> 2.47.0
> 

