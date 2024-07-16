Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A94AC3DA59
	for <linux-um@archiver.kernel.org>; Tue, 16 Jul 2024 23:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GaaUOlTJ2aiy5WeShI5LfyPJ+K68pFBCFfdMRXXg7XQ=; b=3vT0YpUqibOB8yG9LP7WHMoypw
	99WXxflKsvmXU4YketeTTI8V3uvHmv6vlrmvCpoxijZH+gxGQaV1kitLZX9tuMV90inUL/VBPFhgX
	GjcpsxzLspv3TZuJAdFrfx9uvNsxkldUxydWGaBY5NccLHvAkppQd7FVyI+B2OO+BLxc7te0RkalC
	xGTn5uo2I8vlbaMp4EdFWWb44slCMzPtsAuhfaPOgo8QT+pDRIITLxXVTOkp/TL7fj5O782S4A2YI
	0iJr3e+QwHeHVqZll8G3AAGjqSnoD0fgR2UZUGIZMRAM0ok7e9rdc/LEjM6Po32HgBd/xCbs+RkTw
	Vjfekl+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTrRw-0000000C2pM-39pD;
	Tue, 16 Jul 2024 23:19:12 +0000
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTrRu-0000000C2ok-1gSm
	for linux-um@lists.infradead.org;
	Tue, 16 Jul 2024 23:19:11 +0000
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2eecb63de15so68282011fa.0
        for <linux-um@lists.infradead.org>; Tue, 16 Jul 2024 16:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1721171948; x=1721776748; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GaaUOlTJ2aiy5WeShI5LfyPJ+K68pFBCFfdMRXXg7XQ=;
        b=bweYTMESRHXMsGK8cI0AvzdjfRy2ebIH1bPbDUfNAX0MfbmOMjWpBc4tPF0IW3j/Ib
         KNY7wOyQWvlvDttcw+Rj223wIMulJzFgh9aGVi8iPul+twIslZQ9SEjjnd9Gc0OOTskl
         R9xYzBK3xP1nRBBLCZwPe4Aiw6Y7z2eAX8txo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721171948; x=1721776748;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GaaUOlTJ2aiy5WeShI5LfyPJ+K68pFBCFfdMRXXg7XQ=;
        b=XGzkOqVvXOsmiU2+Qjjd2jMqV1HN9vfs5ayll4Kh0QAfFUC9D9WNpXChbx44M7HAw6
         7PBnA5fduxIaXZJs1CeQCsV+BVbiDKV1K2q+0WlD47buU7abm9ZCFnz6N2JVgnKrKG9B
         zXDXln5L7rBLU2txc7jBYBEXb2N2snKpb4dlFgQEF9AZg5/qoHay5Ow3O+9Lb59RQsJa
         6DW5HLD4/AmlXvCrgVNHmt+yK4vAAxA0Tc4vA0Kw44KcgW50POq2w8W24Cm/bXlaGktX
         4Fbg9TxTXmZEwyLou30UQtHRuHIb8A2PlQnCWnQ2+/Yq+9G6M9j5vuiygSorfzJ4JrsH
         u8Sw==
X-Gm-Message-State: AOJu0YxecPxs4Ew827FZGvzWiV3YgU6VP6nqQjbsB4e9SJPoqrN+cKF4
	PkW2jMwvBq5Cg/ffBNRiyfl8bKb/R1+wS6owp0UosJ4oH/E/OzfGHHGaALR+FTxkT6PvwjiJ5gr
	/h4hsag==
X-Google-Smtp-Source: AGHT+IHlwk2K631fU1KEmVsCjwWjEE4xy13YHOEkpGNveehEy7TJt3Rg0yAbhBCNvmkWabL6JQTDMg==
X-Received: by 2002:a05:6512:3a81:b0:52c:df6d:e52e with SMTP id 2adb3069b0e04-52edf01c04bmr2480445e87.16.1721171947943;
        Tue, 16 Jul 2024 16:19:07 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ed24e20easm1300820e87.51.2024.07.16.16.19.07
        for <linux-um@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jul 2024 16:19:07 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2eecb63de15so68281651fa.0
        for <linux-um@lists.infradead.org>; Tue, 16 Jul 2024 16:19:07 -0700 (PDT)
X-Received: by 2002:a05:651c:94:b0:2ee:8b92:952f with SMTP id
 38308e7fff4ca-2eefcded54amr102261fa.0.1721171946631; Tue, 16 Jul 2024
 16:19:06 -0700 (PDT)
MIME-Version: 1.0
References: <20240716143644.GA1827132@thelio-3990X>
In-Reply-To: <20240716143644.GA1827132@thelio-3990X>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 16 Jul 2024 16:18:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=whfQoTDCd=8DYfCiX0a2ndqM-mmoxDm1xA7Kud+WQ9T8w@mail.gmail.com>
Message-ID: <CAHk-=whfQoTDCd=8DYfCiX0a2ndqM-mmoxDm1xA7Kud+WQ9T8w@mail.gmail.com>
Subject: Re: Crash when booting UML after e3c92e81711d14b46c3121d36bc8e152cb843923
To: Nathan Chancellor <nathan@kernel.org>
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240716_161910_478221_15776C7B 
X-CRM114-Status: GOOD (  11.27  )
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

On Tue, 16 Jul 2024 at 07:36, Nathan Chancellor <nathan@kernel.org> wrote:
>
> Our continuous integration notices a crash when booting User Mode Linux
> after commit e3c92e81711d ("runtime constants: add x86 architecture
> support")

Ahh.

Yes, UML should *not* be using the x86-specific (or any "native")
runtime constants, and that was never the intent.

But it turns out UML ends up just blindly getting it, because it ends
up using the native architecture header files here when it exists.

How very annoying.

I'm not entirely sure how to tell UML to use the generic header and
not the native one.

Hmm... Does this simple (whitespace-damaged) patch fix it for you?

  --- a/arch/um/include/asm/Kbuild
  +++ b/arch/um/include/asm/Kbuild
  @@ -19,6 +19,7 @@ generic-y += param.h
   generic-y += parport.h
   generic-y += percpu.h
   generic-y += preempt.h
  +generic-y += runtime-const.h
   generic-y += softirq_stack.h
   generic-y += switch_to.h
   generic-y += topology.h

basically telling UML to not use the runtime-const.h file from the
native architecture..

Somebody who knows UML better can probably confirm whether this is the
right way to say "don't use the low-level architecture file".

                 Linus

