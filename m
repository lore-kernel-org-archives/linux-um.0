Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 288CDC4332F
	for <linux-um@archiver.kernel.org>; Tue, 22 Nov 2022 15:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EWQwJ+oZfFpIbLg+UH4untKZ8igohKElwQMujWTIn3E=; b=r1WwRn3RitsjTh
	KLBetDo6McUcrTc2rnhoZ7Z955RNUChzV0/nPhEQYCh7bMSZ6zFy6vWz9L6OdzF/AquEIK80ico5Q
	2n0I3dCKSuXLDnxYsxmSgEfoj4XoccBbZboIR2WB7oDjftuuRX9NaLHKEJD9ASQhlinuQ4Vg+QIiC
	u4iGPEhB6X1SNq1UU5/lxBC6JwWBkJtKGGzGjain5NZHptj1W0pJoCjdGmnyCUH6MsW+wS4lJ9P32
	2QVzqXwvUPPBWPuKPz/Uk2b36WYvu51vMRsz4KNUIsGCLU4z3hn8c4YYCbwLrXjugbMPRKZ6HbwOO
	z08EPQklCXOKgGSj+gRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxVJg-00AOlK-Hn; Tue, 22 Nov 2022 15:36:08 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxVJT-00AOgK-5H; Tue, 22 Nov 2022 15:35:57 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8357A22007;
	Tue, 22 Nov 2022 15:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1669131353; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xzeEtRVGkBValjf4cAqJIIBnm0WLgHIJrOj2Qpyeryk=;
	b=hSz8uo53GqZkaSBqbG3aIh16lgMQB2Sw8gZ6Z+fnEjIR6uPvpuBuVkR8TpcuCDJwN2rjjn
	iqJmydTFhzXH0tY5jw9oJ6zK0Sx7/l0zZrHLYI1mzVvp/woqabMd2RthMdqBUz+tckoXxt
	gvUiGWpp9yM7xLCq0tNctpGuD1es/pI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1669131353;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xzeEtRVGkBValjf4cAqJIIBnm0WLgHIJrOj2Qpyeryk=;
	b=87yFyDfodelF6paPP+3fZVkcbfCamfu6aYJAmnQjTNh2RXFp/RQ8a0uSheJsgsaRl+tSbc
	rgSpbkEWiLk/2KDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E380913B01;
	Tue, 22 Nov 2022 15:35:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id /ANwNljsfGPGGwAAMHmgww
	(envelope-from <vbabka@suse.cz>); Tue, 22 Nov 2022 15:35:52 +0000
Message-ID: <34835490-57d7-4e26-7474-008b2c4c6b39@suse.cz>
Date: Tue, 22 Nov 2022 16:35:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH mm-unstable v1 08/20] mm: extend FAULT_FLAG_UNSHARE
 support to anything in a COW mapping
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
 <20221116102659.70287-9-david@redhat.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20221116102659.70287-9-david@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221122_073555_386896_7402F1FF 
X-CRM114-Status: GOOD (  27.61  )
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
> Extend FAULT_FLAG_UNSHARE to break COW on anything mapped into a
> COW (i.e., private writable) mapping and adjust the documentation
> accordingly.
> 
> FAULT_FLAG_UNSHARE will now also break COW when encountering the shared
> zeropage, a pagecache page, a PFNMAP, ... inside a COW mapping, by
> properly replacing the mapped page/pfn by a private copy (an exclusive
> anonymous page).
> 
> Note that only do_wp_page() needs care: hugetlb_wp() already handles
> FAULT_FLAG_UNSHARE correctly. wp_huge_pmd()/wp_huge_pud() also handles it
> correctly, for example, splitting the huge zeropage on FAULT_FLAG_UNSHARE
> such that we can handle FAULT_FLAG_UNSHARE on the PTE level.
> 
> This change is a requirement for reliable long-term R/O pinning in
> COW mappings.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  include/linux/mm_types.h | 8 ++++----
>  mm/memory.c              | 4 ----
>  2 files changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 5e7f4fac1e78..5e9aaad8c7b2 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -1037,9 +1037,9 @@ typedef struct {
>   * @FAULT_FLAG_REMOTE: The fault is not for current task/mm.
>   * @FAULT_FLAG_INSTRUCTION: The fault was during an instruction fetch.
>   * @FAULT_FLAG_INTERRUPTIBLE: The fault can be interrupted by non-fatal signals.
> - * @FAULT_FLAG_UNSHARE: The fault is an unsharing request to unshare (and mark
> - *                      exclusive) a possibly shared anonymous page that is
> - *                      mapped R/O.
> + * @FAULT_FLAG_UNSHARE: The fault is an unsharing request to break COW in a
> + *                      COW mapping, making sure that an exclusive anon page is
> + *                      mapped after the fault.
>   * @FAULT_FLAG_ORIG_PTE_VALID: whether the fault has vmf->orig_pte cached.
>   *                        We should only access orig_pte if this flag set.
>   *
> @@ -1064,7 +1064,7 @@ typedef struct {
>   *
>   * The combination FAULT_FLAG_WRITE|FAULT_FLAG_UNSHARE is illegal.
>   * FAULT_FLAG_UNSHARE is ignored and treated like an ordinary read fault when
> - * no existing R/O-mapped anonymous page is encountered.
> + * applied to mappings that are not COW mappings.
>   */
>  enum fault_flag {
>  	FAULT_FLAG_WRITE =		1 << 0,
> diff --git a/mm/memory.c b/mm/memory.c
> index d47ad33c6487..56b21ab1e4d2 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3432,10 +3432,6 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
>  		}
>  		wp_page_reuse(vmf);
>  		return 0;
> -	} else if (unshare) {
> -		/* No anonymous page -> nothing to do. */
> -		pte_unmap_unlock(vmf->pte, vmf->ptl);
> -		return 0;
>  	}
>  copy:
>  	/*


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
