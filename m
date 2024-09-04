Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70584CD4F4B
	for <linux-um@archiver.kernel.org>; Wed,  4 Sep 2024 22:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=35/vvYnjYcTahPnX2Ak6JC2o1aEV4aWjtE37kGrVzrs=; b=ynhCmwHmLQrPU/bKqPThmzp8Gd
	V9ZkFYVw4wMKsIabAKRRYR29MRefcelmXmWwio62BJzPvER7/1OU6ZqJUuqZt9aJrcRSHN3nI67p9
	ME+gjOtWm8jAtz/X5t/iRRHXRwad02qh32vI0Qznr81dZ2VQcyZvphFw5feqBTy4lgstzRyjQUcRm
	4IwkxgK+gkbH8crrbIikWdTesr080YgW+e6Z3njI3ejDf2j+Boi2Ycn+b5KPJwZ1q6ofw66JW1fr8
	2nBsUlQo32ZT3HFlytH5d7iqh+5AeioDSwTzvKC0ixK+gFM0d2WQiG3V8VbrlytkaPhmXF8eumnh4
	x7vqofbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slyv6-00000006ImB-2naU;
	Wed, 04 Sep 2024 22:56:12 +0000
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slyv3-00000006IlH-02xI
	for linux-um@lists.infradead.org;
	Wed, 04 Sep 2024 22:56:10 +0000
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-7c2595f5c35so27425a12.1
        for <linux-um@lists.infradead.org>; Wed, 04 Sep 2024 15:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20230601.gappssmtp.com; s=20230601; t=1725490568; x=1726095368; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=35/vvYnjYcTahPnX2Ak6JC2o1aEV4aWjtE37kGrVzrs=;
        b=ET3gsle6KJGhBb60Jta/5sU6bXggDz+P1RVA9+c7Hae0RaI5z4QQwB5BTcnCCNzTYz
         86qVoR2yMSrXsmVwUZ9lc8uPfn7lRvZvPSKY8gv6U6fDSS4Eb9UniRsqlWMXv3O486kv
         VKPKV/qQzfGlxalvXr9KQEp7VuW/lhvk7B4FVvunp9fwlakh/+rPE9uZElYcAS53Kjb7
         JUXgaPAvSg+KlGOLWjtfe0duzCwW+g4yjFDx2jCGSYdgINtqNZMCNtYJXKG+2/uyPFDH
         7BZuzzK+aKc0bdTcKuwq+tcZx40Al35PRnviJoSbvgJW0mPdnR21gXCy+jj09Duodn86
         jIBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725490568; x=1726095368;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=35/vvYnjYcTahPnX2Ak6JC2o1aEV4aWjtE37kGrVzrs=;
        b=wfoNgBCtsQFBnDLFahzEYXIteZEGWIwSx27O5R/aUxUr2L84AfVPb/Wip6gne2G6lY
         xWmpIh1+S9Vk8Y5Atb6gFeiQM3QyYUd4NhmFekQ2gzfde9RUmkKldzMtQj3xd/B6wrm7
         hIlq2dqszkb3D7B/ZTx+xBu0wWzxfA5OrXB8WHPzKLm8HLBhyuxngIt0yVKpluAfcppd
         og2ufNmDE+2qmmoXx/b65V9frmmoOokasL39ZptKvvi91uNsvPGqfQQdpspSP5Kudks/
         RG1OKD4wcvVfnlURSxiVVj2VLT2ZUe7c0Zdli/TasoFBoJBqV7vMO5aMGpULUwcf+r6g
         MjKw==
X-Forwarded-Encrypted: i=1; AJvYcCXChj8JkGm8hUlgcs/sJysVTQlP+boCWyyYKvsPYX9o5yl6N3V0kmNsChEjinc8tkdSI/8X6ypCqA==@lists.infradead.org
X-Gm-Message-State: AOJu0YyLowC7GFOl6yFztLVrcH6dXvEk5Sg57wcIDVAHNa8lCeLrzS2a
	BqRndrzh6q4GFy6U2itP3zG94d3k/QJNAVmZjBH4sqFImsGf/zJ7Qm7G8UkOiIw=
X-Google-Smtp-Source: AGHT+IGJMJTzWYcjGTZbRrQ6IDaoYzbHR/wGLI0wH+MKCl8eX8iKTnn29gVdjQTwsOFAi2AC/JBGeg==
X-Received: by 2002:a17:902:f545:b0:206:b618:1d8f with SMTP id d9443c01a7336-206b6182580mr23287495ad.11.1725490567622;
        Wed, 04 Sep 2024 15:56:07 -0700 (PDT)
