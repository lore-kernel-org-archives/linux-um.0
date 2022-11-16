Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A127C433FE
	for <linux-um@archiver.kernel.org>; Wed, 16 Nov 2022 10:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=INWIfUHFRbl90xzhr0CHQ4JiGdZqRbHtKdBLkiWqp60=; b=CG8b/haI9QQOsC
	T2vKniX3Lay+rYlckATJ3SrS4Sc6KrCyzrjQkO2D8Z3570Jo8OrF3PiVFMmCJNCcC/YW14EskNhLs
	0TgZzH9ohGc5L5opTMgLs9/pod5/C7iu1z7gCqiiHvoUqZF2wNZ20ROVvCF83qC9uuIKign062hxC
	diYZRqLG1nDp4Ceyu6xh65f/00iX6XRekHrvCh9FK6dtT4pw1tYh29KZXfPwgmHFR7unM2uOkNagv
	PFG8vAoGAmv5yPE0WpvWaOjDQcJBIyle7S8Pi/hl+WQiWIdWEEfgQGAA8hh47CJDNnDDkxZEfl8JB
	ET7Mzm55Xd3m7eYZhr7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovFz2-002RFk-4U; Wed, 16 Nov 2022 10:49:32 +0000
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovFyc-002Qnp-89
	for linux-um@lists.infradead.org; Wed, 16 Nov 2022 10:49:08 +0000
Received: by mail-ej1-x632.google.com with SMTP id n20so22495990ejh.0
        for <linux-um@lists.infradead.org>; Wed, 16 Nov 2022 02:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OSCwvxDUrivspPm0mWYSEKkrMB19obOv39RUwyA0PH0=;
        b=VJ17UkTNHUXDMc38lOye7y2paGd4FOYHBRYpe2vgelPuC55Z4g5rnX+xNi0NFRGTrN
         mdMUVKijrbkJJfn3y8Tm8vf3pLdF4omxIOM6UM8S6CVz2p3NrVUPvz4FNRN3RF3rQ/lN
         9z9ibLXy5LDPJfO5cF7QIpPDKsW5E+659K7gg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OSCwvxDUrivspPm0mWYSEKkrMB19obOv39RUwyA0PH0=;
        b=4SLlxnXp6FfBaRtx/f67XOSbEyad3Ah52pVodpyrqYh0rgGvZ7tCXpVVjtCtoomPyq
         B5ZedsO/ioQMH5ZDt9TIwnaUKRCNXuy9FSszi/sZEFWWqWGBQVdN4nuCmS+aDjMSTCD7
         YZzBhNr5vg6d6Y9CQa+3hXo3fvkoEftvOAPdX8c2dUouSqf3uR+8/284/TFk85ITQYvL
         3FzRnm+etuRBWOtDP945IQ9WpEIUtDu4uhck3TDDoU19XoQqhY+WzHt6ds7unSTKec8L
         0c/lnIboHoAubpQrRUPxoyz9luV9kNY5aF6Hf4Fp8+9H58/7KB450VGBwAOFriLtwVD1
         vu3A==
X-Gm-Message-State: ANoB5pmPLDdagvw5mA+WXRiiI0G8g0a18fRqCuvIxs/YmED5P4mYU3un
	3YkOG3uvEOEeiwZVXbl44tiqSQ==
X-Google-Smtp-Source: AA0mqf6lc5lrEzUlEqYgu67h96R4r19JtBnDlqqKBl9ey0VuIf1EYIOTKVPSxvCTipQmxuaB88n35Q==
X-Received: by 2002:a17:906:970e:b0:7ad:ccae:a30d with SMTP id k14-20020a170906970e00b007adccaea30dmr18079730ejx.704.1668595739329;
        Wed, 16 Nov 2022 02:48:59 -0800 (PST)
Received: from phenom.ffwll.local (212-51-149-33.fiber7.init7.net. [212.51.149.33])
        by smtp.gmail.com with ESMTPSA id g13-20020a50ec0d000000b0045b3853c4b7sm7352935edr.51.2022.11.16.02.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 02:48:58 -0800 (PST)
