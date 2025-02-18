Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAE7BC021AA
	for <linux-um@archiver.kernel.org>; Tue, 18 Feb 2025 10:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zl+t4KaKTs9+cWw6JHoz3j9vod1OhAsIgp3kjHQDp0E=; b=p+gQkb2ZNOYPSkz+9w0Xy4JRB6
	OaRBqriKUlO5zknBIRa5RK/Mgu8xAuIXE92yFhBSNpQZcNH9m3LinsFuSx2W+gihmw6BZVe5N7o1M
	Zu3dDWVVclJMOc8RSs+OStMmsPH8+41bInnylVJnAPZBv48leAUNrdQWZQY4fr09iZRWfJrQU4l9M
	T890Oih6xbcRumcPUJwNwAHOhylWz4WkOgTr0C4GkYMF/kCy3GPkqCoksOCLtrs0cDszRuoYFeu45
	IxJJMBWmzZhLXNQuDwp+pBkxRtn6QqP3LiOi1ZXuoN07hG2BKbwwTnq6tKsqXugwrs5D6S+7pN9Cg
	I//9Lfmw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tkKzc-00000007nZL-2040;
	Tue, 18 Feb 2025 10:38:20 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tkKuG-00000007m3x-3ebU
	for linux-um@lists.infradead.org;
	Tue, 18 Feb 2025 10:32:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739874768;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zl+t4KaKTs9+cWw6JHoz3j9vod1OhAsIgp3kjHQDp0E=;
	b=Ha+WLSHf2eQqouT3KBJjcgr2YoG7foL/f/jnHRr/h2FHd2a6y3zmqRucTFSr7QlrIlIjL/
	3J98COoFyQnju3PVO13EOelIe27Y/nM+uh0P6BRcS+Jcgp3SgAlHy3ECDhJpU0z8/aKkMA
	3dEbrPAuChIHkAT85KIHX1QWT7oDErE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-Nr1lUVaJNEuUTZjW1Ms4Kg-1; Tue, 18 Feb 2025 05:32:46 -0500
X-MC-Unique: Nr1lUVaJNEuUTZjW1Ms4Kg-1
X-Mimecast-MFC-AGG-ID: Nr1lUVaJNEuUTZjW1Ms4Kg_1739874765
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-38f2f438fb6so4171275f8f.1
        for <linux-um@lists.infradead.org>; Tue, 18 Feb 2025 02:32:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739874765; x=1740479565;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zl+t4KaKTs9+cWw6JHoz3j9vod1OhAsIgp3kjHQDp0E=;
        b=mTjPPKLRlNEKb1cVXtwHlzBAxOy7fu8F65BwTaFyST0vguHIp66Cg1NIk6OPQLPfyV
         1CDa/K6EYjHsFcJly4nOCcLitBmBmN17RcTWdm2f0/9w6Pvc3BGhGjBXiDy/VN+QbeKn
         otmvWhYYOiKV5IZyS2CuGdGIRvgP3zVOKXhO1IeBFAd5xZo10uo1bd1I3pVBNPh0Mb/G
         Irxi4Xeih+wYWEnDgrEa2Equn9htQuuSuc7/G6Q8AQRIhIPvvb9Z0U5HnpU0g78GwqYN
         K7Nz58f4CkVIAKeW4UrXrHQQNH6gWprjOmU4Nut/8QNk+l7wP90gRx32Jq4GKpV/IWGe
         4+ig==
X-Forwarded-Encrypted: i=1; AJvYcCWa96Tkb6hwKXCCJGBQ5artexK1uM5PsYDhRCp65/H+nIEs3UFkRk6feIwoCzrwoc0PbGyBGnVeJw==@lists.infradead.org
X-Gm-Message-State: AOJu0YzJDGaYZbVeHlMalagej8NWoCErGLKOBxUsrqRywxFimPJeG8lk
	WXaEN43HNM1B4cJ13WfIH+chyd7DYgJLIv9jvn3DT0kJjqmsmvGWMQHurUxXnaL8TlZsYZfD6Ns
	83ZrN89PL3Z8PRjAN3hTzEUJW9ieY9bFW+jr4CT06xj+C3d1hqHHrdAaKlFFS2Q==
