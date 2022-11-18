Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 640A2C4332F
	for <linux-um@archiver.kernel.org>; Fri, 18 Nov 2022 16:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZdvIr3bBLNxYrErD6Hwiy30XxK6C3XPDPb5Gm3Hscxk=; b=Uu/YrlC4Q7UEqN
	pvlLQbQpFRduffcFpoCXfOVWlCf1fKoA3yH1DtlchxaO/kCKuTic8m/ZP+LtJaaC+oBceORnwrfWc
	hBg/85LDTAMjhSkqxun8ry5zUBgtsrlZkZzMTh+owF/KPVX8/3D4ju7ZeujsxPNqFByDHn9y/IWP4
	6O0Um72s2LMtmsy6xC9GbdK5gzWUTWGhwSSI4dIkLE1ynvkIpPNs1M3BoJdeN2u6xkeXRntw/gvWE
	UzUXZDfXegCKqx6baf+JyaXIQtmJv980+gw2V2xxqrQF8ialc0T/17j5CJRNdoYauEwlgYyCh1U+n
	wYu3koxT1qyrKfFybkjQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ow4Xc-005UW1-Vm; Fri, 18 Nov 2022 16:48:37 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ow4Uh-005SUv-DI; Fri, 18 Nov 2022 16:45:36 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B457722809;
	Fri, 18 Nov 2022 16:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1668789932; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gGWCBwR6W7N/T/oKVxq15JaXduGL74ybELQMLEOROjQ=;
	b=oTTvOF9em1RBHrcDz3sPtZD55HB28JQKz0rq8O6fqbEdz69a/AXJF4jT92zC2TnMfoTP5o
	N+/92zbPBa11XH4uj3j1PVuX4IFT5iMf+cuDaOPUiGYk17AhOFewCKsW2Vloee6rUH2cev
	ywRRIq+dF6sPyizq6eVC4qLT8N+v1Fc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1668789932;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gGWCBwR6W7N/T/oKVxq15JaXduGL74ybELQMLEOROjQ=;
	b=w1a8SK5GtUV98VIRjCKPQTv/uTPpGl8AZCdCXalMKOScuLDWEelI6GTSk7XWYEsOviak8d
	9ZPPVSaQ1GZLctAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2CE531345B;
	Fri, 18 Nov 2022 16:45:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id /+1SCqy2d2MoEAAAMHmgww
	(envelope-from <vbabka@suse.cz>); Fri, 18 Nov 2022 16:45:32 +0000
Message-ID: <f427422c-9af3-dc0a-dcc3-2a1114eb77ea@suse.cz>
Date: Fri, 18 Nov 2022 17:45:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH mm-unstable v1 04/20] mm: add early FAULT_FLAG_UNSHARE
 consistency checks
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
 Nadav Amit <namit@vmware.com>, Matthew Wilcox <willy@infradead.org>,
 Mike Kravetz <mike.kravetz@oracle.com>,
 Muchun Song <songmuchun@bytedance.com>, Shuah Khan <shuah@kernel.org>,
 Lucas Stach <l.stach@pengutronix.de>, David Airlie <airlied@gmail.com>,
 Oded Gabbay <ogabbay@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Christoph Hellwig <hch@infradead.org>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20221116102659.70287-1-david@redhat.com>
 <20221116102659.70287-5-david@redhat.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20221116102659.70287-5-david@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221118_084535_632392_BF60956D 
X-CRM114-Status: GOOD (  14.86  )
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

On 11/16/22 11:26, David Hildenbrand wrote:
> For now, FAULT_FLAG_UNSHARE only applies to anonymous pages, which
> implies a COW mapping. Let's hide FAULT_FLAG_UNSHARE early if we're not
> dealing with a COW mapping, such that we treat it like a read fault as
> documented and don't have to worry about the flag throughout all fault
> handlers.
> 
> While at it, centralize the check for mutual exclusion of
> FAULT_FLAG_UNSHARE and FAULT_FLAG_WRITE and just drop the check that
> either flag is set in the WP handler.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/huge_memory.c |  3 ---
>  mm/hugetlb.c     |  5 -----
>  mm/memory.c      | 23 ++++++++++++++++++++---
>  3 files changed, 20 insertions(+), 11 deletions(-)

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
