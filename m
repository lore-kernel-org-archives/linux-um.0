Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 953A5CFA46B
	for <linux-um@archiver.kernel.org>; Sun, 23 Nov 2025 17:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/jzRdwgrlBGM4Ka3Mqp23QOr2mWfwNczhjfRCOlufvc=; b=kIqgXdT70NR7DrN24Xe4IKOulS
	y/Q0EcijpB+FhkqQCwLR+skdsErREzm60eXTnSl6xG4fRCQYl9/mcxnLhBVJE8vWImlJsAa1zaDr1
	Z4XHJNqXCNdL2eZR0tSIqYH/+Hhlq40j+7EMUcqkUbSUY903IKhRMSyiD5VWNPeim1/dYk8jMhN02
	YG9cvmJKkXm0TRzSkotVtyuUmKd136maTNrhDf/CDuIwUhO7Co8E07pMEWPc980ck1BY8FMi0yAoF
	1IqwiX8dYMojNvgGg+sDeITIRfquJZQI9DH35sPzczl/XAQJbDIaZEOD9M8OYNY4Q8MBDmPQj6ORQ
	2A2qwX+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNDZK-0000000AZUH-0Bpg;
	Sun, 23 Nov 2025 17:08:10 +0000
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNDZI-0000000AZTs-00Zn
	for linux-um@lists.infradead.org;
	Sun, 23 Nov 2025 17:08:09 +0000
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-343743fe398so324108a91.0
        for <linux-um@lists.infradead.org>; Sun, 23 Nov 2025 09:08:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763917686; x=1764522486; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/jzRdwgrlBGM4Ka3Mqp23QOr2mWfwNczhjfRCOlufvc=;
        b=QKP77bh1xQS52lK4d7P+0XJNvnIt8RuyffiL6TZNtWJ3/GpBhdVLRSTnrrk1+XmDK9
         Rz8eCYV9XsWfXEfN7aMzgONtx3On3n9ddtGoZ5UCmcvlX6/83mee9cxv5yioFtxVOXYD
         qAA7OAUPZ8TdILAkEZov/43PdiqNy1VTI28sskzobP2Lj+QIDXfYk+7ekS9S0EN0axdl
         8f6jR3+H7z40Ra8jz096k1tmCUozg8CH0F2Ysq7kCKjqOAi+ohTMrx0HwTVHLO59GJs8
         eHgGuyiuxLTgvHcnIcH31WVQaviqbH/xQmf25n0pix4f2mnYkjld9WdnsoriTz31E42d
         O1Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763917686; x=1764522486;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/jzRdwgrlBGM4Ka3Mqp23QOr2mWfwNczhjfRCOlufvc=;
        b=itMp4TlaqxSGburCfiv/sL6xrRecA874N/JM8osyTeEcaIKPNDiKmWLgnKFAqiOP4L
         wFuMqhvAxk2A2pOBoUrZ9EbL6j5guOprty7n6HkBjSSDzSQJ/tIXFpvkmN/kCuIg+WNl
         oR3MBqirqxASuqQAS+rxUwyMffSR5DyadOWjsxsxVqaNKFRus4LgwXcFvwzjmH5SW7ZD
         x25g7wTS/MiQjOHM0TChYGqAmlRxLBJRQ040S3cvUS5gkWNR26JA16aAn7zDHi60YoU2
         oCJsVjzVLD6cmPEWfOCFdJFP4/tjW12sHbcJNUXeQJS6UnJm6Ryx6ZQSdWxfjy5a6RaE
         Enuw==
X-Forwarded-Encrypted: i=1; AJvYcCUCj8cIRH9lOsxerycz07hrdWpLnjMNRIN7I7ZSmRGSC54IhhHRM8PNekkllHtHYAbFGKXFY8MutA==@lists.infradead.org
X-Gm-Message-State: AOJu0YwI5g/spzh7p8QuHWIwoQzpMQ9lI+XHu0JlvJNa8ZOoCW0Wm/mh
	pj/LQ6qazFcBc+CwqpM/OGo7conTv2TGLeXxkvPZGEzSgN98IKvnuL5n1V+mjm/1l9Q3WPoOJ2+
	5rhnSlNcJPjTr2Xg+E8MSB8sjKbEr75U=
