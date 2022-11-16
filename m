Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9B37C4332F
	for <linux-um@archiver.kernel.org>; Wed, 16 Nov 2022 10:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IPv/MBLVsWFI/bygMWZ+XFPX7Wg7UJ9RuzOnwhaWq5M=; b=CRyHN2EIsKGCfd
	a1xUJfxAbFT1JxX1iVD3ev1F5BcqChACZxtJFFzYb424PXTRbrO4KBTrer0iSMdKR8nbNeI1jS+Bb
	apA0i2OVwr6/881LgQLCxURlkFYpIm/NKwRgh8wvBnWoPEAn4oJIVVl7JeAXjSB9v2mHiPgSSeUTp
	0Q9MfLmPGNzgioQm9L82dzVNzbIaka1zz5RvuHmWREHCMc1zvQbw7WBoCKKhULaC4WPsKf3nWx9Cn
	O74Lt5Nl2yEUINBOf+OZn796rJWBtj7HI70lvtVRS/QNCOZvIAOk/RaPn3m5G8n5j1qNDt56zhiO/
	LPo+CfJ0o8KGh5OSw9RQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovG2S-002Tts-Rh; Wed, 16 Nov 2022 10:53:04 +0000
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovG04-002S6B-BL
	for linux-um@lists.infradead.org; Wed, 16 Nov 2022 10:50:37 +0000
Received: by mail-ej1-x636.google.com with SMTP id i10so34426502ejg.6
        for <linux-um@lists.infradead.org>; Wed, 16 Nov 2022 02:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mdwJ/650wADnRoR72oyZkQ8DiIzSWQSpq6IdxtCR+gY=;
        b=f2SpOZdEZzXCSPn0ykm1oJX1As7I6xxh5wr16pOd/kbA5OOiuO0Y4IWH35k28OjNoj
         wHiTHItpgbOeFMLRaKE+zMy2u3TZ9N8dtmICEQujo3Me7a5E74OF+31ufRLy1oYVFEA1
         T3Nbw0vHjZlr/vzIiD2dpwD9w/oFbF5Q800Lc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mdwJ/650wADnRoR72oyZkQ8DiIzSWQSpq6IdxtCR+gY=;
        b=oTTWshT43bIcNE2WjBVUTeJytc6PXWKMZZSw0XVWrC+Iux86iH/eY2quqlyIAr54Po
         qPoUnQg8AHG3EgK1GIGW3mNk77aD1Cqr8z0L4uwDC5zQePOO6wxCisR/zXqpkG9yq/TJ
         MpZXAIRz0gc/DiQAQceaqVUu+i/gb3lnn2Y07vKgVex9EOez7xScF4iuuLaWsAF4GkNG
         /Igz6LQmOw7M7eHltwI1InV7Eh6JNg0U6Ve9BIFQ8qUb+GfHxY8xKaoLmd53a20O6xlr
         Su/a4BOCDOaL8Dq2qxASVxX/XJJP/T9wHEXkaqxr9zF3kpKMxK5rhvL/ukF2+03bRtEy
         bNxg==
X-Gm-Message-State: ANoB5pmsTUGPpLX+o3uhUHR3YalTsL8ptAU27xi1fksCStfR+8MzhAON
	pvdPPD8HF0NwhVDT6UnMo3r1Eg==
X-Google-Smtp-Source: AA0mqf4MgV0oW/LCUugReHUpBkpepoZ7Vy6UeNXMZ5Yjky+iNhPczOtY8K1ul1dtRtcsoxT6/N3VKQ==
X-Received: by 2002:a17:906:78e:b0:7a1:e52e:bddb with SMTP id l14-20020a170906078e00b007a1e52ebddbmr16502698ejc.685.1668595834073;
        Wed, 16 Nov 2022 02:50:34 -0800 (PST)
Received: from phenom.ffwll.local (212-51-149-33.fiber7.init7.net. [212.51.149.33])
        by smtp.gmail.com with ESMTPSA id jw17-20020a17090776b100b0078b1ff41f05sm6758790ejc.43.2022.11.16.02.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 02:50:33 -0800 (PST)
Date: Wed, 16 Nov 2022 11:50:31 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	dri-devel@lists.freedesktop.org, Hans Verkuil <hverkuil@xs4all.nl>,
	linux-mm@kvack.org, Nadav Amit <namit@vmware.com>,
	linux-kselftest@vger.kernel.org, sparclinux@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
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
	Tomasz Figa <tfiga@chromium.org>, linux-perf-users@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-alpha@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH mm-unstable v1 16/20] mm/frame-vector: remove FOLL_FORCE
 usage
Message-ID: <Y3TAd14jCBSKeqsL@phenom.ffwll.local>
Mail-Followup-To: David Hildenbrand <david@redhat.com>,
	linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	dri-devel@lists.freedesktop.org, Hans Verkuil <hverkuil@xs4all.nl>,
	linux-mm@kvack.org, Nadav Amit <namit@vmware.com>,
	linux-kselftest@vger.kernel.org, sparclinux@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
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
	Tomasz Figa <tfiga@chromium.org>, linux-perf-users@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-alpha@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Mike Kravetz <mike.kravetz@oracle.com>
References: <20221116102659.70287-1-david@redhat.com>
 <20221116102659.70287-17-david@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221116102659.70287-17-david@redhat.com>
X-Operating-System: Linux phenom 5.19.0-2-amd64 
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221116_025036_440090_B0623C18 
X-CRM114-Status: GOOD (  23.89  )
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

On Wed, Nov 16, 2022 at 11:26:55AM +0100, David Hildenbrand wrote:
> FOLL_FORCE is really only for ptrace access. According to commit
> 707947247e95 ("media: videobuf2-vmalloc: get_userptr: buffers are always
> writable"), get_vaddr_frames() currently pins all pages writable as a
> workaround for issues with read-only buffers.
> 
> FOLL_FORCE, however, seems to be a legacy leftover as it predates
> commit 707947247e95 ("media: videobuf2-vmalloc: get_userptr: buffers are
> always writable"). Let's just remove it.
> 
> Once the read-only buffer issue has been resolved, FOLL_WRITE could
> again be set depending on the DMA direction.
> 
> Cc: Hans Verkuil <hverkuil@xs4all.nl>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Tomasz Figa <tfiga@chromium.org>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Also code I looked at while looking at follow_pfn stuff

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> ---
>  drivers/media/common/videobuf2/frame_vector.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/common/videobuf2/frame_vector.c b/drivers/media/common/videobuf2/frame_vector.c
> index 542dde9d2609..062e98148c53 100644
> --- a/drivers/media/common/videobuf2/frame_vector.c
> +++ b/drivers/media/common/videobuf2/frame_vector.c
> @@ -50,7 +50,7 @@ int get_vaddr_frames(unsigned long start, unsigned int nr_frames,
>  	start = untagged_addr(start);
>  
>  	ret = pin_user_pages_fast(start, nr_frames,
> -				  FOLL_FORCE | FOLL_WRITE | FOLL_LONGTERM,
> +				  FOLL_WRITE | FOLL_LONGTERM,
>  				  (struct page **)(vec->ptrs));
>  	if (ret > 0) {
>  		vec->got_ref = true;
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
