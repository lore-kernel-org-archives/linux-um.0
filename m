Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7520CC3ABAC
	for <linux-um@archiver.kernel.org>; Fri,  2 May 2025 09:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XWZ7RNz2ha/TZoahJUWueIyldl3fbm1C2SIgyusEHCo=; b=GdptWn0v//HxXrWIGIMmRXdNR9
	RJLR/yCvQwI8CFL57mG1sjTzRv+8z8h34uuxrUU0/KS2ZloMcpeguUrV6mRLCMKbMnuGVktN3RO9B
	hPDtmmuTEh8qJMKLlAYZmU1z1wxkAw84H1/RJk1irz3jelsM0CENGWr8SfI/d5DfyWHJ8H33/sx1Q
	pehL+cSrifXB97zmv2M/YN6zqyw/xHgr/cYSP1RJA+/++MNeRpOOr2LnkhcN/JrLioxl5pEuBJNDU
	LI25wt8o/tQhxPc+xJgAhXaMPVDgk3wo1E3Acz/LPQLcYlqecDopY5dkmRgMUmXwIXSP2F49hXg2l
	KHt/vhuw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAmny-00000001McM-0Shy;
	Fri, 02 May 2025 09:35:38 +0000
Received: from ns1.kot-begemot.co.uk ([217.160.28.25] helo=www.kot-begemot.co.uk)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAmk6-00000001MAf-2kMP
	for linux-um@lists.infradead.org;
	Fri, 02 May 2025 09:31:39 +0000
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1uAmE9-00AHLZ-Nw; Fri, 02 May 2025 08:58:37 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
	by jain.kot-begemot.co.uk with esmtp (Exim 4.96)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1uAmE4-001mPx-1e;
	Fri, 02 May 2025 09:58:37 +0100
Message-ID: <15ae5fe8-63e1-4155-85b7-3b958dc1f24c@cambridgegreys.com>
Date: Fri, 2 May 2025 09:58:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] um: Merge os-Linux/drivers/ into drivers/
To: Tiwei Bie <tiwei.btw@antgroup.com>, richard@nod.at,
 johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org
References: <20250502083152.3791637-1-tiwei.btw@antgroup.com>
Content-Language: en-US
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
In-Reply-To: <20250502083152.3791637-1-tiwei.btw@antgroup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Clacks-Overhead: GNU Terry Pratchett
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250502_023138_698961_3D854B5F 
X-CRM114-Status: GOOD (  12.98  )
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



