Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FF82C021AE
	for <linux-um@archiver.kernel.org>; Tue, 18 Feb 2025 10:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=T1LOQMZfXNCEDy18+82jAtJj33pWYHUPkHE+taTmaK4=; b=G310jMDFCe2HD2FDPq6O8N+NkI
	pMFibU88VwWRcFkxk+PjnqA4qMX+YevfS0zRywB2KD/wwDyTh/gAV8HyW/S313bjyRhdllLb0IHqm
	+Cl1+CuyaZ3ch2nJamJlkL3l9WjAoGtCOO0b4157K+GeEGoj4n38SEEKsBR++mr6Oz6JxxR+d3H+f
	TZE6/jBfNaWJ8mUIR+UK+FokFOhyHTW9Aq/RHuaijTFn5INHW305UWrBh0JlValbLMusOyjwdP1RK
	hAWLHn/HEagHpHO954Ez5bSzpYiNlc6dRozGzv3hZ72j/oqzFyqnylGpRBSoHxzXewAuPM0246f8p
	32OtlC0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tkKzc-00000007nZt-3PWb;
	Tue, 18 Feb 2025 10:38:20 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tkKv3-00000007mIH-2FmI
	for linux-um@lists.infradead.org;
	Tue, 18 Feb 2025 10:33:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739874816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=T1LOQMZfXNCEDy18+82jAtJj33pWYHUPkHE+taTmaK4=;
	b=Cu0gdBXJCXQqw/jaZpIPpsw1dnxm14GgzJTjDVxPOvMRuCUhCDpwKC4cbfAUHAlEovrIef
	+QZUYWgmAevPQWCT9f4M6HpW8DeJN5KtFw/UErWeuW/2u6aQMLkJ4GlCA9lxEVmqK1yq6/
	juVZU4KT81lRQHhiqZPxlgWPSrqJSWM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-442-W_oV50FDMbip7PFVgcytRQ-1; Tue, 18 Feb 2025 05:33:34 -0500
X-MC-Unique: W_oV50FDMbip7PFVgcytRQ-1
X-Mimecast-MFC-AGG-ID: W_oV50FDMbip7PFVgcytRQ_1739874813
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43935bcec79so31710875e9.3
        for <linux-um@lists.infradead.org>; Tue, 18 Feb 2025 02:33:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739874813; x=1740479613;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=T1LOQMZfXNCEDy18+82jAtJj33pWYHUPkHE+taTmaK4=;
        b=qlw2FbAAAq7adzx7Qx90yS7zIG7DGMO6zdpRxW6AI0Rc2KZxDoGkycqMG1R/sZfBoH
         Z3ZJW5PH40os8W1OZ+R80O9sRoAwcASGHvC8jITbX/ajKyoyJP+VeFfic4Tt5j/lXN4T
         tv7o9Y4x7dtvDrmrLXenouRkJr45aJ2Zo5cjXEBt8woHQ4zG/LzveR7f8WmRgnMrFieW
         kirQyuiB8KCoJ94RVB2pOwWHeDD3vvlEAhKn7f/iXJaCMwao4t5SaIEugAtexp2uaf3p
         NEgozivk0icby8ZSmNUIaLItPjGlCjfGz/VksZQFfb1QGV4mf5godCBDhvm5pXoQKT4k
         gxjw==
X-Forwarded-Encrypted: i=1; AJvYcCVepLor+k0EWgLyQXfjgKKsq7Sk9Wf+UsfZu1GhhwqYnzQnIuWT9qNKhGtvqywtesfUXp5BSFL84A==@lists.infradead.org
X-Gm-Message-State: AOJu0YyY0l+84fv7Kgv6umX+EpMLd7KZJREnKCRo9WRVv8A60Kgc/5So
	T7QM0jp/krZN7vQv4vINtbrXVwSiYcTl2lr6KQz1pCFbYII+zVkQp3fFT/Ub4Q0nZg6/iMkNlVO
	9EeTOIiuC0QF+KpiphTEIokyotVse1gRK9tLnYywEfS7Kq1cQAsBHCo/V8OmzsA==
X-Gm-Gg: ASbGnctxOTc04peV9rn/PFlZlKUPyLwQhHoE5Hq07VrQ9a0ACprySDcK+EhK1yTo/B7
	oQtGR8Is0HguJwFNTJ43pwF9ISNV4sfH7B15avJh/SWpeAK9+VQwLriQltUnFmf0kWWJ5hE8ruK
	NToSQEz48EMyvr9Hle48u7XMeEeQT4aLgp3bIZs7AkLidGMsZ4mbGw6COxcH3p8MjkZv/zRcZ8X
	WHrBvCx8whJefFVC5CmochYncpalVyCwk/HzdNGDEGfaPFLc24ubZXRQS6vXLtHCanK0BylQyRP
	kxHohcutDRth0PmEa4xjvSog3mCzaUl+P6yPKW+kWu7bIsix1URlERbyfkcLooyUiotq8fRcjpF
	KybGtrUjt313MnfcDFSeaRqmSqWng9gty
X-Received: by 2002:a05:600c:354f:b0:439:6b57:c6b with SMTP id 5b1f17b1804b1-4396e700738mr113218055e9.17.1739874813371;
        Tue, 18 Feb 2025 02:33:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG10HbiKwPJC3eaXgh0cFDz3lLRmRUxioOtL7qoeXgGZWfhvAtzEULY5k9Shgn7deaLtJSxFg==
X-Received: by 2002:a05:600c:354f:b0:439:6b57:c6b with SMTP id 5b1f17b1804b1-4396e700738mr113217795e9.17.1739874813029;
        Tue, 18 Feb 2025 02:33:33 -0800 (PST)
Received: from ?IPV6:2003:cb:c70d:fb00:d3ed:5f44:1b2d:12af? (p200300cbc70dfb00d3ed5f441b2d12af.dip0.t-ipconnect.de. [2003:cb:c70d:fb00:d3ed:5f44:1b2d:12af])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43987d1865asm46839995e9.3.2025.02.18.02.33.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 02:33:31 -0800 (PST)
Message-ID: <fcf41c06-ca68-4b26-9462-d96f7cda999c@redhat.com>
Date: Tue, 18 Feb 2025 11:33:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] mm: Add folio_mk_pte()
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org
Cc: linux-arch@vger.kernel.org, x86@kernel.org, linux-s390@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-um@lists.infradead.org
References: <20250217190836.435039-1-willy@infradead.org>
 <20250217190836.435039-8-willy@infradead.org>
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
In-Reply-To: <20250217190836.435039-8-willy@infradead.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -yvTjZAUBcnJv18wGy2pkYpAppsTszJD6X55T1pzL6o_1739874813
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250218_023337_649846_111DF057 
X-CRM114-Status: UNSURE (   5.68  )
X-CRM114-Notice: Please train this message.
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
> Removes a cast from folio to page in four callers of mk_pte().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---

Yes, that looks good

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


