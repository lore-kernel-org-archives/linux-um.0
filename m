Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9020C61DA4
	for <linux-um@archiver.kernel.org>; Fri,  3 Feb 2023 14:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZpI/6Ldxt8+Gne0tsTbSupTVXkGGM1Ot13xHkbRgtCw=; b=hLRBgEZD3H0Eyh
	uze0pS2DScPP6LajH8eY0UT3QVNc67nlmK4uNgEeOySA/IoyycdObYdt1/l3kFHV/VoGBzRnTd2PR
	7taJ6spx3zgebxL25DkpScsrntIYUd3ph7Cf37teMjxv60S5enpV4PHFLjChAqI2R/J5kUgtlIIzK
	cAU8h5cqdfS1CkdiRD1FKE1vREDFE/yoW1FwhesIMfGWPAgKH/+Yxcuzdv5hol4/iqb4Kuj9n5Q31
	+RGwtAe5MVFrBPH5eOgOHFvwci1nNTUKD9qfLO53210L8OAJWKoowh1vUktHe2+lSugE4ZbacGht1
	Fxr9R+Vn89nUBDbXldXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pNxD2-002VX1-Ri; Fri, 03 Feb 2023 14:38:36 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pNxBs-002V2B-Ml
	for linux-um@lists.infradead.org; Fri, 03 Feb 2023 14:37:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1675435041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/decAsXzWzOr1Fn5getBDCGr7TKXQO+f4q0N0MxWErI=;
	b=H1C4CgV2NU65axw+g9rpPGe8qMRGX9i6pAy75fA1iuE9CNfVToiWj8Uf8EEI2yNCgpi9/o
	cNPyC3ccLMvNNC4MFbgPEMGuExtifNopbV6AmmB6o851h49g7y9LlOHOc6SzQxrQCuHH0A
	X9Qw26zjFBj9s+BfAtAmzD/TDjx6MRA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-147-Pq8jRXFsPMWW19ESyegu8g-1; Fri, 03 Feb 2023 09:32:02 -0500
X-MC-Unique: Pq8jRXFsPMWW19ESyegu8g-1
Received: by mail-wr1-f72.google.com with SMTP id i9-20020a0560001ac900b002bfda39265aso714456wry.13
        for <linux-um@lists.infradead.org>; Fri, 03 Feb 2023 06:31:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/decAsXzWzOr1Fn5getBDCGr7TKXQO+f4q0N0MxWErI=;
        b=5qIzAw11Nq6/6+mrxsF4ehE+ePIIX9DdjHwDVAe4vHzsgAGDsDpKzjLXUYblvj1kt2
         YhhIa0//qLREeEBDmBcwEOF10ytDy2KToiP0hOsFntuw4C5rErMQNXI+FjON+nKFDAfm
         JCRjP+CYte3HuWbEY4mjbK785be67WOzdJniK5Okl9RN1G/W9HxWip6XLp5pIWQPMe5T
         yQUIbCs9bMVd9imFTJum15VrqE9q9sYJdJHOGzjPefp0eKTft3h//b9SckNA3HboKPEH
         hRPSlpWnLyh7XVAMhcGeM5RCfon8KFXtlkBmTGC/ulVdVzRmPdfEUHT1Bu//zHNPrweH
         7kXw==
X-Gm-Message-State: AO0yUKUaqyA3//NIVLNY+3ij50NOrVt7YFhlMjOvmhFU0Nn9NEQH5f5B
	O7S4I8PzJctgto0apcRlntzIFS1sJnHrulLiox+dLEAntM49q9Ne+0JwBaU7Say9gbmEPaiLmk5
	EzZ5K1gvaWZx5nsZASLjRsavh
X-Received: by 2002:a05:600c:4747:b0:3df:e549:bd27 with SMTP id w7-20020a05600c474700b003dfe549bd27mr3634985wmo.6.1675434695218;
        Fri, 03 Feb 2023 06:31:35 -0800 (PST)
X-Google-Smtp-Source: AK7set/qkaMfF+TBCgvbwgP2CGu2sIJoLRpl09HLMUmy0eiiBTILy4lbS6cT+HBgr82lyryc+pIpNQ==
X-Received: by 2002:a05:600c:4747:b0:3df:e549:bd27 with SMTP id w7-20020a05600c474700b003dfe549bd27mr3634941wmo.6.1675434694897;
        Fri, 03 Feb 2023 06:31:34 -0800 (PST)
Received: from [192.168.3.108] (p5b0c6376.dip0.t-ipconnect.de. [91.12.99.118])
        by smtp.gmail.com with ESMTPSA id q9-20020a1ce909000000b003dc34edacf8sm7704293wmc.31.2023.02.03.06.31.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Feb 2023 06:31:34 -0800 (PST)
Message-ID: <1d13abeb-ea4b-6314-2fd2-1b86b8f4d6c5@redhat.com>
Date: Fri, 3 Feb 2023 15:31:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 3/4] mips: drop definition of pfn_valid() for
 DISCONTIGMEM
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
 <20230129124235.209895-4-rppt@kernel.org>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230129124235.209895-4-rppt@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230203_063725_072545_4D453FFE 
X-CRM114-Status: UNSURE (   9.05  )
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
> There is stale definition of pfn_valid() for DISCONTINGMEM memory model
> guarded !FLATMEM && !SPARSEMEM && NUMA ifdefery.
> 
> Remove everything but definition of pfn_valid() for FLATMEM.
> 
> Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
