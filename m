Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00BDAC3DA49
	for <linux-um@archiver.kernel.org>; Wed, 17 Jul 2024 00:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cPEE1/PfCm9ph5ZMgfxhzH0UhwP5mSQaE7CtT39oJag=; b=VSHB27KrO0iq9RAsN1ml3p2x9T
	cu19oVaeBCCrXtJqasyF+nCsr9+wobyww7BnaOrWDZ0udPk9GdeuB7iECHC76K9xXuV/PQvtK8JZE
	KFZfR9Uysrl+MZI+wiE5AytgEZT0oKS2nkgyCRPABOZbvo8VdB+RQ9zb/2ZlQsaHDlWp348SsuoO6
	C+iT0CiYcFRWEnIvh0e9XNWOUzWV6i7k+qw0SBdofmRehodlovchrRfndyyrO7Te6tTSQQgH8fzvN
	v82/mKJ+xqK8iL7EisKCAOyisIm9unH/6MWC5kYRtafcxvBuiMhfCzwZ2pM2xJhHdhSo5SNw/ZQLv
	mTPgRK6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTsji-0000000CBLZ-0ek2;
	Wed, 17 Jul 2024 00:41:38 +0000
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTsje-0000000CBKw-3J7j
	for linux-um@lists.infradead.org;
	Wed, 17 Jul 2024 00:41:37 +0000
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-a77d85f7fa3so50152666b.0
        for <linux-um@lists.infradead.org>; Tue, 16 Jul 2024 17:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1721176892; x=1721781692; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cPEE1/PfCm9ph5ZMgfxhzH0UhwP5mSQaE7CtT39oJag=;
        b=K8F2F/HldTaLcj/R8Vf8Ir/Fz8BuwI1u/9tjj5clfGDNJCzTgtbXGXjX/4xjcOloXB
         WiPuOU+2MSJhy3vDuA8gJFexIAkG+aOk+eu1P3pEDML1tCi8Jx1ZfvognJgUCwQeSHxe
         6floZ7sTe3oq7HLEUbGB/oRthHA0DAod4MMDY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721176892; x=1721781692;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cPEE1/PfCm9ph5ZMgfxhzH0UhwP5mSQaE7CtT39oJag=;
        b=dcRTN3sf3+OBavlYGkZ9TYk8ZwDiRsGMkVdiBU/etN9bzjsR8wg52Fne/hjnlXvcLV
         B3kBQiG2ULGou29cOP8rwchyb5FiRbNRf7816TezabhklcK0H9oFM5dA9wnrloo0/Nfr
         9d1GU5C5kTtQkRGOMj1X6BV7HU89+sEqxnP48Fp7+LOCHLUy7Y2p+z5vTuzpl0UN4Ol5
         dWRS6olEiCU5+ZaoKsM3qW4XuJidNZ3Tkf9XWbHUhz2eVhyjkzWbudbF7JEYS0aRIBED
         swD1M3V78g7wbXYGQ4APVXah6skf22k6F4D30r5EXOUAis0wdv3mzrWBrIOAkFJxajhH
         wyWQ==
X-Gm-Message-State: AOJu0YyIYGCnggK3pibQjPxWEWcWhvGXoNhnBcSzuqxxf36/vvSsNACu
	jJSfCNHMxepS1Fp9vponNw0VR7A6P3/WQH3bliZ/14XBHRHxsCgTF+7Rd0U2y4kXj8MiEF9UX/Y
	r2hDPng==
X-Google-Smtp-Source: AGHT+IE2F0fhMJYlCPOSY+bouzFqLLn4bLJ0+RY433W9KMri1BQks2EvuTmlU6wuKX6HoePM8ey5pw==
X-Received: by 2002:a17:906:fa93:b0:a72:b43c:72f2 with SMTP id a640c23a62f3a-a7a00456a9amr19789166b.2.1721176892327;
        Tue, 16 Jul 2024 17:41:32 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc7ff91esm384408366b.168.2024.07.16.17.41.31
        for <linux-um@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jul 2024 17:41:31 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-58c2e5e8649so502878a12.1
        for <linux-um@lists.infradead.org>; Tue, 16 Jul 2024 17:41:31 -0700 (PDT)
X-Received: by 2002:a50:c308:0:b0:58b:5610:945c with SMTP id
 4fb4d7f45d1cf-59f0c91c8f0mr2868711a12.17.1721176891311; Tue, 16 Jul 2024
 17:41:31 -0700 (PDT)
MIME-Version: 1.0
References: <20240716143644.GA1827132@thelio-3990X> <CAHk-=whfQoTDCd=8DYfCiX0a2ndqM-mmoxDm1xA7Kud+WQ9T8w@mail.gmail.com>
In-Reply-To: <CAHk-=whfQoTDCd=8DYfCiX0a2ndqM-mmoxDm1xA7Kud+WQ9T8w@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 16 Jul 2024 17:41:14 -0700
X-Gmail-Original-Message-ID: <CAHk-=whVPmZm=rMBf1qkJzfZeBx4Es15_w7VnPK1wEs=XYDUgg@mail.gmail.com>
Message-ID: <CAHk-=whVPmZm=rMBf1qkJzfZeBx4Es15_w7VnPK1wEs=XYDUgg@mail.gmail.com>
Subject: Re: Crash when booting UML after e3c92e81711d14b46c3121d36bc8e152cb843923
To: Nathan Chancellor <nathan@kernel.org>
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240716_174135_660979_E626B314 
X-CRM114-Status: UNSURE (   6.95  )
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

On Tue, 16 Jul 2024 at 16:18, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Hmm... Does this simple (whitespace-damaged) patch fix it for you?

I verified that it seemed to generate the right (generic) code, so
I've committed this fix. I didn't actually run your test-case, but it
looks ObviouslyCorrect(tm).

Famous last words,

                 Linus

