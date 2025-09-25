Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C10B0CAC5A5
	for <linux-um@archiver.kernel.org>; Thu, 25 Sep 2025 01:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Subject:Cc:To:From:Message-ID:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eQt75DdC8qDrtyjja2Oov+kDMmzEtd4kIyWgE1cwVHk=; b=wH/JNskQvvseKsyYqbrhamWWKU
	cuJlU2LkeY5HPzk5Gz12j2+eVjJaKZ4oKwNJ7iTBXyUXgPPQmsWFNQxRkWdhn+4pTw5sjFpToscSn
	76i/TMbuK7OpnQ3LZ+8GrQ+kb7ZaKhxbrApjF25KYn3KA6M7fua2R79UigFpgQtrdhuWdXTt2JSjV
	+ZjSR1To3aKfbsnrDU1bdRmTVbkTE+zVYZWZRVaufU+B0BEQt3Gw1R+64OgO+y/tYrABwwdmmF2FB
	lzVoTlwH+TPd8ZP9j83KR1PhAAwumxoaVwWnYA+zSKDBYyqhXD1+nh88Tp8NqU+ngk+h+LcicDc8a
	JlDcT2oA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1aQt-000000059WX-1rvO;
	Thu, 25 Sep 2025 01:06:03 +0000
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1aQq-000000059Vl-0IO2
	for linux-um@lists.infradead.org;
	Thu, 25 Sep 2025 01:06:01 +0000
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-27d69771e3eso3883775ad.3
        for <linux-um@lists.infradead.org>; Wed, 24 Sep 2025 18:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758762359; x=1759367159; darn=lists.infradead.org;
        h=mime-version:user-agent:references:in-reply-to:subject:cc:to:from
         :message-id:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eQt75DdC8qDrtyjja2Oov+kDMmzEtd4kIyWgE1cwVHk=;
        b=gKzXFBrLGxDAv+smOmfu64W/S3CQJQImGBLn4nrIISUfUIwne0DzL5GqY/rT9SwA4M
         KsiEl1QiIYrxQ9aCQEt42xKDyt5J5ftwDPfC9c49r1UoXiJgj/MLiBGdpkSRrgWm8ZHb
         yeAlWzi3wu8buQfvmbHky3yeGlazGY4UH7wSclN3ekpuozOOd1M7xFCMOhaC0x7ytfcm
         c2WUYDpLdU5R/E3RsmXVh2yd3DTllm7jjkNSnd/SmJDkgXlXIcT7Hu0KhPd/hqlfHdja
         KIWR7qia9bnxVGWIQlpoGBP7/sRWarTfgujxzdv5wJZAaye7ii1SdhzlY2mcuNcETTIB
         OzsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758762359; x=1759367159;
        h=mime-version:user-agent:references:in-reply-to:subject:cc:to:from
         :message-id:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eQt75DdC8qDrtyjja2Oov+kDMmzEtd4kIyWgE1cwVHk=;
        b=n8koLwA9u4JwPckn7dow40WlBwJCc5BwDazt/bl694qOEQZ9eBoiZQnIJtStB6EuKX
         wI6FZbHXuRRGTv5AmP/oC465KiHzQ4JnUrYP8kv2JTaTCoaBFNRt5wppNkMXpPvT4CXm
         vndNHzgKmxgdwjr1ReS+1/KT3fkLreij2PKr8AzPvJHgcZvcR4I2Ns/a/4k/5r3Au5iU
         5k8V0Jjl6ZM52mUVgKFIPQL0B//n+M2PrClr4wxO/GuPgUBZxs1WzPgAnmUk6KuMJVQ1
         +4LHnrljs2Z9E1cZecm9azGeL6Jq/xUOJh7gtB+Jh9D0zhQJGJQp2oszZJ/ZbSdKSGLH
         239A==
X-Forwarded-Encrypted: i=1; AJvYcCVPmKX59Ymlb1vd+4Vo+q7+fucfp/T0EFpkder9fwa1QfQKJAPhr9vB2nUtYFJsh+LS0YUzvxkzvQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YzLTyTrjVsGkrRWD/cpp63Wsfjv+xv5ejhc9em9Qc1qNU+eTIDh
	Zg1stXHBSuE4aoYQPaWFqSWO+KGhJRP4MIDFfEhJombvDDWlSr7PnPPU