On 02/05/2025 09:31, Tiwei Bie wrote:
> Most of the drivers are stored in drivers/, with only two drivers
> kept in os-Linux/drivers/. Merge os-Linux/drivers/ into drivers/
> to simplify and unify the code organization.
> 
> Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
> ---
>   arch/um/drivers/Makefile                       |  4 ++++
>   arch/um/{os-Linux => }/drivers/etap.h          |  0
>   arch/um/{os-Linux => }/drivers/ethertap_kern.c |  0
>   arch/um/{os-Linux => }/drivers/ethertap_user.c |  0
>   arch/um/{os-Linux => }/drivers/tuntap.h        |  0
>   arch/um/{os-Linux => }/drivers/tuntap_kern.c   |  0
>   arch/um/{os-Linux => }/drivers/tuntap_user.c   |  0
>   arch/um/os-Linux/Makefile                      |  2 +-
>   arch/um/os-Linux/drivers/Makefile              | 13 -------------
>   9 files changed, 5 insertions(+), 14 deletions(-)
>   rename arch/um/{os-Linux => }/drivers/etap.h (100%)
>   rename arch/um/{os-Linux => }/drivers/ethertap_kern.c (100%)
>   rename arch/um/{os-Linux => }/drivers/ethertap_user.c (100%)
>   rename arch/um/{os-Linux => }/drivers/tuntap.h (100%)
>   rename arch/um/{os-Linux => }/drivers/tuntap_kern.c (100%)
>   rename arch/um/{os-Linux => }/drivers/tuntap_user.c (100%)
>   delete mode 100644 arch/um/os-Linux/drivers/Makefile
> 
> diff --git a/arch/um/drivers/Makefile b/arch/um/drivers/Makefile
> index 0a5820343ad3..4180a59df929 100644
> --- a/arch/um/drivers/Makefile
> +++ b/arch/um/drivers/Makefile
> @@ -6,6 +6,8 @@
>   # pcap is broken in 2.5 because kbuild doesn't allow pcap.a to be linked
>   # in to pcap.o
>   
> +ethertap-objs := ethertap_kern.o ethertap_user.o
> +tuntap-objs := tuntap_kern.o tuntap_user.o
>   slip-objs := slip_kern.o slip_user.o
>   slirp-objs := slirp_kern.o slirp_user.o
>   daemon-objs := daemon_kern.o daemon_user.o
> @@ -38,6 +40,8 @@ obj-y := stdio_console.o fd.o chan_kern.o chan_user.o line.o
>   obj-$(CONFIG_SSL) += ssl.o
>   obj-$(CONFIG_STDERR_CONSOLE) += stderr_console.o
>   
> +obj-$(CONFIG_UML_NET_ETHERTAP) += ethertap.o
> +obj-$(CONFIG_UML_NET_TUNTAP) += tuntap.o
>   obj-$(CONFIG_UML_NET_SLIP) += slip.o slip_common.o
>   obj-$(CONFIG_UML_NET_SLIRP) += slirp.o slip_common.o
>   obj-$(CONFIG_UML_NET_DAEMON) += daemon.o
> diff --git a/arch/um/os-Linux/drivers/etap.h b/arch/um/drivers/etap.h
> similarity index 100%
> rename from arch/um/os-Linux/drivers/etap.h
> rename to arch/um/drivers/etap.h
> diff --git a/arch/um/os-Linux/drivers/ethertap_kern.c b/arch/um/drivers/ethertap_kern.c
> similarity index 100%
> rename from arch/um/os-Linux/drivers/ethertap_kern.c
> rename to arch/um/drivers/ethertap_kern.c
> diff --git a/arch/um/os-Linux/drivers/ethertap_user.c b/arch/um/drivers/ethertap_user.c
> similarity index 100%
> rename from arch/um/os-Linux/drivers/ethertap_user.c
> rename to arch/um/drivers/ethertap_user.c
> diff --git a/arch/um/os-Linux/drivers/tuntap.h b/arch/um/drivers/tuntap.h
> similarity index 100%
> rename from arch/um/os-Linux/drivers/tuntap.h
> rename to arch/um/drivers/tuntap.h
> diff --git a/arch/um/os-Linux/drivers/tuntap_kern.c b/arch/um/drivers/tuntap_kern.c
> similarity index 100%
> rename from arch/um/os-Linux/drivers/tuntap_kern.c
> rename to arch/um/drivers/tuntap_kern.c
> diff --git a/arch/um/os-Linux/drivers/tuntap_user.c b/arch/um/drivers/tuntap_user.c
> similarity index 100%
> rename from arch/um/os-Linux/drivers/tuntap_user.c
> rename to arch/um/drivers/tuntap_user.c
> diff --git a/arch/um/os-Linux/Makefile b/arch/um/os-Linux/Makefile
> index 049dfa5bc9c6..fae836713487 100644
> --- a/arch/um/os-Linux/Makefile
> +++ b/arch/um/os-Linux/Makefile
> @@ -8,7 +8,7 @@ KCOV_INSTRUMENT                := n
>   
>   obj-y = execvp.o file.o helper.o irq.o main.o mem.o process.o \
>   	registers.o sigio.o signal.o start_up.o time.o tty.o \
> -	umid.o user_syms.o util.o drivers/ skas/
> +	umid.o user_syms.o util.o skas/
>   
>   CFLAGS_signal.o += -Wframe-larger-than=4096
>   
> diff --git a/arch/um/os-Linux/drivers/Makefile b/arch/um/os-Linux/drivers/Makefile
> deleted file mode 100644
> index cf2d75bb1884..000000000000
> --- a/arch/um/os-Linux/drivers/Makefile
> +++ /dev/null
> @@ -1,13 +0,0 @@
> -# SPDX-License-Identifier: GPL-2.0
> -#
> -# Copyright (C) 2000, 2002 Jeff Dike (jdike@karaya.com)
> -#
> -
> -ethertap-objs := ethertap_kern.o ethertap_user.o
> -tuntap-objs := tuntap_kern.o tuntap_user.o
> -
> -obj-y =
> -obj-$(CONFIG_UML_NET_ETHERTAP) += ethertap.o
> -obj-$(CONFIG_UML_NET_TUNTAP) += tuntap.o
> -
> -include $(srctree)/arch/um/scripts/Makefile.rules

They are both marked as obsolete since 5.6.

40814b98a57089463eb4be09c72205f551481f39 2019-12-10 22:34:03
um: Mark non-vector net transports as obsolete

We should probably consider removing them.

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/


