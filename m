Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E962C3A59F
	for <linux-um@archiver.kernel.org>; Wed, 23 Nov 2022 14:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:Cc:To:From:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZU3lxkjsmr1kFKbdiW38dq0tCqwo4pii3fC2M+tjZXI=; b=0fRa65dRK7tK+5
	adRL/wY3rjCK6kBFa9e41/MeMHYkdFHXJa2rHdcWk6u7BrpHt2Zq9/dkuuPtF4PLy8AETDM52cUGS
	mkAq9Dm4+yOE0sMRRa2X4WlapeqSPsCyX/W9Tk+8iPSkOH0U4SDr48OteeL7x0P9inISFH4MoQoFW
	YtxGG4wP1e/y/zXmgIJupNpdXT5yYCJcW3GgVj7BM29+imTUHpQInSqeM+0B15n8V70XHaGL6NIOZ
	FWkLz7uncgD0TNkD6URxUQ1VgwkEUffw4moSWDeJYrKVxPjpHsj3P/mDaghXRuu3qBhFFiICXoxLk
	r/m4EUNdKiya6HYTrD4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxqk9-0002In-9v; Wed, 23 Nov 2022 14:28:53 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxqjt-0002AW-HK; Wed, 23 Nov 2022 14:28:40 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 19562B8202D;
	Wed, 23 Nov 2022 14:28:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B521C433D6;
	Wed, 23 Nov 2022 14:28:28 +0000 (UTC)
Message-ID: <0da1813a-7e37-bc35-cf8d-8c41590f3b1a@xs4all.nl>
Date: Wed, 23 Nov 2022 15:28:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH mm-unstable v1 16/20] mm/frame-vector: remove FOLL_FORCE
 usage
Content-Language: en-US
From: Hans Verkuil <hverkuil@xs4all.nl>
To: David Hildenbrand <david@redhat.com>, Tomasz Figa <tfiga@chromium.org>
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
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, linux-kernel@vger.kernel.org
References: <20221116102659.70287-1-david@redhat.com>
 <20221116102659.70287-17-david@redhat.com>
 <36dd800b-d96b-af39-d0de-a5a8ca1034dd@xs4all.nl>
In-Reply-To: <36dd800b-d96b-af39-d0de-a5a8ca1034dd@xs4all.nl>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221123_062837_875170_E560FF8C 
X-CRM114-Status: GOOD (  26.45  )
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

On 23/11/2022 14:26, Hans Verkuil wrote:
> Hi David, Tomasz,
> 
> On 16/11/2022 11:26, David Hildenbrand wrote:
>> FOLL_FORCE is really only for ptrace access. According to commit
>> 707947247e95 ("media: videobuf2-vmalloc: get_userptr: buffers are always
>> writable"), get_vaddr_frames() currently pins all pages writable as a
>> workaround for issues with read-only buffers.
> 
> I've decided to revert 707947247e95: I have not been able to reproduce the problem
> described in that commit, and Tomasz reported that it caused problems with a
> specific use-case they encountered. I'll post that patch soon and I expect it
> to land in 6.2. It will cause a conflict with this patch, though.
> 
> If the problem described in that patch occurs again, then I will revisit it
> and hopefully do a better job than I did before. That commit was not my
> finest moment.

In any case, for this patch:

Acked-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>

Regards,

	Hans

> 
> Regards,
> 
> 	Hans
> 
>>
>> FOLL_FORCE, however, seems to be a legacy leftover as it predates
>> commit 707947247e95 ("media: videobuf2-vmalloc: get_userptr: buffers are
>> always writable"). Let's just remove it.
>>
>> Once the read-only buffer issue has been resolved, FOLL_WRITE could
>> again be set depending on the DMA direction.
>>
>> Cc: Hans Verkuil <hverkuil@xs4all.nl>
>> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
>> Cc: Tomasz Figa <tfiga@chromium.org>
>> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
>> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  drivers/media/common/videobuf2/frame_vector.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/media/common/videobuf2/frame_vector.c b/drivers/media/common/videobuf2/frame_vector.c
>> index 542dde9d2609..062e98148c53 100644
>> --- a/drivers/media/common/videobuf2/frame_vector.c
>> +++ b/drivers/media/common/videobuf2/frame_vector.c
>> @@ -50,7 +50,7 @@ int get_vaddr_frames(unsigned long start, unsigned int nr_frames,
>>  	start = untagged_addr(start);
>>  
>>  	ret = pin_user_pages_fast(start, nr_frames,
>> -				  FOLL_FORCE | FOLL_WRITE | FOLL_LONGTERM,
>> +				  FOLL_WRITE | FOLL_LONGTERM,
>>  				  (struct page **)(vec->ptrs));
>>  	if (ret > 0) {
>>  		vec->got_ref = true;
> 


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
