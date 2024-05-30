Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8EA9C25B75
	for <linux-um@archiver.kernel.org>; Thu, 30 May 2024 03:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ql/X5MPHOqz0Dazk+XvHqGrsSkDLGOl071tj+kglOgU=; b=YD/xp61hpSqoaKI42J1yxghGSd
	wjPjEzlvpqDfKwmuAuqFplESXeoQeOi66SbjNdRnYyVm/WT2e/C0m04vDysr5i6Daugt8+OMDODH9
	CoSIw9IcPf6cGHBZH6Z+1HfBsbxGlQJ2NEggbQxHtzkSyuaHSBZ+0CyISiUTuiF/lhEtvg5GL88eE
	UNwsLH45d/al8UEbHngikhsoSQyD5KXeeUnQeEp2X6r+FD083bzTbqKTMYwqczrSnSzbmeFpBAxml
	WzYc6DFusnU31qK0S9jItpZUxLQe1NQ3xUVfFr+3MRpETVdUMTXXM7y5QDb9sSa6k//T8pqoUPCYI
	p+bMtVNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCW8T-000000069sZ-1zyl;
	Thu, 30 May 2024 03:07:25 +0000
Received: from out0-211.mail.aliyun.com ([140.205.0.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCW8Q-000000069rw-0CfA
	for linux-um@lists.infradead.org;
	Thu, 30 May 2024 03:07:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1717038436; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Ql/X5MPHOqz0Dazk+XvHqGrsSkDLGOl071tj+kglOgU=;
	b=WiXswMgju5FYpjPEwLpf726vBuJOvgE7tBaSjlVEBkO7zfNPO+MuuZiIUZ+JCOwx2CDxNpW0h/fIjr0sixpm29osUAQ5kHfObd897TFaFc54hJubHdERY4PxVW0BNGqPTV8/Z3cQuGFBZlpcQxBLrVXARlQieNUq7oTNsRnsvW8=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068221070;MF=tiwei.btw@antgroup.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---.XqsjMz6_1717038433;
Received: from 30.177.168.159(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.XqsjMz6_1717038433)
          by smtp.aliyun-inc.com;
          Thu, 30 May 2024 11:07:14 +0800
Message-ID: <64fc3b3f-50c7-42c1-a30d-c3eb90c76286@antgroup.com>
Date: Thu, 30 May 2024 11:07:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] um: Add 4 level page table support
To: benjamin@sipsolutions.net, linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
References: <20240528085419.1964424-1-benjamin@sipsolutions.net>
 <20240528085419.1964424-6-benjamin@sipsolutions.net>
Content-Language: en-US
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
In-Reply-To: <20240528085419.1964424-6-benjamin@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240529_200722_745523_FA308971 
X-CRM114-Status: GOOD (  11.24  )
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

On 5/28/24 4:54 PM, benjamin@sipsolutions.net wrote:
[...]
> diff --git a/arch/um/Kconfig b/arch/um/Kconfig
> index 93a5a8999b07..5d111fc8ccb7 100644
> --- a/arch/um/Kconfig
> +++ b/arch/um/Kconfig
> @@ -208,6 +208,7 @@ config MMAPPER
>  
>  config PGTABLE_LEVELS
>  	int
> +	default 4 if 4_LEVEL_PGTABLES
>  	default 3 if 3_LEVEL_PGTABLES
>  	default 2
>  
[...]
> diff --git a/arch/x86/um/Kconfig b/arch/x86/um/Kconfig
> index 186f13268401..72dc7b0b3a33 100644
> --- a/arch/x86/um/Kconfig
> +++ b/arch/x86/um/Kconfig
> @@ -28,16 +28,34 @@ config X86_64
>  	def_bool 64BIT
>  	select MODULES_USE_ELF_RELA
>  
> -config 3_LEVEL_PGTABLES
> -	bool "Three-level pagetables" if !64BIT
> -	default 64BIT
> -	help
> -	  Three-level pagetables will let UML have more than 4G of physical
> -	  memory.  All the memory that can't be mapped directly will be treated
> -	  as high memory.
> -
> -	  However, this it experimental on 32-bit architectures, so if unsure say
> -	  N (on x86-64 it's automatically enabled, instead, as it's safe there).
> +choice
> +	prompt "Pagetable levels" if EXPERT
> +	default 2_LEVEL_PGTABLES if !64BIT
> +	default 4_LEVEL_PGTABLES if 64BIT
> +
> +	config 2_LEVEL_PGTABLES
> +		bool "Three-level pagetables" if !64BIT

Nit: s/Three-level/Two-level/

> +		depends on !64BIT
> +		help
> +		  Two-level page table for 32-bit architectures.
> +
> +	config 3_LEVEL_PGTABLES
> +		bool "Three-level pagetables" if 64BIT
> +		help
> +		  Three-level pagetables will let UML have more than 4G of physical
> +		  memory.  All the memory that can't be mapped directly will be treated
> +		  as high memory.
> +
> +		  However, this it experimental on 32-bit architectures, so if unsure say
> +		  N (on x86-64 it's automatically enabled, instead, as it's safe there).
> +
> +	config 4_LEVEL_PGTABLES
> +		bool "Four-level pagetables" if 64BIT
> +		depends on 64BIT
> +		help
> +		  Four-level pagetables, gives a bigger address space which can be
> +		  useful for some applications (e.g. ASAN).

On 64bit, it appears that 4_LEVEL_PGTABLES won't be selected by running
"make ARCH=um defconfig", and PGTABLE_LEVELS will be 2.

I got the following search result in "make ARCH=um menuconfig":

  │ Symbol: 4_LEVEL_PGTABLES [=n]
  │ Type  : bool
  │ Defined at arch/x86/um/Kconfig:51
  │   Prompt: Four-level pagetables
  │   Depends on: <choice> && 64BIT [=y]
  │   Location:
  │ (1) -> UML-specific options
  │       -> Pagetable levels (<choice> [=n])
  │         -> Four-level pagetables (4_LEVEL_PGTABLES [=n])

And 4_LEVEL_PGTABLES will be selected if I turn on EXPERT manually.

Regards,
Tiwei

> +endchoice
>  
>  config ARCH_HAS_SC_SIGNALS
>  	def_bool !64BIT


