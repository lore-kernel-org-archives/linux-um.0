Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726A3606A31E
	for <linux-um@archiver.kernel.org>; Tue, 20 Oct 2026 19:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=du4S8RkC;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=elck4AEo
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:References:In-Reply-To:Message-ID:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uM5DkyTcQcIY9+zos5+5Y8SpLbQKEPMCEH5xBlRrlEY=; b=du4S8RkC1AcwwTzekU5AFXlCOi
	c/bPqV5mVBs9e6N4iewfGNE95EZuBBizYO7FAq/OFsOQ7vH0u5AAkWm9TKMuQbj4JQoI/Fy/YVytM
	w9dCF0ULwApdxN1yOhCpf6KoORVu0z3cMhv78C8rhS6jGLvpTrs2dXUsBJP0n1FY0Vr/UiQ8oK2jm
	pgvFO3KqkctoCqB14ss5c2+PhhacFtVfBPWZiUmy5lie+2U2XDLfoG5q1rgwoWaZFspEiCWLBfzCy
	w3V/RUj4T/5vmNQTY7ZHDLoIAAxKXnfTD9Ogiz8sM+5CNDepOOT8nwj/nPKpS8R40jp4mQgaYWuTH
	A5jhzCYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJFVf-0000000AXJU-1CEu;
	Tue, 20 Oct 2026 19:28:31 +0000
Received: from mail-vs1-xe32.google.com ([2607:f8b0:4864:20::e32])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJFVc-0000000AXIn-1aPE
	for linux-um@lists.infradead.org;
	Tue, 20 Oct 2026 19:28:29 +0000
Received: by mail-vs1-xe32.google.com with SMTP id ada2fe7eead31-7bec5112765so18217137.1
        for <linux-um@lists.infradead.org>; Tue, 20 Oct 2026 12:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792524506; x=1793129306; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uM5DkyTcQcIY9+zos5+5Y8SpLbQKEPMCEH5xBlRrlEY=;
        b=elck4AEoFIXoKZ650fkWnnHWNuztLkcqoMQSPNGp86vwcYdyoJgeW/kE6jqXta/PDw
         3+dy0z/falvmaJLBTpfMQF6uJsi5d2KaFMpwbV/BK01y1zNkzeZ15N3TdsLnHLvVhdR+
         zw+pNXVIME4tdoTTuuHYPR9Ty351U2nIfdzgSYcHH7dXwWME/5OCPS3pczKRV2H57OAN
         GiRRdlFfdx+xemwl+zzzVv4chl4SR/WewKKFpnQQA5mpE6Wuk6dT2RJRc4/taCW0bVu3
         KmklB2TTmUm5+Ff9QQwfxmmhMo6ByB+BY00+6b8KCZLfKf+Fok1okmEdaMufUfTozn9k
         ehEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792524506; x=1793129306;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uM5DkyTcQcIY9+zos5+5Y8SpLbQKEPMCEH5xBlRrlEY=;
        b=O+h2xaKMkVfIEOGDMSIwZXriYzHU7+rWLICOZe4p/D86zgjeCxaaHZiBDJtP+Grxcq
         b/wM3Vfl0Z+G9w1mS5Jwk6zeN87njsgUbw79+SxwK7Mkrd4UnREw6sRrjRF1AyvNxpoV
         l7dVafFSW18GuuEH1RY1uUO//gScdANYY3a53KSzajbSNWcGx60gJac1ve9fshbQd6RT
         MoKCMTbhTT8ae6/4MG8VEiqYwk1xGaeVy2HH91N3ImrYVlSePn+P0V5vaAvXY5dsaNUk
         8C22LlMk+2N/sqmg6aSalUbHMy8z7JYCAAWEaMT3qjcRpxMgbgCIDuYykJygZpSpeP94
         eZ4Q==
X-Forwarded-Encrypted: i=1; AKwUvByhKuMnVOMMi10ELLRdZnzYnYxRVzBXOg04TM9AsnYpSlmJxEAWhRI1Axh0AYvWEomfzXNFHlVnng==@lists.infradead.org
X-Gm-Message-State: AFq9FYKdurOClZNwAddVr7FBv/BT5VkSSq2C4NuHVQjrFPoVTw3WClIA
	j9Iaj7H0MPUjlGTusEIzMhlve4eFB6iT8Xhp8kpeh4QI2y5fvAfCAfTQXF1keg==
