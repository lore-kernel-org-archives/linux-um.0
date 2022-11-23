Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD445C4332F
	for <linux-um@archiver.kernel.org>; Wed, 23 Nov 2022 13:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dRchmQkzc0L9XOYayG2ui0G7izXYYieQFwUIr/kf4Go=; b=VQxvPV7+RvzAup
	FUgG8UvDFFzk+r2OoXBEhhovxMuXXXIWmhTaZWV/GKlCYnaftkqPKlXt9HSmB+UA2/FT+8809i0C0
	YNYJZZoapu7rfZtaWeNHi+lLT8qNLjv7QrQeY3QUSpm7wgZ+HNWfAG5wym7d9rg0AnMDAgS0RMchn
	xF7LTeqpTANarJs04cX0xkd66we4JZzKfU0OIk6yLwv8Iz7Ljo1JhWc/SykqZzW3xmp7+PgQttv0Y
	pPq5TdxfrrfDuxdicoYHJzE4RQ6VIPqCjt91+ZwBWxwOs4nYB1TKvyEnkBilpk530i0t2Fu0h5Ukm
	15mKKfARVjFEgMkTHPMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxpo8-00HEcH-Vb; Wed, 23 Nov 2022 13:28:56 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxpnq-00HEVg-Kr; Wed, 23 Nov 2022 13:28:41 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 1B64861C4E;
	Wed, 23 Nov 2022 13:18:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74BDEC433C1;
	Wed, 23 Nov 2022 13:18:32 +0000 (UTC)
Message-ID: <e0701648-fec1-f1fd-0c69-8ed85e162a01@xs4all.nl>
Date: Wed, 23 Nov 2022 14:18:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH mm-unstable v1 15/20] media: pci/ivtv: remove FOLL_FORCE
 usage
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
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
 Andrew Morton <akpm@linux-foundation.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andrea Arcangeli <aarcange@redhat.com>, Hugh Dickins <hughd@google.com>,
 Nadav Amit <namit@vmware.com>, Vlastimil Babka <vbabka@suse.cz>,
 Matthew Wilcox <willy@infradead.org>, Mike Kravetz
 <mike.kravetz@oracle.com>, Muchun Song <songmuchun@bytedance.com>,
 Shuah Khan <shuah@kernel.org>, Lucas Stach <l.stach@pengutronix.de>,
 David Airlie <airlied@gmail.com>, Oded Gabbay <ogabbay@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@infradead.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Andy Walls <awalls@md.metrocast.net>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
References: <20221116102659.70287-1-david@redhat.com>
 <20221116102659.70287-16-david@redhat.com>
From: Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <20221116102659.70287-16-david@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221123_052838_804663_0966179B 
X-CRM114-Status: GOOD (  22.18  )
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

On 16/11/2022 11:26, David Hildenbrand wrote:
> FOLL_FORCE is really only for ptrace access. R/O pinning a page is
> supposed to fail if the VMA misses proper access permissions (no VM_READ).
> 
> Let's just remove FOLL_FORCE usage here; there would have to be a pretty
> good reason to allow arbitrary drivers to R/O pin pages in a PROT_NONE
> VMA. Most probably, FOLL_FORCE usage is just some legacy leftover.

I'm pretty sure about that as well, so:

Acked-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>

Regards,

	Hans

> 
> Cc: Andy Walls <awalls@md.metrocast.net>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  drivers/media/pci/ivtv/ivtv-udma.c | 2 +-
>  drivers/media/pci/ivtv/ivtv-yuv.c  | 5 ++---
>  2 files changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/media/pci/ivtv/ivtv-udma.c b/drivers/media/pci/ivtv/ivtv-udma.c
> index 210be8290f24..99b9f55ca829 100644
> --- a/drivers/media/pci/ivtv/ivtv-udma.c
> +++ b/drivers/media/pci/ivtv/ivtv-udma.c
> @@ -115,7 +115,7 @@ int ivtv_udma_setup(struct ivtv *itv, unsigned long ivtv_dest_addr,
>  
>  	/* Pin user pages for DMA Xfer */
>  	err = pin_user_pages_unlocked(user_dma.uaddr, user_dma.page_count,
> -			dma->map, FOLL_FORCE);
> +			dma->map, 0);
>  
>  	if (user_dma.page_count != err) {
>  		IVTV_DEBUG_WARN("failed to map user pages, returned %d instead of %d\n",
> diff --git a/drivers/media/pci/ivtv/ivtv-yuv.c b/drivers/media/pci/ivtv/ivtv-yuv.c
> index 4ba10c34a16a..582146f8d70d 100644
> --- a/drivers/media/pci/ivtv/ivtv-yuv.c
> +++ b/drivers/media/pci/ivtv/ivtv-yuv.c
> @@ -63,12 +63,11 @@ static int ivtv_yuv_prep_user_dma(struct ivtv *itv, struct ivtv_user_dma *dma,
>  
>  	/* Pin user pages for DMA Xfer */
>  	y_pages = pin_user_pages_unlocked(y_dma.uaddr,
> -			y_dma.page_count, &dma->map[0], FOLL_FORCE);
> +			y_dma.page_count, &dma->map[0], 0);
>  	uv_pages = 0; /* silence gcc. value is set and consumed only if: */
>  	if (y_pages == y_dma.page_count) {
>  		uv_pages = pin_user_pages_unlocked(uv_dma.uaddr,
> -				uv_dma.page_count, &dma->map[y_pages],
> -				FOLL_FORCE);
> +				uv_dma.page_count, &dma->map[y_pages], 0);
>  	}
>  
>  	if (y_pages != y_dma.page_count || uv_pages != uv_dma.page_count) {


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
