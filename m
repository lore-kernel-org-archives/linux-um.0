Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BABF1CD4F26
	for <linux-um@archiver.kernel.org>; Fri, 26 Jun 2026 10:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cT0BDtDugceKAggCQsSGYTrTPkbadSs08NjvUXAN76c=; b=ARQ7vTZRIf+mCwVJGyfEqcDARn
	8iFWslnkTrHpNLcXkftrMXPgXdqv19Ky75772u4r2IHTtKsYMAXr/7m35cO3af8BL/aS+hiOhwZzn
	+OTnP+c/vPv8+dzmMXqPvnPi7JZuKwlp4ZgSHwynmA5wxxNnD3qilhmdljExv0vEhCsLtiM1mk6Gu
	mjk/VwJ4X7iPFHVgFTYT0x/WVZECcgyGnywvO+9ZO4ofUz2HU/uL04TY8hKN7F1o4liFj7RS3hznk
	FmOPdrWD4xSCEAs4gIZggF5FnSMIYTPT/Dn8JF7qVgOhhzTPrmHM1tmyUgktbStmfyDCstRKFfrUw
	WblNupAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wd48K-0000000B8ex-321y;
	Fri, 26 Jun 2026 10:50:04 +0000
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wd48H-0000000B8eD-3Hrl
	for linux-um@lists.infradead.org;
	Fri, 26 Jun 2026 10:50:02 +0000
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-490b9318997so6237365e9.2
        for <linux-um@lists.infradead.org>; Fri, 26 Jun 2026 03:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782471000; x=1783075800; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cT0BDtDugceKAggCQsSGYTrTPkbadSs08NjvUXAN76c=;
        b=WrZvsLn7/X5MKkErTGFR7LHkvXlQKBp8+GW76s7shuYGNN8jcR7zayMAFWbfcKgPIO
         urInT8x/N1gZfycN+eqzb3VQKP29cpGCyNu22htX/4Wyp6u/gcVdilwy1VUuwV//mxCH
         DgHyXlYppnJrD9VKQO9CZ/aVT3aXXenc7NKT8bcPVDxZMAHbKG36aMC0tKDtCqBirmeo
         DXg5ivnBjR/eiw5SnKsPkdPtkiw793yQa4u0/WCQN0GpcBZOngQO9GFlZLuZTgi+l4pi
         1F9yCdgFvSKnoFLAn4EhzgRu/Ysz9cJOvenEmPYeIlYvnDcVH76qZiSB+aUCka5Bcc8i
         BvSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782471000; x=1783075800;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cT0BDtDugceKAggCQsSGYTrTPkbadSs08NjvUXAN76c=;
        b=H/rzZMzw12R+ZtiFBTTrhlFdBf1uFWeO+hh6W2zjBOvEbu6GDfxH12g8UDj0UrIuBS
         q47ypEmyvy75qXBN12wfn4IKrKgA889hwpofXpVnNFLTvkQtyHqetP8z/AG4VS+5SMER
         w/3dEFOwU9BLfGeNmLBR3D8b+obWWnStVWa1MFVVz5FoorrJ9zaPj4DHj7Wm/Fn+VSnE
         3vBoi1IIOto8zZHSz7y6gk5DJ8RGJ+BLZdhLlAyFzjZWBLlc7k1UJ40WbMcwJPh4jiiU
         k/I33BjXrhJZMXLPpBhd2643lMEc9mXaGA8eSnfSjL1YLQjSZaQoHjx6pr+FMfn5ywtP
         xfcQ==
X-Forwarded-Encrypted: i=1; AFNElJ8LcHwDtN8NtLcOk6tiOba2sLiUy9lUPa3nvA7x2QFmU/0otY9wpsaSGV4MTxP09rkCKFzkO01h1w==@lists.infradead.org
X-Gm-Message-State: AOJu0YzCf740GpLGJ34p1cpZ0VLGbSGrjKyndPKWpl3Qx0qniiBj+lqB
	fQdFF+qn8fKNOGxkS4XfCb0gsVJ/dGX63dhtbsygz5RgaPJAUZiTj4PzSBZYXede