X-Gm-Gg: AYBFou2rrAOz6ZL+sQBzMw1gPEPu3k7wwczGhkwnHwfkVqqVggd1GPYuhXtt57YxlD/
	7IbsDWlzsKD+1AkHC5PkVYolLq5yJaaAV2PeGhYXiOJd7zOCAEzI2ROQzOwUz+cUDoGsa5Wo4Fa
	OtdbEuCvHISHzdqKNLOVnDr9Bx7SD1OWigx3SvqrpcHMiknqvNNY0kmobpDcghQtgOd6zeBQJpX
	aE6dIO3FcLfIX8DdI58cPJa0q8kN20NBQrLdorYhz8TgLJqvRIjBrx2WpCNgwfje4vCXJnCFdOO
	5cgDy0JFW4dnErf53ToVoqVAmhK9UOYk7E36oSRc4wD31qPUjQ/s7qjeCULTa/m7CYePzffYCRd
	TBmyuQUZVQpFjGG+eiKz1NSy4gj3aYsqeo0W4F80R1oCX8aSpQ4rklOZbuemIlaVxxr5YH/8gZk
	WWZBGeCjsBm1oo1cR7t9c+7PHTRzfPFcXbTed68WcBOV8pCkUkhOAe+OpiQKYH1JQgaC1xXAlX+
	k517rZRBis6eWVNTwP1+47rq0YuRM1SFhirMrVxZZ/+KqAr2h1XHHYOenwvmMsvifpHLKk8PKFR
	7jd5kNEJt1SMEgVfc2v/Wikz+EsAIbDy1eiYEg==
X-Received: by 2002:a05:6102:5348:b0:7be:3766:9062 with SMTP id ada2fe7eead31-7cc9271c22bmr70477137.27.1792524506671;
        Tue, 20 Oct 2026 12:28:26 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7cc924348c4sm207823137.11.2026.10.20.12.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 12:28:26 -0700 (PDT)
Date: Tue, 20 Oct 2026 15:28:25 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 linux-kernel@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Chris Arges <carges@cloudflare.com>, 
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
 Phil Sutter <phil@nwl.cc>, 
 Jason Wang <jasowangio@gmail.com>, 
 =?UTF-8?B?RXVnZW5pbyBQw6lyZXo=?= <eperezma@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org, 
 virtualization@lists.linux.dev, 
 Max Krasnyansky <maxk@qualcomm.com>, 
 Rusty Russell <rusty@rustcorp.com.au>, 
 Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 linux-um@lists.infradead.org
Message-ID: <willemdebruijn.kernel.317e66c2e17bb@gmail.com>
In-Reply-To: <554a7cf11f82676fcadde914c7044dcad9bbd0b5.1792411304.git.mst@redhat.com>
References: <cover.1792411304.git.mst@redhat.com>
 <554a7cf11f82676fcadde914c7044dcad9bbd0b5.1792411304.git.mst@redhat.com>
Subject: Re: [PATCH net v3 2/8] um: vector: honor virtio net hdr conversion
 failures
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261020_122828_450690_FB040611 
X-CRM114-Status: GOOD (  16.61  )
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Michael S. Tsirkin wrote:
> virtio_net_hdr_to_skb() refuses packets whose checksum metadata
> it cannot make sense of, but the vector raw transport ignored
> its return value: rejected packets went on into the stack with
> their metadata unvalidated.
> 
> Propagate the failure.
> 
> Note that a follow-up patch will modify virtio_net_hdr_to_skb()
> to return a negative value on error and a non-negative value on
> success.  This is why we don't just propagate its return value
> directly.
> 
> Assisted-by: LLM
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  arch/um/drivers/vector_transports.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/um/drivers/vector_transports.c b/arch/um/drivers/vector_transports.c
> index e1fb2a76fdff..8b7548458663 100644
> --- a/arch/um/drivers/vector_transports.c
> +++ b/arch/um/drivers/vector_transports.c
> @@ -210,7 +210,9 @@ static int raw_verify_header(
>  		return 1;
>  
>  	skb_set_network_header(skb, ETH_HLEN);
> -	virtio_net_hdr_to_skb(skb, vheader, virtio_legacy_is_little_endian());
> +	if (virtio_net_hdr_to_skb(skb, vheader,
> +			virtio_legacy_is_little_endian()) < 0)
> +		return -1;

fold into the previous patch? It already mentions that it covers all
cases.


>  	return 0;
>  }
>  
> -- 
> MST
> 



