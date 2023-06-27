Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05EEFEB64D9
	for <linux-um@archiver.kernel.org>; Tue, 27 Jun 2023 16:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=O0bboAZMh8EYgFnpw/yrkOSz07OwONopHm7zOFzWNhs=; b=AnLxSXuLY1fggw
	37fDryHjAbQNOnZIcUdrl4RL2Gc/ptOaK/FL5pgglFQOWbyZaUzI6As9OGytYLp9TVSuLEDBPeGvL
	KMCPhyOqoYrawhvBXG6XERbfXcTE3Jps9rT30IC9u0Yckbg2Rv2r65WF4iWnorMMZ33DQCh4A76tt
	RQxyr3eM5GF0BmTBSPHwbNyoKZ/mue264JcSszZMotu0+7JLzfzpKYWQHIGd9ZkOwecPP/Tg7eHHr
	sBTZNN1jtJ0C3hLdX0ZcIEv3YO8OWbd0k13Dwd8nt6G5woV3UZaLUF39UFpYDOjheNgn+aC2cJMP5
	okZjVZ7hNgAKhKwEShyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qEBES-00Db7r-0g;
	Tue, 27 Jun 2023 16:07:56 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qEBEN-00Db5e-1s
	for linux-um@lists.infradead.org;
	Tue, 27 Jun 2023 16:07:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687882068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hJDOCrbidQ6SQFQe4MgEFJjZ7UTNPrXFah4ZUMjVF/Y=;
	b=Cc0KwX7LyXS8JYv5xGW2+kada08T3uFyGsb8yTCVnIZMX4XtJxbocE5Ojds0u20/K+87is
	myxitS0nc+jnkl3smPQ3i2/vDsQnyna8j92dy+nE2BauC8pcvPB3aet2VXVwCWMCIfP96f
	FZgTv+82jeH/NQ6orFj0L1Qu8UqSMoQ=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-408-fIcL9ITCOQqIyd2jzznIRw-1; Tue, 27 Jun 2023 12:07:46 -0400
X-MC-Unique: fIcL9ITCOQqIyd2jzznIRw-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-74faf5008bbso79690785a.0
        for <linux-um@lists.infradead.org>; Tue, 27 Jun 2023 09:07:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687882066; x=1690474066;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hJDOCrbidQ6SQFQe4MgEFJjZ7UTNPrXFah4ZUMjVF/Y=;
        b=aR+lrQs8Gi1dDJIyiUj+jLHsdo2kRFFAQFacWGc94qH87WfyJtAfeh1ijJ9ZvsuK42
         pSLm7uNnEYP/Mfn1JnVdLDqzEC4YXiIRATgJhJMRwRqIokOv/nu8E0R7F5KQq1v56Klo
         lVlbTRbmWp7y6AlAOZ887pA7I8dxRL+6G3PYUEWZFybGeTkVlzZT3FVcdgqg3Sp7tJ4z
         T+Mu9MEmgV9pzw/+8bZWYamjfDzUrjenh/2BHnhlcuDpYNoYxXg7ERASS5326bA5XZTo
         4zBZbcouoUyPnyHGO7aBW1ooBR49v8YVJT16C5RNO++j0u5uDAvU6+LvInpnAdSxSYqO
         xDmQ==
X-Gm-Message-State: AC+VfDzDnHpHHe1i5uHcRzgpj8KA+AhaQ/u8kHKvG9KMhw0mELclaJuW
	0YCs1BcRp8DoczUAKCbV5fU9pORs/8OdxIEdZDs6UMCNOad/pmbCA1RMGJNX/ojzeswEYHvsZaT
	Ri9GUkXFFqVSCPSC7xQRUSGhg
X-Received: by 2002:a05:620a:4007:b0:765:7b61:46fc with SMTP id h7-20020a05620a400700b007657b6146fcmr12614196qko.7.1687882066271;
        Tue, 27 Jun 2023 09:07:46 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7UY1eApNq4tXkhQSQVDzyCNrRRXMA0KLJ6oWun1WyljocOJD3jbWnq1iikbRngPAZ/IFjT9Q==
