Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82A3FC3DA63
	for <linux-um@archiver.kernel.org>; Tue, 23 Jul 2024 03:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=z8drHD9Jhai5CXRn1c7yaLoe/54xU5BshWoGMTrI9n8=; b=IODycApSNE+UlchEZYSqQ8xoXk
	tphcfykuW3gVtQ9fe730Hulhx3Cmgr0imJ30U39jseaaghZXHkDSSpdH1y1tfW5wxAh0nUiAV5q5y
	x9SXwHD8HHCpj/sc0YT6gh8w81mzzzLkdHdvOSRxozK9pLEbGFX0pk+TD7o4PsgvnxfgFPfXy6QSR
	z1CJfoARBk9V6ecKOPkb8BWCZ9sTazijFvZy7kWpMiq/D/Ku+TQxjXjw6P95o6j1dWAKxodXJVNG0
	K+HAKLKUaOxWe/HjdJBRBUAWJISAHbHKyZMHtyMuerkKXHH1Fg+32wtytwCDzdRa+BWnt0ocQhqki
	nC2DQCeg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sW6Qh-0000000BEyN-05Wm;
	Tue, 23 Jul 2024 03:43:11 +0000
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sW6Qe-0000000BExm-0IuA
	for linux-um@lists.infradead.org;
	Tue, 23 Jul 2024 03:43:09 +0000
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-52efd855adbso3287663e87.2
        for <linux-um@lists.infradead.org>; Mon, 22 Jul 2024 20:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721706186; x=1722310986; darn=lists.infradead.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z8drHD9Jhai5CXRn1c7yaLoe/54xU5BshWoGMTrI9n8=;
        b=nL6NdislOCDV5E1J6ZLC+6fYSjKos0YSCjAPk5A5lfy2VPWpn89gOH354Vt0yjBHVP
         xU3nz47rGJWu84PDggaqMYD9CaQowHdxkaHHqXtYKghOdvMgosYl+t8/IfYCuYJJTE71
         dHsuIUXXPZSGg+xi8gV3XZEsQOUuvHPw857BAnrsM28jx7OLEsvMA7u2iIeS8HIAXyq2
         sfdI5VapxUwaGQIrV/wpP3wvyHAOtRSmbRmUEKkufYf3jtKGURymSbdmv7pGc+aGtTtS
         8Pezo5HcQ/aQ+o7sgsEO52L+Irdxvm5zRiHBa2FY6eyHiW+bPPuPqEMX1fmebNyxgFRx
         7b+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721706186; x=1722310986;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z8drHD9Jhai5CXRn1c7yaLoe/54xU5BshWoGMTrI9n8=;
        b=ovpAzBOgAp6A7uYYZW+3+MFiLsSgxkm7gxwTp85mUerzHtxpmrk+S6i5Kke6FCgvSF
         dBTkeujsolGWFuQPTZVJS/m+3etKYSk/GBZZdeLV8GbXbxWgXzJezvArK2p6u61Ze6i0
         w3yFKau7rKgbAgkLkbQ3V6yESqLj4+4REyP8H0VZ7orna5Ip2BjxVjX6ABEgQj8uZyv6
         yWaAM93xodjDaHwIgn15oVTaaV3L+n7W+ndqpTLY4L8qxN/SUtyJ+b0kp1a0z8pTaVeG
         oVPsQlAsjsJsVVo9msyzWbaH/eCqs0moMYwu7QztORwXeuy9oTD9yLSKeTTH13+0cudM
         Qy+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUBfegW0KAtFfDvppNrdZ15i911Gb9iV2BNo32XmbPmVgldxvgdB3Gf+LKcZq63EcfdSStBJ+Dd/udoykuvg9xmn2Xo0XJCBTLXWfUM
X-Gm-Message-State: AOJu0Yz8SpeYsc+Q3QmCB0S0wtQc52sqMw2/C6gcqdIZ6g6petf6Ff2R
	PelVsDxxwswbg79FRqtrgPCylmnLdW4AOtI3IAM/b4TAdj1ISPhW
X-Google-Smtp-Source: AGHT+IF32v8kFk8Basd1MM0Ibyww+RyV7twqacJiRpCzVI455Xzz7OyQnvj7SRhtGGtqiOPkiemjbg==
X-Received: by 2002:ac2:4c4d:0:b0:52e:fabf:5adf with SMTP id 2adb3069b0e04-52fc404c831mr829754e87.36.1721706185377;
        Mon, 22 Jul 2024 20:43:05 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7a3c94d7fcsm484033666b.192.2024.07.22.20.43.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Jul 2024 20:43:04 -0700 (PDT)
Date: Tue, 23 Jul 2024 03:43:04 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: richard@nod.at, anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net, linux-um@lists.infradead.org,
	linux-mm@kvack.org, Jeff Dike <jdike@linux.intel.com>,
	Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>,
	Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mike Rapoport <rppt@kernel.org>,
	David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2] um/mm: remove redundant assignment of max_low_pfn
Message-ID: <20240723034304.4kbzxsaapxanxms4@master>
References: <20240615034150.2958-1-richard.weiyang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240615034150.2958-1-richard.weiyang@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240722_204308_152613_A2A60D3B 
X-CRM114-Status: GOOD (  17.24  )
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
Reply-To: Wei Yang <richard.weiyang@gmail.com>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

Would someone pick up this one?

On Sat, Jun 15, 2024 at 03:41:50AM +0000, Wei Yang wrote:
>Current calculation of max_low_pfn is introduced in commit af84eab20891
>("[PATCH] uml: fix LVM crash"). It is intended to set max_low_pfn to the
>same value as max_pfn.
>
>But I am not sure why the max_pfn is set to totalram_pages, which
>represents the number of usable pages in system instead of an absolute
>page frame number. (The change history stops there.)
>
>While we have already calculate it in setup_physmem(), so not necessary
>to do it again.
>
>Also this would help changing totalram_pages accounting, since we plan
>to move the accounting into __free_pages_core(). With this change,
>totalram_pages may not represent the total usable pages at this point,
>since some pages would be deferred initialized.
>
>Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>CC: Jeff Dike <jdike@linux.intel.com>
>Cc: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
>Cc: Alasdair G Kergon <agk@redhat.com>
>CC: Andrew Morton <akpm@linux-foundation.org>
>CC: Mike Rapoport (IBM) <rppt@kernel.org>
>CC: David Hildenbrand <david@redhat.com>
>
>---
>v2: remove redundant assignment of max_low_pfn
>---
> arch/um/kernel/mem.c | 1 -
> 1 file changed, 1 deletion(-)
>
>diff --git a/arch/um/kernel/mem.c b/arch/um/kernel/mem.c
>index ca91accd64fc..a5b4fe2ad931 100644
>--- a/arch/um/kernel/mem.c
>+++ b/arch/um/kernel/mem.c
>@@ -73,7 +73,6 @@ void __init mem_init(void)
> 
> 	/* this will put all low memory onto the freelists */
> 	memblock_free_all();
>-	max_low_pfn = totalram_pages();
> 	max_pfn = max_low_pfn;
> 	kmalloc_ok = 1;
> }
>-- 
>2.34.1

-- 
Wei Yang
Help you, Help me

