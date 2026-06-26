Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABA61CDE008
	for <linux-um@archiver.kernel.org>; Fri, 26 Jun 2026 07:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=k25eMOii6qvKTUwqK2ux2YYsD1dZ9vGEfhftC5yZWFo=; b=yQNJMKiKA53AgBCuO4JUUG7Lh9
	q0meqCA7iWVdYsurUfcE7aXW7N1lSTBl56arsksbCWEXDH6sBdmFqopkrO8Yby4rIXS4jeQobdkPi
	3AGQ1wk4/b8O7Fi6PhWBAxN1OfE5GtI6rpwsAVSmde4Myzx8kNkGqtWmjEWdm1T7ulJ3WnffksUka
	6yZUscYKJuXr0owmkFbhxqJnsex0h9/ZPja8zY34MGPmdx6gOm2LiT/QlvzsP3jl65pSwkv+eRhCU
	6xVgwPhhZ4n4jdVv1o8DKuP1nGShSW1qCHWowDD/iguMfSH5PWnuzxTbXX8hjv2njjl3s8Vc+ygGS
	0/AZOLDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wd1Bg-0000000Agsr-3TK4;
	Fri, 26 Jun 2026 07:41:20 +0000
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wd1Bd-0000000Ags4-41UG
	for linux-um@lists.infradead.org;
	Fri, 26 Jun 2026 07:41:19 +0000
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-46f8562013bso51834f8f.1
        for <linux-um@lists.infradead.org>; Fri, 26 Jun 2026 00:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782459675; x=1783064475; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k25eMOii6qvKTUwqK2ux2YYsD1dZ9vGEfhftC5yZWFo=;
        b=suewPNY15vB1usmYjsfVifMUmD1RlXOh6PTSpb9Pa0ccyS4/pgdThJ+YxkhqYluvmP
         MksSUdt+qXyyk83ileFjcXyQacEfNfdnMz2GRzB6he2+4fX9yofglpK797CO3Vpr6hUk
         MxX6VCopxAOsBmQeXb5dXBnJPo3uQzLuYQQqq9EPKwmNkcc4TkU188ZP/D6DZIkKbQv8
         2JabiKKyhc9sSNhgNK8I8DwA0F+7bE9YYtv3wXY/dsvzDXSO+4yVyx5nGZJroRr5NMM4
         EsasqdhE+1AawDZq8wEaL0pH7kPKMQw5AOhrOD+7IiTo8K/EMJkb/RkNr/fOdEt4zXoN
         OA4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782459675; x=1783064475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k25eMOii6qvKTUwqK2ux2YYsD1dZ9vGEfhftC5yZWFo=;
        b=dOBDUVjKINSxEU4p0yQDviwF5yi5C2zZpabFnP2S1lO1FU3eQLve3vcChDy2V2wgLu
         azNd05XarECSsRce+Kb5RZWDxNcQ7g8yZZJwxgVvlbULn99s8DtyAGEzlCdGUeh999Y3
         INmu2u/U40S5eVANBNJq31KEwuOtGbgGGPnPWaZnPFn1qHTAbFm2dmZJwy6XXz7wN027
         cZl2MTRuZ+HclnGIuqx+vR0kABO5SSAEwgBPMP5aiUXyba1UqLGicJZNZBwOejTjE5dM
         mGRhb+qQkw0VERwKvDnzY7YaFQF59zMEQlwheZPgXnKKoQgvpkDbcvyUqW+IQYWMcbH/
         /Gyw==
X-Forwarded-Encrypted: i=1; AHgh+RrRB434s/PLeogW7/edpJXDjWa25W72z2Pr0n6KwkKsGemuPKKuZP19yboq9MAbY/fzoFtm6ePzng==@lists.infradead.org
X-Gm-Message-State: AOJu0YxFnX2LnxhIYeiq+1Oo57zr6Tmxl16boxH2b/SHrBgvZeA/dxFV
	8x81VMGeLmYvpy3r+/0lt/23Ql8BR6V3OoeReAuB96GjueZ8L0skyh+o
X-Gm-Gg: AfdE7cmswhBy/IgGW8nGaMaI1Gu4UKLRG60fj45WcquV1bz6697irpcnuRa43WVsZd/
	lFKvWo1ve6CWjft5fn88k+raAZoTDcGxUmcobIyXq43A90ZomMpoogH/wME7CZ/ELhaPop8byoE
	cyF3/EkHe8d8xcfanQsVmpWmkLcrxKHNE3qAzc5ArRL1DV4B4+B1eCwjS30qXGfIdQgsZ6pjaU9
	gHZlG7a2gcPxoNLYcjrgn3ap7lk26WpXFp5JJi0mdDDzOLG78aQV5duY5itVJv+N71EVCZVlp9e
	kgVlFZpoN+PY5siWws8eG4mvjxwNh+t0ruiIFRNe4GJGPg/nKAdx+u0DKHxNxfb0NMHiyTvADXG
	fN6u+zaHq0kBMEiRJYSSpDo0gr9D0d62Y2Lm6ErF8BRCERqt/LbSFFij+QZwhPhPDMX1j08HbVw
	VnF+JH/32p0kCkoVozuxAC2W0VQf/bS9r41TsiaMrDw/xbWrQ4aA==
X-Received: by 2002:a05:6000:24c2:b0:46d:654:d1f1 with SMTP id ffacd0b85a97d-46dc1a91830mr9870326f8f.21.1782459674983;
        Fri, 26 Jun 2026 00:41:14 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46c1ee01c3bsm23853241f8f.10.2026.06.26.00.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 00:41:14 -0700 (PDT)
Date: Fri, 26 Jun 2026 08:41:13 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: x86@kernel.org, linux-um@lists.infradead.org,
 linux-raid@vger.kernel.org, linux-crypto@vger.kernel.org,
 linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>, Andrew Morton
 <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/8] um: Check for missing AVX and AVX-512 xstate bits
Message-ID: <20260626084113.42eae31c@pumpkin>
In-Reply-To: <20260626043731.319287-3-ebiggers@kernel.org>
References: <20260626043731.319287-1-ebiggers@kernel.org>
	<20260626043731.319287-3-ebiggers@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260626_004118_006644_6445BE9C 
X-CRM114-Status: GOOD (  14.18  )
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

On Thu, 25 Jun 2026 21:37:25 -0700
Eric Biggers <ebiggers@kernel.org> wrote:

> If the CPU declares AVX or AVX-512 support, verify that all the
> corresponding xstate bits are also set.  If any are missing, warn and
> don't set the corresponding X86_FEATURE_* flags.
> 
> This eliminates the perceived need for UML-supporting AVX and AVX-512
> optimized code in the kernel (that is, lib/raid/ currently) to start
> checking the xstate bits in addition to X86_FEATURE_AVX*.
> 
...
>  static void __init parse_host_cpu_flags(char *line)
>  {
> +	u64 xcr0 = read_xcr0();
>  	int i;
> +
>  	for (i = 0; i < 32*NCAPINTS; i++) {
>  		if ((x86_cap_flags[i] != NULL) && strstr(line, x86_cap_flags[i]))

'line' comes from /proc/cpuinfo
Surely something would be terribly wrong if that included something the kernel
had disabled (or didn't support).

	David


> -			set_cpu_cap(&boot_cpu_data, i);
> +			validate_and_set_cpu_cap(i, xcr0);
>  	}
>  }
>  
>  static void __init parse_cache_line(char *line)
>  {