X-Gm-Gg: ASbGncsjqS08Aw6u4uhEX6yNNZa2hIr6jEBNCBDz3ENaJG3EoK3w/o7BOuKptpBidHq
	f561vrN4n6MV8yiqICZDvYQWfAodBDb2ZdWr7eyHGHvU00TJpz2f+izobGxi0aAuko7wWpdbEVC
	i31Is9sL/yA1yAOD0n1D8hkVLxnOWXwSRwef/2jEL4CqpevMhUarPFTfmsdEn7s43TK5GFeUWv5
	0+cPv+NK8TTUwcAJm/n4Qa541R40nV2LoV7TJh5PFo/HXAwuZEAU73bbmG4KhV4f+N7ywwNxn6f
	LeQ1/GUhxqLttA6aeoepj1aCpXd74Fynmo/NrCtdsA7v9RzMRDxqQcRts49RorHnhw6qTYQ+ZoV
	H2cYTiCUPO1nSzyBlIwTxdqbZ2k1d+ziv
X-Received: by 2002:a5d:444e:0:b0:385:d7f9:f157 with SMTP id ffacd0b85a97d-38f33f50c03mr11146145f8f.36.1739874765509;
        Tue, 18 Feb 2025 02:32:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHFoZP2GHZ6yD/enVlIVfGFoZuVzgKIlrmVpkt2wTKjnhpYW41AK3ZcwVNJXA3ZnS3Vw67J9A==
X-Received: by 2002:a5d:444e:0:b0:385:d7f9:f157 with SMTP id ffacd0b85a97d-38f33f50c03mr11146116f8f.36.1739874765191;
        Tue, 18 Feb 2025 02:32:45 -0800 (PST)
