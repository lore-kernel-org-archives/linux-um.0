Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FD25C10F15
	for <linux-um@archiver.kernel.org>; Mon, 22 Apr 2024 20:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=s9Rtmcw81GSG9zCbjUh61wEXkhKo/qPRbnRkT6JvNhg=; b=yQWGEcklmuzt92DqN//hVSdy81
	lwDS5iSSH+qK+hbTAHKPMIiDgwXNt5zsMn+9QrQO2//N3DQA2sovdoLsIDR8WQ4pdJZOjVFJ95S93
	bnp8Az0E8NgYo7YjaqGA+HBComD/LgFrYbqx134VSrAjA9NcCBj9btBCFfVSSSNswFw4eMeXNz3Ob
	784+7W+kuGMrEi9XDCkNnGSXasQi9CNBcD1ebrINl+4T7tVQWvK+EtwdrsH7g5yRlIOXIMyq84r4b
	qtqbIkflTSI2DHIBo0LudOkSvpu5z0VeIwLahNBs6UOqQ2RwDw2Pji1caDmD+7r/eFIHEbzjYhcsV
	9pC8Bbvg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rz0SR-0000000F0Jk-1nnt;
	Mon, 22 Apr 2024 20:40:11 +0000
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rz0SO-0000000F0JM-3LtO
	for linux-um@lists.infradead.org;
	Mon, 22 Apr 2024 20:40:10 +0000
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-41a1d2a7b81so10201285e9.0
        for <linux-um@lists.infradead.org>; Mon, 22 Apr 2024 13:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713818407; x=1714423207; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s9Rtmcw81GSG9zCbjUh61wEXkhKo/qPRbnRkT6JvNhg=;
        b=NEOBaGev0EQF46hpzpPleUSyCETo1Cyy9zI33roMOTGQ/SR/UNkRG6WuS/hooSrMeO
         mOHGvvUaKO4dvjgZLpkqYD6fv07SOlegsNrZchsxJEAFDFYSzUd6k5ybni9PJelGFgaW
         K1XF49lZJVw4VLIARJCqrVtqJGfM+3LReoPDH5X5WGdMS41Xao3SJdFRyGOJrNemp5c/
         suIqGArC9w5Zj3686mRCgH5INuaqml9p+Ub8fr6t3LiDdyqqmpyBdSdpPJsil1VqtrTa
         IfpqppVg68CWAUkc1L+uR/S6UI9S14zXMbA5d2a3iLijAiyGLm78oY6j+nVrcZDW5ug4
         KqfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713818407; x=1714423207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s9Rtmcw81GSG9zCbjUh61wEXkhKo/qPRbnRkT6JvNhg=;
        b=IBf8faDCYR+68IxOfH0DlmC+DlsAuyogpbPnd35EKjkpIdFRzbii6fiFG72CLIZMlL
         QpzFPJFqFzSjoi38gEWHcPnP91uX30vVt/a4wyof16jd4ABMe3NiUznSyOJkJE242DG4
         CFdzUJydPjL6bKtS83iBHj6o4tdDHQ7/WZV9DKaW1LqSqnAKWcBNKo5qBuqYm/1dWDij
         cGFjD9k01LjvTVZ90ukLcciLE97tEhjOHzZduF9S0W7hQ2PUXy0Eo4xP0W3ZJpy38zZi
         ES8BYXSfv0T5EINyldsj7NiVNZLGCu1c75jtbf2vxddDGdLhKmhFUklT1ix0LXFkoWXv
         9szA==
X-Forwarded-Encrypted: i=1; AJvYcCWAyYZVKute98bpssxiMn282QiErdWdxGWs7aKbNsN1whL1JRq/+wWWnEG2f3+x/KSA65ABNgaR9JDT4eifzeC1ljs+z5nUrM80GRrP
X-Gm-Message-State: AOJu0YxFId+TufpuLuzihYfwH91lLLtB6FBI2Dbg2pLDZiKRXck/i1kG
	Emi9LG7hX1FID7dkymSxBR32y+CNwB0BXU3kZnZBljVzOJWeq0vgF8PSWjMzwQqhDIWqUaClwtA
	IFaHjc67P2HjFWHEDXdV3H/PKohDGMhZ4T0Ii
X-Google-Smtp-Source: AGHT+IF7rFm9mITo1Vmn1L9OtqNa4/FBUTwSXrEKXV+NRexmqy2sVD4twe62Ho8ckMl9s4IIedPmaRUcauWYnCOdQWM=
X-Received: by 2002:a5d:5985:0:b0:34a:4b4b:7f4b with SMTP id
 n5-20020a5d5985000000b0034a4b4b7f4bmr573264wri.19.1713818407006; Mon, 22 Apr
 2024 13:40:07 -0700 (PDT)
MIME-Version: 1.0
References: <20240326073750.726636-1-surenb@google.com> <95819052.15033.1713816660761.JavaMail.zimbra@nod.at>
 <CAJuCfpHnM6L-7s8cd90XKiawhw9LZaRfMfeDm54OshLQdV5YmA@mail.gmail.com> <1375034928.15114.1713817899712.JavaMail.zimbra@nod.at>
In-Reply-To: <1375034928.15114.1713817899712.JavaMail.zimbra@nod.at>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 22 Apr 2024 13:39:52 -0700
Message-ID: <CAJuCfpFsrQxa2CX66xQtxp=Y-=R5_YkJMMX9VQ-g32rdCrukeg@mail.gmail.com>
Subject: Re: [PATCH 1/1] arch/um: fix forward declaration for vmalloc
To: Richard Weinberger <richard@nod.at>
Cc: Andrew Morton <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, 
	kent overstreet <kent.overstreet@linux.dev>, SeongJae Park <sj@kernel.org>, 
	anton ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	linux-mm <linux-mm@kvack.org>, linux-um <linux-um@lists.infradead.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240422_134008_857389_DA3C10CB 
X-CRM114-Status: GOOD (  12.53  )
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

On Mon, Apr 22, 2024 at 1:31=E2=80=AFPM Richard Weinberger <richard@nod.at>=
 wrote:
>
> ----- Urspr=C3=BCngliche Mail -----
> > Von: "Suren Baghdasaryan" <surenb@google.com>
> >> > Fixes: 576477564ede ("mm: vmalloc: enable memory allocation profilin=
g")
> >>
> >> This commit id is not in Linus tree.
> >> Do I miss something?
> >
> > It's in mm-unstable under dc26c7e79daf2fc11169b23c150862f0e878ee5a. I
> > think it just didn't reach Linus' tree yet.
>
> Hmm, so we better postpone this path until said commit hits Linus tree,
> or you carry it together with the commit in mm-unstable.

Oh, sorry, I didn't realize you were talking about the `Fixes:
576477564ede` part... Yeah, unfortunately SHAs in mm-unstable are
unstable, so the change being fixed is under
edf0a25633bda1e5b7844478dd13b4326a3d5d09 now. I think Andrew placed
this fix right after the change it fixes with intention to merge them
together later on.

>
> Thanks,
> //richard

