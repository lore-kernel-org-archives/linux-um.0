Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD26BCF34B5
	for <linux-um@archiver.kernel.org>; Thu,  3 Oct 2024 14:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WdndKVp/SXRSmiqlbx9yFx2IrKrWcsly5j+I0V4+Xpc=; b=2JqPQvHeQul8M9zxt2UcPvz86s
	m1MRr0NVWd3LBacqPKdc76mHdLMt17Fsnd1wOU7stIrER9iVfWGhkyxJp+16sAprAkeFP+JVGCkGF
	GnFXNPAqepdIZLuhcOPWwqJUAwdR8yIVW0pfjw+aHL8HbIp0RLiJaq7l0XYN5IvzhKUKARWGW4Xo0
	znMUls/ccsA/Jk6Y8iLHkZRT9j6yxvOvQYSgFZXJp5+JbVBXggjKsrg9gSRSY2BHcPWZeYGrLzDgv
	4tbm1iAZBdmC2tEq498e2Cvf+z2tOSQ0dxgeIBwQ81AXC5zm+/6Se6KnQfmlkSzvgZeKPKqdppiIJ
	HfJCkJSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1swN9b-00000009SaT-05aj;
	Thu, 03 Oct 2024 14:50:07 +0000
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1swN9O-00000009SXG-2M7z
	for linux-um@lists.infradead.org;
	Thu, 03 Oct 2024 14:50:05 +0000
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-20ba8d92af9so7693855ad.3
        for <linux-um@lists.infradead.org>; Thu, 03 Oct 2024 07:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727966993; x=1728571793; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WdndKVp/SXRSmiqlbx9yFx2IrKrWcsly5j+I0V4+Xpc=;
        b=WGryCVyjR8CU2lZbIBL869YejT+/MZtdPKMUb4Jq7tEVx47ox/k9Atyd+tD5wp16j4
         3K841fnL2kA4tIL0IvLz2dumFnaBstUcl2k1W0ioYDzrJJNcbvnQKGjxDYiIiDSCw4Xf
         IXqiKPYhemqXQBvO9t1ilAxVheBshf2T3wymnkqDFxQHvB/W7BjC3hj1U6YaWTmkYwUe
         r6G2wLKhHrMNmiON6teNod+D0WI5cmRV/g770++0U5eFViwGiMdb/g6gCY4qMa+ip4v7
         gsWxpArGO3vCXxto7C80zO+jJzvHHXaqnVFEEft3/HmOD0dSyJUfAIGRLNF4TyMESwqj
         GUDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727966993; x=1728571793;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WdndKVp/SXRSmiqlbx9yFx2IrKrWcsly5j+I0V4+Xpc=;
        b=flTkzCugtQNEqVnsKmPMFlR+cLcgYF6wYuU4JswNFSQqdyXP8NH4u0vZOCzS1kfn0q
         qKsFRGXb2pyLdE8egCdR4xXx7kg7uT8ThsyUYl/I4HaODEqMh9hit2GnPrTtEzuxCZi1
         Y9ug6g4IucZGalfXNMckjYU/7GjvMr+FTKOAIqeppQCrtzs5fFgpBcXOzYUVVZNbMbzJ
         JbifXoFotUSSkY1ZXhC8B87K2KdXkbUUPYdL00Zhdfw723GAoi4BSmxcsvWZFRQRBAUn
         f1fLDyK4WVn5Ncd/rF2YnXGY4vbJjQ6ve9vWHU9sBDXiX+8kxtxiy7pELtfqgzGcQIKG
         CsjQ==
X-Forwarded-Encrypted: i=1; AJvYcCU85/Z1Hh26vSNnxAYnO8zTEcEHWU1WqKbsrrcDU8+n82igI7ONLrVtLQzqk+YdiZFtjavKi9s/+w==@lists.infradead.org
X-Gm-Message-State: AOJu0YxcL+2a1GX3pNey4MtG6DNcRb45L0F1FIixySaMOpuKai8JCcQ+
	h1Gu9EjFpkz7mLF+W0+hK6jL1UHm5jRnNZoyRlzX/Zfwp0ov70KGnqNSiVhcq2Y=
X-Google-Smtp-Source: AGHT+IGo1/5wmvT+S3lgxo2dZaET0mITukuMWSSrKrQoA9kwkNrpn/E6uNgdsnyYgFqETska12PKbQ==
X-Received: by 2002:a17:903:1105:b0:20b:b455:eb72 with SMTP id d9443c01a7336-20bc59f0768mr101644085ad.8.1727966993424;
        Thu, 03 Oct 2024 07:49:53 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20beeee42f6sm9722015ad.123.2024.10.03.07.49.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 07:49:52 -0700 (PDT)
Message-ID: <238ace80-c5b4-4c8c-bcd9-8a06f99a3aa7@linaro.org>
Date: Thu, 3 Oct 2024 07:49:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 07/10] parisc: Align prototypes of IO memcpy/memset
To: Julian Vetter <jvetter@kalrayinc.com>, Arnd Bergmann <arnd@arndb.de>,
 Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Guo Ren <guoren@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
 WANG Xuerui <kernel@xen0n.name>, Andrew Morton <akpm@linux-foundation.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner
 <mattst88@gmail.com>,
 "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
 Helge Deller <deller@gmx.de>, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Rich Felker <dalias@libc.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-csky@vger.kernel.org, loongarch@lists.linux.dev,
 linux-m68k@lists.linux-m68k.org, linux-alpha@vger.kernel.org,
 linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-um@lists.infradead.org, linux-arch@vger.kernel.org,
 Yann Sionneau <ysionneau@kalrayinc.com>
References: <20240930132321.2785718-1-jvetter@kalrayinc.com>
 <20240930132321.2785718-8-jvetter@kalrayinc.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240930132321.2785718-8-jvetter@kalrayinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241003_074954_655282_C89A0BFD 
X-CRM114-Status: UNSURE (   6.03  )
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

On 9/30/24 06:23, Julian Vetter wrote:
> -void memset_io(volatile void __iomem *addr, unsigned char val, int count)
> +void memset_io(volatile void __iomem *addr, int val, size_t count)
>   {
>   	u32 val32 = (val << 24) | (val << 16) | (val << 8) | val;

Mask of val now required.


r~

