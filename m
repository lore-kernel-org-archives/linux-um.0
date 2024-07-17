Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEBD8C3DA49
	for <linux-um@archiver.kernel.org>; Wed, 17 Jul 2024 02:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XYrqWZq1EqYPi9XpXV1CPlqkOEZcea5WhRbwHmUhz3Y=; b=VrRJj5vPQH3E+gWplfqLe38DC1
	yMMqxLd19plhp9Bg0HJB+g9zh36MeUD5WySTCVdiz+dvBdEqZbBnI5+ITUnD20uVN0SliW4f44PXs
	+zWwaZ0Fc3G77pcwVs+Jo8RWrJ/kgbybU9HddBzhaZAOTR5LYnNH3FAfYYvWJXF3CtbjWDRndK2ty
	VGSzEu6Spb8pwMwRQ4w3Zvy5mSI65veZftMkelMjvOwmt59tLwJUeX/w65v/UjAKkejWm9nqGC1Nt
	m+TUuAp2K0+bnpYrgbfvxy7QwwPnI8vwrhJ/XQsS+qPFSJq8II9TaQkcbEJcu/Tke5Q0+AaNpogyP
	Cohakjgg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTtz4-0000000CJjw-3ykf;
	Wed, 17 Jul 2024 02:01:34 +0000
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTtz2-0000000CJjL-0KMo
	for linux-um@lists.infradead.org;
	Wed, 17 Jul 2024 02:01:33 +0000
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-52ea34ffcdaso6750559e87.1
        for <linux-um@lists.infradead.org>; Tue, 16 Jul 2024 19:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1721181689; x=1721786489; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XYrqWZq1EqYPi9XpXV1CPlqkOEZcea5WhRbwHmUhz3Y=;
        b=eaYOzWke3fRCk7IRYKKICecw+b3nK1XSCNeGMn12TPd9dAdlkHH8jTNfN3FRWyVVmF
         9SCE4TADCJRCYRp++PM26pwYGo8r2s693FWYjpGa2Vilrd7Ufd5XZUrIvceK/cZDkAId
         SqSyVTedWuISlY5cLTIrP50nJ3poK2bO6f+LA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721181689; x=1721786489;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XYrqWZq1EqYPi9XpXV1CPlqkOEZcea5WhRbwHmUhz3Y=;
        b=D5J1sgnbxEfQkbxZ+gzmxe/4sSoSt0nOXquQZ8CBfM3Ja+k8iCEF6Iz2eGUqRs50CN
         8Jyar586IGPzhnxPZLhaTApsjTvkO2/AaHtuLCNg5b9g3glAdAu+Hj/InjHoPOxWDGSW
         cqlVrJQleQiZjK3vTLwz2rPe6N3RhGhOVEyXlIdUgN4yOxTywf5W0b3krhx/G92hea29
         dgWHtaKx+8zniZPbhaGD6aAg6Ax986JJUNnIkHMD2xxOOv/vItAo9XDoGeRxQOqYpZEx
         XzUuZ/SYLu3d5SsK2ItcIAbMYbAu+gTBnNXtXWyA5BdWTWRaWx6ZJzbxT+2w9Ip5R/dc
         BisA==
X-Gm-Message-State: AOJu0YzHdbZlZel8S77PRzZ5JSBE4KBaJiJQtOwD39cntw+Ou6tG/iDu
	9YviKs5rZcPFpHDP9jpY74VUwTJrjOo/BAkhle2gf4IzCIaGRrneKDM5mTN9KdW4z1gAmSgF6fV
	/Mth/tQ==
X-Google-Smtp-Source: AGHT+IHpe/sezqAcmq6Fm7KCd5+BTSVTWai9Auf9CyUapVWwDbSOMaEI+Pste91DMLmvBq9nLlOp3w==
X-Received: by 2002:a05:6512:3da3:b0:52b:c0cd:7312 with SMTP id 2adb3069b0e04-52ee5447dccmr152266e87.49.1721181689067;
        Tue, 16 Jul 2024 19:01:29 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc7ff707sm390598166b.146.2024.07.16.19.01.27
        for <linux-um@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jul 2024 19:01:28 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-58b447c51bfso8001790a12.2
        for <linux-um@lists.infradead.org>; Tue, 16 Jul 2024 19:01:27 -0700 (PDT)
X-Received: by 2002:a05:6402:40d5:b0:59e:a222:80f6 with SMTP id
 4fb4d7f45d1cf-5a05d0efa3emr256034a12.27.1721181687614; Tue, 16 Jul 2024
 19:01:27 -0700 (PDT)
MIME-Version: 1.0
References: <20240716143644.GA1827132@thelio-3990X> <CAHk-=whfQoTDCd=8DYfCiX0a2ndqM-mmoxDm1xA7Kud+WQ9T8w@mail.gmail.com>
 <CAHk-=whVPmZm=rMBf1qkJzfZeBx4Es15_w7VnPK1wEs=XYDUgg@mail.gmail.com> <20240717005346.GA516623@thelio-3990X>
In-Reply-To: <20240717005346.GA516623@thelio-3990X>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 16 Jul 2024 19:01:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=whxxhjocp7Q92g4vkN75w+VNCEvAS+qbC8aEpguxudMAA@mail.gmail.com>
Message-ID: <CAHk-=whxxhjocp7Q92g4vkN75w+VNCEvAS+qbC8aEpguxudMAA@mail.gmail.com>
Subject: Re: Crash when booting UML after e3c92e81711d14b46c3121d36bc8e152cb843923
To: Nathan Chancellor <nathan@kernel.org>
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240716_190132_170041_8F70B2AD 
X-CRM114-Status: GOOD (  12.80  )
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

On Tue, 16 Jul 2024 at 17:53, Nathan Chancellor <nathan@kernel.org> wrote:
>
> Can confirm. I tried it initially and it did not seem to work but I
> think I may have been using the wrong object folder or something.

I wonder if our dependency rules might not be confused by a new header
file just showing up earlier in the search path.

So what might have happened for you is that it generated that new

    arch/um/include/generated/runtime-const.h

file thanks to the Kbuild rule, but then it didn't actually re-build
the fs/dcache.o file, because the way our auto-dependency works is
that it generates that list of all the other files it depends on, and
it also depends on the exact build flags - but that would all miss the
case of "there's a new file in the include path".

So that would explain your "it did not seem to work".

There's some handwaving here, but I do think that this is a case that
our otherwise pretty good automatic dependency rules may fail at.

              Linus

