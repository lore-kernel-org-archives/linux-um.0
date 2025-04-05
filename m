Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8C58C36010
	for <linux-um@archiver.kernel.org>; Sat,  5 Apr 2025 01:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:Subject:References:Cc:To:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NRiuL4Sy1s+c/lXgB3vFyCUJTB29r4cpXB4vQmrcmqI=; b=MA2OqYOYKT4wgabpYjxHzU0LVB
	cdBwOz1ZwEE0ERJpnAocFueDOd85h0liEPlu/RFsOi5LzhFVBlVWVxzE7HrrMcZx9BJwG3P2NuvFy
	J/401z5Jn0TzJsLmUsHW0cPkOaxdNlhLZMc9MCaMIx6V1YUAkIMiGSUZrvyYFtL9hpjWIojYkHYOL
	aE3WCeYmvQXIzhtjlQZAwG9QTtk/wboBDKW1TFya/74HPdTzj8rrM8zPYeNQEN2gkt2A+4vHbHupu
	vxx4ICLov6f8Kwt4emms5FDinQ0/FOltvnnW3YYk2klxdOtJ1/Cd1lKOVAdRIlGQ5JIHdM7pChlTG
	SWF3fOaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0sA7-0000000DGOS-0P5V;
	Sat, 05 Apr 2025 01:17:31 +0000
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0sA3-0000000DGNz-3PNu
	for linux-um@lists.infradead.org;
	Sat, 05 Apr 2025 01:17:29 +0000
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-22622ddcc35so34701525ad.2
        for <linux-um@lists.infradead.org>; Fri, 04 Apr 2025 18:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743815846; x=1744420646; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NRiuL4Sy1s+c/lXgB3vFyCUJTB29r4cpXB4vQmrcmqI=;
        b=kM5S4njNDvkpmsO9NBjzkVRTLI9J2UjRvXK8rFDRDwZ/pJ1j7f6r1PiljohDPu1rkR
         ucLBQdCJ8yDVNb0ndbl7ACV8OnI+VU6EIcEPCuvrrJ5C2yQx2fnxkcb4MAYQlL4o/J1Q
         nuMy3km58IH8jwWXxYLE8id6Au00Ozt6isdTBDC6gvv87RO8N8jQz/i8Ld3QtOsQh4qk
         l1eSd8V71QqfNxpAt/dSrEveGmUFndsDGFYuTJcxX0nGsBcW4VsSz7l/w9JrueWSJ2If
         e7qeg/V03tgntPRA34IgWRX4KIEM/qkvhMr0itcQWjeRgAt3I93eS79kdlfsMpyFsh0x
         bnyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743815846; x=1744420646;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NRiuL4Sy1s+c/lXgB3vFyCUJTB29r4cpXB4vQmrcmqI=;
        b=OXlGviqPeTWHLaqC/65lpUPuv2cdD+GxQor0cKlRvwxCCW8WiPEb2kbum5MsJRyeOO
         YL9GGYlvsFM2Haxy9m6CBWT76Hp23ylDRtwITTTwWVcPB8XtIfjTwLn06/qkefuEyQLU
         4odKrHseZsNHJ2yL4Ddpjrh9hupqObFGFA3Q76gakewzDWK9bMvi11PsBQtTVo32gtYw
         aAuGS8j70SS0IZogr2eSwhoVex5nQ83Ds9TLBKPRWZGvnzKSDa4jrKgcWN1obZBTomI1
         RmEGhk7LhIOWGjzs7LBNAPugn6/kZXlnaV/TXMS1ZElrAS75Q5SWfpuaplSMfJwxl1nj
         F7dA==
X-Forwarded-Encrypted: i=1; AJvYcCUTot+DCljjD5WyGDqbwD6SIq+6DA0jYJHL8XQa8CiEoTkN7tJztD8+Ox4lrSyEeq09Hqc8jn22NQ==@lists.infradead.org
X-Gm-Message-State: AOJu0Yyi/aabSN0xvjCeTczvYQGBhEufRe47+DiguRI6nNP/QX+knbte
	nkX1sf3JgkCa+7MvCZL+hiDHaWXe3hs5RN55RPJivzoV0xc4m+ik
X-Gm-Gg: ASbGnctCtMbuO6qNXqWsa/WyGbmXx7Ie3of7xO17PATA0Xj1AExpWfG7bQkAcFQk2z3
	e/13DILvQJZgmWnU1NfqMBMXv7uo9MHctpRGinn5TCobR6ZkDclj9w+PrCdoKVyWHv9hiYe1adh
	2qkPyvfYS33neOSHOCxbTyLsDO0Eh79T7F3bU1d4+lBu3il2cNioRF3gUIMaLy9awrx1TxdmuJA
	NlXyE3ewjijltil0BI/HcgZKjD7TfN93OkcBEuyG57Gxq2H706XL9HIr2ctwL/ZHEZTAbz+gL90
	imn23twUGuo8a1NK16bMMWw3C43h7FD4NMsA+49RGlHsJJrpBanMmCEv6HjOGTlBke9oqE9Wf6+
	BRJOXfrhgr5Sxv3k=
