Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BD5DC636D4
	for <linux-um@archiver.kernel.org>; Fri,  3 Feb 2023 14:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pHT9xT4ve6SzDwYA+uFACxEvs2/CJGP6biEST/lmAR4=; b=kjQPJytH83qpLe
	DN0Xb3bTpabckDCfq9Uo9zcYhCQ8pPkc1Uwh+/yTVA4WjHPvWjLjNr+FlrAYmVxh4WTJvmua6T9ZO
	JmxaW65yvsAawU3j1mgzMIPCGXNocfEWEI1CqWjeVbONg97vQuhjfKCc9TKrWO4MUwEuG9bVk2y3W
	CNbvbB4dyjKnLA69TQEdPUWw2GwnAvITlShg/twSrX4f9pgx3cc1sUDpZbnCTnFDNrq0LfND7I9u+
	wuT+8020UsFPF+muHDtlWvLKm0x/Qi1xInU4RMpqyPEukGwLb1ggMvlt84N9IvsdWKrc5X1T9omTL
	QFNhmXaXVSp7zfj3/ssw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pNx7H-002SpE-VT; Fri, 03 Feb 2023 14:32:40 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pNx5x-002S1a-Gb
	for linux-um@lists.infradead.org; Fri, 03 Feb 2023 14:31:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1675434676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bBuUxRqwVpT90qSSvu23sLwWbKqZ02KC/SRu5tcTWNA=;
	b=KoCvTALGset8w6k1Si6CZ6l/74I0+l5J/fxz9/c71cc6sQogROtaYrOAQo01YgoYvBfzrC
	q/3LKjhGqMHX5kY8yrNk80Qy/RpbK+qE8oRrud0H8y+CB6t5xX/mDDkf3Jcvz8Ofnv+gqE
	Zxtn52h1d7tdsFFEMfyeGja/aYjxP64=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-606-CV6TftI0NGigobc0icIJmw-1; Fri, 03 Feb 2023 09:31:15 -0500
X-MC-Unique: CV6TftI0NGigobc0icIJmw-1
Received: by mail-wm1-f69.google.com with SMTP id x10-20020a05600c21ca00b003dc5584b516so4691508wmj.7
        for <linux-um@lists.infradead.org>; Fri, 03 Feb 2023 06:31:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bBuUxRqwVpT90qSSvu23sLwWbKqZ02KC/SRu5tcTWNA=;
        b=0nr+VVsBQfvIQ9Z3o/5pZe1dbtYv6IAJxjfRATeuuR06wqsX3ErQL73AJnrdUsEHqj
         EEs9ByIinDIFI9OvcV3LwBvGCV9SHNX9NOXeWHrTcIBy3fIhggSRbp/Wl72vxNXopsf5
         OrLN2+LTdCLLToIuKoC+YcTPR77nj3BmSMlinz51oc7APwDFJRfW+7hnZkS1GVymqy/n
         SMN9oF8mHCeErdfsLM/0D+5hae8Dz+FUx/0TCka/Fy7CAYYwKPCa0SJ9C6UrpP1yCK0/
         +7OmnTlObWqYUOF0M4QK//Z8Vde55bIfxMtFP5qykkCGEmr6iw9ZLqPyQeAoBO40zDpH
         3BcA==
X-Gm-Message-State: AO0yUKUckk3R3EN/mfBjEIwQMDwbzWE3hU2MOri3lD9pSK32C3TneMZ2
	92qCAwF98MURm/5fQb7KiUxx/E5h+rN9jGA4TRrpVXsa/Uh4XaHHXApqVLqBAmcNqdzposCgveu
	hY2b1KdlE/MzW7LGWFBko2rBE
X-Received: by 2002:a05:600c:4707:b0:3df:e6bb:768 with SMTP id v7-20020a05600c470700b003dfe6bb0768mr2347073wmo.24.1675434673739;
        Fri, 03 Feb 2023 06:31:13 -0800 (PST)
X-Google-Smtp-Source: AK7set8jlKBL+3VH/Q/zFxtw4x3QAOrg1CgHYVk1aVg00PiHMhqeIMC/qbmUMqYVh9aDbNcRdczHvA==
X-Received: by 2002:a05:600c:4707:b0:3df:e6bb:768 with SMTP id v7-20020a05600c470700b003dfe6bb0768mr2347047wmo.24.1675434673459;
        Fri, 03 Feb 2023 06:31:13 -0800 (PST)
Received: from [192.168.3.108] (p5b0c6376.dip0.t-ipconnect.de. [91.12.99.118])
        by smtp.gmail.com with ESMTPSA id w14-20020a05600c474e00b003dfe57f6f61sm2479833wmo.33.2023.02.03.06.31.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Feb 2023 06:31:12 -0800 (PST)
Message-ID: <862cb71f-0775-916d-b0c9-5247f772d637@redhat.com>
Date: Fri, 3 Feb 2023 15:31:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 2/4] m68k: use asm-generic/memory_model.h for both MMU
 and !MMU
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
 <20230129124235.209895-3-rppt@kernel.org>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230129124235.209895-3-rppt@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230203_063117_657795_578DB9DA 
X-CRM114-Status: GOOD (  10.11  )
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
> The MMU variant uses generic definitions of page_to_pfn() and
> pfn_to_page(), but !MMU defines them in include/asm/page_no.h for no
> good reason.
> 
> Include asm-generic/memory_model.h in the common include/asm/page.h and
> drop redundant definitions.
> 
> Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
