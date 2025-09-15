Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EE58CAC58E
	for <linux-um@archiver.kernel.org>; Mon, 15 Sep 2025 08:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=26LOU0sJvq3kxKyzepiVXpiiSbNjQhMQ+DJfy3+xMkA=; b=1MTAg4veogTqJ7NipyMxHF+iNB
	IrHWiB0IvCTuFk0I4N5WpVaYJL6IWBEDPAn14L8WBPogSrdNBfHoYdCDDFqRAjM9umxH2dWaK8Xse
	P7kI8zAtN+QSYz5dmseY9oM5syYXkzNj54UDhRXfdP8t5Rk7xED4iT/mrtO4HcnJzDW5W7QNV0v3a
	tydInRXkOPWyte72HWlARPUGKVZK93nofggqyptSqReih6YFzeJ8ypRhn0VJdTuMprliX6h2YTBNi
	jpAFvXaGNFbp3nDxwvkBXT6jzgyro1Nn3LAL81GoJlhyE8c6zjmDfkLac7GwwbQ+GuBwad1N5NSSP
	1mm3x77A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uy52a-00000003KSD-2aKh;
	Mon, 15 Sep 2025 08:58:28 +0000
Received: from todd.t-8ch.de ([2a01:4f8:c010:41de::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uy521-00000003JnE-2xOU
	for linux-um@lists.infradead.org;
	Mon, 15 Sep 2025 08:57:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1757926670;
	bh=e0SMJFBpOy5/d3qbT4HP8L3kb/X4vlvHNxXtwRTDE3g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IjnophdEcujlUxbWSM/TmsAayR8h17N0bfCB5Bo5m9oxaCnRWX00C6D3uvqSsSA0U
	 7EKIYetgs+W+HrCHcY+te2d8/JAkiqDQDvxKpWD/cep8t/L0MCct2eaQGPgq89kqkQ
	 q1vM9YBNxwwZhla4y8JfEkiOB9iPHN/mUy0WcDx4=
Date: Mon, 15 Sep 2025 10:57:51 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Benjamin Berg <benjamin@sipsolutions.net>
Cc: linux-um@lists.infradead.org, Willy Tarreau <w@1wt.eu>, 
	linux-kselftest@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	linux-kernel@vger.kernel.org, Tiwei Bie <tiwei.btw@antgroup.com>, 
	Benjamin Berg <benjamin.berg@intel.com>
Subject: Re: [PATCH 7/9] um: add infrastructure to build files using nolibc
Message-ID: <31a81a3a-e6f2-49b1-9a07-4b11df9e4091@t-8ch.de>
References: <20250915071115.1429196-1-benjamin@sipsolutions.net>
 <20250915071115.1429196-8-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915071115.1429196-8-benjamin@sipsolutions.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250915_015753_994614_9A3AB7B7 
X-CRM114-Status: GOOD (  17.57  )
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

On 2025-09-15 09:11:13+0200, Benjamin Berg wrote:
> From: Benjamin Berg <benjamin.berg@intel.com>
> 
> Add NOLIBC_CFLAGS and NOLIBC_OBJS to build files against nolibc rather
> than libc. With this it is possible to move to nolibc in smaller steps.
> 
> Set NOLIBC_IGNORE_ERRNO, as the nolibc errno implementation is overly
> simple and cannot handle threading. nolibc provides sys_* functions that
> do not emulate the libc errno behaviour and can be used instead.
> 
> Guard the syscall definition as it is a macro in nolibc.
> 
> Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
> ---
>  arch/um/Makefile               | 21 ++++++++++++++++++++-
>  arch/um/include/shared/os.h    |  2 ++
>  arch/um/scripts/Makefile.rules |  8 +++++++-
>  3 files changed, 29 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/um/Makefile b/arch/um/Makefile
> index a3f27d791cc0..54aa26fcc32b 100644
> --- a/arch/um/Makefile
> +++ b/arch/um/Makefile
> @@ -78,6 +78,25 @@ USER_CFLAGS = $(patsubst $(KERNEL_DEFINES),,$(patsubst -I%,,$(KBUILD_CFLAGS))) \
>  		-include $(srctree)/include/linux/kern_levels.h \
>  		-include $(srctree)/$(ARCH_DIR)/include/shared/user.h
>  
> +NOLIBC_CFLAGS = $(patsubst $(KERNEL_DEFINES),,$(patsubst -I%,,$(KBUILD_CFLAGS))) \
> +		$(ARCH_INCLUDE) $(MODE_INCLUDE) $(filter -I%,$(CFLAGS)) \
> +		-I $(srctree)/tools/include \
> +		-D__EXPORTED_HEADERS__ \
> +		-D__UM_HOST__ -D__UM_NOLIBC__ \
> +		-DNOLIBC_NO_STARTCODE \
> +		-DNOLIBC_IGNORE_ERRNO \
> +		-nostdlib -nostdinc -static \
> +		-I$(srctree)/include/uapi \
> +		-I$(srctree)/$(HOST_DIR)/include/uapi \
> +		-I$(objtree)/$(HOST_DIR)/include/generated/uapi \
> +		-I $(srctree)/tools/include/nolibc \
> +		-I $(srctree)/usr/include \
> +		-include $(srctree)/include/generated/autoconf.h \
> +		-include $(srctree)/tools/include/linux/kconfig.h \
> +		-include $(srctree)/include/linux/kern_levels.h \
> +		-include $(srctree)/tools/include/nolibc/nolibc.h \

This is not needed. It doesn't hurt though.

> +		-include $(srctree)/$(ARCH_DIR)/include/shared/user.h
> +
>  #This will adjust *FLAGS accordingly to the platform.
>  include $(srctree)/$(ARCH_DIR)/Makefile-os-Linux
>  
> @@ -157,4 +176,4 @@ archclean:
>  		-o -name '*.gcov' \) -type f -print | xargs rm -f
>  	$(Q)$(MAKE) -f $(srctree)/Makefile ARCH=$(HEADER_ARCH) clean
>  
> -export HEADER_ARCH SUBARCH USER_CFLAGS CFLAGS_NO_HARDENING DEV_NULL_PATH
> +export HEADER_ARCH SUBARCH USER_CFLAGS NOLIBC_CFLAGS CFLAGS_NO_HARDENING DEV_NULL_PATH
> diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
> index b35cc8ce333b..3e9f3ae61658 100644
> --- a/arch/um/include/shared/os.h
> +++ b/arch/um/include/shared/os.h
> @@ -327,7 +327,9 @@ extern int __ignore_sigio_fd(int fd);
>  /* tty.c */
>  extern int get_pty(void);
>  
> +#ifndef syscall

You could use 'ifndef NOLIBC' to make the reason clear.

>  long syscall(long number, ...);
> +#endif
>  
>  /* irqflags tracing */
>  extern void block_signals_trace(void);

(...)

