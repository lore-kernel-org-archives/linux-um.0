Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F26AC4332F
	for <linux-um@archiver.kernel.org>; Thu, 17 Nov 2022 00:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yMw5fxGY1p2h/KXFfbAPV7iCUjQYbLBZtZUT7oyi98c=; b=c7vvvBExsKpv6O
	7Bo2HAw9tcI4WNFQIIeBgGNI+AzKpGb4YfbjjpOnNoNclNLCB47VqzVVv+YTdVIz33RzfAElmrjTJ
	YsdAjrUsnwZoFXxniEXveNkAHm1c7QexPtepDOcMR+ZWKxqrP6+4Npy2mG/ojXokXe3a+34Nj8nVz
	T/9TxYXSh+AaTuZ2ColmsTilyQUtdut63dyJVTlW1XpwolG2PbfRRG/n1mvjw17H377Fm56hfnQ2c
	gPDFcmPoHuzfwJUWvJehLjdDIUaycfgcU6odfvp2ggEjXb4DqIrzZdWHaHicr6A0HHHu8bCmHUxhu
	0rFSRTdIBOlG5uM3T7Hw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovT20-009ESx-CS; Thu, 17 Nov 2022 00:45:28 +0000
Received: from mail-qk1-x734.google.com ([2607:f8b0:4864:20::734])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovT1y-009EQl-82
	for linux-um@lists.infradead.org; Thu, 17 Nov 2022 00:45:27 +0000
Received: by mail-qk1-x734.google.com with SMTP id x18so238450qki.4
        for <linux-um@lists.infradead.org>; Wed, 16 Nov 2022 16:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HEOs2OljVpzFekHebtNmxJNTS1biZDzbDC+7E+gbGXE=;
        b=NKUDG6/HRBHYArrki2ErKlKAFAloDP3syGXEvUqNJ9D2fVrZim0dI4zYfgnJWEKy+2
         eIgPOs+mttvXhYUIJL/UppN4gHtQqcQpWlrONSgHhATtfRfLqa70r2Y5AFUtDhoXumLz
         QwAO0SpqErl+SpXb2isD+wqK260zhrI3m0OcjGKZmRIuadG54e+ieDR5HURAecTq4gww
         +4XuPNBvBD2G5dec/bz8Eh9V9EDh1RbiHGn8GIrcO4V8END9r1k5y0xfRAbT/lxmG9Cm
         d4SXiY9+ZupOQT/Gb+ZePnA6lwtOPkxvxI9tRVsC2WHBPZX7s+xnX8nZsTymxhqmYSZB
         7vEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HEOs2OljVpzFekHebtNmxJNTS1biZDzbDC+7E+gbGXE=;
        b=sCFquuKWiM/AyRDS7VNlZys5Yb0cu1Tlik1lkmzYJb5Z0qbemG1ntZIA7RVkt+fkO5
         zAMNWXctADXaR8E0NQVXIRwG1BkZdZgDmjfyrxH4lMEHGM8UUrPYtBoRS65dwVEqbDPQ
         QN/c+AXmmF5xHdtOM0BWVs2h29XpuQTNw4N/Q9Ic5cHh4GyaP10iR+8mAHRtiLCdSHez
         4x9zbYiW9BWDgFeDgK3yrT54cEJX+jjUWdhIFQeuITHCRlZwiEvxEQoelKTpC3mdbsQW
         PIS22Wg4q9toCjvk1jNhL1Ah9iPNDF8/LWl7AnlIKUeJDmyNUzmh0p2lWpybDmJCkwak
         Er+A==
X-Gm-Message-State: ANoB5plmap9xxBkNa+c/0ckrWadQgaEOZL0AwYvukhPiTffuKZhQP1YC
	sVfYYpz1LAUYqhZcIuxAcs1tfg==
X-Google-Smtp-Source: AA0mqf7xjJLeTnaPhhrans4JhE0iVba1LlwPzkyl9vYE07B6pyjsI7ODbIFQEN1WHHyVUFKfNxMUWg==
X-Received: by 2002:a05:620a:1455:b0:6ee:80b5:32d3 with SMTP id i21-20020a05620a145500b006ee80b532d3mr22079595qkl.237.1668645923644;
        Wed, 16 Nov 2022 16:45:23 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-122-23.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.122.23])
        by smtp.gmail.com with ESMTPSA id n7-20020ac86747000000b00399ad646794sm9480378qtp.41.2022.11.16.16.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 16:45:22 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1ovT1t-0066TN-E8;
	Wed, 16 Nov 2022 20:45:21 -0400
Date: Wed, 16 Nov 2022 20:45:21 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-ia64@vger.kernel.org, linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
	linux-um@lists.infradead.org, etnaviv@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-samsung-soc@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-media@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-perf-users@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Hugh Dickins <hughd@google.com>, Nadav Amit <namit@vmware.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Matthew Wilcox <willy@infradead.org>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Muchun Song <songmuchun@bytedance.com>,
	Shuah Khan <shuah@kernel.org>, Lucas Stach <l.stach@pengutronix.de>,
	David Airlie <airlied@gmail.com>, Oded Gabbay <ogabbay@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Christoph Hellwig <hch@infradead.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH mm-unstable v1 10/20] RDMA/umem: remove FOLL_FORCE usage
Message-ID: <Y3WEIVROhUPTtaeQ@ziepe.ca>
References: <20221116102659.70287-1-david@redhat.com>
 <20221116102659.70287-11-david@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221116102659.70287-11-david@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221116_164526_299796_9BAE936F 
X-CRM114-Status: GOOD (  13.26  )
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

On Wed, Nov 16, 2022 at 11:26:49AM +0100, David Hildenbrand wrote:
> GUP now supports reliable R/O long-term pinning in COW mappings, such
> that we break COW early. MAP_SHARED VMAs only use the shared zeropage so
> far in one corner case (DAXFS file with holes), which can be ignored
> because GUP does not support long-term pinning in fsdax (see
> check_vma_flags()).
> 
> Consequently, FOLL_FORCE | FOLL_WRITE | FOLL_LONGTERM is no longer required
> for reliable R/O long-term pinning: FOLL_LONGTERM is sufficient. So stop
> using FOLL_FORCE, which is really only for ptrace access.
> 
> Tested-by: Leon Romanovsky <leonro@nvidia.com> # Over mlx4 and mlx5.
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Leon Romanovsky <leon@kernel.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  drivers/infiniband/core/umem.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
