Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E78D9C54EFC
	for <linux-um@archiver.kernel.org>; Tue, 28 Jul 2026 09:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fd4u7HbSw7LmAIg2c748Ol/BOezHkKcbVf+2ouQF5V0=; b=OWreWboMH43JuxIQlLBKmXSzrr
	CuLNEXf70ODgGe2b5alo23A0URaHHVrVt+rhC2nWwccabgR8ikBSc16m9WxOBc6ILnYUxbzZDsDpe
	EiA4Hq1wNfq6BPhwZOPKHZWV7Jf7Jw/LXN2DtteUlerh3VoTh0tEIvUm46otoPZJoRX9uCBKBjHTp
	9vUORxAC1PBEbY+bp6Zy97XlHsygVDfTMH5aTkrYjgg6h2U2CEKpigACJAi530u9I6p2XxBwmwZxw
	mlz2systpUkvYiTdHzRBm4kxbhLwHYvcQtj7xjv0wFMvEDxCUrcT8gNQy6JE1OMHIs2JcOVNcx6/T
	pC7FHHCQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woe8m-00000004pbN-0qeG;
	Tue, 28 Jul 2026 09:30:24 +0000
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woe8k-00000004pan-0fO8
	for linux-um@lists.infradead.org;
	Tue, 28 Jul 2026 09:30:23 +0000
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-4957eefd361so26703985e9.1
        for <linux-um@lists.infradead.org>; Tue, 28 Jul 2026 02:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785231020; x=1785835820; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fd4u7HbSw7LmAIg2c748Ol/BOezHkKcbVf+2ouQF5V0=;
        b=i6UaKNVd76GYhgLr//seFPUe9QQI7tZbUp0Oi8qXfvnYihzvTCqVaYEYasBLqkxN4L
         CaPv7LRRbFZNa6Ak8yF3km/4tAGoAlV2QXtYr9DN3yrwQfjJpDGZCfq1XU8fioAofPCo
         3F0mi7+M4iPFL5d3vPfhjZU9ENLHS5rQN4WV1lhvKOx6JdGb/56ErGIxtAnKAFRxIf71
         TSUgwp2jODEW6v/O++8q4SxwwgPjotM5wh2LosCb1H+bh/GAzGyoBCv0CRNWp5zOCVof
         1mt++bl008IsucnmRV8LH5ImjODNSqbnvdqXekpTFbzCYWBaHMjoRCLWPCdxs1JZ/vlw
         +Q7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785231020; x=1785835820;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fd4u7HbSw7LmAIg2c748Ol/BOezHkKcbVf+2ouQF5V0=;
        b=s7hDOl3wNwCnNEh3tNPr9t4l3o6O8kiSy3Yvt+5YFwutCx8i7uP3QW867HrybcOAAC
         YboD7kfrU0eGvwVtxoR0ujxBcRonNjZls6dpGuplxUoOA195Vd3y7f2NQMkKlrue/5Jq
         3TZ+CW9bQfMcRw0x+sV5SNw5REmhQM5L2oBWvAMqa83Z+7daddpt0Nmcp/Mw4ZhP478y
         uNfTQRRW1FHGU99HvsgzGzO9GmbC+2oo59AcC/r/5Fyqf66/v8/Q4sBzaxJyqy0pFF/+
         MXbV8EKDQm6779T2Fk4SrHQnAthj9esU/iOhUapEZhN2MzIv2gB0yIAiL2D94CZgoFKZ
         S41Q==
X-Forwarded-Encrypted: i=1; AHgh+RoQE9XFZfzxPTtO/+Ml6GIoScCduqRzjKqUHVhHNp7wxd+oM9oifyIivgRTQmNUDtVpykbZyVs8dw==@lists.infradead.org
X-Gm-Message-State: AOJu0YyDQKhhaNUiXe4R0Z5+wvsaMfLU0AQsV5o0btJI4xtB29OXnA+y
	SYnL/UBJwT2LakwI7D6WiLNcRaVPKZRbqg23rhJh9fzDm1ShLnPVqyQt
