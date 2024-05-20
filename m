Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49504C25B77
	for <linux-um@archiver.kernel.org>; Mon, 20 May 2024 19:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:References:In-Reply-To:Message-ID:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=G36Cx8GySjdHNtcYSHoIRZuKeuqegAU39EJK3W+NhBc=; b=nRpmNVjv/bJsLR006z+6jdF5k8
	3Vl2jGXgNIh7Vm/HwPunD51UnY+xBcJAArxYtNPju9VqOSCX1AOkevx4NJ0HttTMyUzfzcIG5tmnf
	UelvHFJDptvaLZ51vZ5M2LjO9yK0i6Nklx2+JnRMl+E4EDjySCKrUGYezDfeaRh9Ft0w56Oy2QmVN
	BtZ1oaFoKIuFMVggWeIorM+dbC/gSLI9XB6zZ8c0TEkv2G452zuohFrWmNcIk3oHx1Qb8hkHNyizu
	tlQRlLCrv9URFbLSD7py293vRSfUhsJW18Yh5X8oZNFNU1yk9OLYc5xYr6RbA9BeicK4sir06Ien7
	+hlcSYzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s98cP-0000000FMS0-2kjW;
	Mon, 20 May 2024 19:24:21 +0000
Received: from lithops.sigma-star.at ([195.201.40.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s98cM-0000000FMQS-0u6o
	for linux-um@lists.infradead.org;
	Mon, 20 May 2024 19:24:20 +0000
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 1B8E96195FC2;
	Mon, 20 May 2024 21:24:07 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 6z9Gs4OLXYbU; Mon, 20 May 2024 21:24:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 678D96195FD7;
	Mon, 20 May 2024 21:24:06 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id cPpfmcUIF8d4; Mon, 20 May 2024 21:24:06 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 09C736195FC2;
	Mon, 20 May 2024 21:24:05 +0200 (CEST)
Date: Mon, 20 May 2024 21:24:05 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: hch <hch@lst.de>
Cc: "Dr. David Alan Gilbert" <linux@treblig.org>, 
	linux-um <linux-um@lists.infradead.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <1300720405.125947.1716233045712.JavaMail.zimbra@nod.at>
In-Reply-To: <20240520152049.GB398@lst.de>
References: <20240505001508.255096-1-linux@treblig.org> <20240506070648.GA6506@lst.de> <ZktoVIG500he350_@gallifrey> <20240520152049.GB398@lst.de>
Subject: Re: [PATCH] ubd: Remove unused mutex 'ubd_mutex'
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: Remove unused mutex 'ubd_mutex'
Thread-Index: sUO+fPwo/Hce3VfngHxEy05naTFOLg==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240520_122418_421161_02A0EC6A 
X-CRM114-Status: UNSURE (   5.58  )
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

----- Urspr=C3=BCngliche Mail -----
> Von: "hch" <hch@lst.de>
> An: "Dr. David Alan Gilbert" <linux@treblig.org>
> CC: "hch" <hch@lst.de>, "richard" <richard@nod.at>, "linux-um" <linux-um@=
lists.infradead.org>, "linux-kernel"
> <linux-kernel@vger.kernel.org>
> Gesendet: Montag, 20. Mai 2024 17:20:49
> Betreff: Re: [PATCH] ubd: Remove unused mutex 'ubd_mutex'

> On Mon, May 20, 2024 at 03:12:20PM +0000, Dr. David Alan Gilbert wrote:
>> * Christoph Hellwig (hch@lst.de) wrote:
>> > Looks good:
>> >=20
>> > Reviewed-by: Christoph Hellwig <hch@lst.de>
>>=20
>> Thanks Christoph; any ideas who might take this?
>=20
> Probably Richard who is alredy on Cc.

Yes, after the merge window.

Thanks,
//richard

