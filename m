Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EB12C10F15
	for <linux-um@archiver.kernel.org>; Mon, 22 Apr 2024 20:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:References:In-Reply-To:Message-ID:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=i6bdLCbDlUXhfBU62pSTidBdeKEWGuacTmR/v6dTwFc=; b=aw7OzzmdBZVQI6hWeDKMe+2gg1
	oX0w12OBIacp5bqjeaqNTz8tKjXj/ETE/HJtoYGA2pws7wx72haUgfqTUaDeNJcG7RdGi3vQB/HeF
	zi4SYQfdQHfrpaIFMRpON5/4BiT4uI3tpl9OjCpRSrLtH0T5l/Mvr1rFTQV/8IHxrMvcKYuAyOmsZ
	RGCVuQHLSxxc2+h0NKXuc9x599D1L+YTaQ7hu08BoL0i8T9ZEMT6MZL8NTVsLLvFQD4NdFUwjsRSR
	MZiQsINz2Aq39VASMqyucMx/MIx5NCsDsCzPdcaqh+B3aOPNFXM0XkkCE9VgXrcJc4aaAfZwXbDoY
	YSIskW4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rz0c3-0000000F1h1-2CO0;
	Mon, 22 Apr 2024 20:50:07 +0000
Received: from lithops.sigma-star.at ([195.201.40.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rz0bz-0000000F1gF-35YS
	for linux-um@lists.infradead.org;
	Mon, 22 Apr 2024 20:50:05 +0000
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 78689608F445;
	Mon, 22 Apr 2024 22:50:01 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id aLFQ3ulMU7v4; Mon, 22 Apr 2024 22:50:00 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id CDCF6609B3C4;
	Mon, 22 Apr 2024 22:50:00 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id gIB3UWmMAyCg; Mon, 22 Apr 2024 22:50:00 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 9E120608F445;
	Mon, 22 Apr 2024 22:50:00 +0200 (CEST)
Date: Mon, 22 Apr 2024 22:50:00 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Stephen Rothwell <sfr@canb.auug.org.au>, 
	kent overstreet <kent.overstreet@linux.dev>, 
	SeongJae Park <sj@kernel.org>, 
	anton ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, 
	linux-mm <linux-mm@kvack.org>, 
	linux-um <linux-um@lists.infradead.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <714170984.15180.1713819000411.JavaMail.zimbra@nod.at>
In-Reply-To: <CAJuCfpFsrQxa2CX66xQtxp=Y-=R5_YkJMMX9VQ-g32rdCrukeg@mail.gmail.com>
References: <20240326073750.726636-1-surenb@google.com> <95819052.15033.1713816660761.JavaMail.zimbra@nod.at> <CAJuCfpHnM6L-7s8cd90XKiawhw9LZaRfMfeDm54OshLQdV5YmA@mail.gmail.com> <1375034928.15114.1713817899712.JavaMail.zimbra@nod.at> <CAJuCfpFsrQxa2CX66xQtxp=Y-=R5_YkJMMX9VQ-g32rdCrukeg@mail.gmail.com>
Subject: Re: [PATCH 1/1] arch/um: fix forward declaration for vmalloc
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: arch/um: fix forward declaration for vmalloc
Thread-Index: UBGj77MW+AtEVaScQFoqg8K21PqsYg==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240422_135003_954335_2D1C1DDE 
X-CRM114-Status: UNSURE (   8.17  )
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
> Von: "Suren Baghdasaryan" <surenb@google.com>
>> > It's in mm-unstable under dc26c7e79daf2fc11169b23c150862f0e878ee5a. I
>> > think it just didn't reach Linus' tree yet.
>>
>> Hmm, so we better postpone this path until said commit hits Linus tree,
>> or you carry it together with the commit in mm-unstable.
>=20
> Oh, sorry, I didn't realize you were talking about the `Fixes:
> 576477564ede` part... Yeah, unfortunately SHAs in mm-unstable are
> unstable, so the change being fixed is under
> edf0a25633bda1e5b7844478dd13b4326a3d5d09 now. I think Andrew placed
> this fix right after the change it fixes with intention to merge them
> together later on.

Ah, the patch itself goes via Andrew's tree, works for me!
Let me note this in the uml patchwork system.

Acked-by: Richard Weinberger <richard@nod.at>

Thanks,
//richard

