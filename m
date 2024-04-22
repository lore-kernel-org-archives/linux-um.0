Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACC32C10F15
	for <linux-um@archiver.kernel.org>; Mon, 22 Apr 2024 20:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:References:In-Reply-To:Message-ID:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DY4ANjXW+IeF+DYmL4TMInJWjnTHMwJVJqNPVqlFGDQ=; b=Ey09dl9gP/WgCpmYdn7SbvFAWy
	ss0+IROIjAoFKFDxbM0XIs44+/ov9GZyxahIjGp9J6xbo3MhkLe1lk+Pa2jnE07qHL2D+AGaiUUUn
	Sh1TSXYuFR3UbwFNW63PDDicCt3rPQyWhXuOqlIpuo2KbpE9YfSn3zSrKxABzfaL0zgeCf87HTp5A
	4RcxgO2L4xT3pt3EVpG1aPlXAZKyX/i1FWootdQ4vrSh/aPuGFQoi4HEHoP1zURxPntvTLvCJt16j
	AUJQCzuXSavbq7rTQ8Nwc+/t3AmNGDF0iLGmjwtPVEG/Y8UOLRKRr5vv4scqSpp9A5XaB5wVekRGM
	YDKZbJWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rz0KH-0000000EyeV-15gm;
	Mon, 22 Apr 2024 20:31:45 +0000
Received: from lithops.sigma-star.at ([195.201.40.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rz0KE-0000000Eydt-1OSY
	for linux-um@lists.infradead.org;
	Mon, 22 Apr 2024 20:31:43 +0000
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 61C54608F445;
	Mon, 22 Apr 2024 22:31:40 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id lISoQ8qWT-Eb; Mon, 22 Apr 2024 22:31:40 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 097CA609B3C4;
	Mon, 22 Apr 2024 22:31:40 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id YFngM_8nOgmK; Mon, 22 Apr 2024 22:31:39 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id D0AFF608F445;
	Mon, 22 Apr 2024 22:31:39 +0200 (CEST)
Date: Mon, 22 Apr 2024 22:31:39 +0200 (CEST)
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
Message-ID: <1375034928.15114.1713817899712.JavaMail.zimbra@nod.at>
In-Reply-To: <CAJuCfpHnM6L-7s8cd90XKiawhw9LZaRfMfeDm54OshLQdV5YmA@mail.gmail.com>
References: <20240326073750.726636-1-surenb@google.com> <95819052.15033.1713816660761.JavaMail.zimbra@nod.at> <CAJuCfpHnM6L-7s8cd90XKiawhw9LZaRfMfeDm54OshLQdV5YmA@mail.gmail.com>
Subject: Re: [PATCH 1/1] arch/um: fix forward declaration for vmalloc
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: arch/um: fix forward declaration for vmalloc
Thread-Index: n1ihtpuFBj2UP0//vEBjnw1r03B3Wg==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240422_133142_537991_C6C71B23 
X-CRM114-Status: UNSURE (   5.02  )
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
>> > Fixes: 576477564ede ("mm: vmalloc: enable memory allocation profiling"=
)
>>
>> This commit id is not in Linus tree.
>> Do I miss something?
>=20
> It's in mm-unstable under dc26c7e79daf2fc11169b23c150862f0e878ee5a. I
> think it just didn't reach Linus' tree yet.

Hmm, so we better postpone this path until said commit hits Linus tree,
or you carry it together with the commit in mm-unstable.

Thanks,
//richard