X-Gm-Gg: ASbGncu83kKe3v/sqgHmIB/zTKAKIytRKQ8Ta2XMXYXG/u7aKvQkjQ6PQoY1GNNdS44
	nhhJIPJfsxTg5YLbM1BDorZzm+f2/pT1lC9esww/lKVrF+Qqiytbv+SOYzg9GU3LpldkcSFEzpv
	vZcWehxXNo4daF8VfYnfpWLYNLwC88QSdsEFLaoBTX//uSmtk5Klh2p2Fi400nG9feurAi/9Cjm
	bCh+2HhW2dVglVD3FIwbBZGFcTVIBc+hGqEAGcCICKdDOAGR2ine8dpjkNGbSTQopfXnXKby1wd
	9fGvupb2i4fA4MPo/pdogxxROOtCYejJyeq0Eq2+VoNY8f+RRdkjM2FPBQjHk/CTrxo8H/EGUGA
	qaBV9G/d8tAtekCQMoqs4ZHeIXHgBafS+7UdDfSCihaQ5Me6JP8D9ep8RFnhZAuYj8yJx3zd1lr
	77yOHe+lBZ3IZzIBJvp/XqvfNWhQ==
X-Google-Smtp-Source: AGHT+IGwHElmVODhLjzcGQwYiLLF8PustJQtiHPJXl154Q9y4nWgofjfbBNw4V3dkvm+lgwYi65hdg==
X-Received: by 2002:a17:902:f541:b0:248:e3fb:4dc8 with SMTP id d9443c01a7336-27ed4a7eabdmr16878415ad.39.1758762358734;
        Wed, 24 Sep 2025 18:05:58 -0700 (PDT)
Received: from mars.local.gmail.com (p958197-ipxg03701okidate.aomori.ocn.ne.jp. [180.22.82.197])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed66d3ac4sm6088475ad.5.2025.09.24.18.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 18:05:58 -0700 (PDT)
Date: Thu, 25 Sep 2025 10:05:53 +0900
Message-ID: <m2plbf734e.wl-thehajime@gmail.com>
From: Hajime Tazaki <thehajime@gmail.com>
To: w@1wt.eu
Cc: johannes@sipsolutions.net,
	hch@infradead.org,
	benjamin@sipsolutions.net,
	linux-um@lists.infradead.org,
	linux@weissschuh.net,
	linux-kselftest@vger.kernel.org,
	acme@redhat.com,
	linux-kernel@vger.kernel.org,
	benjamin.berg@intel.com
Subject: Re: [PATCH v2 00/11] Start porting UML to nolibc
In-Reply-To: <20250924033217.GA9039@1wt.eu>
References: <20250919153420.727385-1-benjamin@sipsolutions.net>
	<aM15eChUObXfxLzs@infradead.org>
	<4354d88c2ff7a57a7324cc39b4ce5ed4ebe5277d.camel@sipsolutions.net>
	<m2y0q47mbs.wl-thehajime@gmail.com>
	<20250924033217.GA9039@1wt.eu>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250924_180600_103242_E1C8F893 
X-CRM114-Status: GOOD (  15.26  )
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


Hello Willy,

On Wed, 24 Sep 2025 12:32:17 +0900,
Willy Tarreau wrote:

> > just curious
> > 
> > - are those issues not happening in other libc implementation ? (e.g.,
> >   musl-libc)
> > - same question to nolibc: is there any possibility that nolibc will
> >   evolve as glibc does, and this evolution introduces the UML issues ?
> 
> Nolibc focuses on early boot programs. That does not mean it will never
> evolve towrards more generic usage but this remains unlikely, and in any
> case there's the goal will remain not to degrade the experience on the
> original target (early boot). That doesn't mean there will never be any
> breakage but we're doing our best to keep things in a clean and workable
> state. Regarding threads, it seems unlikely that they'll arrive any time
> soon. But if they did, assuming UML would by then be a long established
> user, we'd certainly find a solution together (even via build-time
> defines if needed).

thanks for the detail background of nolibc.
I understand nolibc will evolve with the carefully considering the
issues we faced with glibc.

> Hoping this answers your question.

definitely, thanks again.

-- Hajime