X-Gm-Gg: AfdE7cn6mKDOpcKKbPp/ZInTlQrjSAr1mQaXDKkmLXyBTMJqA+HrAD4bBm+XcHOavQh
	7PBlcNHj0InGJPgBKYFEopa4Vwei4cFYF/umv0YTGE6Pe2IyDaRjkhr+SWE0qdOp0sum9giKgbF
	xsCzJBld/8JMdqTlPVq0eM2B909A4a+kXiUUCKkQWOUGR4uPdsS9UPFkr7nflF673sibPKXKWSX
	TKtchMmq9b84/2G21XVuI4XpueVPSZMTkNZtAhfY6cqv7M38Ac/n1hpxsLUwM2dyN3IjumytOZ3
	Db1xG57skP6niGSJTXn4UcP+eSGfcU5MCqPW7rUak4qSSgGtRtTR0kVXBboJzOwGnNplsD2XC76
	DhyFfGrzCO7Dgx3zSJ21N+eBRapV8gKJlFdPKiYPZnX81EkObvzeLfmWprSyJ+O5GQX8bhkDTNp
	2E5Eq6Fvs7I9onGINr0bmA2ObvJP2YwoLebsIhcvPB/7qiPJwbWQ==
X-Received: by 2002:a05:600d:8494:20b0:490:5cb3:e94a with SMTP id 5b1f17b1804b1-4926684a83fmr72058605e9.2.1782470999554;
        Fri, 26 Jun 2026 03:49:59 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46c221d9371sm25352587f8f.21.2026.06.26.03.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 03:49:59 -0700 (PDT)
Date: Fri, 26 Jun 2026 11:49:57 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Eric Biggers <ebiggers@kernel.org>, x86@kernel.org,
 linux-um@lists.infradead.org, linux-raid@vger.kernel.org,
 linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, Christoph
 Hellwig <hch@lst.de>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/8] um: Check for missing AVX and AVX-512 xstate bits
Message-ID: <20260626114957.1a2b7e5b@pumpkin>
In-Reply-To: <6a20b442-b97f-4cae-9168-30201d5ef82c@cambridgegreys.com>
References: <20260626043731.319287-1-ebiggers@kernel.org>
	<20260626043731.319287-3-ebiggers@kernel.org>
	<20260626084113.42eae31c@pumpkin>
	<6a20b442-b97f-4cae-9168-30201d5ef82c@cambridgegreys.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260626_035001_871477_6C6A2212 
X-CRM114-Status: GOOD (  21.34  )
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

On Fri, 26 Jun 2026 09:21:49 +0100
Anton Ivanov <anton.ivanov@cambridgegreys.com> wrote:

> On 26/06/2026 08:41, David Laight wrote:
> > On Thu, 25 Jun 2026 21:37:25 -0700
> > Eric Biggers <ebiggers@kernel.org> wrote:
> >   
> >> If the CPU declares AVX or AVX-512 support, verify that all the
> >> corresponding xstate bits are also set.  If any are missing, warn and
> >> don't set the corresponding X86_FEATURE_* flags.
> >>
> >> This eliminates the perceived need for UML-supporting AVX and AVX-512
> >> optimized code in the kernel (that is, lib/raid/ currently) to start
> >> checking the xstate bits in addition to X86_FEATURE_AVX*.
> >>  
> > ...  
> >>   static void __init parse_host_cpu_flags(char *line)
> >>   {
> >> +	u64 xcr0 = read_xcr0();
> >>   	int i;
> >> +
> >>   	for (i = 0; i < 32*NCAPINTS; i++) {
> >>   		if ((x86_cap_flags[i] != NULL) && strstr(line, x86_cap_flags[i]))  
> > 
> > 'line' comes from /proc/cpuinfo
> > Surely something would be terribly wrong if that included something the kernel
> > had disabled (or didn't support).
> > 
> > 	David
> > 
> >   
> >> -			set_cpu_cap(&boot_cpu_data, i);
> >> +			validate_and_set_cpu_cap(i, xcr0);
> >>   	}
> >>   }
> >>   
> >>   static void __init parse_cache_line(char *line)
> >>   {  
> > 
> > 
> > 
>  >  
> Lots of other stuff will go wrong before that. Glibc, things compiled with LLVM, python, perl, etc.
> 
> Half of the userland will go belly up, because AVX is used in string operations and hashing if it is available.

And glibc will check xcr0.

> 
> UML is just another userland application from this perspective, so there is no reason for it to behave any different from the rest of the userland.