X-Google-Smtp-Source: AGHT+IGrKFiapGLIEGHnSEZIAujUvj6ZJLSj064m/nFeE0wcOjOeNVFt0u8EmZ8qnV5tFeQau4dR7A==
X-Received: by 2002:a17:903:3c6b:b0:224:24d3:6103 with SMTP id d9443c01a7336-22a955734f5mr25800795ad.35.1743815846125;
        Fri, 04 Apr 2025 18:17:26 -0700 (PDT)
Received: from [10.0.2.15] (KD106167137155.ppp-bb.dion.ne.jp. [106.167.137.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-229785b352esm39374225ad.18.2025.04.04.18.17.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Apr 2025 18:17:25 -0700 (PDT)
Message-ID: <811c4103-08b1-4288-9a15-bd9795bc59f4@gmail.com>
Date: Sat, 5 Apr 2025 10:17:16 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: nfraprado@collabora.com
Cc: James.Bottomley@HansenPartnership.com, akpm@linux-foundation.org,
 anton.ivanov@cambridgegreys.com, corbet@lwn.net, davem@davemloft.net,
 dmaengine@vger.kernel.org, ebiggers@kernel.org, edumazet@google.com,
 horms@kernel.org, jaegeuk@kernel.org, jarkko@kernel.org, jic23@kernel.org,
 johannes@sipsolutions.net, kernel@collabora.com, keyrings@vger.kernel.org,
 kuba@kernel.org, lars@metafoo.de, linux-doc@vger.kernel.org,
 linux-fscrypt@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linux-mm@kvack.org,
 linux-sound@vger.kernel.org, linux-um@lists.infradead.org,
 maxime.chevallier@bootlin.com, mchehab@kernel.org, netdev@vger.kernel.org,
 pabeni@redhat.com, perex@perex.cz, richard@nod.at, tiwai@suse.com,
 tytso@mit.edu, vkoul@kernel.org, workflows@vger.kernel.org,
 zohar@linux.ibm.com, Akira Yokosawa <akiyks@gmail.com>
References: <20250404-doc-paths-unliteral-v1-1-74718785444e@collabora.com>
Subject: Re: [PATCH] docs: Remove literal markup from Documentation/ paths
Content-Language: en-US
From: Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <20250404-doc-paths-unliteral-v1-1-74718785444e@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250404_181727_852040_9FE87FB8 
X-CRM114-Status: GOOD (  18.05  )
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

Hi,

Nícolas F. R. A. Prado wrote:
> Given that the automarkup Sphinx plugin cross-references
> "Documentation/*.rst" strings in the text to the corresponding
> documents, surrounding those strings with the literal markup (``) not
> only adds unnecessary markup in the source files, but actually prevents
> the automatic cross-referencing to happen (as it doesn't happen in
> literal blocks).
> 
> Remove all the occurrences of the literal markup in
> "Documentation/*.rst" paths, except when the actual source file is being
> referred. Also change the surrounding text when needed so it reads well
> both in the source and the web page (eg. 'see file Doc...' -> 'see
> Doc...').
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> ---
[...]

>  Documentation/process/submit-checklist.rst                | 7 ++++---

I have updated ja_JP translation of this recently.

> diff --git a/Documentation/process/submit-checklist.rst b/Documentation/process/submit-checklist.rst
> index beb7f94279fdb6a1d9b4aa86b2bea031f140732b..3ae31c5af2cb5c374658c1fb7125e70bf36e911c 100644
> --- a/Documentation/process/submit-checklist.rst
> +++ b/Documentation/process/submit-checklist.rst
> @@ -30,7 +30,8 @@ Review Kconfig changes
>  
>  1) Any new or modified ``CONFIG`` options do not muck up the config menu and
>     default to off unless they meet the exception criteria documented in
> -   ``Documentation/kbuild/kconfig-language.rst`` Menu attributes: default value.
> +   Documentation/kbuild/kconfig-language.rst, under "Menu attributes", "default
> +   value".

I have made the same change in the translation, but failed to submit a patch...

>  
>  2) All new ``Kconfig`` options have help text.
>  
> @@ -47,7 +48,7 @@ Provide documentation
>  2) All new ``/proc`` entries are documented under ``Documentation/``
>  
>  3) All new kernel boot parameters are documented in
> -   ``Documentation/admin-guide/kernel-parameters.rst``.
> +   Documentation/admin-guide/kernel-parameters.rst.

Hmm, this item is asking "Have you documented the new params in that
particular file?", so I don't think this change should be made.

>  
>  4) All new module parameters are documented with ``MODULE_PARM_DESC()``
>  
> @@ -58,7 +59,7 @@ Provide documentation
>     linux-api@vger.kernel.org.
>  
>  6) If any ioctl's are added by the patch, then also update
> -   ``Documentation/userspace-api/ioctl/ioctl-number.rst``.
> +   Documentation/userspace-api/ioctl/ioctl-number.rst.

Ditto.

        Thanks, Akira

>  
>  Check your code with tools
>  ==========================


