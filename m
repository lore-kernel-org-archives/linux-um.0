Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F387AC83F25
	for <linux-um@archiver.kernel.org>; Mon, 21 Jul 2025 22:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qziS/qpONFFAWWmGEcjsGqxLtdqROLsiMhv3HQa+DVo=; b=4H2mhfuNCLlx/ze76UI4/wH1AE
	+KthoboTxy8qfNi1QAe9JcboHF1FAzlP+2xj+kwdKHC1yQRiPhfTrV/EE7M/amZlvLALIUWCo8i8t
	SUQ2bl9vTek6KwF+pAJ0LTsFivmWsxsokI5THRBUJn3Zgfd99VdO6+qn97hOS098eAWgvmDeTmNt1
	+VmBu+7gCFWmf5qdRw88159hHGCDBbAsdnhGLCq3uFuq2Yy0Hb96Y0BkO5GrNZmpKfNnFeQlWpfeK
	B3LxFnJROh2dnmyol+DFWMIKLvAhIrN5EohOOxAg8Yec5zMRE5OL6OnycV554qMGaFUUORRcZNA7m
	vPu1Pk3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1udzU6-00000000q43-0CPw;
	Mon, 21 Jul 2025 22:59:50 +0000
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1udzU2-00000000q2e-3Mpg;
	Mon, 21 Jul 2025 22:59:47 +0000
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-ae0df0bb8fbso82980966b.3;
        Mon, 21 Jul 2025 15:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753138785; x=1753743585; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qziS/qpONFFAWWmGEcjsGqxLtdqROLsiMhv3HQa+DVo=;
        b=OjwEEa40+VLpqlYLZE/hfTyYXfaDdcr0f1VJOEgqerOQh3+iza2Xfwtz3KEm2yBSal
         Iwi+3xLnOL3SVH/f5zolDHxE5AB9MmQAboTTGzFFu/vXV8eq8d5P1atp3oXpkAI5l5Ik
         ZOoXt/PbhuRa8b8wiL9sS0v0SAyMC+10w66KZFrEPr3XKvV3D3dZcDdKtvqNE1a4zx0M
         QVhiCm6hiJQ978yILlWNsDcB9ggZEW05BejmpHJFwNp8Tt9L+VBibz6/Lxn9rpIvKN+F
         1CydypQ9RBo5Ci3z8q1SpQjLNkHNB4UEngZpr6kEoi8UHoBVD0ZHHYf4WFgPcihK4Z6L
         rt/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753138785; x=1753743585;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qziS/qpONFFAWWmGEcjsGqxLtdqROLsiMhv3HQa+DVo=;
        b=dwreNsoLL4gUOvDT3IFV7F66J/FO+85wnae84PrcpYFyiU7afPW/Fl4XuvSZ7GHyIM
         xGfI45A3el8ftQEeYfXXbg27RGz3O/9Sp/qcKAoTDT1qmvYp4XlV8YmQqIb6tee6pJDc
         KEnegY7RyGtZL548BSWkwfh922SqGHT3z79ZHbBQZJqurcKkioupZhr5iDUs3TlU+QEO
         xn1NnbCz3LfwpzOcJxksweUk72ARrl/UduzpiF/2jbtkIZLlnMNr1t+e3o97njAV8Wwy
         pRI30AWD9866hubizyrSPz6JSyTqM5vC3/p59JrFNklGb/dnqAIeThwPz7QDk1BM2gwd
         y0Ng==
X-Forwarded-Encrypted: i=1; AJvYcCWES7fr+/x9xh/Ys85ihO5JUCN5HNV8YoM2KPKAyhWTdKYr6ZwHnfwqOKJddHrNHp9oULaeR8prWXk=@lists.infradead.org, AJvYcCWFGEy+yYqKjfzX4moqjUJAqfRAmilaNdGr1lf6dg4PK2P/QDK9VMKHjI85nKmOPBWOweZ3qq2ejV1ppQ==@lists.infradead.org
X-Gm-Message-State: AOJu0Yzhk4VRvXmIZ7jRGvckrpeaV0cvEzu2Lh6t64//RC7SP4vAf5Bd
	P7siVkuOFpQIwoiFuxa8wfYlmyr4LagwBlfBIAOGHAy/K5T4E4rKmZy3
