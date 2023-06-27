Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BA98C0015E
	for <linux-um@archiver.kernel.org>; Tue, 27 Jun 2023 07:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yeNfzqovjrx9M4wgVQmNcm1Qu5j5UV4t/GH9JHGQ6eI=; b=G5GbO2UYKmAuyq
	xATu3hH1KibYWChyol13BuceKw2rwDBvHvMLpijjTPIIPyK+5UIwgLQpq5IFzdGijdaJ6ug5Ycw2r
	+xRfMlVv+8XT9EWA+IkPyy9SILTHW9248Ztg55O5H4lD2ea3ffZ0Z5Bmbd4k3qkL9pjWE0enAzofo
	2m9KwBn03bcuwRgcOKmQZtQQW26SCcyGpOSFSlD4VujTT2N746a/wXsJ02suL2EzGTpuCxrEUVruN
	HqiwLxZwd1tekS149SWsRlB8mr9oLRwgDCyk389RcMS3zuQj9X1Md2/vI31oBcuDoDqeZmjQeBqmH
	1RL9GFgHow98I2VZgJMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qE2uP-00CHXQ-09;
	Tue, 27 Jun 2023 07:14:41 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qE2uK-00CHUq-2C
	for linux-um@lists.infradead.org;
	Tue, 27 Jun 2023 07:14:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687850075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N1scKhPxxz/YxysE64BuheSdyQmgV4XhiinPf6icWX8=;
	b=gLHtxCt7YxT7fD4RUMsMt5nkuqomgRGHLVnhkE5mtTO9G6qqlrV6MupV/chx6JnAHldSvj
	wk86egqixoIqEzSgzOQ0uzhhe50WyoLlDU0uUS0mQ8IJsOJB9b5honExYv+XEhLrorqKcT
	tv5LsStXpK5QhintwqeKkiF2P9peTmQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-266-w3Hdh1bpMkeqtZZLtouWEw-1; Tue, 27 Jun 2023 03:14:33 -0400
X-MC-Unique: w3Hdh1bpMkeqtZZLtouWEw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3f814f78af2so17782695e9.0
        for <linux-um@lists.infradead.org>; Tue, 27 Jun 2023 00:14:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687850072; x=1690442072;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N1scKhPxxz/YxysE64BuheSdyQmgV4XhiinPf6icWX8=;
        b=e48+sjD4SI7UJ2J6QlCSzjvbL/78m59cTWaz5pat32NrEmRAPAa9Nl26MDk6GLrSHe
         IUZBZ6DI7iywWqx31jelrkBZvyDkT+9nDivCGImiApllQ+C4TvY9+neglvOv5h90nADw
         A1xA53R213+SApWk+AaHyWW5xXnw8RfHBInw4M0njIJ7lUtzjpmHI5QHkD6X7x4m/Bzg
         EjVLOVhqKzorCBFetCcPZHECSSbvriBWDz19Wb7/BOevMeyy2sfFxldBKpV/xLimeaK0
         +9xgxARr4++ZcpdfvgX3dFJuDpTp4phKjnjKlR8U+tJoMN26fjeDNIzanC8ENgzwuaqn
         GK2A==
X-Gm-Message-State: AC+VfDysxu0WyIX2ySruFayvAxh1MSH03NhJBNYC+VHJSSSql/K6b6ik
	2gg0KUFnAdnseWnlLYycc5J5N6iGfzV+gERuMvWpG2cz6ab3Kkxxm4tUphzRfZavCm694FBrH9p
	QPBASUGl2G22cgOEyMt7CprC+
X-Received: by 2002:a05:600c:3655:b0:3fa:9d0f:f1e1 with SMTP id y21-20020a05600c365500b003fa9d0ff1e1mr2936769wmq.35.1687850072225;
        Tue, 27 Jun 2023 00:14:32 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6HIpOGvancvhac5jw2GR0kOhKc72MxDndtCuN9HZ1pSF+uaoBl/D52ddajPiSHV9uK1Eb9sw==
X-Received: by 2002:a05:600c:3655:b0:3fa:9d0f:f1e1 with SMTP id y21-20020a05600c365500b003fa9d0ff1e1mr2936755wmq.35.1687850071891;
        Tue, 27 Jun 2023 00:14:31 -0700 (PDT)
Received: from ?IPV6:2003:cb:c737:4900:68b3:e93b:e07a:558b? (p200300cbc737490068b3e93be07a558b.dip0.t-ipconnect.de. [2003:cb:c737:4900:68b3:e93b:e07a:558b])
        by smtp.gmail.com with ESMTPSA id 21-20020a05600c22d500b003f96d10eafbsm9778433wmg.12.2023.06.27.00.14.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jun 2023 00:14:31 -0700 (PDT)
Message-ID: <ac1c162c-07d8-6084-44ca-a2c1a4183df2@redhat.com>
Date: Tue, 27 Jun 2023 09:14:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v6 00/33] Split ptdesc from struct page
To: Hugh Dickins <hughd@google.com>,
 "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
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
 Catalin Marinas <catalin.marinas@arm.com>,
 Huacai Chen <chenhuacai@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Dinh Nguyen <dinguyen@kernel.org>, Jonas Bonn <jonas@southpole.se>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 "David S. Miller" <davem@davemloft.net>, Richard Weinberger
 <richard@nod.at>, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Dave Hansen <dave.hansen@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>,
 Christophe Leroy <christophe.leroy@csgroup.eu>
References: <20230627031431.29653-1-vishal.moola@gmail.com>
 <e8992eee-4140-427e-bacb-9449f346318@google.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <e8992eee-4140-427e-bacb-9449f346318@google.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230627_001436_858752_F9236830 
X-CRM114-Status: GOOD (  17.89  )
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

On 27.06.23 06:44, Hugh Dickins wrote:
> On Mon, 26 Jun 2023, Vishal Moola (Oracle) wrote:
> 
>> The MM subsystem is trying to shrink struct page. This patchset
>> introduces a memory descriptor for page table tracking - struct ptdesc.
> ...
>>   39 files changed, 686 insertions(+), 455 deletions(-)
> 
> I don't see the point of this patchset: to me it is just obfuscation of
> the present-day tight relationship between page table and struct page.
> 
> Matthew already explained:
> 
>> The intent is to get ptdescs to be dynamically allocated at some point
>> in the ~2-3 years out future when we have finished the folio project ...
> 
> So in a kindly mood, I'd say that this patchset is ahead of its time.
> But I can certainly adapt to it, if everyone else sees some point to it.

I share your thoughts, that code churn which will help eventually in the 
far, far future (not wanting to sound too pessimistic, but it's not 
going to be there tomorrow ;) ).

However, if it's just the same as the other conversions we already did 
(e.g., struct slab), then I guess there is no reason to stop now -- the 
obfuscation already happened.

... or is there a difference regarding this conversion and the previous 
ones?

-- 
Cheers,

David / dhildenb


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
