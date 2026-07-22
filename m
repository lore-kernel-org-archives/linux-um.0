Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84D6AC44536
	for <linux-um@archiver.kernel.org>; Wed, 22 Jul 2026 21:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/qYokwiAAGe63GTWrnJUGK39HtmVxgzCgf7RDiUQ524=; b=bk1Z5qXOftPStNlri/FMHqfmOi
	2KuOh1fBQh8N4oyUQ/3XPAWBP+D7nBOJy9mdH34/ToW3W+U0k5kskSEIu5DVWZKTCKKu7s/hLxmD0
	lOpOqnm/oeu3KbwRpBGaVoX0l0tL6I19emNY2ERyTtkUErUqoS0DbSaKnpYMnNocuMgJb0zNpy1op
	7kaImmmkaNVvcbopibGtuWKHeZool7St6lbt9iFWn/QRVigwXCO7ReZRqq7wwOqsAx9IUxRv1IRLF
	RnLCWvoFY9J6mKOYy9mDE5NP+lbNuu/xymoxGfgivdVaMvv+D23NdMuEMgIHXIkkjOovK+a87c4cL
	ZOAoi5NA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmeZP-0000000Corm-2dDi;
	Wed, 22 Jul 2026 21:33:39 +0000
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmeZN-0000000Coqv-37Zd
	for linux-um@lists.infradead.org;
	Wed, 22 Jul 2026 21:33:38 +0000
Received: by mail-yx1-xb130.google.com with SMTP id 956f58d0204a3-6682259cb3dso8568469d50.1
        for <linux-um@lists.infradead.org>; Wed, 22 Jul 2026 14:33:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784756015; cv=none;
        d=google.com; s=arc-20260327;
        b=j/torqCSsMI9yB6ATtqZUIN7oeEfgOe1o5HfQJIVd3Z1jKZjUsuaWkz8snf0xJcn4a
         +87tn+v3Q0Hk4heK7ZlNWlPBCYzI3HqOPXUqjxYnFMzVRrAkf27ldck+/l84RWhXaIJI
         MBD1CfOMD4hNho7F/A9vr4aZGW/NPjD0Mrptw8+Hjv2ChjYkiIFIjzLsI4Q47g83s49T
         hCdQsgs0GoZdw2froY4hYubP/9ds52lAeBa39N0mGmuNetyRB2t0D3tapWZiVTVdolaW
         YIzmJsAjXJKEKjR2z5YEOm9cZ+3lW+feV6CchFXhL2yuS6ez263lc4Eff+jXpfGLOI6a
         xCpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/qYokwiAAGe63GTWrnJUGK39HtmVxgzCgf7RDiUQ524=;
        fh=M+DGkPgDmMDmi18hr3/NaS70vnxyH5yCYvpBaDozc+s=;
        b=RzsmPN0x8K4aXh23ugBxDPj3t6mB5SFBk9uRWRbNWxGi9PUPDTdj7CcfoicSyT4KLq
         pe6w0/Hpq8/i9qxPEt74fcFYKc6IEaqkG4UonV/U2jB42N6JyVFQOFATcQ57gEWUEMbU
         Mg8RUEMu57Lxrv8fdb4mcI6zJpZSch9rXUZW43x4WjxJTNceoiEfBoQ53bvO4YdbekVq
         psUu1kRcga6bOx+0eyhypuWaZgiGTvwrN81VHC9QD8JoKXV8S2WaoOnHzd3nzOvz2DDO
         +ONLOrYLh1tDvuEwtb3mFIX2qFfpytww471GD0+SlgEMQ3HjR+yjlqZc6gqG8z9v+TwY
         nEbg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784756015; x=1785360815; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/qYokwiAAGe63GTWrnJUGK39HtmVxgzCgf7RDiUQ524=;
        b=ewYccmpfG/nh/zw2vddvlyPgjBdGOSPCVOrzcIIvG98sn7C12QkeJeYMx8RhnOLiTN
         Q1RsPO608IAbBZ2FLvgsaE7tz/ACFMvSInrS4SdInh+XZF6XS23LVr4ADmFZnELilMf1
         Iu4F54wGnhBYNp9vG2uXWaaOC9KM1zcz1DH85odtQ7FHrb5NbhS9PAZbuggk8wW8gKYs
         v6ximaYv5ulEJiGyWZmstP0H7aAPOUeFbjWk2sVNHRiPHXNsUpCW/e9nVB4JXhcRY8/M
         gzTkV1AkrTpj0hn17t+2I04S0+CvahgjXYCEMbED2KS99NrhElD+G1EuLQgKhihwhV+4
         vYfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784756015; x=1785360815;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/qYokwiAAGe63GTWrnJUGK39HtmVxgzCgf7RDiUQ524=;
        b=PHiOAg0yP8kKBPTfB3r7+kxIVuZeoHJziNieI0puKiitVaOh0MFFyLznLVCmDQOrDa
         dCL5GG18/S5J9h0T/Gv2IzA2ZCZkRIQ3v8uHkd/PmIwA6EyKiM0X+N0W2kceO/qltz6P
         R1juref899aFzuOdwX8j0wwGUPBDWzfPsoDMqmyBlbQ6Vttu5fdPC9Qk/l84/qiBjH5L
         p5ZnavtZEBZPYflaRapRTaqcIVs8ieEt3IJHGZSTIF+wkfP0+2pEwshmEGD9mOealwjo
         3jBk+M3JMcFgxKSOeGB8exSkW6G1fduAhiu9UBq8tlmqlJYA3obOjYB6QqZGTmTpfGPh
         +hqQ==
