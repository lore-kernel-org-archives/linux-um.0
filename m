Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8516CC83F26
	for <linux-um@archiver.kernel.org>; Mon, 21 Jul 2025 23:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=k6qH8mhMJUNtpiP5ZkZtwmZQrunIQJlcyvnjoj0lgTw=; b=ZvH25X5j9DiQcYe43KHqBEgrAO
	A92aeG67NPrf84WGehPOErAgXwi17RWJtBnmwjZD5v47ApUuscjXAtSfVBzzXTZ+Dan29CeMv+zIX
	R6TGSxnuXCFGM59DDI6dHeLTQ6BjCZTITJLMn2PZ8EWA0z+YojJVDD7gwhTO7eJ4XZtKvY1pGg5Xu
	ulL64oE+9CEKt2QXfKyMslalP0yo1YzwU2nWLYNFXnfbEEm4KMYYdmySr/G7jYB/u1djbbuIKMj8p
	LariZ5k9qPnwylPa2TbiIerdMpupXbd6JF+FXaNIOkP3hbzI7jAoAkk5ya5ZlWPbdlfdTcJLNPE7B
	eQqgtX1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1udzUI-00000000q9p-0afm;
	Mon, 21 Jul 2025 23:00:02 +0000
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1udzUE-00000000q5d-0BZJ;
	Mon, 21 Jul 2025 22:59:59 +0000
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-ae34f43be56so98184366b.2;
        Mon, 21 Jul 2025 15:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753138796; x=1753743596; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k6qH8mhMJUNtpiP5ZkZtwmZQrunIQJlcyvnjoj0lgTw=;
        b=lWkOPlxIyUaYVLaqUoBk19UGWRsRpzXXbMmfOauwIeiJ63TNCSGBsv41T+IgX2I1oS
         2Ur5LXXPvV75vwiWnS0aDZXj+aELm3FNuWXTeSuGiB+uvR/PmrR6HoYJoZPN8BsCpmVQ
         gBsQ8sMNxvA1LR45DsrurUYXzKqFAEGXxc2gqEg7K4IO1NyM6siZ8/qgPY3Zq+glSbQy
         IDqtmI+BTLmrtnAV6n9PMbdrzSfSNYO0R/B/mEFjywbB2YU652ETXx4O9KAoy7zV30OH
         bdCheRxOiFuxcHEr2uOeOMNBepkPg7sazfEF5R5IrCXnvR3iY09TmugObhoDwvpQg27Y
         sRoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753138796; x=1753743596;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k6qH8mhMJUNtpiP5ZkZtwmZQrunIQJlcyvnjoj0lgTw=;
        b=LcO5YoZ923bv4iqc+ZSAZPL62lu7+txs5JLgr0p7+NK/jjozYbI3ulrnCOSJFnq9OA
         KUx7k7R5JPHEwyMOdWaGgZarNRLnSOPxcCIRqtoGQFSW6nznZifxTQkC2yg8r+zS/1cp
         lxX0MjeEoSe66DL7EU0PKvQKxKSpTx1q/Zb+zsvF/wSP7GT8HXv6LXGAJC+UhLG/nwnh
         KmNndOIPnksEQgDZXYyIshu8e6z760WW4Z0vAWmygxASaNpcuS8ZNffU04N3zn/9zYbb
         XRoaQOJUknz3KpUc1e6FxEAm4POAGKrinVXcg3j5TxS/jPwL883+bSowOmDotB/s0fiP
         q6Jw==
X-Forwarded-Encrypted: i=1; AJvYcCUNecCP3qfKwsbwzWEfx40IvSe0vXQofi5DwcrvVUYYOH54kRite3gosbRxgkgLybSKOoGX6OVgwI8=@lists.infradead.org, AJvYcCVv1K9b9l6c+pOI6B8fIU5ECBlXL9YQgtB/bTLUwLT+IhCJ5a2HJzDJmLtxa72+IaWolEW4zPDnCJcEMw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yy666Mdaq/Awu6O1wXnc5BgWiY6W8HeJIR5YzEMOhDT/279ZJcl
	BTWz5L4RHJOqbfccghOH+GmL2mhWg62e6Bmivd7uHCY7hGAK2m96QSn+
