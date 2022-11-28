Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC298C43217
	for <linux-um@archiver.kernel.org>; Mon, 28 Nov 2022 22:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Message-Id:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9GgBPH7Gr7jVCTjF/S60fK2uqYGtJui+ldxBFce5qAU=; b=yzk2b7/pX/83kr
	i9X+hM25IgeM5zUZ4UAWcXkXGGSXclwy20ruwb31VzNMrPhZUUZMTRbyU/jroZAEsugqhRuD1ojsG
	Vj49nF/gfgBVzgAI9y2OBdZ4vG07vu/NYglpqmOWLPkKWTgSffi4UT01060HbePNqVhTJgDfCshA/
	lDps8gQiHdJq6OMQq3AJJ4mIq9CXLLTYKCaooMfKa8MRypEs7ac0fuLzVU18pQiX1YwKOPN0qEQDH
	gf5jDxUtbwXVowrpQKFLGLL6vSlo6ltiRVTSO16wWwpt4C/MZrbRLI0JxTaRfnIaxGcYcOKme1wr8
	Xa+VQpUe8EXpAaTMkQLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ozn6I-004fdE-LL; Mon, 28 Nov 2022 22:59:46 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ozn67-004faq-SN; Mon, 28 Nov 2022 22:59:37 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.source.kernel.org (Postfix) with ESMTPS id 7ACDFCE109D;
	Mon, 28 Nov 2022 22:59:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A99DC433D6;
	Mon, 28 Nov 2022 22:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1669676369;
	bh=8eUsQnXrojDc3xf/FA0TCQqqadaNCz4PLnjHT4xDE/M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=p/c6sfRX9un7PSA9WHRKHQPKKlq0P4NHxZWk+3LaBZS7DQenvFmjKk0jQBgH6o535
	 rwsyByROkiEJmDN58P/Z53hmZWo4xmybXT0VaPtvGqyQZyuQQjThzncIMjLPHHFdpc
	 3v4hl13h6A47jhJOM5850oDp2I/9vqahh0Q1uqps=
Date: Mon, 28 Nov 2022 14:59:27 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: David Hildenbrand <david@redhat.com>
Cc: Hans Verkuil <hverkuil@xs4all.nl>, linux-kernel@vger.kernel.org,
 x86@kernel.org, linux-alpha@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
 linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
 etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-samsung-soc@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-media@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-perf-users@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>, Jason Gunthorpe
 <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>, Peter Xu
 <peterx@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andrea Arcangeli <aarcange@redhat.com>, Hugh Dickins <hughd@google.com>,
 Nadav Amit <namit@vmware.com>, Vlastimil Babka <vbabka@suse.cz>, Matthew
 Wilcox <willy@infradead.org>, Mike Kravetz <mike.kravetz@oracle.com>,
 Muchun Song <songmuchun@bytedance.com>, Shuah Khan <shuah@kernel.org>,
 Lucas Stach <l.stach@pengutronix.de>, David Airlie <airlied@gmail.com>,
 Oded Gabbay <ogabbay@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Christoph
 Hellwig <hch@infradead.org>, Alex Williamson <alex.williamson@redhat.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Tomasz Figa
 <tfiga@chromium.org>, Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH mm-unstable v1 16/20] mm/frame-vector: remove FOLL_FORCE
 usage
Message-Id: <20221128145927.df895bf1966cfa125cae9668@linux-foundation.org>
In-Reply-To: <9d0bf98a-3d6a-1082-e992-1338e1525935@redhat.com>
References: <20221116102659.70287-1-david@redhat.com>
	<20221116102659.70287-17-david@redhat.com>
	<81fb0fa3-2e06-b765-56ac-a7d981194e59@redhat.com>
	<08b65ac6-6786-1080-18f8-d2be109c85fc@xs4all.nl>
	<9d0bf98a-3d6a-1082-e992-1338e1525935@redhat.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221128_145936_114982_B2251689 
X-CRM114-Status: GOOD (  16.63  )
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

On Mon, 28 Nov 2022 09:18:47 +0100 David Hildenbrand <david@redhat.com> wrote:

> > Less chances of things going wrong that way.
> > 
> > Just mention in the v2 cover letter that the first patch was added to
> > make it easy to backport that fix without being hampered by merge
> > conflicts if it was added after your frame_vector.c patch.
> 
> Yes, that's the way I would naturally do, it, however, Andrew prefers 
> delta updates for minor changes.
> 
> @Andrew, whatever you prefer!

I'm inclined to let things sit as they are.  Cross-tree conflicts
happen, and Linus handles them.  I'll flag this (very simple) conflict
in the pull request, if MM merges second.  If v4l merges second then
hopefully they will do the same.  But this one is so simple that Linus
hardly needs our help.

But Linus won't be editing changelogs so that the changelog makes more
sense after both trees are joined.  I'm inclined to let the changelog
sit as it is as well.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
