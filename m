Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA3DDC77B7F
	for <linux-um@archiver.kernel.org>; Thu, 26 Jun 2025 03:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=w4XTaD2tNZVnetmUxeEcKN2FJhAWBnQgKVB9ItQiBPg=; b=KflqIYvSVOszDWE+6FiFCXuBA2
	ei1XbGW+poJM0LjYlpuxsBhJETigawjYYBpW9aNy5olg8hCCr6lyG0wdPyIgi0Jkx+lp8ngZWVhcd
	LceT34Z7zCkyIXxDF90Y9La+0gSFNir5IBHCTjWgkKMsp5gPpr09mRds1JHrJXvVu4tN5QIJ9VXIz
	gV6Xodc3QG/mbfr5elKA6laA8flrqDXyJTSNONt7PLdzBGbhhhHFrJ25Rsu8A4ndwTdaEwyIhfBGr
	xWpXK2OuGDQejNrhorEhLpPWMRJSZRRivp8AAyOEYojE2wNlx8cdMAi4JN5HhRHmdRpcRV5JhUas0
	HmSbK5RQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUdbE-0000000AXzl-3y7S;
	Thu, 26 Jun 2025 03:48:32 +0000
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUdbB-0000000AXzO-3gRO
	for linux-um@lists.infradead.org;
	Thu, 26 Jun 2025 03:48:31 +0000
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-60c51860bf5so774665a12.1
        for <linux-um@lists.infradead.org>; Wed, 25 Jun 2025 20:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1750909708; x=1751514508; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=w4XTaD2tNZVnetmUxeEcKN2FJhAWBnQgKVB9ItQiBPg=;
        b=TNcRxNdKDBkAC+F8T3QxLOpxLdMmvFo3d/ju4ITdqAHSmJy8ksGcJy0/4h2A4ws8Mf
         jv5ISxb60PsRpFNo94wsDm4KfnpHJzkIzDo+gweqYzW1DpjC0EkuenDod0Akjf3TVUBH
         5DKEYpTZa1viSXIjdR8/51lcXYL8+Smmg7Hxc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750909708; x=1751514508;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w4XTaD2tNZVnetmUxeEcKN2FJhAWBnQgKVB9ItQiBPg=;
        b=WUSQlFXif0v/JHyvNGFyBFRCo5ISTY2CPvYOn1zf2SOme1u0JWd2FODmU0g2wK4fZN
         u+P/fQuUtdAUk0dAFn9OKVtcDlOhlLfcMNLdU1Mms3TIiJAJv1YajRDpXw1dlYYv4Ezc
         3E/SRqj3kKtt8SrOtJdSzkXGdIw3gbmpfthefEbciXKOnw2s6fmniLtP50WTPFt5LRIM
         0hbEw96aQlQttk+dYLoHuCpnGxX+Vy8SbPJC+u82IbP/WK6fySEJzNvss39Ibp1x2ras
         J2HZNtx/mSZUS9BUOT8GWyD5K8Vj1mUE/R4wincTHvr5Nhm15hXjshnHu5O0Yi+I6ohJ
         DLmA==
X-Forwarded-Encrypted: i=1; AJvYcCVneSZChc+f2mEB4tDSP7rTiTU6nOnj4pEK5naYnLUO34fQaDEuikSjiL9LwF7hsuRgSvgQ6ZO5mA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yx0N0Ad6j5Kl/CxAH+0Od+HEhr1AZf1fMnnedYuHVx4HN1t+YJ8
	DU0NaUn8c1ILGX66WZUGxLniBUudyPFVMQCRmF8ysmTZOe3Sjbarg+q0Ejtqw++PyxlqOBICLmd
	S3IB6xO0=
