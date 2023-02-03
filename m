Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CB43C05027
	for <linux-um@archiver.kernel.org>; Fri,  3 Feb 2023 14:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oO+PPZDjUDCb+vgOC5rqvv+uovBeckkDfsrNzR48o5g=; b=TH4ax0QPm79doF
	1qezyMgzA+a4DuMRADFDPKNliNb1L+wj5N2s9Hkg0iLVg7b6ffb0f39Cx5TMHfi1UvNmgQXwoHTi4
	ayFcZUYbhBmFODy+YwOSvIeo+HKSrTO+5VKLPg7+yP8pGDMyNbqmONJNnImGc7kxHikuIalObiSnq
	vKev0WsKjxekLvmVOhL17dnWzjwucS0b53MQ36GG0hxaHHiKX+7Xqyu79ce/C3AJwfacaA6ka/xaO
	Ig82RoCllBNRgRj4gSSFpMNBK8sW6BwWA+Vyed2y4N0xnVB9oXpMckwWKQzpCO+d06XAC8TSBXDny
	alhA1Dpb1f5fDtkvCskQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pNx67-002S9o-Q8; Fri, 03 Feb 2023 14:31:27 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pNx53-002RYm-Nx
	for linux-um@lists.infradead.org; Fri, 03 Feb 2023 14:30:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1675434618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FGqA/t5BHooNtKKmgY/P/RvUeTIDhJpfv4X01I3UuzM=;
	b=P8qzXveJOOKidGroGDRSjJif7Ju7vo86XrAFwhoVMgmLeJZ4pDxyVrH7oMrR2TRofK/YYY
	7qZf5SgymR7l3UHX48wuoFjsJhI+FkJKOnjeOOUtT5ecnQfpvYbYyZJ5pQb22kKEgOPZ7L
	j2ZtkNwN2jk0CEA8r0TACMnlZZu8RPs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-119-B9hARmkpM3WIXooWPntOGQ-1; Fri, 03 Feb 2023 09:30:17 -0500
X-MC-Unique: B9hARmkpM3WIXooWPntOGQ-1
Received: by mail-wm1-f72.google.com with SMTP id o42-20020a05600c512a00b003dc5341afbaso2692720wms.7
        for <linux-um@lists.infradead.org>; Fri, 03 Feb 2023 06:30:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FGqA/t5BHooNtKKmgY/P/RvUeTIDhJpfv4X01I3UuzM=;
        b=uwatu8cdmGG5r7P3uPpL9U5S81z9EI2ShEjr02W1WxGGCwU3YBQ7ceRngF8PKMihi1
         TbpQfG7IMMi8lygs3k/0bOqtdsfIBXp4KPRjJh1Ti7ze3C5d1o+T9AHjyIkRMu70Z8Pm
         D6WpFkFLt+54cCtrTQ3ANclv64Ms6qdwibNpoqPY7i+ryLrDzkNVw5QmCoXlUq1DvrOA
         9OKte94whnlip3GCKZVzdeLdqeBE8p4+mEkUoq7Tw8zahQ2PKPJE72k9ZYgU0LpQ1P1a
         VXw7UOb5n+UWy1xwJjRUWua664E/uTLCng0HglYeamYsR8smfspKj1RX5nkqtecWnruU
         aHFA==
X-Gm-Message-State: AO0yUKVCLpHGF2e9hlhM+qv9xfMwniw9A5ymN580KkEwP3y7oGhG/5al
	zYge6vdJU9Z3+aqxD5G+dxta1+5ub/HFL2XefKW9nZzlaUdQfxZ2Z9hshtK3kNNaOWKYnXmNp1u
	77iGCjaueUXdCGuzo0u8LY0+I
X-Received: by 2002:a05:600c:3588:b0:3df:e1e9:200e with SMTP id p8-20020a05600c358800b003dfe1e9200emr4472920wmq.39.1675434616196;
        Fri, 03 Feb 2023 06:30:16 -0800 (PST)
X-Google-Smtp-Source: AK7set+3Fxk3nALXFhpoXy/lSyMSFcdmxLuZvgb86YYfx4M4JIQvKCJs/tKTkc3VpDPsDt8toFavpA==
X-Received: by 2002:a05:600c:3588:b0:3df:e1e9:200e with SMTP id p8-20020a05600c358800b003dfe1e9200emr4472869wmq.39.1675434615896;
        Fri, 03 Feb 2023 06:30:15 -0800 (PST)
Received: from [192.168.3.108] (p5b0c6376.dip0.t-ipconnect.de. [91.12.99.118])
        by smtp.gmail.com with ESMTPSA id h27-20020a05600c2cbb00b003db12112fcfsm3203111wmc.4.2023.02.03.06.30.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Feb 2023 06:30:15 -0800 (PST)
Message-ID: <569308c6-558b-de6e-1e98-2f50c1c56755@redhat.com>
Date: Fri, 3 Feb 2023 15:30:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 1/4] arm: include asm-generic/memory_model.h from
 page.h rather than memory.h
To: Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Brian Cain <bcain@quicinc.com>,
 "David S. Miller" <davem@davemloft.net>, Dinh Nguyen <dinguyen@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Greg Ungerer
 <gerg@linux-m68k.org>, Guo Ren <guoren@kernel.org>,
 Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>,
 Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Michal Simek <monstr@monstr.eu>,
 Palmer Dabbelt <palmer@dabbelt.com>, Rich Felker <dalias@libc.org>,
 Richard Weinberger <richard@nod.at>, Russell King <linux@armlinux.org.uk>,
 Stafford Horne <shorne@gmail.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Vineet Gupta <vgupta@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, linux-alpha@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
 linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
 linux-mm@kvack.org, linux-parisc@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, linux-um@lists.infradead.org,
 linux-xtensa@linux-xtensa.org, linuxppc-dev@lists.ozlabs.org,
 loongarch@lists.linux.dev, openrisc@lists.librecores.org,
 sparclinux@vger.kernel.org, x86@kernel.org
References: <20230129124235.209895-1-rppt@kernel.org>
 <20230129124235.209895-2-rppt@kernel.org>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230129124235.209895-2-rppt@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230203_063021_958225_163F2B7D 
X-CRM114-Status: UNSURE (   9.06  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

On 29.01.23 13:42, Mike Rapoport wrote:
> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> 
> Makes it consistent with other architectures and allows for generic
> definition of pfn_valid() in asm-generic/memory_model.h with clear override
> in arch/arm/include/asm/page.h
> 
> Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