X-Gm-Gg: ASbGncsXcZ30V6XZhexmMZxzsq+qQmC9LF1xPfQbZvIXQ2LCNQXYEYATAbIc3EsYnm9
	36w8OgdEoVlp8PuviuT0UQSEzcHlpbkf86YS5trW+CHbqnN4v93rPMx0gUaVdHx3rCtUpB3WMyg
	gwMhtvaxVnMFfL1Nqu2HzlJ6WzfuIQm/y8aBEjYausIoNaNj6xac09e9d8C3Zy9HCJK5B1GDYYY
	PGoJ6SzaZCeot37MnRxhpQRweWJoP7ZDs/vxw1a6iKYXF0qO5VkYp4oOpY/KTkjxMYu8yFR/pef
	phX7yho/WC2CpXajTa9qgUreCSSkKj8xHXrqph0zFUjSoPRB/4zT2y+kq5ktyZIG/iaewQjB0az
	3e80JkH96i75jGg==
X-Google-Smtp-Source: AGHT+IGZHjtJcEGBPZNIEzBBEH/GIwzRmK0XuA/cxDdYSVB2Kf4jYlzMZYG0qa248vJt64LoIMnSUJcQtEvU8UopE1Y=
X-Received: by 2002:a05:7301:e24:b0:2a4:3593:2c07 with SMTP id
 5a478bee46e88-2a7243ec7b9mr4703615eec.0.1763917686200; Sun, 23 Nov 2025
 09:08:06 -0800 (PST)
MIME-Version: 1.0
References: <20251122083213.3996586-1-davidgow@google.com>
In-Reply-To: <20251122083213.3996586-1-davidgow@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 23 Nov 2025 18:07:54 +0100
X-Gm-Features: AWmQ_bn4_ZVLWf7sDF8GSmpgYnQ7TxDVaCgMHNgG3l299wML01MntHwi2jSGnm8
Message-ID: <CANiq72=MXHZ2XswxkfzLqUEPwriNy=_sxAQpOYoYW8iNgyuJ8Q@mail.gmail.com>
Subject: Re: [PATCH] arch: um: Don't rename vmap to kernel_vmap
To: David Gow <davidgow@google.com>
Cc: Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Miguel Ojeda <ojeda@kernel.org>, 
	"Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>, Alice Ryhl <aliceryhl@google.com>, 
	linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251123_090808_052157_D91BE9CF 
X-CRM114-Status: GOOD (  16.24  )
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

On Sat, Nov 22, 2025 at 9:32=E2=80=AFAM David Gow <davidgow@google.com> wro=
te:
>
> In order to work around the existence of a vmap symbol in libpcap, the
> UML makefile unconditionally redefines vmap to kernel_vmap. However,
> this not only affects the actual vmap symbol, but also anything else
> named vmap, including a number of struct members in DRM.
>
> This would not be too much of a problem, since all uses are also
> updated, except we now have Rust DRM bindings, which expect the
> corresponding Rust structs to have 'vmap' names. Since the redefinition
> applies in bindgen, but not to Rust code, we end up with errors such as:
>
> error[E0560]: struct `drm_gem_object_funcs` has no fields named `vmap`
>   --> rust/kernel/drm/gem/mod.rs:210:9
>
> Since, as far as I can tell, we no longer actually link to libpcap, it
> should be safe to just remove this define unconditionally.
>
> (If it's not, we can possibly either disable DRM Rust bindings under
> UML, or move the redefinition of vmap behind some config option.)
>
> We also take this opportunity to update the comment.
>
> Signed-off-by: David Gow <davidgow@google.com>

Nice, thanks for this!

Yeah, I guess we would otherwise need to do the same kind of "wild"
macro replacement in Rust code to support this or conditional
compilation, and neither sounds good.

If it is not actually needed, then this sounds like a win-win.

It seems it was indeed gone in commit:

    12b8e7e69aa7 ("um: Remove obsolete pcap driver")

So it sounds reasonable to me assuming I am not missing anything,
which I may be... FWIW:

Acked-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel

