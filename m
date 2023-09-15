Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4552DEE644B
	for <linux-um@archiver.kernel.org>; Fri, 15 Sep 2023 09:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ci9KpB3DOV2RIXFNQ01ql5ZoNB4LrB22K4mnD+Pehlo=; b=guUrVQvNz5FtYu
	S8HD2dp26MN8gSl56DlyxL6GUXPFDPtUNaG7PFKq/IsmdiiMHrEPY7LIwGg0EGTtngCLskM5u1sgF
	tAoQN8kfQk57r1FOiaKzmP4yz+fIqe4J3CDwIkeNCzRHk084VuDd37ZGr1nBeara3Y23Ym3lrnGUK
	sjuU1tEL6g5UmxUMJvZgVo6NjwLNWKjjh8WU2tak+dg2mrvahBcRRTCySlPkOdbVl9DRan2cIMoK2
	gTyvHPL9GztL7T0VoZAIekZhytvZVGAqMF2i05Heib5srTr8VN9fGtFQo8dCK6yz4J7yNMwQRIFiV
	ePDZXJwLI91zdY/OssqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qh5Bw-00AHmH-2N;
	Fri, 15 Sep 2023 09:32:48 +0000
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qh5Bt-00AHl6-1t
	for linux-um@lists.infradead.org;
	Fri, 15 Sep 2023 09:32:47 +0000
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-31f7638be6eso1763604f8f.3
        for <linux-um@lists.infradead.org>; Fri, 15 Sep 2023 02:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694770361; x=1695375161; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HETKbupRhTYs1z9MLvczngFisFfV/0QzW50/Eiut1z4=;
        b=Q8gjNQx6mKh7XSpig1+UBf17R+0l1g61sbM9KgjvOYwY9FaEd+7EqLp4XDih4TDwrG
         1ND2rc+eCUUTGUhEUaG0/Ui2mQCO8ODx8zlfG885BXOeR23alSl6eASyx/RFjKVu/epT
         TJvuN/gbDwWq+qtr9lZOkVmJMPeLLsIdqZGwxONvQT9sSsDTL9lJOhGGzQYu6fO55vch
         ugKe30zuO/mTIdFI3QzQGlxJeCqkhc2TphW/EFhJYVOWATnZct7yFpCKFCy2xAqtFNx7
         MbtYqzMDkxIa8kVnpz6J49EYEdnJW/7CzI/Q/quPDLFl+VC6L9V39CRqVCvsARY7k6Zc
         OZYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694770361; x=1695375161;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HETKbupRhTYs1z9MLvczngFisFfV/0QzW50/Eiut1z4=;
        b=H011WDlscJdnMSkwWta0rBpxQz7U/oj/eOVx4vpXXSmpV1msmVnI8bvsiOR4xjJF6v
         cXqzTtZVLYY1WnF/UDbMLWBf2iVm6YY8WGvZo05JQXnjUksD88d9smQHU80h+0k6Phmz
         2+mirInfBRrSTBiLvd1dhUo5ashJpJJZgV5RPTUjycJry7Foz8yBjcq0rYgyIaNhW1P3
         TpmeyXq4qsbAvm/H3NYIzRbJZx4gj23ojGEjVDUDIHB2FsUNLWDC0JDkt3cILg28oy0P
         mWRt9TR5KZL1wu1avcPNf9MtISfR+Rltf3qyN+6+EOPzY8NE6GiIOgWTNFV4NPf0rIAP
         j2Xw==
X-Gm-Message-State: AOJu0Yy9DiQbQDxR11/oe1PG/XR1LODqRivPPmLs/5agD/O7+WVm1LVw
	JmXu3jJvO9/zswAJBNQHVnQ=
X-Google-Smtp-Source: AGHT+IHCTwneR8c2SNEnOg6XrWMjyFnTAG+5GiPew/rJysjCFZm8QIppYR64TsM2ynWOerEhQPwQdA==
X-Received: by 2002:adf:f7c4:0:b0:31f:ea18:6f6b with SMTP id a4-20020adff7c4000000b0031fea186f6bmr1120906wrq.19.1694770361264;
        Fri, 15 Sep 2023 02:32:41 -0700 (PDT)
