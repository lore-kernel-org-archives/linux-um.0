Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83083EB64D9
	for <linux-um@archiver.kernel.org>; Tue, 27 Jun 2023 05:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RJwbki39Ed+htDgrXVTu3OFQcGBOt63bkZ+J0dw19qY=; b=VdyvwP/l0CR1tC
	Wo+4kUCVaw0TeI9+iuo8ZZ9SngJ0Rix+ywxU+Wsf4JSAUDhelDpOA2A3gQ+eUdB/TyAEytLG7A0T6
	g5NAV9fJq5Nzp9n4OQ7r5yYIB6aq9VJFpAFpw8Bi5WNGIaHQ6xfnsXfqfo36qUDfkj1KkIhBTidwu
	jbMnQ/n2jWso/UnV2gwOEvCubXdXohrsThzcYpD74y/2e2bbvEaCYz04ZNGW0TMEe5banujlXFcVs
	arSvNxOQgT5Xyq1pYGZm0+xTgAvLLhmjXm+0V9aT/OpmS9gDcFZkmgDIB6Xt1U/XD38MXC5MMYu5t
	WB0bGOwaH80RbtO0ENiQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qE1YX-00Bwov-2P;
	Tue, 27 Jun 2023 05:48:01 +0000
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qE1YT-00Bwle-2e;
	Tue, 27 Jun 2023 05:47:59 +0000
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-55ae2075990so878591a12.0;
        Mon, 26 Jun 2023 22:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687844871; x=1690436871;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bjTPMlxWt9nC/sXrGsrew1h8LID7KP4FRrxfXfknacs=;
        b=CKCXCuWl0gYpQ4q8YGqBYIHt4kiR1AhHpEiDPYQrq6u+C1EcCN199Rf+TEI2yZgN+R
         yHF4vksLQaZZNCW1AKLUCeBUhO/zz1T+Q9/6Dn0kQ15ZW6K5TqPmtUB9rSpHUKgxZgiA
         HSTUVKDZ4xM6L9+zGQEVzY8EH5rZJBCsvXHjcbbzvbKrE2StJxwwReSDEN5b3GfPvLfH
         eqtt0xPcEOboGwjNakJZJtyOpw0n8CltvqJLvaWUUnjMuBH5yNe38AlJDiG6mzZTOhDy
         hB/teSyin+eBzVwUgFatWumtP7LykGuBvZNNj+IJUNFfPVWNZBZUcFVQKEBMH4tHKOww
         HTig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687844871; x=1690436871;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bjTPMlxWt9nC/sXrGsrew1h8LID7KP4FRrxfXfknacs=;
        b=RdKKETUOVogW1Jgq4BRzSc+pb/M9KcekqoCGIpqlVDzMQT9nWClD4PmqNn9YAj/Qy6
         IoksCEOVE026AqwD4PAETQhpKGBxCOb9ikqGBdTLYHkY90G2ok9qgH5rcG3Zs2aFbWES
         DbO3Wgx8Kssmi7UYaILLhC7gK02PgQvnf3gA9OTuwhRBdkWGXVhDQDVSJYpXWLsBCh7I
         uvMlLAQpL1H9oxB8fFSqrZeAYPtkwszsBh4SsJmUySLr6MIASBmNucgH9/bcB3lU0bun
         yXivkotlYhgn3Lv5H8Ike8larfxG5NrEHb2tQ3dKeIJrE23r5EoziHHvnynV6ah6Npry
         ljpA==
X-Gm-Message-State: AC+VfDxDHTnrCEvvauF+W8TfLlGpBYNoCMUVPqIE3cfyGeSyinTMvHoD
	QZgBKP6Ff4b5FaJn9PIx0Y0=
X-Google-Smtp-Source: ACHHUZ7JjW8b6fgOe+JthCsQbs9/NjABXgCew6ba8g3n2m02um8mxuD9LeyNll8XOwuywhMwRgh5kw==
X-Received: by 2002:a05:6a20:7491:b0:126:8ddd:d786 with SMTP id p17-20020a056a20749100b001268dddd786mr5575003pzd.46.1687844870738;
        Mon, 26 Jun 2023 22:47:50 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id je5-20020a170903264500b001b8004ff609sm3033756plb.270.2023.06.26.22.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 22:47:50 -0700 (PDT)
