Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1850ECE79A8
	for <linux-um@archiver.kernel.org>; Tue, 19 Sep 2023 21:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=P/fSOLPyOVgLQSKouOtf+ZQK9AmdZ1MtEG6yLCK+moE=; b=N+k8kmID5ndp01
	hy4Kiq7iGpaH74d0gosGXQfFcRdyrmJPCvdRLM4yW2ttJIJBOQf7+E2wh1dxCehDIoIkOGePQXDrX
	NW730SdgNFBvGVb9ZUfW0aNRBetg/UpgdR9IU3f7oj+4r/PikrtG+M6RO7sbkCpopYtjmp3X2h0Pr
	z46s23RVzgqeBrbR/QIZg9dvfR4yVMsTR5UaxcDH8CTyh4qbNTZTkmXtlTlfwlkxtDGeKNGIb80RR
	PlD2TF4FIC736K7cnQRbHBvTe0Rff3CA+O9Lks0m37pw/hIqpOyy4R4wAmjksAIJXIbBuALnCuabq
	pYv8Ykc6cStboYBgaLFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qii7P-001HaQ-2U;
	Tue, 19 Sep 2023 21:18:51 +0000
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qii7N-001HYn-0a
	for linux-um@lists.infradead.org;
	Tue, 19 Sep 2023 21:18:50 +0000
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-68fb98745c1so4685402b3a.1
        for <linux-um@lists.infradead.org>; Tue, 19 Sep 2023 14:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695158322; x=1695763122; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zUuiZDmU5EMTeO4CdiXdV5Ryvju9HaBb50QeYalbm10=;
        b=au2n4ftfdUxmpnTXQhU0o3msnzqNWG+RUNKENsJ5aB0iC8nmjtElbSh0nfUBOOOffx
         TK8CtCwwrJOIeAuzVsTB8FTOqzZ4Anq4kjpi7GR25oLsMJzYiISBvNiifR8fHF66G2fw
         /M0jafN7adrjgGGjmmRXrq8EPZn/nll0gl4SEjve94x1aYu68lucCfu4jeWvye4l0Ova
         EsmH2IiGN6XgNPNTuCBChu8we1+/rsTBVqkokU1TKeRKBKfi1EuAz2F/9cU9MjHIUI+G
         Fg4YeDCg4RCDV+ZQmPJeIawjaWEaTpgeLIiW7mGPJE6bMjbb7XDAI2MmD3RUrmRE0+Y8
         QbSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695158322; x=1695763122;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zUuiZDmU5EMTeO4CdiXdV5Ryvju9HaBb50QeYalbm10=;
        b=KCieJut16vtqRDeQOh6SJ1GEx/6IJJ7toKdYswiwdL1Xe3jvCI2O7BbUoXhmKaxROn
         FqkPQ07VD525Hh1iR3i/4p7jC8u4iXMMlfOWZeZ8PJlkmj/Qz+NCH4iXOuUl0BjTqgJ5
         PhQY6uwXa2zh9wbeAHnYxzvFfF96LBl+93bTq2XO16Xb0+6zfzbhGvParkxwDjS83soy
         SytM9sne5iTFXexzQ6qUzZyoS+sRP1G4q2kjMGSLqV/6JypOR8ka7vm+3tVw7pkuTYVG
         fGO5eghNoeyjVLDT8DMhD3yPc79JtaPhnAnps+jj4PeU2SA2bz468pWmnunOZRdjFDTR
         mTeA==
X-Gm-Message-State: AOJu0YzPnnjUPg8amGzN7nzozh+cztBMmy5jF4teovdvqwonKGJsrzq5
	mapEfdsqYd24MaNbWY4sbmRSVgD8vRQcEo0LmQCN8w==
X-Google-Smtp-Source: AGHT+IH6dUDZ77/DJvfNaKnqCuhMLQbO7XX7jFgJOsx/GKqMs+XRvae/XJkRkp1vo0dCwYMw5veKww==
X-Received: by 2002:a05:6a00:4783:b0:690:cd33:a582 with SMTP id dh3-20020a056a00478300b00690cd33a582mr641768pfb.7.1695158321630;
        Tue, 19 Sep 2023 14:18:41 -0700 (PDT)
Received: from google.com ([2620:15c:2d1:203:118e:eaf2:1433:f9fe])
        by smtp.gmail.com with ESMTPSA id v3-20020a62a503000000b00682bec0b680sm9002891pfm.89.2023.09.19.14.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 14:18:40 -0700 (PDT)
Date: Tue, 19 Sep 2023 14:18:36 -0700
From: Nick Desaulniers <ndesaulniers@google.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-um <linux-um@lists.infradead.org>,
	Mike Rapoport <rppt@kernel.org>, llvm@lists.linux.dev
Subject: Re: linux-next: Tree for Sep 19 (UML)
Message-ID: <ZQoQLJnGFxjA8p5E@google.com>
References: <20230919163728.78432283@canb.auug.org.au>
 <04b8a6de-2b20-4488-b20f-c8a8f6001fd2@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <04b8a6de-2b20-4488-b20f-c8a8f6001fd2@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230919_141849_238397_80ED4111 
X-CRM114-Status: GOOD (  15.25  )
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

On Tue, Sep 19, 2023 at 08:42:07AM -0700, Randy Dunlap wrote:
> 
> 
> On 9/18/23 23:37, Stephen Rothwell wrote:
> > Hi all,
> > 
> > Changes since 20230918:
> > 
> > New tree: kvm-ppc
> > 
> > The mm tree gained a boot warning for which I reverted 5 commits.
> > 
> > Non-merge commits (relative to Linus' tree): 5750
> >  3717 files changed, 446028 insertions(+), 107378 deletions(-)
> > 
> > ----------------------------------------------------------------------------
> > 
> 
> on i386 or x86_64:
> 
> ../arch/x86/um/../kernel/module.c: In function 'execmem_arch_params':
> ../arch/x86/um/../kernel/module.c:54:50: error: implicit declaration of function 'kaslr_enabled'; did you mean 'kasan_enabled'? [-Werror=implicit-function-declaration]
>    54 |         if (IS_ENABLED(CONFIG_RANDOMIZE_BASE) && kaslr_enabled())
>       |                                                  ^~~~~~~~~~~~~
>       |                                                  kasan_enabled
> 
> 
> 
> git blames this on:
> 
> commit 12633d679796
> Author: Stephen Rothwell <sfr@canb.auug.org.au>
> Date:   Tue Sep 19 15:14:03 2023 +1000
> 
>     Revert "arch: make execmem setup available regardless of CONFIG_MODULES"
>     
>     This reverts commit 3300c3af20090ff5e03e5c4bf2ef2cfaa03d4e9b.

Thanks for the report, FWIW, our CI is hitting this, too.

Was 12633d679796 a pure revert, or was it manually modified?

Oh 3300c3 was patch 10/13; maybe a clean revert is not possible without
other reverts in addition?
https://lore.kernel.org/lkml/20230918072955.2507221-11-rppt@kernel.org/

Seems like there's more info in this thread:
https://lore.kernel.org/lkml/20230919152031.GF3303@kernel.org/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