X-Gm-Gg: ASbGncsobd2z5d+KaawEMiGYn6lcNNK8sjogAM9nuUxSC+53mSSmRPdOdUuZDzfX+aX
	P5Fj85IdRAKRIIxLLTPdbcdSOyWGez92AyBezHtxm46WvdUxQNbkIC+80KKdw/EO/yMoVYjQF3g
	Ax/+2+uUqJt7A8fKJ6dXST/Lll2Kdo+K77dJfKgLuLkG8J11FU4Fcu/tvzKXkfZXJ4dq2Vssgkm
	WBc0TrnHqwtWICmIgoy0vOUMRXQbk5j0Cgn0Tdb2sQ8fk+zF2IpwEFI7FTW5Ht0zbCvMStHE6iP
	MovJDR1S+WK4DUmzeSz/gDv9CLHeUoWXPLS5C4kAhInxVMaKdqQeuLewQsfvaKUuMtxcKRPqgz2
	ev73xSAdZqj7g4uKiuHVdjIeSXNCs2tGrRNZxT9laJLP60sc=
X-Google-Smtp-Source: AGHT+IGkCiMUiyNv8DVA5wCu79PogK2eONV17OLm6Sd/gwVBgrS+XwUgkvFkRCqCc6iRa2rOKTkfew==
X-Received: by 2002:a05:6402:40c3:b0:607:f558:2894 with SMTP id 4fb4d7f45d1cf-60c661268fcmr2033058a12.3.1750909708142;
        Wed, 25 Jun 2025 20:48:28 -0700 (PDT)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60c2f196ab3sm3260961a12.3.2025.06.25.20.48.25
        for <linux-um@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jun 2025 20:48:27 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-60c5b8ee2d9so1070629a12.2
        for <linux-um@lists.infradead.org>; Wed, 25 Jun 2025 20:48:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWQkypoATogJxQ4f6LbtdW6bccrsPdFQnWwiA5pIe9LBh4Gzh1e/iCJEJROkH0opiFOHYiEZ1hyIQ==@lists.infradead.org
X-Received: by 2002:a05:6402:27cb:b0:60c:461e:7199 with SMTP id
 4fb4d7f45d1cf-60c66149e7amr1836785a12.9.1750909705477; Wed, 25 Jun 2025
 20:48:25 -0700 (PDT)
MIME-Version: 1.0
References: <20250625121529.42911-3-johannes@sipsolutions.net>
 <CAHk-=wjTCAzaw4AXXpxcYc7v7ZjAeyaOOJw7FWXO+gV7v7Cp0g@mail.gmail.com> <0d630dec-41fe-4968-8d6a-7faae8a554a1@antgroup.com>
In-Reply-To: <0d630dec-41fe-4968-8d6a-7faae8a554a1@antgroup.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 25 Jun 2025 20:48:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh=_ZmpYtCx11wqsGGdrZRHsPorTzpzh2-QccT8PGKW1w@mail.gmail.com>
X-Gm-Features: Ac12FXycbCEItBxGZBZHR-kJgJKAj9PUK2Osl5wq-e9vxN7XlQjqQ2Ty7F-dNLs
Message-ID: <CAHk-=wh=_ZmpYtCx11wqsGGdrZRHsPorTzpzh2-QccT8PGKW1w@mail.gmail.com>
Subject: Re: [GIT PULL] uml-for-6.16-rc4
To: Tiwei Bie <tiwei.btw@antgroup.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-kernel@vger.kernel.org, 
	linux-um@lists.infradead.org, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250625_204829_943350_0F1BC035 
X-CRM114-Status: GOOD (  12.11  )
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

On Wed, 25 Jun 2025 at 19:44, Tiwei Bie <tiwei.btw@antgroup.com> wrote:
>
> The behavior of gcc and clang differs. Clang's behavior appears to be
> related to the volatile qualifier in arch_spinlock_t:

Ahh. That kind of makes sense.

At the same time, I think clang is being stupid here. Yes, it makes
sense to treat volatile specially in this way - just not for an
initializer.

I realize that initializers can be made to be their own data
structures in modern C (ie taking the address of an initializer and
using the initializer itself as an argument to a function call, for
example), but when an initializer is used to set the value of a
variable, the only real thing there is that variable.

Oh well. The patch certainly looks fine and I obviously already merged
the pull request. It does make me go "I wonder how many other places
clang just generates stupid code due to this".

            Linus

