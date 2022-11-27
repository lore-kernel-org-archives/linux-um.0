Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F094C4321E
	for <linux-um@archiver.kernel.org>; Sun, 27 Nov 2022 10:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:Subject:From:References:Cc:To:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=G1LxGg6lThxykOMDsBO+gkd4mNaE+E0lcZrZBvY3ckQ=; b=aDz5WzCYsLrzzS
	tC2pC/WUtCjXxhec/w/cIgT1CJBv+beGMBFsiJgtcbdO4Zzmqm93B2DUvr4+tCVzRNyFTy2G7MYws
	s3HIyytbcaHf/PLTPgg0zBfwelltgxJUHwS6yn6geWtXUwFI9hBBKk+g48oMV2qU4u3wGXHitBCNN
	IzcYPO1J2FonHG3e6qgbPxDxCACX+MkRv3rudtK39mjOERNWY6Zx19MqsAFoslmB3A+o5/gXOCcF1
	H9h7H6yFD9/nAEGAMKoo3aIFNfYbB451YbtjdjGQmVk8YmjmH/dO+7j6cnWjEXK4U64kZ7dW6GuAZ
	EWasNbakolfhRfkun4ZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ozF0J-00Aqta-Mj; Sun, 27 Nov 2022 10:35:19 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ozF0H-00AqsC-6g
	for linux-um@lists.infradead.org; Sun, 27 Nov 2022 10:35:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1669545316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a/FKhEJUKr4Au5jEDV0nA39boCfv1uOAmeL78/XZzlw=;
	b=ZiWJIwXTHsjSEHq8nmAktEDguAR5ZBAbFagwztjoL15CYq9GXM4SxOqpaYXHRKTbS1pN9e
	jPSH3sxop7DDk2Qsf6e7hqox/pF9rAGnzh/0LlLNO+yvnwwdwmmRAuewqVMMGL4mV+x151
	w2ahB7HNB+KnDfIPqHjmPpm7Q2xo68A=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-592-5kI_V4KZOk6ud1j95iO5FA-1; Sun, 27 Nov 2022 05:35:13 -0500
X-MC-Unique: 5kI_V4KZOk6ud1j95iO5FA-1
Received: by mail-wm1-f69.google.com with SMTP id ay40-20020a05600c1e2800b003cf8aa16377so4822969wmb.7
        for <linux-um@lists.infradead.org>; Sun, 27 Nov 2022 02:35:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :content-language:references:cc:to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a/FKhEJUKr4Au5jEDV0nA39boCfv1uOAmeL78/XZzlw=;
        b=YVny/5Ld/oy7ayCiNJ2E8PcP+NbDHNBgmTkMnuegPnrvhFWhoSkT54Kz637JdGEDgj
         m7wU16U0J7nFq5pkMRAU68FT5aMq+xgDzvGk33rdD3HHitg1whytTlvxQHgwHabIA/Yj
         eDSqV8WUjWncYXQKEu2xR7f5GU4JSfynBYOcMyHZdx2pyjVPdj0+EIeeG4FjNLi/6zYC
         bcw+Oa0zJEh69Izil/zZqho3V784TwEFBsDp630gJudFHSaZBAS81V608Zuve12GRemT
         GnS6rZUOnmnRwMplA2DXKGTGx5O62FLTZWoqLREUSKtDmacpaIZpfsW1NaomREDilPUT
         +3dQ==
X-Gm-Message-State: ANoB5pnCXmoVCocH8/+npXK2PlZ68ZQGvfugcUGXAqdu83ySXel1Fqrc
	9mYBOdSgg6hbhKtlmcsKQZnJvJgsbUXIS+i+uMwnzTglOKkdwl6fIGMscOfULPDZbOjMsF0D88q
	DjKnnwrYWlOlB6SX07wDgYUDK
X-Received: by 2002:a05:600c:4e88:b0:3b5:477:1e80 with SMTP id f8-20020a05600c4e8800b003b504771e80mr34594848wmq.200.1669545311983;
        Sun, 27 Nov 2022 02:35:11 -0800 (PST)
X-Google-Smtp-Source: AA0mqf44zTk6J1KBaqs1seffTqR2+v9TqwwPSmjBWI2JrtJKUPaYELfhGu32bDJHUXiVwBKDfUuj3g==
X-Received: by 2002:a05:600c:4e88:b0:3b5:477:1e80 with SMTP id f8-20020a05600c4e8800b003b504771e80mr34594816wmq.200.1669545311706;
        Sun, 27 Nov 2022 02:35:11 -0800 (PST)
Received: from ?IPV6:2003:cb:c724:dc00:5ea8:da59:8609:7da? (p200300cbc724dc005ea8da59860907da.dip0.t-ipconnect.de. [2003:cb:c724:dc00:5ea8:da59:8609:7da])
        by smtp.gmail.com with ESMTPSA id u10-20020a05600c19ca00b003c5571c27a1sm14797024wmq.32.2022.11.27.02.35.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Nov 2022 02:35:11 -0800 (PST)
