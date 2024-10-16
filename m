Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4EDCD2068F
	for <linux-um@archiver.kernel.org>; Wed, 16 Oct 2024 02:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=A/2h9Het1gb8QqxL2UgPDQ7wqjMyHBZws0fF7VXAkeI=; b=0GW00EO1H9RPDyyjYw7khGgLKt
	mAy975z/7ANoQnxvKKeIkVf9BqLdj9mybFWoUfacmyQXDSdr9rLk5/gOPYeoFSiXaOWELNG3vUcQo
	mpMrn2vDOecop4GPVeOAoePskgiU+WCOrvQ9uhXNV8bDojrUQB0H68NafHk9x9cVQs15P6JOk850/
	nXlDuCdHPYWF/a+z7fPU6TCDeHvryKLN/3UqlZrg5mIxWzhVdDJJaWlf455mE2u/JwZB3YNAUc8TE
	Y5wme+/Wq5emqNLE7Vy+Lesiqgpd2r6bfvymxA7O4qSVR0u6uSI4HgAyudV9lG8l8otJyEKA4TEaI
	yo65efmg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t0trr-0000000AEqg-1gW9;
	Wed, 16 Oct 2024 02:34:31 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t0trp-0000000AEpY-0vzI
	for linux-um@lists.infradead.org;
	Wed, 16 Oct 2024 02:34:30 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 164755C5611;
	Wed, 16 Oct 2024 02:34:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2366C4CEC6;
	Wed, 16 Oct 2024 02:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729046068;
	bh=yJGBVUpZrAxCkVWAv7xnyqTDoabYgqFnkJBcr1NBFCU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ud+WjJV1m+xFKjOYVbvqUl6STV1zc95Wdj1bHS1wkBcWtf3yrZzaaAW4Lk2eJqG6b
	 JfdIwR5Bn7ouaWvD677GWGVOsP/PyVfD8ajd+F3dr5n5i+gF2MmnVRNBt6VQMcGmAH
	 WpnvylmYq4hG/sXAlMX9AUj4zeiTamBPMjl1EUACwMxymzN97th67DCBcMhI68dV8/
	 JtlD0yD0JUiOwsCCMve61ULwPREeIxoXTfeQ1Y5A9Eqoc+sOgzgX9Hz0L8cBn5Vv7I
	 drb00aeYcIk1OXpGAR8PAdIUDxsty7qCU8BMygxNy+eymi23RE7iXQIoMovWWUV5mG
	 DPk061J7nebIw==
Date: Tue, 15 Oct 2024 19:34:26 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Benjamin Berg <benjamin@sipsolutions.net>
Cc: linux-um@lists.infradead.org, Benjamin Berg <benjamin.berg@intel.com>,
	llvm@lists.linux.dev
Subject: Re: [PATCH v9 02/10] um: use execveat to create userspace MMs
Message-ID: <20241016023426.GA1115452@thelio-3990X>
References: <20240919124511.282088-1-benjamin@sipsolutions.net>
 <20240919124511.282088-3-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240919124511.282088-3-benjamin@sipsolutions.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241015_193429_375069_542E2A84 
X-CRM114-Status: GOOD (  16.43  )
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

Hi Benjamin,

On Thu, Sep 19, 2024 at 02:45:03PM +0200, Benjamin Berg wrote:
...
> diff --git a/arch/um/kernel/skas/Makefile b/arch/um/kernel/skas/Makefile
> index 6f86d53e3d69..fbb61968055f 100644
> --- a/arch/um/kernel/skas/Makefile
> +++ b/arch/um/kernel/skas/Makefile
> @@ -3,14 +3,43 @@
>  # Copyright (C) 2002 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
>  #
>  
> -obj-y := stub.o mmu.o process.o syscall.o uaccess.o
> +obj-y := stub.o mmu.o process.o syscall.o uaccess.o \
> +	 stub_exe_embed.o
> +
> +# Stub executable
> +
> +stub_exe_objs-y := stub_exe.o
> +
> +stub_exe_objs := $(foreach F,$(stub_exe_objs-y),$(obj)/$F)
> +
> +# Object file containing the ELF executable
> +$(obj)/stub_exe_embed.o: $(src)/stub_exe_embed.S $(obj)/stub_exe
> +
> +$(obj)/stub_exe.dbg: $(stub_exe_objs) FORCE
> +	$(call if_changed,stub_exe)
> +
> +$(obj)/stub_exe: OBJCOPYFLAGS := -S
> +$(obj)/stub_exe: $(obj)/stub_exe.dbg FORCE
> +	$(call if_changed,objcopy)
> +
> +quiet_cmd_stub_exe = STUB_EXE $@
> +      cmd_stub_exe = $(CC) -nostdlib -o $@ \
> +			   $(KBUILD_CFLAGS) $(STUB_EXE_LDFLAGS) \
> +			   $(filter %.o,$^)
> +
> +STUB_EXE_LDFLAGS = -n -static

After this change in -next as commit 32e8eaf263d9 ("um: use execveat to
create userspace MMs"), I am seeing an error when building ARCH=um
defconfig with clang.

  $ make -skj"$(nproc)" ARCH=um LLVM=1 mrproper defconfig linux
  clang: error: unknown argument: '-n'
  make[7]: *** [arch/um/kernel/skas/Makefile:19: arch/um/kernel/skas/stub_exe.dbg] Error 1
  ...

I have looked through the GCC manual and options index but I do not see
what '-n' is. Was this intended to be passed to the linker like -Wl,-n
or was there some other option that this should be? If I try dropping
it, I end up running into another issue, which could be entirely
unrelated.

  $ make -skj"$(nproc)" ARCH=um LLVM=1 mrproper defconfig arch/um/kernel/skas/
  /usr/bin/ld: arch/um/kernel/skas/stub_exe.o: in function `_start':
  arch/um/kernel/skas/stub_exe.c:83:(.ltext+0x15): undefined reference to `memset'
  clang: error: linker command failed with exit code 1 (use -v to see invocation)
  make[7]: *** [arch/um/kernel/skas/Makefile:19: arch/um/kernel/skas/stub_exe.dbg] Error 1

Cheers,
Nathan

> +targets += stub_exe.dbg stub_exe $(stub_exe_objs-y)
> +
> +# end
>  
>  # stub.o is in the stub, so it can't be built with profiling
>  # GCC hardened also auto-enables -fpic, but we need %ebx so it can't work ->
>  # disable it
>  
>  CFLAGS_stub.o := $(CFLAGS_NO_HARDENING)
> -UNPROFILE_OBJS := stub.o
> +CFLAGS_stub_exe.o := $(CFLAGS_NO_HARDENING)
> +UNPROFILE_OBJS := stub.o stub_exe.o
>  KCOV_INSTRUMENT := n
>  
>  include $(srctree)/arch/um/scripts/Makefile.rules