Date: Mon, 26 Jun 2023 22:47:49 -0700
From: Guenter Roeck <linux@roeck-us.net>
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
	Hugh Dickins <hughd@google.com>, Dinh Nguyen <dinguyen@kernel.org>,
	Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v5 26/33] nios2: Convert __pte_free_tlb() to use ptdescs
Message-ID: <13bab37c-0f0a-431a-8b67-4379bf4dc541@roeck-us.net>
References: <20230622205745.79707-1-vishal.moola@gmail.com>
 <20230622205745.79707-27-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230622205745.79707-27-vishal.moola@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230626_224757_863483_440DA7F0 
X-CRM114-Status: GOOD (  15.81  )
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

On Thu, Jun 22, 2023 at 01:57:38PM -0700, Vishal Moola (Oracle) wrote:
> Part of the conversions to replace pgtable constructor/destructors with
> ptdesc equivalents.
> 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>

This patch causes all nios2 builds to fail.

Building nios2:allnoconfig ... failed
--------------
Error log:
<stdin>:1519:2: warning: #warning syscall clone3 not implemented [-Wcpp]
In file included from mm/memory.c:85:
mm/memory.c: In function 'free_pte_range':
arch/nios2/include/asm/pgalloc.h:33:17: error: implicit declaration of function 'pagetable_pte_dtor'; did you mean 'pgtable_pte_page_dtor'? [-Werror=implicit-function-declaration]
   33 |                 pagetable_pte_dtor(page_ptdesc(pte));                   \
      |                 ^~~~~~~~~~~~~~~~~~
include/asm-generic/tlb.h:666:17: note: in expansion of macro '__pte_free_tlb'
  666 |                 __pte_free_tlb(tlb, ptep, address);             \
      |                 ^~~~~~~~~~~~~~
mm/memory.c:193:9: note: in expansion of macro 'pte_free_tlb'
  193 |         pte_free_tlb(tlb, token, addr);
      |         ^~~~~~~~~~~~
arch/nios2/include/asm/pgalloc.h:33:36: error: implicit declaration of function 'page_ptdesc' [-Werror=implicit-function-declaration]
   33 |                 pagetable_pte_dtor(page_ptdesc(pte));                   \
      |                                    ^~~~~~~~~~~
include/asm-generic/tlb.h:666:17: note: in expansion of macro '__pte_free_tlb'
  666 |                 __pte_free_tlb(tlb, ptep, address);             \
      |                 ^~~~~~~~~~~~~~
mm/memory.c:193:9: note: in expansion of macro 'pte_free_tlb'
  193 |         pte_free_tlb(tlb, token, addr);
      |         ^~~~~~~~~~~~
arch/nios2/include/asm/pgalloc.h:34:17: error: implicit declaration of function 'tlb_remove_page_ptdesc'; did you mean 'tlb_remove_page_size'? [-Werror=implicit-function-declaration]
   34 |                 tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));      \
      |                 ^~~~~~~~~~~~~~~~~~~~~~
include/asm-generic/tlb.h:666:17: note: in expansion of macro '__pte_free_tlb'
  666 |                 __pte_free_tlb(tlb, ptep, address);             \
      |                 ^~~~~~~~~~~~~~
mm/memory.c:193:9: note: in expansion of macro 'pte_free_tlb'
  193 |         pte_free_tlb(tlb, token, addr);

> ---
>  arch/nios2/include/asm/pgalloc.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/nios2/include/asm/pgalloc.h b/arch/nios2/include/asm/pgalloc.h
> index ecd1657bb2ce..ce6bb8e74271 100644
> --- a/arch/nios2/include/asm/pgalloc.h
> +++ b/arch/nios2/include/asm/pgalloc.h
> @@ -28,10 +28,10 @@ static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd,
>  
>  extern pgd_t *pgd_alloc(struct mm_struct *mm);
>  
> -#define __pte_free_tlb(tlb, pte, addr)				\
> -	do {							\
> -		pgtable_pte_page_dtor(pte);			\
> -		tlb_remove_page((tlb), (pte));			\
> +#define __pte_free_tlb(tlb, pte, addr)					\
> +	do {								\
> +		pagetable_pte_dtor(page_ptdesc(pte));			\
> +		tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));	\
>  	} while (0)
>  
>  #endif /* _ASM_NIOS2_PGALLOC_H */
> -- 
> 2.40.1
> 
> 

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
