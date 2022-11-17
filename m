Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 492A2C4332F
	for <linux-um@archiver.kernel.org>; Thu, 17 Nov 2022 00:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WnJEhr8C7TDzd9smvaKqqmF0av3OdyIW1Pdtz+1NmQc=; b=eqCoHRirwcCTwQ
	RKFMEuTNb8n237EJ5ij5bU4xfs5tcQPOiE9z5HK2VFGxm4oOgAxVZWVktK1KmMx2y6aDFVgE6y7+6
	2XHR5hlV5tvtV34JAbR6ujEDwqoYAaxJdcRDutKCl8n++BsZXaV1ryGVPLCWMJaYW9i26+cFDSWto
	6XtH7RO+jSpOb3M3doo9kB/9XmNP7C2Q1S8V4J8lSIl0r8je/hRxNaC4IiKKcdNrowJEaPG3j+c+h
	Cqk5qLZms65dOa0JevNtZC5T8mSxxlKh1NgytHEKw/4OKuE0jJ6vLiXK6DdOBPNLasxGeY0E3BfiB
	RX3zZmAiTgi5VFmh9WbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovT2p-009EqQ-MO; Thu, 17 Nov 2022 00:46:19 +0000
Received: from mail-qk1-x72e.google.com ([2607:f8b0:4864:20::72e])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovT2b-009EjF-Q0
	for linux-um@lists.infradead.org; Thu, 17 Nov 2022 00:46:07 +0000
Received: by mail-qk1-x72e.google.com with SMTP id i9so219847qki.10
        for <linux-um@lists.infradead.org>; Wed, 16 Nov 2022 16:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rT9xjSJmKp4cCvf16bTKl9Dc4YEY7MjOtsK/w44qv+E=;
        b=VV2cb+pd6jfcSL2tauZE67KBioAHcybPQR+VfU40dKebsvpG7CB3+xd0Uv8h8MKz8R
         sbSQ7TqeMCU61fYQIjRwQoQBWrCcg8ekkdEQ8V7xYjRGPq0DN+C0Atnpvt0eAux7Zvaz
         PXr7WI31PYcmErRNWRYdBKljCyptLiKShcOF4gqH5bxcH7c9a48sUWSu+SLW+D60rEcT
         94q2cJm8yEvdEzbYpl0Vwvwu6uXwvrse0KXhbaR5xd9/LECZYdD6vR+hmUeAJTlxbvcq
         ueSGRE+vNlUSsDE90kXWUWeAcS6lHSqHDXkbeBbAuFPPnKLrO2HgUtltNTPZxflFTx6j
         B+8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rT9xjSJmKp4cCvf16bTKl9Dc4YEY7MjOtsK/w44qv+E=;
        b=MR9HlZ9bhpffIjNUfqbbGMsyKNMvnIHmOPJ3YyUV/if8oVYPak2gOi4Jom/3AjDoWd
         EOitlMFDyecnPoZ8UoOdp6ljwHPEYwB86I7dTdFA5E44l8Wm+8SkKXCHHHxyV8bDji3C
         rNiKue6UjF5RK3TKkfDWqmVJ7im5xgBrSeIJihHb5ndIsiycmfc+q9v2OhFMuHN/Ee2Z
         34xHKLfXCIEJOQry1s3uj7cODCw9gWchOWKYTPsgKaPUtbydpzd5NktUhuYrr+3z4ENR
         te1Wkb02JRR0uM7LVfni2K0YavsqLyW5r+XqCGYoAL18b9CDV7RUoBTn/4qgQqdnQu3l
         0HKw==
X-Gm-Message-State: ANoB5pk6RfHhSlhxBlVKuzGLOkYzn1EsCcjgrBQO6zVs77DLr+9Qfp5/
	4AKnez9cqKfJK8ehjE5CmbHCPBqeKL41Ig==
X-Google-Smtp-Source: AA0mqf607w9C7cuVA1Gk/5OO594s7B3KGBk4c2yq8D1+/1YgY/KvFwESfDj3NEnwxZjz0MAqyk7Deg==
X-Received: by 2002:a37:424c:0:b0:6fb:a0ec:c5ba with SMTP id p73-20020a37424c000000b006fba0ecc5bamr8177915qka.493.1668645964499;
        Wed, 16 Nov 2022 16:46:04 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-122-23.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.122.23])
        by smtp.gmail.com with ESMTPSA id i18-20020a05620a405200b006fa84082b6dsm11394495qko.128.2022.11.16.16.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 16:46:03 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1ovT2Z-0066UZ-3n;
	Wed, 16 Nov 2022 20:46:03 -0400
Date: Wed, 16 Nov 2022 20:46:03 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-ia64@vger.kernel.org, linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
	linux-um@lists.infradead.org, etnaviv@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-samsung-soc@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-media@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-perf-users@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Hugh Dickins <hughd@google.com>, Nadav Amit <namit@vmware.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Matthew Wilcox <willy@infradead.org>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Muchun Song <songmuchun@bytedance.com>,
	Shuah Khan <shuah@kernel.org>, Lucas Stach <l.stach@pengutronix.de>,
	David Airlie <airlied@gmail.com>, Oded Gabbay <ogabbay@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Christoph Hellwig <hch@infradead.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Bernard Metzler <bmt@zurich.ibm.com>,
	Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH mm-unstable v1 12/20] RDMA/siw: remove FOLL_FORCE usage
Message-ID: <Y3WES5adl6yyS4ZB@ziepe.ca>
References: <20221116102659.70287-1-david@redhat.com>
 <20221116102659.70287-13-david@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221116102659.70287-13-david@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221116_164605_872311_EF8DAA9B 
X-CRM114-Status: GOOD (  12.90  )
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

On Wed, Nov 16, 2022 at 11:26:51AM +0100, David Hildenbrand wrote:
> GUP now supports reliable R/O long-term pinning in COW mappings, such
> that we break COW early. MAP_SHARED VMAs only use the shared zeropage so
> far in one corner case (DAXFS file with holes), which can be ignored
> because GUP does not support long-term pinning in fsdax (see
> check_vma_flags()).
> 
> Consequently, FOLL_FORCE | FOLL_WRITE | FOLL_LONGTERM is no longer required
> for reliable R/O long-term pinning: FOLL_LONGTERM is sufficient. So stop
> using FOLL_FORCE, which is really only for ptrace access.
> 
> Cc: Bernard Metzler <bmt@zurich.ibm.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Leon Romanovsky <leon@kernel.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  drivers/infiniband/sw/siw/siw_mem.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