X-Gm-Gg: ASbGncspcR0X2Cygv/KkNAScQybiREhSJ07nYYN7/bDM+BhgrW+7kHQtUELLrI/uypJ
	oyYcvTBKGu3MKUHx59fD8cLVsQ9ofq/pUrlRQwaPrr+Ve+lXpsAykOcx3lXYJoieYNnWwQ1hatk
	7Lp2DsYh/4EoChqKAvThYLe7XkS6kbn67ax2+KDYQvhWJBdlr1UWQOJV4cyIhlqePT9o3VVV33c
	7+N3zmGSAV18sgOPBWKFXtbYf1Ikh3cfKrUTeCZ3RNqzb99ShsP1PNNX3Oozxs4a8cf8PFf0XrW
	L72IGUpOjkCpEqwkNLOaMqXi9VRC0InArafZGAqwpdX5Sk2PR0GO9nFJ0NQECMcafyr9UTS5c5q
	emrbkehLJNyeubNGd4i2BicBbCcyDA2BwPE2ZZKI9WWqZc75Vc8rC4GNwM2MerHQ+Lpev
X-Google-Smtp-Source: AGHT+IFBO2iP/n38Feyyqa7ON62IpV2R/kvBKzJAAeBv02jcMXCr2o0KVEmn950sS2xc+ad0bPTgUA==
X-Received: by 2002:a17:907:1b05:b0:ae3:bd92:e6aa with SMTP id a640c23a62f3a-ae9c99adb7amr852181266b.6.1753138784434;
        Mon, 21 Jul 2025 15:59:44 -0700 (PDT)
Received: from [192.168.0.18] (cable-94-189-142-142.dynamic.sbb.rs. [94.189.142.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6ca7d330sm755829066b.126.2025.07.21.15.59.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jul 2025 15:59:43 -0700 (PDT)
Message-ID: <f10f3599-509d-4455-94a3-fcbeeffd8219@gmail.com>
Date: Tue, 22 Jul 2025 00:59:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/12] kasan: unify kasan_arch_is_ready() and remove
 arch-specific implementations
To: Sabyrzhan Tasbolatov <snovitoll@gmail.com>, hca@linux.ibm.com,
 christophe.leroy@csgroup.eu, andreyknvl@gmail.com, agordeev@linux.ibm.com,
 akpm@linux-foundation.org
Cc: glider@google.com, dvyukov@google.com, kasan-dev@googlegroups.com,
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-um@lists.infradead.org, linux-mm@kvack.org
References: <20250717142732.292822-1-snovitoll@gmail.com>
Content-Language: en-US
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
In-Reply-To: <20250717142732.292822-1-snovitoll@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250721_155946_849720_2E951E7B 
X-CRM114-Status: GOOD (  11.54  )
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



On 7/17/25 4:27 PM, Sabyrzhan Tasbolatov wrote:

> === Testing with patches
> 
> Testing in v3:
> 
> - Compiled every affected arch with no errors:
> 
> $ make CC=clang LD=ld.lld AR=llvm-ar NM=llvm-nm STRIP=llvm-strip \
> 	OBJCOPY=llvm-objcopy OBJDUMP=llvm-objdump READELF=llvm-readelf \
> 	HOSTCC=clang HOSTCXX=clang++ HOSTAR=llvm-ar HOSTLD=ld.lld \
> 	ARCH=$ARCH
> 
> $ clang --version
> ClangBuiltLinux clang version 19.1.4
> Target: x86_64-unknown-linux-gnu
> Thread model: posix
> 
> - make ARCH=um produces the warning during compiling:
> 	MODPOST Module.symvers
> 	WARNING: modpost: vmlinux: section mismatch in reference: \
> 		kasan_init+0x43 (section: .ltext) -> \
> 		kasan_init_generic (section: .init.text)
> 
> AFAIU, it's due to the code in arch/um/kernel/mem.c, where kasan_init()
> is placed in own section ".kasan_init", which calls kasan_init_generic()
> which is marked with "__init".
> 
> - Booting via qemu-system- and running KUnit tests:
> 
> * arm64  (GENERIC, HW_TAGS, SW_TAGS): no regression, same above results.
> * x86_64 (GENERIC): no regression, no errors
> 

It would be interesting to see whether ARCH_DEFER_KASAN=y arches work.
These series add static key into __asan_load*()/_store*() which are called
from everywhere, including the code patching static branches during the switch.

I have suspicion that the code patching static branches during static key switch
might not be prepared to the fact the current CPU might try to execute this static
branch in the middle of switch.