Received: from telecaster.dhcp.thefacebook.com ([2620:10d:c090:500::4:761e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206ae9525cbsm18305395ad.99.2024.09.04.15.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 15:56:07 -0700 (PDT)
Date: Wed, 4 Sep 2024 15:56:04 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Benjamin Gray <bgray@linux.ibm.com>,
	"Christopher M. Riedl" <cmr@bluescreens.de>,
	Christoph Hellwig <hch@lst.de>, x86@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-um@lists.infradead.org, kernel-team@fb.com
Subject: Re: [PATCH 2/2] mm: make copy_to_kernel_nofault() not fault on user
 addresses
Message-ID: <ZtjlhFbeFZtxzmTb@telecaster.dhcp.thefacebook.com>
References: <cover.1725223574.git.osandov@fb.com>
 <f0e171cbae576758d9387cee374dd65088e75b07.1725223574.git.osandov@fb.com>
 <64e74f4d-948d-442e-9810-69907915401c@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <64e74f4d-948d-442e-9810-69907915401c@csgroup.eu>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240904_155609_076308_1498C236 
X-CRM114-Status: GOOD (  25.97  )
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

On Wed, Sep 04, 2024 at 09:50:56AM +0200, Christophe Leroy wrote:
> Hi,
> 
> Le 02/09/2024 à 07:31, Omar Sandoval a écrit :
> > [Vous ne recevez pas souvent de courriers de osandov@osandov.com. Découvrez pourquoi ceci est important à https://aka.ms/LearnAboutSenderIdentification ]
> > 
> > From: Omar Sandoval <osandov@fb.com>
> > 
> > I found that on x86, copy_to_kernel_nofault() still faults on addresses
> > outside of the kernel address range (including NULL):
> > 
> >    # echo ttyS0 > /sys/module/kgdboc/parameters/kgdboc
> >    # echo g > /proc/sysrq-trigger
> >    ...
> >    [15]kdb> mm 0 1234
> >    [   94.652476] BUG: kernel NULL pointer dereference, address: 0000000000000000
> ...
> > 
> > Note that copy_to_kernel_nofault() uses pagefault_disable(), but it
> > still faults. This is because with Supervisor Mode Access Prevention
> > (SMAP) enabled, do_user_addr_fault() Oopses on a fault for a user
> > address from kernel space _before_ checking faulthandler_disabled().
> > 
> > copy_from_kernel_nofault() avoids this by checking that the address is
> > in the kernel before doing the actual memory access. Do the same in
> > copy_to_kernel_nofault() so that we get an error as expected:
> > 
> >    # echo ttyS0 > /sys/module/kgdboc/parameters/kgdboc
> >    # echo g > /proc/sysrq-trigger
> >    ...
> >    [17]kdb> mm 0 1234
> >    kdb_putarea_size: Bad address 0x0
> >    diag: -21: Invalid address
> > 
> > Signed-off-by: Omar Sandoval <osandov@fb.com>
> > ---
> >   mm/maccess.c | 3 +++
> >   1 file changed, 3 insertions(+)
> > 
> > diff --git a/mm/maccess.c b/mm/maccess.c
> > index 72e9c03ea37f..d67dee51a1cc 100644
> > --- a/mm/maccess.c
> > +++ b/mm/maccess.c
> > @@ -61,6 +61,9 @@ long copy_to_kernel_nofault(void *dst, const void *src, size_t size)
> >          if (!IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS))
> >                  align = (unsigned long)dst | (unsigned long)src;
> > 
> > +       if (!copy_kernel_nofault_allowed(dst, size))
> > +               return -ERANGE;
> > +
> >          pagefault_disable();
> >          if (!(align & 7))
> >                  copy_to_kernel_nofault_loop(dst, src, size, u64, Efault);
> > --
> > 2.46.0
> > 
> 
> This patch leads to the following errors on ppc64le_defconfig:
> 
> [    2.423930][    T1] Running code patching self-tests ...
> [    2.428912][    T1] code-patching: test failed at line 395
> [    2.429085][    T1] code-patching: test failed at line 398
> [    2.429561][    T1] code-patching: test failed at line 432
> [    2.429679][    T1] code-patching: test failed at line 435
> 
> This seems to be linked to commit c28c15b6d28a ("powerpc/code-patching: Use
> temporary mm for Radix MMU"), copy_from_kernel_nofault_allowed() returns
> false for the patching area.

Thanks for testing. This patch isn't worth the trouble, so we can drop
it.

Thanks,
Omar