X-Forwarded-Encrypted: i=1; AHgh+RorXxnL5TyPJwiHewc4tYCYmjX7C7zW32cNQGXs6mQg5FLM+u+6qawERjdt6cj4JyCzilgj56vslQ==@lists.infradead.org
X-Gm-Message-State: AOJu0Yzx1nyEcgg8KPlQlj9PHjDgXNU5qS/bog1RboK7awpR+7CxABpM
	K9WrYHsSgzutKzBy6wlLWPH+PScr27M900yhnDAzKF6SQ75ByzKEGS6k62z0zF+3AkmSRbH+09/
	JsKONFfGj/7iEiBRYi7Q9Tfm2BOYgrAQ=
X-Gm-Gg: AR+sD112ZBZg2oD7ipO/7rWw0DQjg7t+twu9J+xRlueZVzMhSlVAeVNTMFP8a55txXH
	WQs/9HkL8M3bD65NHXx8dBEcKtFnl9U4DNr6VT0dm1ep0LkBvyLtWXGDZIOo47CE4VabifWlmJ7
	DTBLey3tatS0RmKR82LhlQlbYJ3z9MPgcGH5DeRmRYWW4+wrAQq66NbB4z1QOQf45wNnIKXdGaM
	vvfyb811onl3iACwiDHxU4YhD81EWt8/yWSYFizFnAVY8Uc1XfZd8/aKv0QV5Bh2sbjj6VwJVDK
	UCR6bAodLXpcerM=
X-Received: by 2002:a53:ad52:0:b0:668:27a8:5566 with SMTP id
 956f58d0204a3-668a605a840mr4723d50.9.1784756015568; Wed, 22 Jul 2026 14:33:35
 -0700 (PDT)
MIME-Version: 1.0
References: <20260622124722.1694157-1-michael.bommarito@gmail.com>
 <CAFLxGvzLku3V1v1aEZU0v6ZhRE0UcUUbkfj1H3vzgtE9LEQZVQ@mail.gmail.com> <7aea68a6-a393-417f-9f99-f915a6ccf2d4@cambridgegreys.com>
In-Reply-To: <7aea68a6-a393-417f-9f99-f915a6ccf2d4@cambridgegreys.com>
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Wed, 22 Jul 2026 17:33:23 -0400
X-Gm-Features: AUfX_mzq6eVP_QlQZL6XvLJWnXt_wwzFM32zbpQQ5fl0xV1xszu9Gc2irvFk4a8
Message-ID: <CAJJ9bXwjR=O2SRa47s_PYHEfp-mOtRjRuRz6vowu2x=aX_sxdQ@mail.gmail.com>
Subject: Re: [PATCH] um: vector: fix use-after-free in vector_mmsg_rx()
To: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Richard Weinberger <richard.weinberger@gmail.com>, Richard Weinberger <richard@nod.at>, 
	Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260722_143337_792766_787BD4B2 
X-CRM114-Status: UNSURE (   9.10  )
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

On Wed, Jul 22, 2026 at 5:31=E2=80=AFPM Anton Ivanov
<anton.ivanov@cambridgegreys.com> wrote:
> I already did with Johannes a while back. Valid bug and can be triggered
> remotely.
>
> I think I acked the patch at the time.

Yup, back in April.  I think it got lost in the security triage at the
time and I forgot to follow up until June.

Sorry for not providing that context.

Thanks,
Mike