X-Gm-Gg: AR+sD10HjHLM+IP4DNAjDnLuH/UuooRUSKdZMSubTDER94zxCr6XmwNyXj3h/Sstm3w
	1G8Ek2YjSrFP6+7ZRwv3F3hVpK7nHOBtNC8CQX+tnLa0DKe2DRYmQEY9XmclY87CDPGYXcj3wBG
	WnjrLfPRMznQ5+hhXPkack70ldYeh/C2tpodsCpJBXiJSPoV2peTTfMbKl5g/CDucp1nAUSDdf8
	Q33C3SeM5dIGsEKxmCecKQ13w+jiq1yck1KDm/gydhwNmv+GgH+L+Crg0S1Wjx0jxB4O97xj/va
	HYF3BDsQ27mvLzmd3LOYKqR8OUxn1ugGWU2Z0tp+ywU7bpQIx5XOTp6SDSuF750KSOovh9bZFh9
	eDRPJlIlEKoNIz9R0yE81TcQscwMaRW0W9Y4Gbcx2OYHj13/s7wOIDu13VNLg364qvxVhq9Kd+t
	Xj4zolJeFIc/fxfMET805F5BS3wa2XWyVmFfXWISk=
X-Received: by 2002:a05:600c:310b:b0:495:779c:fbef with SMTP id 5b1f17b1804b1-496c65aaf28mr16540495e9.37.1785231020039;
        Tue, 28 Jul 2026 02:30:20 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496c44b84edsm99732275e9.5.2026.07.28.02.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 02:30:19 -0700 (PDT)
Date: Tue, 28 Jul 2026 10:30:18 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: x86@kernel.org, linux-um@lists.infradead.org,
 linux-raid@vger.kernel.org, linux-crypto@vger.kernel.org,
 linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>, Andrew Morton
 <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 3/8] crypto: x86 - Stop using cpu_has_xfeatures()
Message-ID: <20260728103018.00938ac6@pumpkin>
In-Reply-To: <20260728021603.79870-4-ebiggers@kernel.org>
References: <20260728021603.79870-1-ebiggers@kernel.org>
	<20260728021603.79870-4-ebiggers@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260728_023022_229405_2F175D42 
X-CRM114-Status: GOOD (  16.61  )
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

On Mon, 27 Jul 2026 19:15:58 -0700
Eric Biggers <ebiggers@kernel.org> wrote:

> Checking both boot_cpu_has(X86_FEATURE_AVX*) and cpu_has_xfeatures() has
> never really been needed in practice, and it's never been universally
> done (e.g., lib/raid/ omits cpu_has_xfeatures()).  Nevertheless, both
> x86 and UML now explicitly clear the AVX and AVX-512 flags if their
> xfeatures are missing, which should remove any remaining doubts.
> 
> Thus, remove all the calls to cpu_has_xfeatures(), as well as the
> related checks of boot_cpu_has(X86_FEATURE_OSXSAVE).
> 
> In a few cases there was no corresponding boot_cpu_has(X86_FEATURE_AVX*)
> check, so add the missing ones.
> 
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> ---
...
> --- a/arch/x86/crypto/aria_gfni_avx512_glue.c
> +++ b/arch/x86/crypto/aria_gfni_avx512_glue.c
> @@ -196,24 +196,15 @@ static struct skcipher_alg aria_algs[] = {
>  
>  static int __init aria_avx512_init(void)
>  {
> -	const char *feature_name;
> -
>  	if (!boot_cpu_has(X86_FEATURE_AVX) ||
>  	    !boot_cpu_has(X86_FEATURE_AVX2) ||

Doesn't AVX2 require AVX support?

>  	    !boot_cpu_has(X86_FEATURE_AVX512F) ||
>  	    !boot_cpu_has(X86_FEATURE_AVX512VL) ||

And (less sure) AVX512xxx require AVX2?

So the extra checks could be reduced.

	David

> -	    !boot_cpu_has(X86_FEATURE_GFNI) ||
> -	    !boot_cpu_has(X86_FEATURE_OSXSAVE)) {
> +	    !boot_cpu_has(X86_FEATURE_GFNI)) {