Received: from gmail.com (1F2EF265.nat.pool.telekom.hu. [31.46.242.101])
        by smtp.gmail.com with ESMTPSA id c18-20020a5d4cd2000000b0031762e89f94sm3902903wrt.117.2023.09.15.02.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 02:32:40 -0700 (PDT)
Date: Fri, 15 Sep 2023 11:32:38 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
	kernel@axis.com
Subject: Re: [PATCH v2] x86: Fix build of UML with KASAN
Message-ID: <ZQQkthfNuV3dOhZe@gmail.com>
References: <20230915-uml-kasan-v2-1-ef3f3ff4f144@axis.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230915-uml-kasan-v2-1-ef3f3ff4f144@axis.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230915_023245_640324_52EB7035 
X-CRM114-Status: GOOD (  18.73  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org


* Vincent Whitchurch <vincent.whitchurch@axis.com> wrote:

> Building UML with KASAN fails since commit 69d4c0d32186 ("entry, kasan,
> x86: Disallow overriding mem*() functions") with the following errors:
> 
>  $ tools/testing/kunit/kunit.py run --kconfig_add CONFIG_KASAN=y
>  ...
>  ld: mm/kasan/shadow.o: in function `memset':
>  shadow.c:(.text+0x40): multiple definition of `memset';
>  arch/x86/lib/memset_64.o:(.noinstr.text+0x0): first defined here
>  ld: mm/kasan/shadow.o: in function `memmove':
>  shadow.c:(.text+0x90): multiple definition of `memmove';
>  arch/x86/lib/memmove_64.o:(.noinstr.text+0x0): first defined here
>  ld: mm/kasan/shadow.o: in function `memcpy':
>  shadow.c:(.text+0x110): multiple definition of `memcpy';
>  arch/x86/lib/memcpy_64.o:(.noinstr.text+0x0): first defined here

So the breakage was ~9 months ago, and apparently nobody build-tested UML?

Does UML boot with the fix?

> UML does not use GENERIC_ENTRY and is still supposed to be allowed to
> override the mem*() functions, so use weak aliases in that case.
> 
> Fixes: 69d4c0d32186 ("entry, kasan, x86: Disallow overriding mem*() functions")
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> ---
> Changes in v2:
> - Use CONFIG_UML instead of CONFIG_GENERIC_ENTRY.
> - Link to v1: https://lore.kernel.org/r/20230609-uml-kasan-v1-1-5fac8d409d4f@axis.com
> ---
>  arch/x86/lib/memcpy_64.S  | 4 ++++
>  arch/x86/lib/memmove_64.S | 4 ++++
>  arch/x86/lib/memset_64.S  | 4 ++++
>  3 files changed, 12 insertions(+)
> 
> diff --git a/arch/x86/lib/memcpy_64.S b/arch/x86/lib/memcpy_64.S
> index 8f95fb267caa..47b004851cf3 100644
> --- a/arch/x86/lib/memcpy_64.S
> +++ b/arch/x86/lib/memcpy_64.S
> @@ -40,7 +40,11 @@ SYM_TYPED_FUNC_START(__memcpy)
>  SYM_FUNC_END(__memcpy)
>  EXPORT_SYMBOL(__memcpy)
>  
> +#ifdef CONFIG_UML
> +SYM_FUNC_ALIAS_WEAK(memcpy, __memcpy)
> +#else
>  SYM_FUNC_ALIAS(memcpy, __memcpy)
> +#endif
>  EXPORT_SYMBOL(memcpy)

Meh, the extra 3 #ifdefs are rather ugly and don't really express UML's 
expectations here.

So how about introducing a SYM_FUNC_ALIAS_MEMFUNC() variant on x86 in a 
suitable header, which maps to the right thing, with a comment added that 
explains that this is for UML's mem*() functions?

Thanks,

	Ingo

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
