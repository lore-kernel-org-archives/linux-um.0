Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79B07C4332F
	for <linux-um@archiver.kernel.org>; Fri, 18 Nov 2022 17:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vuDABdCXNcHFcGYm9h4ysKDoSTVJJxrdxq9ldJxGs68=; b=yt2YmlKLOFHpqj
	Ami8Y1AzFgunf03QJ0Fidn8LNIsxSeBUrcJGJUqOoe11rTDT20FPEXpwCiT2SkZIVsvZn+2NiFJtB
	1y+5Ir36mQqxqbnRlT6ixWLyMUZjSE0/OVEpSl9OmQElUmifaf+T/cmbWWxqKBhrkkYkKyOrquuD+
	CANffSCyjCNZzO2PVbeNHNbhWmswgXsEuVk0vmF+lDw9dJkWZ9ExyKa86YgJsgAs4FU4nR7ao2zo8
	nhgdEEquG9TyZQIukNz7zHAb8rfR2VJFRjJdYeJt3ttLB8ZqKFsYPzM1oxvJa7lMAEPaOWV/BTVdb
	HPP0NLvc9zWwIBiAwlzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ow4ln-005bDx-WC; Fri, 18 Nov 2022 17:03:16 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ow4lb-005b71-Qh; Fri, 18 Nov 2022 17:03:05 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D4BF31FDA4;
	Fri, 18 Nov 2022 17:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1668790981; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fK2sdLfZqlxwdzyzeVC6Yy7wx8vYkqbsaxCq7BgcB58=;
	b=LS+hNeQ4geGgj4IXWO5+0pS41T+O+kbhrtYk+pP+vVRIoeuKs+oW13F6Ht+tR7USTuEyYF
	w44h38vtDK2kFPU+O2RCals0tqkM1nJKUf86qC24NucyatqLyr4TTvgkMY8PsBAD2uBX+L
	cHUUR5s7utA0uOsl3r11W1mUfWblbh8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1668790981;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fK2sdLfZqlxwdzyzeVC6Yy7wx8vYkqbsaxCq7BgcB58=;
	b=khb2AjlSZXqyWGI6UYbr+/ZmYWHGQEHMU8He9yK4yvl4DWCKZ0jYtp3ha5rFTfTmR/yC2u
	C7/yrrNfpsGvyLBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 41DED1345B;
	Fri, 18 Nov 2022 17:03:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id kEZlD8W6d2PfGAAAMHmgww
	(envelope-from <vbabka@suse.cz>); Fri, 18 Nov 2022 17:03:01 +0000
Message-ID: <e4dd50b8-7ae9-a6fd-8765-2b2dd90ea1a8@suse.cz>
Date: Fri, 18 Nov 2022 18:03:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH mm-unstable v1 05/20] mm: add early FAULT_FLAG_WRITE
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
 <20221116102659.70287-6-david@redhat.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20221116102659.70287-6-david@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221118_090304_046910_0D4AA62B 
X-CRM114-Status: GOOD (  22.65  )
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
> Let's catch abuse of FAULT_FLAG_WRITE early, such that we don't have to
> care in all other handlers and might get "surprises" if we forget to do
> so.
> 
> Write faults without VM_MAYWRITE don't make any sense, and our
> maybe_mkwrite() logic could have hidden such abuse for now.
> 
> Write faults without VM_WRITE on something that is not a COW mapping is
> similarly broken, and e.g., do_wp_page() could end up placing an
> anonymous page into a shared mapping, which would be bad.
> 
> This is a preparation for reliable R/O long-term pinning of pages in
> private mappings, whereby we want to make sure that we will never break
> COW in a read-only private mapping.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/memory.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index e014435a87db..c4fa378ec2a0 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -5170,6 +5170,14 @@ static vm_fault_t sanitize_fault_flags(struct vm_area_struct *vma,
>  		 */
>  		if (!is_cow_mapping(vma->vm_flags))
>  			*flags &= ~FAULT_FLAG_UNSHARE;
> +	} else if (*flags & FAULT_FLAG_WRITE) {
> +		/* Write faults on read-only mappings are impossible ... */
> +		if (WARN_ON_ONCE(!(vma->vm_flags & VM_MAYWRITE)))
> +			return VM_FAULT_SIGSEGV;
> +		/* ... and FOLL_FORCE only applies to COW mappings. */
> +		if (WARN_ON_ONCE(!(vma->vm_flags & VM_WRITE) &&
> +				 !is_cow_mapping(vma->vm_flags)))
> +			return VM_FAULT_SIGSEGV;
>  	}
>  	return 0;
>  }


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