Date: Wed, 16 Nov 2022 11:48:56 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
	Nadav Amit <namit@vmware.com>, linux-kselftest@vger.kernel.org,
	sparclinux@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
	Andrea Arcangeli <aarcange@redhat.com>,
	linux-samsung-soc@vger.kernel.org, linux-rdma@vger.kernel.org,
	x86@kernel.org, Hugh Dickins <hughd@google.com>,
	Matthew Wilcox <willy@infradead.org>,
	Christoph Hellwig <hch@infradead.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka <vbabka@suse.cz>,
	linux-media@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	John Hubbard <jhubbard@nvidia.com>, linux-um@lists.infradead.org,
	etnaviv@lists.freedesktop.org,
	Alex Williamson <alex.williamson@redhat.com>,
	Peter Xu <peterx@redhat.com>,
	Muchun Song <songmuchun@bytedance.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	Oded Gabbay <ogabbay@kernel.org>, linux-mips@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-alpha@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH mm-unstable v1 13/20] media: videobuf-dma-sg: remove
 FOLL_FORCE usage
Message-ID: <Y3TAGAUIo/IR+tAa@phenom.ffwll.local>
Mail-Followup-To: David Hildenbrand <david@redhat.com>,
	linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
	Nadav Amit <namit@vmware.com>, linux-kselftest@vger.kernel.org,
	sparclinux@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
	Andrea Arcangeli <aarcange@redhat.com>,
	linux-samsung-soc@vger.kernel.org, linux-rdma@vger.kernel.org,
	x86@kernel.org, Hugh Dickins <hughd@google.com>,
	Matthew Wilcox <willy@infradead.org>,
	Christoph Hellwig <hch@infradead.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka <vbabka@suse.cz>,
	linux-media@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	John Hubbard <jhubbard@nvidia.com>, linux-um@lists.infradead.org,
	etnaviv@lists.freedesktop.org,
	Alex Williamson <alex.williamson@redhat.com>,
	Peter Xu <peterx@redhat.com>,
	Muchun Song <songmuchun@bytedance.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	Oded Gabbay <ogabbay@kernel.org>, linux-mips@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-alpha@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Mike Kravetz <mike.kravetz@oracle.com>
References: <20221116102659.70287-1-david@redhat.com>
 <20221116102659.70287-14-david@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221116102659.70287-14-david@redhat.com>
X-Operating-System: Linux phenom 5.19.0-2-amd64 
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221116_024906_341590_2E9EE046 
X-CRM114-Status: GOOD (  23.01  )
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

On Wed, Nov 16, 2022 at 11:26:52AM +0100, David Hildenbrand wrote:
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
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>

I looked at this a while ago when going through some of the follow_pfn
stuff, so

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> ---
>  drivers/media/v4l2-core/videobuf-dma-sg.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/media/v4l2-core/videobuf-dma-sg.c b/drivers/media/v4l2-core/videobuf-dma-sg.c
> index f75e5eedeee0..234e9f647c96 100644
> --- a/drivers/media/v4l2-core/videobuf-dma-sg.c
> +++ b/drivers/media/v4l2-core/videobuf-dma-sg.c
> @@ -151,17 +151,16 @@ static void videobuf_dma_init(struct videobuf_dmabuf *dma)
>  static int videobuf_dma_init_user_locked(struct videobuf_dmabuf *dma,
>  			int direction, unsigned long data, unsigned long size)
>  {
> +	unsigned int gup_flags = FOLL_LONGTERM;
>  	unsigned long first, last;
> -	int err, rw = 0;
> -	unsigned int flags = FOLL_FORCE;
> +	int err;
>  
>  	dma->direction = direction;
>  	switch (dma->direction) {
>  	case DMA_FROM_DEVICE:
> -		rw = READ;
> +		gup_flags |= FOLL_WRITE;
>  		break;
>  	case DMA_TO_DEVICE:
> -		rw = WRITE;
>  		break;
>  	default:
>  		BUG();
> @@ -177,14 +176,11 @@ static int videobuf_dma_init_user_locked(struct videobuf_dmabuf *dma,
>  	if (NULL == dma->pages)
>  		return -ENOMEM;
>  
> -	if (rw == READ)
> -		flags |= FOLL_WRITE;
> -
>  	dprintk(1, "init user [0x%lx+0x%lx => %lu pages]\n",
>  		data, size, dma->nr_pages);
>  
> -	err = pin_user_pages(data & PAGE_MASK, dma->nr_pages,
> -			     flags | FOLL_LONGTERM, dma->pages, NULL);
> +	err = pin_user_pages(data & PAGE_MASK, dma->nr_pages, gup_flags,
> +			     dma->pages, NULL);
>  
>  	if (err != dma->nr_pages) {
>  		dma->nr_pages = (err >= 0) ? err : 0;
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
