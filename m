Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28E17C77B75
	for <linux-um@archiver.kernel.org>; Tue, 18 Apr 2023 15:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bJt9A6RNcEb2U6B5tDYSF5FW7H+XG/yzaWW7RKwGd0k=; b=kHy+12xpMzOR7e
	2SZ7sFlVTZfqBmSkk9FYo6p0eCqrtD9RQX14utP7CsVByOhxoIRwfAVXE8t7kDRnKt55EIfoOz5UV
	xm6mn3RubDgv3Oj49X9ltwmPOv9+su5z+dHhJtxSrI7BIkfXnuaIUOcPIMkPpmB3P83juxcBeC4h/
	XCQmGxIve57Yx23ethdD4am1uPqDJwnEXLXt1q3c90wtG/gIzRsJ59nW7g8DRVQ600cyV1GBzGBgl
	3FYAREtppVy+kEY7EW7E4Wlt3xMD7CDyPIDIdJEl5vej+KJRTfzGqN+HiEPt5+gY2w0ZZWIoEpYT8
	WNa42r9vpD5EtyFWll0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ponW7-002fOz-0F;
	Tue, 18 Apr 2023 15:45:15 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ponW3-002fNR-2z
	for linux-um@lists.infradead.org;
	Tue, 18 Apr 2023 15:45:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1681832711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=27YuiGTc/1Ayk3pIwHwifC0cK9cQSm41NYDsP6qMI7E=;
	b=U8JMYrlgiEj994b1hrSfSqrDjhhXCK47LNEPZZlIOsQi+ZB22f0Al53zFXUWl8isy99rZY
	/qiEg+Isjo2jy6vWzMdVtAfsrkfsetV/WtgOJsiwFZmMyk40b0apRxF8eL5nY9q9Ll9Px2
	Hb+JKTRNdIWqNkGQHQPaweFerSjxz0U=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-DjIcHoVdO8eIOjkdLcLlaw-1; Tue, 18 Apr 2023 11:45:07 -0400
X-MC-Unique: DjIcHoVdO8eIOjkdLcLlaw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3f0b0c85c4fso42470605e9.0
        for <linux-um@lists.infradead.org>; Tue, 18 Apr 2023 08:45:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681832706; x=1684424706;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=27YuiGTc/1Ayk3pIwHwifC0cK9cQSm41NYDsP6qMI7E=;
        b=X0/Ihj1feCfDjPB72JTQ/LFe37ZUaeXWjWo9OJ2gnBma6XFvj5z2QG8/9itYlyxO4g
         q2Tu8wR7/tCwwcAFOps7smQo2p3tsYJtEscey0PTdpiWqUbveQgkYdrZk0fXOo71yt0k
         eK2BjNyveyyxwG5g47jGEHnebsnihRuy7RVqqN+38Sy9icbsI7MWwcqA+lafa0gf1/yv
         jqOaA0vn72OrvmLMktGoFhe8ldvNqp0xiJmnFaMBHe035zhZ8JbLIwEQsT6vzPOwyMiF
         ZeFIkjYw6dLdpBClXYjBd2hcm7W5jVpUwQ80Z77eEL1N3U32ZUjxFd8zJ5m9SijZOfMC
         1E5Q==
X-Gm-Message-State: AAQBX9dIn4JlQk+EZQ0B36yZsd3ER+t15sd6MfDim8KNT3wbsa3gw1WC
	g242u4w3KYhcPuYKbDSovmMKo7QQ0lRbkyAtYZYdN+lhIGnO4eVj9pub7RnW1dcUgQEDLtD59ti
	T8F+MkvVduhtYj08FqlsBBSyX
X-Received: by 2002:a5d:6dcc:0:b0:2ef:b8ae:8791 with SMTP id d12-20020a5d6dcc000000b002efb8ae8791mr2341925wrz.10.1681832706618;
        Tue, 18 Apr 2023 08:45:06 -0700 (PDT)
X-Google-Smtp-Source: AKy350boD2pgyaTgtT87B/OGZT/ZiXFytTcP4U4+Qx8x/yMODSTgYDG7+n20ySQtuSYJgFc2NPKTdg==
X-Received: by 2002:a5d:6dcc:0:b0:2ef:b8ae:8791 with SMTP id d12-20020a5d6dcc000000b002efb8ae8791mr2341904wrz.10.1681832706235;
        Tue, 18 Apr 2023 08:45:06 -0700 (PDT)
Received: from ?IPV6:2003:cb:c715:3f00:7545:deb6:f2f4:27ef? (p200300cbc7153f007545deb6f2f427ef.dip0.t-ipconnect.de. [2003:cb:c715:3f00:7545:deb6:f2f4:27ef])
        by smtp.gmail.com with ESMTPSA id z10-20020a5d654a000000b002daeb108304sm13380984wrv.33.2023.04.18.08.45.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 08:45:05 -0700 (PDT)
Message-ID: <da600570-51c7-8088-b46b-7524c9e66e5d@redhat.com>
Date: Tue, 18 Apr 2023 17:45:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 01/33] s390: Use _pt_s390_gaddr for gmap address tracking
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, linux-arch@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
 linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
 linux-openrisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-um@lists.infradead.org, xen-devel@lists.xenproject.org,
 kvm@vger.kernel.org
References: <20230417205048.15870-1-vishal.moola@gmail.com>
 <20230417205048.15870-2-vishal.moola@gmail.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230417205048.15870-2-vishal.moola@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230418_084512_039958_F9299895 
X-CRM114-Status: GOOD (  16.94  )
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

On 17.04.23 22:50, Vishal Moola (Oracle) wrote:
> s390 uses page->index to keep track of page tables for the guest address
> space. In an attempt to consolidate the usage of page fields in s390,
> replace _pt_pad_2 with _pt_s390_gaddr to replace page->index in gmap.
> 
> This will help with the splitting of struct ptdesc from struct page, as
> well as allow s390 to use _pt_frag_refcount for fragmented page table
> tracking.
> 
> Since page->_pt_s390_gaddr aliases with mapping, ensure its set to NULL
> before freeing the pages as well.
> 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> ---

[...]

> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 3fc9e680f174..2616d64c0e8c 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -144,7 +144,7 @@ struct page {
>   		struct {	/* Page table pages */
>   			unsigned long _pt_pad_1;	/* compound_head */
>   			pgtable_t pmd_huge_pte; /* protected by page->ptl */
> -			unsigned long _pt_pad_2;	/* mapping */
> +			unsigned long _pt_s390_gaddr;	/* mapping */
>   			union {
>   				struct mm_struct *pt_mm; /* x86 pgds only */
>   				atomic_t pt_frag_refcount; /* powerpc */

The confusing part is, that these gmap page tables are not ordinary 
process page tables that we would ordinarily place into this section 
here. That's why they are also not allocated/freed using the typical 
page table constructor/destructor ...

-- 
Thanks,

David / dhildenb


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