Message-ID: <81fb0fa3-2e06-b765-56ac-a7d981194e59@redhat.com>
Date: Sun, 27 Nov 2022 11:35:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
To: linux-kernel@vger.kernel.org, Hans Verkuil <hverkuil@xs4all.nl>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: x86@kernel.org, linux-alpha@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
 linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
 etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-samsung-soc@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-media@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-perf-users@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
 Peter Xu <peterx@redhat.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Andrea Arcangeli <aarcange@redhat.com>,
 Hugh Dickins <hughd@google.com>, Nadav Amit <namit@vmware.com>,
 Vlastimil Babka <vbabka@suse.cz>, Matthew Wilcox <willy@infradead.org>,
 Mike Kravetz <mike.kravetz@oracle.com>,
 Muchun Song <songmuchun@bytedance.com>, Shuah Khan <shuah@kernel.org>,
 Lucas Stach <l.stach@pengutronix.de>, David Airlie <airlied@gmail.com>,
 Oded Gabbay <ogabbay@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Christoph Hellwig <hch@infradead.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Tomasz Figa
 <tfiga@chromium.org>, Mauro Carvalho Chehab <mchehab@kernel.org>
References: <20221116102659.70287-1-david@redhat.com>
 <20221116102659.70287-17-david@redhat.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH mm-unstable v1 16/20] mm/frame-vector: remove FOLL_FORCE
 usage
In-Reply-To: <20221116102659.70287-17-david@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221127_023517_328772_B86B5478 
X-CRM114-Status: GOOD (  27.96  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

On 16.11.22 11:26, David Hildenbrand wrote:
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
> ---
>   drivers/media/common/videobuf2/frame_vector.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/common/videobuf2/frame_vector.c b/drivers/media/common/videobuf2/frame_vector.c
> index 542dde9d2609..062e98148c53 100644
> --- a/drivers/media/common/videobuf2/frame_vector.c
> +++ b/drivers/media/common/videobuf2/frame_vector.c
> @@ -50,7 +50,7 @@ int get_vaddr_frames(unsigned long start, unsigned int nr_frames,
>   	start = untagged_addr(start);
>   
>   	ret = pin_user_pages_fast(start, nr_frames,
> -				  FOLL_FORCE | FOLL_WRITE | FOLL_LONGTERM,
> +				  FOLL_WRITE | FOLL_LONGTERM,
>   				  (struct page **)(vec->ptrs));
>   	if (ret > 0) {
>   		vec->got_ref = true;


Hi Andrew,

see the discussion at [1] regarding a conflict and how to proceed with
upstreaming. The conflict would be easy to resolve, however, also
the patch description doesn't make sense anymore with [1].


On top of mm-unstable, reverting this patch and applying [1] gives me
an updated patch:


 From 1e66c25f1467c1f1e5f275312f2c6df29308d4df Mon Sep 17 00:00:00 2001
From: David Hildenbrand <david@redhat.com>
Date: Wed, 16 Nov 2022 11:26:55 +0100
Subject: [PATCH] mm/frame-vector: remove FOLL_FORCE usage

GUP now supports reliable R/O long-term pinning in COW mappings, such
that we break COW early. MAP_SHARED VMAs only use the shared zeropage so
far in one corner case (DAXFS file with holes), which can be ignored
because GUP does not support long-term pinning in fsdax (see
check_vma_flags()).

Consequently, FOLL_FORCE | FOLL_WRITE | FOLL_LONGTERM is no longer required
for reliable R/O long-term pinning: FOLL_LONGTERM is sufficient. So stop
using FOLL_FORCE, which is really only for ptrace access.

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Acked-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc: Hans Verkuil <hverkuil@xs4all.nl>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Tomasz Figa <tfiga@chromium.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
  drivers/media/common/videobuf2/frame_vector.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/common/videobuf2/frame_vector.c b/drivers/media/common/videobuf2/frame_vector.c
index aad72640f055..8606fdacf5b8 100644
--- a/drivers/media/common/videobuf2/frame_vector.c
+++ b/drivers/media/common/videobuf2/frame_vector.c
@@ -41,7 +41,7 @@ int get_vaddr_frames(unsigned long start, unsigned int nr_frames, bool write,
  	int ret_pin_user_pages_fast = 0;
  	int ret = 0;
  	int err;
-	unsigned int gup_flags = FOLL_FORCE | FOLL_LONGTERM;
+	unsigned int gup_flags = FOLL_LONGTERM;
  
  	if (nr_frames == 0)
  		return 0;
-- 
2.38.1



Please let me know how you want to proceed. Ideally, you'd pick up
[1] and apply this updated patch. Also, please tell me if I should
send this updated patch in a separate mail (e.g., as reply to this mail).


[1] https://lkml.kernel.org/r/71bdd3cf-b044-3f12-df58-7c16d5749587@xs4all.nl

-- 
Thanks,

David / dhildenb


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
