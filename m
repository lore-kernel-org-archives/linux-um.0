Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A194CF34BA
	for <linux-um@archiver.kernel.org>; Thu,  3 Oct 2024 16:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RW5P1Arx8XPYT/NPFqMkITFeiGycXbJcANO3qtPPvbA=; b=SCaBOHrhVdMzjn6TYlp75C80qr
	1Rc98zOIHaV8dOEyUTQHBAIDurhB6ymJpENcrhBfa5lolDyrnZYMdqbM2ZVFD/e5S0DroOhzWmOUu
	dr20rfNBRi+O8OwYWA2nrWI9hPWeVCUH66ylSB1t3RiaP4/vW76CiAaNhpyAXg2K3q/eAS8r+IAKM
	6EjUaBEId7s2I8DfMUyl8K+YMSTaJS0TG/jGn9selZ6ar14f02VTned4gkXhckBvt1Ao2Q5gRt2aD
	L0qqU2mROvER0s8RPfDUX4GagSC3QSczLaLbHUdp6aASOLK2wZCnwPn5cBVmJi8wmyw/xjR/Rp0gd
	jLljUHfg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1swP0T-00000009rcB-3ocH;
	Thu, 03 Oct 2024 16:48:49 +0000
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1swOyd-00000009rEj-3BTy
	for linux-um@lists.infradead.org;
	Thu, 03 Oct 2024 16:46:57 +0000
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-7e6afa8baeaso976936a12.3
        for <linux-um@lists.infradead.org>; Thu, 03 Oct 2024 09:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727974015; x=1728578815; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RW5P1Arx8XPYT/NPFqMkITFeiGycXbJcANO3qtPPvbA=;
        b=lNm8HC+Vzdn2PkLyiju+1SGrCxTPpHjhjH9lt8jTmb1UvXAVnn75b/Hg53FO57xu6j
         SrPrhoHUJ1emeE11FeKsoh5aHV3aZ1dxIC06WmiW9vMNb7GM6AOEb1rDs14H+Cb7hxCl
         MPnz1LOCHcHRpNlsCTksYvrJi3q1ILeZnwgoJ2QguZDpK49gYtepBRF1pHITkirCQNGS
         Ht+yJ7gHcplObHP6m3p2iRFS2BkppisGLNACC7fu36s6PdVyDmkuIZmPtjGL/7q1Nrui
         Cy0Wg9gUJZxhoIbWjf6iv8ZKoIRYMOOoxsZtwt4u4kLh2rl0alYLoZ8omLKzM6h3aR2n
         E02w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727974015; x=1728578815;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RW5P1Arx8XPYT/NPFqMkITFeiGycXbJcANO3qtPPvbA=;
        b=nYON8hiXFGnzytyw729HtqzXi3Gc5xMCRwpY/b1pRrSacCvqoWcEpOJ3wgpjeRm+VG
         ENI8wjbZA5B2sRWrfpKxhrfRC+E0O6oTA8VZSYrJjeFSO5CSBqmxFwoB9DDQnfGafgB7
         1+1XNwHkUq7y1qOS32TUpzaJmZifPT8IBbmPfpwSAbvgM9mvx63auBcm7x1p/eefpbPn
         i7vn7Wfvn96FuhHWq92Z6n61VoFYzYR1qGxhpN58jyOOSq4pMvodZAE3cNXm+TXHyaBl
         QwwqazXfMCXVnr4DZAHucQD+UtYVDyGiF9CAOHMlU1FyixUMHL7KVcm/m2X0kxSiSwFc
         RkXw==
X-Forwarded-Encrypted: i=1; AJvYcCX9nHL6v8ufWxp0OBfxU6wxL1Yrjmxrrb3iQ5jgFlHlbPNI77KTROudDl6tTCmTKM5UlhIE1RxVkQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YwPc8+9aWTsUe5j59weSXSnr5R50Zos+bk5gDE+gcBGCQ3OQWMv
	XpI2VTKc6tOHfm+ZD16cspmb6ssH6f4H0ET7M0ukgWmOsVfHF9Yt3o+HiQvfI/4=
X-Google-Smtp-Source: AGHT+IHrNLnq312K7GVWKGT1Vo9Ff69i9ensfXAZGMY12ruPSu/BXqZiVZ26a2jiItIAw0CUa22nFw==
X-Received: by 2002:a05:6a20:cf84:b0:1d2:e8f6:81e with SMTP id adf61e73a8af0-1d5db1bf932mr10105522637.24.1727974014772;
        Thu, 03 Oct 2024 09:46:54 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e9dbcf13b6sm1055380a12.8.2024.10.03.09.46.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 09:46:54 -0700 (PDT)
Message-ID: <a4f85184-73d4-44e4-bddd-0c1775ed9f50@linaro.org>
Date: Thu, 3 Oct 2024 09:46:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 01/10] Consolidate IO memcpy/memset into iomap_copy.c
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
 <20240930132321.2785718-2-jvetter@kalrayinc.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240930132321.2785718-2-jvetter@kalrayinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241003_094655_926915_84BCD41C 
X-CRM114-Status: UNSURE (   6.82  )
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
> +void memset_io(volatile void __iomem *dst, int c, size_t count)
> +{
> +	uintptr_t qc = (u8)c;

Missed one change to 'long'

> +
> +	qc |= qc << 8;
> +	qc |= qc << 16;
> +
> +#ifdef CONFIG_64BIT
> +	qc |= qc << 32;
> +#endif

Could be 'qc *= -1ul / 0xff;'


r~