X-Gm-Gg: ASbGnctrEJXYIBx479hCQgcgiW2azT4jpVorSvPSq1dQXoIQfSLCJN2HU6BwzRKn9Xl
	oR2nTghojCp7iIkL7YYYOIvXt81RsHt294+iVdUsTtE4dchNly3jsjzAa5mUZiv9NleWJ+1jHYg
	un1S596cnusp0QUD3X320glcvyCOoIdZ6bqLhRTMqQjuz77TdVTml5eINzN5Ww306eVwUkhDxcm
	bxfofLlElwSNzx64DzAvI6h+CBEDWdt2spQhnTjZyLlcR465QuMTyFnZ5hQB6Ia1vCU/hhpSP/R
	QgjbI9/lYKhMivg2HHOQkhXLf7mkPEY0Ngx5QXeBoUo4uoctwVnUtd/7CaZyy0NBq8atL5tiq6K
	ahm5+YyHCP/i7O65D4COFdBGRYW9aKKReM47SVtqXhRlrNe3v0968ainfWPz/tYWv+PjgAe2O32
	eqTGQ=
X-Google-Smtp-Source: AGHT+IEnEupELw4ajNrlfkyI1uQuImlm2WT9jEJPd1nte24ZB52Dcj+jDrjKRG7BtovOALnxWEn+Rg==
X-Received: by 2002:a05:6402:3582:b0:612:b0d9:3969 with SMTP id 4fb4d7f45d1cf-612b0d93f03mr5896841a12.8.1753138796402;
        Mon, 21 Jul 2025 15:59:56 -0700 (PDT)
Received: from [192.168.0.18] (cable-94-189-142-142.dynamic.sbb.rs. [94.189.142.142])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-612c8f543ddsm5962670a12.30.2025.07.21.15.59.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jul 2025 15:59:55 -0700 (PDT)
Message-ID: <bc47c08b-fbc7-4954-8e81-c22bce654556@gmail.com>
Date: Tue, 22 Jul 2025 00:59:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/12] lib/kasan: introduce CONFIG_ARCH_DEFER_KASAN
 option
To: Sabyrzhan Tasbolatov <snovitoll@gmail.com>, hca@linux.ibm.com,
 christophe.leroy@csgroup.eu, andreyknvl@gmail.com, agordeev@linux.ibm.com,
 akpm@linux-foundation.org
Cc: glider@google.com, dvyukov@google.com, kasan-dev@googlegroups.com,
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-um@lists.infradead.org, linux-mm@kvack.org
References: <20250717142732.292822-1-snovitoll@gmail.com>
 <20250717142732.292822-2-snovitoll@gmail.com>
Content-Language: en-US
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
In-Reply-To: <20250717142732.292822-2-snovitoll@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250721_155958_117063_F66CBFCC 
X-CRM114-Status: GOOD (  17.87  )
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



On 7/17/25 4:27 PM, Sabyrzhan Tasbolatov wrote:
> Introduce CONFIG_ARCH_DEFER_KASAN to identify architectures that need
> to defer KASAN initialization until shadow memory is properly set up.
> 
> Some architectures (like PowerPC with radix MMU) need to set up their
> shadow memory mappings before KASAN can be safely enabled, while others
> (like s390, x86, arm) can enable KASAN much earlier or even from the
> beginning.
> 
> This option allows us to:
> 1. Use static keys only where needed (avoiding overhead)
> 2. Use compile-time constants for arch that don't need runtime checks
> 3. Maintain optimal performance for both scenarios
> 
> Architectures that need deferred KASAN should select this option.
> Architectures that can enable KASAN early will get compile-time
> optimizations instead of runtime checks.
> 
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217049
> Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
> ---
> Changes in v3:
> - Introduced CONFIG_ARCH_DEFER_KASAN to control static key usage
> ---
>  lib/Kconfig.kasan | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
> index f82889a830f..38456560c85 100644
> --- a/lib/Kconfig.kasan
> +++ b/lib/Kconfig.kasan
> @@ -19,6 +19,14 @@ config ARCH_DISABLE_KASAN_INLINE
>  	  Disables both inline and stack instrumentation. Selected by
>  	  architectures that do not support these instrumentation types.
>  
> +config ARCH_DEFER_KASAN
> +	bool
> +	help
> +	  Architectures should select this if they need to defer KASAN
> +	  initialization until shadow memory is properly set up. This
> +	  enables runtime control via static keys. Otherwise, KASAN uses
> +	  compile-time constants for better performance.
> +
>  config CC_HAS_KASAN_GENERIC
>  	def_bool $(cc-option, -fsanitize=kernel-address)
>  

This needs to be merged with the next patch where this option at least has some users.


