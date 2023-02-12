Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F377C636D3
	for <linux-um@archiver.kernel.org>; Sun, 12 Feb 2023 17:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Yzvg0kqFUtsW45z4k6R4j+RqlH30qoxOMykGTX47rK4=; b=wTnHUm/FNP9IkE
	3gZxwcVtNU82Bc+ELXUm05HiSeN6Gw3kgLiNPV6OHG+Pxuv4rY7XqofaZ3+/G77nN24EKtN5JvrX3
	Rod729FKpYF6xPh9ssJ50Zbkew8ylwRPBxpOAMwQpcS6AisisNuA1FkDUbOyeZLinqY3JJpajUk3K
	SdVb/47mbU72bt0/Fe08Ct+GrDG+Z8Snb9tVU5eJvUKeHqgC4BjFoj60+78SaU0Tzsuufq9cpRxWT
	Myn4brS5JawjWQ0ROqV0hviUJMR1WH4MKCYT+4cz8PTstvPNPLSgKkVaiCa0+rW1xbrc+XqWimi3f
	+zwRqEsyrZNCgR6uU4aQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pRGJY-00BzFq-Oq; Sun, 12 Feb 2023 17:39:01 +0000
Received: from mail-oa1-x2c.google.com ([2001:4860:4864:20::2c])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pRGJK-00BzB1-Ab; Sun, 12 Feb 2023 17:38:47 +0000
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-15fe106c7c7so12815473fac.8;
        Sun, 12 Feb 2023 09:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=gEc3d6k45zjDeEZHbol4IIwzjmxqM4mBWgDI31Sfc5o=;
        b=R330sse/EVLRGFL0igafPWieDgvfGLbUv1mxwjjJZAHpBvZcU2/Gg7Ye7o55WJDp/T
         d/MkHSIY+rV5WmpmEtSQ3EcpkVyHgH/g8WGwdicgdAr8s7fVYzB3M6AQYSXN1fWO7dsD
         adnG3ljI9LKreMS0IYacGj+zm2/uKWOjveyAMeTbeBXzAlA0+lDjE38oWr0kFL4x/3pl
         NtGAiadx3cotdBgXvBg6mFyqYNavUvZnDTVR9OSu3hxj7Glcs0NmbhgPuh+/V46P8f0N
         UAStFFymZhcq+751kC0Xe8LgThvdTeD+HxCq3F5UGXwSHXYBMgqQ0gCOk/Vyqx7W2YhY
         u2kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gEc3d6k45zjDeEZHbol4IIwzjmxqM4mBWgDI31Sfc5o=;
        b=VQqA00cpwV1eHP24rOw22/Mg3AjqXlp398/LCbOSfItuaPIyJRFO/8EFAw2iLUI+NN
         DUldOXIXSOE4q5Rb/wyvznvdu45x7Nsa+zMPvTbPUuCwgYcE5EBDDB69Gw7j6oydkSEE
         rZepRYNKVoW95MdHQSe4uH9oAz8chc6SW4tc62KqMEm6SH9V5rrWk6J37O+MIBzypgbS
         Ti7dtxFiaFkNO6SYzZZxVakPNFdy+pkHmgAOTZ9ZnvyMgHfpc0vzJvPIUmJ536+vosvP
         f/H1mXYzW9vguRtGb07dAERZB53UsapM+g9beaMd5AXJ1oyDLKWKYTv/ymmKwdIkmWtm
         6OlQ==
X-Gm-Message-State: AO0yUKUtSlWNXFSZI5oPR3LmesgPGMNdzB2XzMLRM18FnsE6aIg3/u9x
	NkzXbfDMXV5EzbWtbva/qBM=
X-Google-Smtp-Source: AK7set/4d6sAa3sFADK7k8Ny8wL2J6QT+VlS2G9nj4JhFjRiy2CF6KFV2p0y673SokHVHJOuHdHtkw==
X-Received: by 2002:a05:6870:2885:b0:16e:a65:3b8e with SMTP id gy5-20020a056870288500b0016e0a653b8emr473342oab.9.1676223521592;
        Sun, 12 Feb 2023 09:38:41 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n40-20020a056870822800b0013bc95650c8sm4012885oae.54.2023.02.12.09.38.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Feb 2023 09:38:41 -0800 (PST)
Message-ID: <64f2ba37-d869-0160-1a89-d7f15d243d05@roeck-us.net>
Date: Sun, 12 Feb 2023 09:38:36 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 4/4] mm, arch: add generic implementation of
 pfn_valid() for FLATMEM
Content-Language: en-US
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>,
 Brian Cain <bcain@quicinc.com>, "David S. Miller" <davem@davemloft.net>,
 Dinh Nguyen <dinguyen@kernel.org>, Geert Uytterhoeven
 <geert@linux-m68k.org>, Greg Ungerer <gerg@linux-m68k.org>,
 Guo Ren <guoren@kernel.org>, Helge Deller <deller@gmx.de>,
 Huacai Chen <chenhuacai@kernel.org>, Matt Turner <mattst88@gmail.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Michal Simek <monstr@monstr.eu>, Palmer Dabbelt <palmer@dabbelt.com>,
 Rich Felker <dalias@libc.org>, Richard Weinberger <richard@nod.at>,
 Russell King <linux@armlinux.org.uk>, Stafford Horne <shorne@gmail.com>,
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
 sparclinux@vger.kernel.org, x86@kernel.org,
 Huacai Chen <chenhuacai@loongson.cn>
References: <20230129124235.209895-1-rppt@kernel.org>
 <20230129124235.209895-5-rppt@kernel.org>
 <20230212161320.GA3784076@roeck-us.net> <Y+kTHsaq8FAG72CX@kernel.org>
From: Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <Y+kTHsaq8FAG72CX@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230212_093846_378427_96F66967 
X-CRM114-Status: GOOD (  12.44  )
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

On 2/12/23 08:26, Mike Rapoport wrote:
> Hi Guenter,
> 
> On Sun, Feb 12, 2023 at 08:13:20AM -0800, Guenter Roeck wrote:
>> On Sun, Jan 29, 2023 at 02:42:35PM +0200, Mike Rapoport wrote:
>>> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
>>>
>>> Every architecture that supports FLATMEM memory model defines its own
>>> version of pfn_valid() that essentially compares a pfn to max_mapnr.
>>>
>>> Use mips/powerpc version implemented as static inline as a generic
>>> implementation of pfn_valid() and drop its per-architecture definitions.
>>>
>>
>> With this patch in the tree, sh4 and sh4eb qemu emulations no longer boot.
>> Reverting this patch fixes the problem.
>   
> Can you please test with only partial revert for arch/sh?
> 

Sure, that works as well.

Guenter


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
