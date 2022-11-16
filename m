Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5851C433FE
	for <linux-um@archiver.kernel.org>; Wed, 16 Nov 2022 10:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Xu/b7cN87VYKfZrV9jxZq5rwlKo+L73aKLAexobUGT0=; b=E58Ql974cJPKbp
	z0n1GZdojGtzkpF90JF8rT78wFzU49iaqcp2eG7qQvEMYzLwtrtydjVmTMfFp0KHPDNuPvRHYzzYl
	shSqZ9aCJ0YcOqHnNv5lf15Nf6CeXdToyhCvucJ4cgmHtKWVC+1LU/hcPIgFfMosMobbbTKgk5w4S
	C0NJiafoNUZFvwNrPDzeRTJUe6NNo0289gMmxn2CMP19N2+ZJ9ifK8l7DJz0j1T+HNQWmhoDb6Z1N
	oA4L6GHYxfMlexQeun+ahZCEt03Bg0kmKsmfMRsoR42MwHNeEb43SlXEPK7KggGffhp6zIfiIGE8X
	c6WlUWmdE6meztfmHLxA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovG3T-002UZQ-J0; Wed, 16 Nov 2022 10:54:07 +0000
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovG0T-002ST0-G5
	for linux-um@lists.infradead.org; Wed, 16 Nov 2022 10:51:03 +0000
Received: by mail-ed1-x532.google.com with SMTP id v27so25987265eda.1
        for <linux-um@lists.infradead.org>; Wed, 16 Nov 2022 02:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NMt8HjKxItO2J6bIbRsCvEdSlAZpP8uC48lcisou+nI=;
        b=eLnGvKK+w1XqLxzowLTo19VxBdUCyRC3jZCwBMpKaUWXXlLi4fs0Axmuul/wRN/I3k
         Ls2daX/AS8NBqlkGiJqqxb0gEFzgn6n0a6+XnpTDtipAc3J5NayuL7HDBO33beS0D75x
         K2gRZhVXeM0+lA+7zcbmJS/RVo1YdOeZ/sxms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NMt8HjKxItO2J6bIbRsCvEdSlAZpP8uC48lcisou+nI=;
        b=WCum2Wt3Gsw3bBhKk6thkVyAOTkzWfmbyq2fzDIAn8DyPMs2YE1+v16aZlMrxqUIVZ
         Wun2xp+6fwP29plBLvEkOEvocdeSEfe2M2HRMBRe79CRqmOeRx5Da86Izl6A8lGX7yWw
         +IozAPBJp7ZCmad9WY2s+Ilr1F8hvEJ/aLcy0p25lWvqJ4srZ9UQGn7lIVQ/LXFVUxhm
         rBVC2nvL91rA/KzEGywwWBdRX44YKqwVeGyXKdzyG8Vtx9/LxIzomcALlWHvjgDZfIYH
         jCZoIPvqcuHm0OEsNMyTeZuVbaVGpSCNKi7gccm/AtliAwItVQf6wsp19BzUC+Z6/ZUx
         LVDg==
X-Gm-Message-State: ANoB5plpSBSxZkxjfHZ9Z9bTWGIlJ2gCaNxYTkYlidTq2viZw1MaWvdw
	U5OMcrQ0FFeqX2/DTJ5wOTfQfA==
X-Google-Smtp-Source: AA0mqf4Z9KF9DYfdJQdqGvbtRloYOPQXnN3MkKcJxdOs80iDic7Ysg9e6qfGKtqJuC+1emfUPfQ+gw==
X-Received: by 2002:a50:ff04:0:b0:462:709:9f7b with SMTP id a4-20020a50ff04000000b0046207099f7bmr19331341edu.263.1668595860175;
        Wed, 16 Nov 2022 02:51:00 -0800 (PST)
Received: from phenom.ffwll.local (212-51-149-33.fiber7.init7.net. [212.51.149.33])
        by smtp.gmail.com with ESMTPSA id s6-20020a170906bc4600b007aed2057eaesm6056420ejv.161.2022.11.16.02.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 02:50:59 -0800 (PST)
Date: Wed, 16 Nov 2022 11:50:57 +0100
From: Daniel Vetter <daniel@ffwll.ch>
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
	Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
	Peter Xu <peterx@redhat.com>,
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
	Inki Dae <inki.dae@samsung.com>,
	Seung-Woo Kim <sw0312.kim@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH mm-unstable v1 17/20] drm/exynos: remove FOLL_FORCE usage
Message-ID: <Y3TAkWy/xXfX1cIv@phenom.ffwll.local>
Mail-Followup-To: David Hildenbrand <david@redhat.com>,
	linux-kernel@vger.kernel.org, x86@kernel.org,
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
	Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
	Peter Xu <peterx@redhat.com>,
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
	Inki Dae <inki.dae@samsung.com>,
	Seung-Woo Kim <sw0312.kim@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20221116102659.70287-1-david@redhat.com>
 <20221116102659.70287-18-david@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221116102659.70287-18-david@redhat.com>
X-Operating-System: Linux phenom 5.19.0-2-amd64 
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221116_025101_645058_0352AFFF 
X-CRM114-Status: GOOD (  23.45  )
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

On Wed, Nov 16, 2022 at 11:26:56AM +0100, David Hildenbrand wrote:
> FOLL_FORCE is really only for ptrace access. As we unpin the pinned pages
> using unpin_user_pages_dirty_lock(true), the assumption is that all these
> pages are writable.
> 
> FOLL_FORCE in this case seems to be a legacy leftover. Let's just remove
> it.
> 
> Cc: Inki Dae <inki.dae@samsung.com>
> Cc: Seung-Woo Kim <sw0312.kim@samsung.com>
> Cc: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Plus ack for merging through the appropriate non-drm tree.
-Daniel

> ---
>  drivers/gpu/drm/exynos/exynos_drm_g2d.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_g2d.c b/drivers/gpu/drm/exynos/exynos_drm_g2d.c
> index 471fd6c8135f..e19c2ceb3759 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_g2d.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_g2d.c
> @@ -477,7 +477,7 @@ static dma_addr_t *g2d_userptr_get_dma_addr(struct g2d_data *g2d,
>  	}
>  
>  	ret = pin_user_pages_fast(start, npages,
> -				  FOLL_FORCE | FOLL_WRITE | FOLL_LONGTERM,
> +				  FOLL_WRITE | FOLL_LONGTERM,
>  				  g2d_userptr->pages);
>  	if (ret != npages) {
>  		DRM_DEV_ERROR(g2d->dev,
> -- 
> 2.38.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
