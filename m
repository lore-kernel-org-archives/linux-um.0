Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F3FEC021AA
	for <linux-um@archiver.kernel.org>; Tue, 18 Feb 2025 10:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=G+HjwJ9mJ5Ava/YF/RbVKXd+QR18qcRDmZfeajdLUu8=; b=NLbmUsxkjW4ZqXwXudgW3m0WOt
	wRAPqWkShUVSnmvBH1ZQbAvCnRe0zj4tfAC8Ry71UagsoNjyKnFBejf5xBDp2rbfiF3/tfHSi8Aau
	4iD+/wrEcfrhrGHzsd5UG1WGlNpqsL5TjqmY8bv0VjWEwuMrBMoIctOfK94fIVN+40TinRF04Oqns
	vIrcNfXxX6yCKxk9QT0MvxYS6r6Z3VCOCnH5f3VDqD7OR0XL8riLUuR+CrECUMFs1bPNoquAfdUTe
	9CHbMrnAWKmQvl/+o7bevUYsmJbIjDK+ldSwIpX3q+O5JR87btXoU1QptqYuw2m6xZTz6MWlP0FfM
	JaQIoRug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tkKyA-00000007nDU-2UKz;
	Tue, 18 Feb 2025 10:36:50 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tkKr8-00000007l8B-3u6x
	for linux-um@lists.infradead.org;
	Tue, 18 Feb 2025 10:29:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739874573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=G+HjwJ9mJ5Ava/YF/RbVKXd+QR18qcRDmZfeajdLUu8=;
	b=NkkKIOXfuoC3JDxSWjfTtwCu2FO2cnuh1sXjqzwmws8YZJORZ40dKkoMLRKWU28UGlMfoz
	ewU3s/docihZ+ibEdyfEPZSZXg6wJRTOEv6NqUE/JyRSeQqVIztALYJfAYOqUqC6+Nq4pI
	SmjfGtTTWLicS7LiAEcKRt3HxkHRpE4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-49iUcc_CP6eEzvk0fddvPQ-1; Tue, 18 Feb 2025 05:29:31 -0500
X-MC-Unique: 49iUcc_CP6eEzvk0fddvPQ-1
X-Mimecast-MFC-AGG-ID: 49iUcc_CP6eEzvk0fddvPQ_1739874570
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-38f2f78aee1so2254417f8f.0
        for <linux-um@lists.infradead.org>; Tue, 18 Feb 2025 02:29:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739874570; x=1740479370;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=G+HjwJ9mJ5Ava/YF/RbVKXd+QR18qcRDmZfeajdLUu8=;
        b=CpVTf5xOVSAa32qoE2wmxnpiwLVT/7wMDk4xZ7IzafPJ2mL0YL+qi34P/6WeTRFPxs
         fmd1c+w3lOa72K0W+yJpu8vVuA3LWP2qn3FubbHSVq4LX23+go/bTCqOhVQ4P3Go0Wsk
         vtuPLnV21EzKaRhLL8RTIBWcf9keAElEA60w3k2s9fur5SbMsO4Sct2BV/nXEUvRhy+u
         IO4Y7NZrO7dbunw5kKmZRW8i3Crde5+IL4I/uhSeZPMh5yLMY8oIYGtyGXKAO9DbsuMK
         0OMWJ+tRcUvBdEkEZoUMZyTVRqRGvWSQ0BFlsmtPkBZSid2HPGjg/RmBBTJMug6u2mKd
         NJTg==
X-Forwarded-Encrypted: i=1; AJvYcCXaXj3iXOAKS4OgINbbtFkk1I09CSEVT9RCZgIRU2A/FlkXtbIK5+FGuls5hI3Px6c2w8azejKUXg==@lists.infradead.org
X-Gm-Message-State: AOJu0Yy0wKNu9ws7ace+r2breDQA6ogLEBlfTcNE5TgRsiE5zXIhyqoQ
	O8RCbBkuHSu3NhsUk9eykYObz2AYmzTkBLiVrUSsCDCtua57qB6TfeiIYKZEHzAHD7CHlpn3CSP
	Qn8NxUJIszf2OtEWLwcqCKU8dll6SptqepRK/5lSUZpSiY1HB7RLfodV02VH5Dw==