Received: from ?IPV6:2003:cb:c70d:fb00:d3ed:5f44:1b2d:12af? (p200300cbc70dfb00d3ed5f441b2d12af.dip0.t-ipconnect.de. [2003:cb:c70d:fb00:d3ed:5f44:1b2d:12af])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259f7df2sm14623376f8f.84.2025.02.18.02.32.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 02:32:44 -0800 (PST)
Message-ID: <4d38ad6a-a7ee-486b-a189-aca575eaa654@redhat.com>
Date: Tue, 18 Feb 2025 11:32:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] mm: Make mk_pte() definition unconditional
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org
Cc: linux-arch@vger.kernel.org, x86@kernel.org, linux-s390@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-um@lists.infradead.org
References: <20250217190836.435039-1-willy@infradead.org>
 <20250217190836.435039-7-willy@infradead.org>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzSREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZgEEwEIAEICGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAhkBFiEEG9nKrXNcTDpGDfzKTd4Q9wD/g1oFAl8Ox4kFCRKpKXgACgkQTd4Q
 9wD/g1oHcA//a6Tj7SBNjFNM1iNhWUo1lxAja0lpSodSnB2g4FCZ4R61SBR4l/psBL73xktp
 rDHrx4aSpwkRP6Epu6mLvhlfjmkRG4OynJ5HG1gfv7RJJfnUdUM1z5kdS8JBrOhMJS2c/gPf
 wv1TGRq2XdMPnfY2o0CxRqpcLkx4vBODvJGl2mQyJF/gPepdDfcT8/PY9BJ7FL6Hrq1gnAo4
 3Iv9qV0JiT2wmZciNyYQhmA1V6dyTRiQ4YAc31zOo2IM+xisPzeSHgw3ONY/XhYvfZ9r7W1l
 pNQdc2G+o4Di9NPFHQQhDw3YTRR1opJaTlRDzxYxzU6ZnUUBghxt9cwUWTpfCktkMZiPSDGd
 KgQBjnweV2jw9UOTxjb4LXqDjmSNkjDdQUOU69jGMUXgihvo4zhYcMX8F5gWdRtMR7DzW/YE
 BgVcyxNkMIXoY1aYj6npHYiNQesQlqjU6azjbH70/SXKM5tNRplgW8TNprMDuntdvV9wNkFs
 9TyM02V5aWxFfI42+aivc4KEw69SE9KXwC7FSf5wXzuTot97N9Phj/Z3+jx443jo2NR34XgF
 89cct7wJMjOF7bBefo0fPPZQuIma0Zym71cP61OP/i11ahNye6HGKfxGCOcs5wW9kRQEk8P9
 M/k2wt3mt/fCQnuP/mWutNPt95w9wSsUyATLmtNrwccz63XOwU0EVcufkQEQAOfX3n0g0fZz
 Bgm/S2zF/kxQKCEKP8ID+Vz8sy2GpDvveBq4H2Y34XWsT1zLJdvqPI4af4ZSMxuerWjXbVWb
 T6d4odQIG0fKx4F8NccDqbgHeZRNajXeeJ3R7gAzvWvQNLz4piHrO/B4tf8svmRBL0ZB5P5A
 2uhdwLU3NZuK22zpNn4is87BPWF8HhY0L5fafgDMOqnf4guJVJPYNPhUFzXUbPqOKOkL8ojk
 CXxkOFHAbjstSK5Ca3fKquY3rdX3DNo+EL7FvAiw1mUtS+5GeYE+RMnDCsVFm/C7kY8c2d0G
 NWkB9pJM5+mnIoFNxy7YBcldYATVeOHoY4LyaUWNnAvFYWp08dHWfZo9WCiJMuTfgtH9tc75
 7QanMVdPt6fDK8UUXIBLQ2TWr/sQKE9xtFuEmoQGlE1l6bGaDnnMLcYu+Asp3kDT0w4zYGsx
 5r6XQVRH4+5N6eHZiaeYtFOujp5n+pjBaQK7wUUjDilPQ5QMzIuCL4YjVoylWiBNknvQWBXS
 lQCWmavOT9sttGQXdPCC5ynI+1ymZC1ORZKANLnRAb0NH/UCzcsstw2TAkFnMEbo9Zu9w7Kv
 AxBQXWeXhJI9XQssfrf4Gusdqx8nPEpfOqCtbbwJMATbHyqLt7/oz/5deGuwxgb65pWIzufa
 N7eop7uh+6bezi+rugUI+w6DABEBAAHCwXwEGAEIACYCGwwWIQQb2cqtc1xMOkYN/MpN3hD3
 AP+DWgUCXw7HsgUJEqkpoQAKCRBN3hD3AP+DWrrpD/4qS3dyVRxDcDHIlmguXjC1Q5tZTwNB
 boaBTPHSy/Nksu0eY7x6HfQJ3xajVH32Ms6t1trDQmPx2iP5+7iDsb7OKAb5eOS8h+BEBDeq
 3ecsQDv0fFJOA9ag5O3LLNk+3x3q7e0uo06XMaY7UHS341ozXUUI7wC7iKfoUTv03iO9El5f
 XpNMx/YrIMduZ2+nd9Di7o5+KIwlb2mAB9sTNHdMrXesX8eBL6T9b+MZJk+mZuPxKNVfEQMQ
 a5SxUEADIPQTPNvBewdeI80yeOCrN+Zzwy/Mrx9EPeu59Y5vSJOx/z6OUImD/GhX7Xvkt3kq
 Er5KTrJz3++B6SH9pum9PuoE/k+nntJkNMmQpR4MCBaV/J9gIOPGodDKnjdng+mXliF3Ptu6
 3oxc2RCyGzTlxyMwuc2U5Q7KtUNTdDe8T0uE+9b8BLMVQDDfJjqY0VVqSUwImzTDLX9S4g/8
 kC4HRcclk8hpyhY2jKGluZO0awwTIMgVEzmTyBphDg/Gx7dZU1Xf8HFuE+UZ5UDHDTnwgv7E
 th6RC9+WrhDNspZ9fJjKWRbveQgUFCpe1sa77LAw+XFrKmBHXp9ZVIe90RMe2tRL06BGiRZr
 jPrnvUsUUsjRoRNJjKKA/REq+sAnhkNPPZ/NNMjaZ5b8Tovi8C0tmxiCHaQYqj7G2rgnT0kt
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250217190836.435039-7-willy@infradead.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: tpT1FPmRNtWOwfbql6_tMJBnzGJskyXJVhInreR87V4_1739874765
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250218_023248_992656_02CFA765 
X-CRM114-Status: GOOD (  12.14  )
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
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

On 17.02.25 20:08, Matthew Wilcox (Oracle) wrote:
> All architectures now use the common mk_pte() definition, so we
> can remove the condition.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>   include/linux/mm.h | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 3ef11ff3922f..62dccde9c561 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1916,14 +1916,12 @@ static inline struct folio *pfn_folio(unsigned long pfn)
>   	return page_folio(pfn_to_page(pfn));
>   }
>   
> -#ifndef mk_pte
>   #ifdef CONFIG_MMU
>   static inline pte_t mk_pte(struct page *page, pgprot_t pgprot)
>   {
>   	return pfn_pte(page_to_pfn(page), pgprot);
>   }
>   #endif
> -#endif
>   
>   /**
>    * folio_maybe_dma_pinned - Report if a folio may be pinned for DMA.

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


