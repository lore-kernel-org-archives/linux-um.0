Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8C38C3DA4A
	for <linux-um@archiver.kernel.org>; Fri, 16 Aug 2024 05:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zOCx/yhRLMyGOlVLnFvOTRFA/rCMKs9v6IWO0bkSMLE=; b=VD50ByoykKOWZVvG6VE1gwb7my
	Pw0lRqooneD0vwSD2PIfb5ytIUjst1qk4xqhwu1r2iYP6nvQ7UzA83UpYwdPd0IvjdEW8wiMmw/EZ
	NBNa1TzqElfgULfdEIFKbOCY9YQ1N/1m4N6/KmyROqrzwed2OaSaRAo2s9Z9kMCtgXIfcVTos5vZ3
	whoNNI9DJt186OWLKX28zfaQ12c31ipBMp05vfmzcqLMdJVeskyXSG51g2fABEWofC8P3Vkn1aiAS
	9iDkZ+SGCoHo3JfbWiXj3Jf0gfkf1ezh5pCsCFEZ126i5SBOl7fOkNHjZL0DgNwAxyBVahvuOT7+a
	vqFkHGVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1seq05-0000000BtyK-0soe;
	Fri, 16 Aug 2024 05:59:49 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1seq01-0000000Btxc-3DKt
	for linux-um@lists.infradead.org;
	Fri, 16 Aug 2024 05:59:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=zOCx/yhRLMyGOlVLnFvOTRFA/rCMKs9v6IWO0bkSMLE=;
	t=1723787983; x=1724997583; b=mLp5wnjLyqlH1wIprwmT3h32ub9gfIrNBEiH/BlnU11whJS
	prjuGGO9Sn+ABI6iH9dC7nY2HOc6VDduJBy/5cc4hfZbCBr7My/fQtmmDDuCG9Th33LTJrHYflWn0
	6YbzaiIQ7/vBQrXaYsw4DJ3ZKGpBJVEU0tN992Gfg/jPbS1N2IdPRgZ5D64dnWoJi0io7iMvYNzrl
	3skmNfCqfZd4chH5/5/GuR6bpOiwsD60u0I9QQGpHm6ROiBuKHipBX2FOREOP+0twSVOXi5dTnJBM
	Tkev5lsYXUvRoN6c2k3TmAh2WmN3Gfmb9lEjl/zGU5+8CGpqcZCuCQP1yiqrz9cA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1sepzt-000000026cX-3j83;
	Fri, 16 Aug 2024 07:59:38 +0200
Message-ID: <3be8448cfb2aeb39e0e73856a701101dc8a0f04f.camel@sipsolutions.net>
Subject: Re: [PATCH 4/6] um: Remove unused mm_fd field from mm_id
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Tiwei Bie <tiwei.btw@antgroup.com>, richard@nod.at, 
	anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Fri, 16 Aug 2024 07:59:35 +0200
In-Reply-To: <20240816015447.320394-5-tiwei.btw@antgroup.com>
References: <20240816015447.320394-1-tiwei.btw@antgroup.com>
	 <20240816015447.320394-5-tiwei.btw@antgroup.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240815_225946_040091_F91817D7 
X-CRM114-Status: GOOD (  10.36  )
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

On Fri, 2024-08-16 at 09:54 +0800, Tiwei Bie wrote:
> It's no longer used since the removal of the SKAS3/4 support.
>=20
> Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
> ---
> =C2=A0arch/um/include/shared/skas/mm_id.h | 1 -
> =C2=A01 file changed, 1 deletion(-)
>=20
> diff --git a/arch/um/include/shared/skas/mm_id.h
> b/arch/um/include/shared/skas/mm_id.h
> index 1e76ba40feba..b3571a8afec9 100644
> --- a/arch/um/include/shared/skas/mm_id.h
> +++ b/arch/um/include/shared/skas/mm_id.h
> @@ -8,7 +8,6 @@
> =C2=A0
> =C2=A0struct mm_id {
> =C2=A0	union {
> -		int mm_fd;
> =C2=A0		int pid;
> =C2=A0	} u;
> =C2=A0	unsigned long stack;

Maybe we should also remove the union here while at it? It is pretty
pointless after all.

Benjamin