X-Gm-Gg: ASbGncvTiacz2to5Q29AvL2RJX2vBzuIYZkVpDgshG6wzerl4f67gItVfZLVqj9dfZf
	6AAyhwyNiYYELr5/xgmum4vDjNHyF3aOn6vMfVFGj5k9iWqcspUVyAxjQ5XTYxL2XUW5T3R38WA
	pDDaaKPZBAUhK4nG8QmcmSL9EPEb9UlQLUjn7BGEd6cNRnlyekQUxLFgIdieGT3IjGEVnTbIhzg
	7Cp1WPq6FwKhFQpnMWbcE8PIvKnrgr1wQZyQTP9e0xth1qub9X5IBvh7ZHMb/ZgjXwZyJo09ts6
	LAUhZ8d/siqPKrDNJgVLCjwMph8hSS8HODowgu06K03ktpNlxBnsA0gjH0P+K3LksIa/9lj0a5q
	plIXu4RkeOVnVbc+eGarSA6AovoopHguu
X-Received: by 2002:a5d:64aa:0:b0:38f:4f37:7504 with SMTP id ffacd0b85a97d-38f4f377bb4mr3195055f8f.16.1739874570266;
        Tue, 18 Feb 2025 02:29:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFN693UNj3uMUwWwlf2ctNsjDwCDYZ2rQpAw3Q3z51pqfxfutoeEP1sMGNfu8iSj0Dl+e27fA==
X-Received: by 2002:a5d:64aa:0:b0:38f:4f37:7504 with SMTP id ffacd0b85a97d-38f4f377bb4mr3195027f8f.16.1739874569894;
        Tue, 18 Feb 2025 02:29:29 -0800 (PST)
Received: from ?IPV6:2003:cb:c70d:fb00:d3ed:5f44:1b2d:12af? (p200300cbc70dfb00d3ed5f441b2d12af.dip0.t-ipconnect.de. [2003:cb:c70d:fb00:d3ed:5f44:1b2d:12af])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43994f0c10csm12319315e9.26.2025.02.18.02.29.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 02:29:29 -0800 (PST)
Message-ID: <dcc74d17-9e5c-468a-a248-e4cddca2b1dc@redhat.com>
Date: Tue, 18 Feb 2025 11:29:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] Add folio_mk_pte() and simplify mk_pte()
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org
Cc: linux-arch@vger.kernel.org, x86@kernel.org, linux-s390@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-um@lists.infradead.org
References: <20250217190836.435039-1-willy@infradead.org>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250217190836.435039-1-willy@infradead.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: MJ7_QyVeaxEEvp3zqeo32uXPzsCxXjDNi3cqYCfWc_o_1739874570
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250218_022935_049346_75160431 
X-CRM114-Status: GOOD (  15.90  )
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
> The intent is to add folio_mk_pte() to remove the conversion from folio
> to page necessary to call mk_pte().  Eventually we might end up removing
> mk_pte(), but that's not what's being proposed today.
> 
> I didn't want to add folio_mk_pte() to each architecture, and I didn't
> want to lose any optimisations that architectures have from their own
> implementation of mk_pte().  Fortunately, most architectures have by
> now turned their mk_pte() into a fairly bland variant of pfn_pte(),
> but s390 is different.
> 
> So patch 1 hoists the optimisation of calling pte_mkdirty() from s390
> to generic code.  I'd appreciate some eyes on this from mm people who
> understand this better than I do.  I originally had
> 
> -	if (write)
> +	if (write || folio_test_dirty(folio))
> 		entry = maybe_mkwrite(pte_mkdirty(entry), vma);
> 
> and I think that broke COW under some circumstances that 01.org could
> reproduce and I couldn't.

If it's an anon folio that logic would be broken, yes (anon CoW). We do 
have can_change_pte_writable() that tells you when it is safe to upgrade 
write permissions for a PTE.

Looking at can_change_pte_writable(), I don't know if filesystems with 
writenotify might have a problem when setting the PTE dirty and allowing 
for write access, just because the folio is dirty.

So I assume that it would break fs-level CoW indeed.

-- 
Cheers,

David / dhildenb