X-Received: by 2002:a05:620a:4007:b0:765:7b61:46fc with SMTP id h7-20020a05620a400700b007657b6146fcmr12614153qko.7.1687882065917;
        Tue, 27 Jun 2023 09:07:45 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id m21-20020a05620a13b500b0075ecdc937ffsm1342302qki.41.2023.06.27.09.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 09:07:45 -0700 (PDT)
Date: Tue, 27 Jun 2023 12:07:43 -0400
From: Peter Xu <peterx@redhat.com>
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
	xen-devel@lists.xenproject.org, kvm@vger.kernel.org,
	Hugh Dickins <hughd@google.com>, Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v6 03/33] pgtable: Create struct ptdesc
Message-ID: <ZJsJT9dLtxaKlxVb@x1n>
References: <20230627031431.29653-1-vishal.moola@gmail.com>
 <20230627031431.29653-4-vishal.moola@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20230627031431.29653-4-vishal.moola@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230627_090751_696273_7101FF38 
X-CRM114-Status: GOOD (  17.98  )
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

On Mon, Jun 26, 2023 at 08:14:01PM -0700, Vishal Moola (Oracle) wrote:
> Currently, page table information is stored within struct page. As part
> of simplifying struct page, create struct ptdesc for page table
> information.
> 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
> ---
>  include/linux/pgtable.h | 68 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 68 insertions(+)
> 
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index 5063b482e34f..d46cb709ce08 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -987,6 +987,74 @@ static inline void ptep_modify_prot_commit(struct vm_area_struct *vma,
>  #endif /* __HAVE_ARCH_PTEP_MODIFY_PROT_TRANSACTION */
>  #endif /* CONFIG_MMU */
>  
> +
> +/**
> + * struct ptdesc -    Memory descriptor for page tables.
> + * @__page_flags:     Same as page flags. Unused for page tables.
> + * @pt_rcu_head:      For freeing page table pages.
> + * @pt_list:          List of used page tables. Used for s390 and x86.
> + * @_pt_pad_1:        Padding that aliases with page's compound head.
> + * @pmd_huge_pte:     Protected by ptdesc->ptl, used for THPs.
> + * @_pt_s390_gaddr:   Aliases with page's mapping. Used for s390 gmap only.

Should some arch-specific bits (and a few others) always under some
#ifdefs, so it shouldn't appear on other archs?

> + * @pt_mm:            Used for x86 pgds.
> + * @pt_frag_refcount: For fragmented page table tracking. Powerpc and s390 only.
> + * @ptl:              Lock for the page table.
> + * @__page_type:      Same as page->page_type. Unused for page tables.
> + * @_refcount:        Same as page refcount. Used for s390 page tables.
> + * @pt_memcg_data:    Memcg data. Tracked for page tables here.
> + *
> + * This struct overlays struct page for now. Do not modify without a good
> + * understanding of the issues.
> + */
> +struct ptdesc {
> +	unsigned long __page_flags;
> +
> +	union {
> +		struct rcu_head pt_rcu_head;
> +		struct list_head pt_list;
> +		struct {
> +			unsigned long _pt_pad_1;
> +			pgtable_t pmd_huge_pte;
> +		};
> +	};
> +	unsigned long _pt_s390_gaddr;
> +
> +	union {
> +		struct mm_struct *pt_mm;
> +		atomic_t pt_frag_refcount;
> +	};
> +
> +	union {
> +		unsigned long _pt_pad_2;
> +#if ALLOC_SPLIT_PTLOCKS
> +		spinlock_t *ptl;
> +#else
> +		spinlock_t ptl;
> +#endif
> +	};
> +	unsigned int __page_type;
> +	atomic_t _refcount;
> +#ifdef CONFIG_MEMCG
> +	unsigned long pt_memcg_data;
> +#endif
> +};

-- 
Peter Xu


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
