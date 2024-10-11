Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93C08CFC60F
	for <linux-um@archiver.kernel.org>; Fri, 11 Oct 2024 07:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HCw/3no5oYj2UHi2qRYtGo97uJOdKggjS5l76VTP6Oc=; b=4k4zNIlFewPDepMdpy2rPDtv7i
	4ECzu7XGM+r1UZuLJyBlkPiz5jySBM5Sg8EoocOWIFA0MKIpPqCPLgKac3qUo2T9vdKK1YlZKR/Cc
	tRZuXpYYpWmDjRVP4uPQEgZ7DXVWJCIiPk5/C0PaFXekqRoAvO2OUa7QRdsmmnsyMkuFCkBUoot4z
	tS7RTL3q4YwV1nG25Vim9iZFJH88Icv2/MrC9+gf+/h9jBi+siuINVvEjy9WGSGiZp7I1qZOrsutR
	H7Bz7Mp37Ks0wn755vg7IgKHuvzAy0A3IYv9e0Zliav6afzVqtb8vSWCY2Afq7nYsuumDOIw3ODAz
	/VHKNWFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1szAEP-0000000FZT1-0dlV;
	Fri, 11 Oct 2024 07:38:37 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1szAEM-0000000FZRD-43LX
	for linux-um@lists.infradead.org;
	Fri, 11 Oct 2024 07:38:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=HCw/3no5oYj2UHi2qRYtGo97uJOdKggjS5l76VTP6Oc=;
	t=1728632314; x=1729841914; b=BY3/bSfQkNSEJtQtf5IEbLTHXy8MWUiRd5lJ3ndlwVTt8iy
	+qBzXFY6WGFcUD3I+7vaj1TKd2WVpst999r2Rtyy9+kcrxXCSJvbxRk5D+SePjnnNdHC6pKUojUjA
	d/AmjMwHLN1MHgM0oyJHca2i6Jg3A8AQPJYHNm7XbDkSXXzrYpc57FC/hhhGkL619/mTq2lhDc1bs
	KnI6NDGE4ygM/zvGruLHqPJnGhQUJtkDeuxt11TI6LMZnjNC/vToUccXYY67os4kjingmEGzF0FgY
	6rn+Qadc/69l6RPlkyDFgWVLLFtSF6L6CbmXC37BbmPtRrlDV4Vw3OCsOs4ZNWPQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1szAEI-00000006zgG-3Yaf;
	Fri, 11 Oct 2024 09:38:31 +0200
Message-ID: <99d9e95fcb27160da5ff931fcfe16a07b3256574.camel@sipsolutions.net>
Subject: Re: [PATCH] um: Abandon the _PAGE_NEWPROT bit
From: Johannes Berg <johannes@sipsolutions.net>
To: Tiwei Bie <tiwei.btw@antgroup.com>, richard@nod.at, 
	anton.ivanov@cambridgegreys.com
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Fri, 11 Oct 2024 09:38:29 +0200
In-Reply-To: <20241011053843.1623089-1-tiwei.btw@antgroup.com>
References: <20241011053843.1623089-1-tiwei.btw@antgroup.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241011_003835_034840_C09CC414 
X-CRM114-Status: UNSURE (   6.39  )
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

Hi Tiwei,

So kind of a nit, but if the resulting code looks like this:

> @@ -184,17 +172,14 @@ static inline pte_t pte_wrprotect(pte_t pte)
>  {
>  	if (likely(pte_get_bits(pte, _PAGE_RW)))
>  		pte_clear_bits(pte, _PAGE_RW);
> 	return pte;
>  }

then the if really isn't needed?

Same for all the others, I guess.

johannes

