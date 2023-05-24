Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DA95C77B7C
	for <linux-um@archiver.kernel.org>; Wed, 24 May 2023 15:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	MIME-Version:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=q4sGduJUD2wSPKlhFW5yw9WYX/t/6vqq0Lnr4iR97R4=; b=yJt
	U3+DAWvdiLWclZUkO3k9gYJoP/fpmJ3IUqodmCooqDoHJTw2ipcjbubKRi9h/gcyTcoxCGGPAyA8R
	GGF0fEY9ONJ6Gz5srnL6YuNx3lyEpeqwgbQOH/5NIlZcqQfSxG6EEdIx3ClvQzB40w1EduX4zx7kX
	PsEyr0zpzo24Xt39g0LvBxf8ceIEg2YUmEvC51Twn+d6I2DhaIHvdYKZD6ybaejWOfZuGRogJkBqp
	eXgdVmoJ/wHrrKVTU11tRtFWbPt90xWmL2MdgJMeyYXVg4aY9zKV/2S6IdGlL6Y5DpPN339XOIEXs
	X475yWHh82ufHHwLAmQPlLZHGX8jn1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q1qhy-00DtQZ-2Z;
	Wed, 24 May 2023 15:47:26 +0000
Received: from mail-yb1-xb2c.google.com ([2607:f8b0:4864:20::b2c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q1qhu-00DtLd-13
	for linux-um@lists.infradead.org;
	Wed, 24 May 2023 15:47:24 +0000
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-ba86ea269e0so2263331276.1
        for <linux-um@lists.infradead.org>; Wed, 24 May 2023 08:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684943223; x=1687535223;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7tGw+/RB183XXg/5VnSSbQyfA2HGRV+zIzbBqKjJP9k=;
        b=kCzyC2ehZk6HBvx8Ta6uU7L847bQAMSzA3tVME3zAEh8PmOQxeaQrvh9cTo2qdsB3C
         xCR8Ei8mDk1N6UTG+eMTA0EaRcifzPdkSKTv6VCxkY98/O8oSMjGe0lIyIjeGL43wU85
         hnIVd8ropPaNnkIJdZCt7KEWk2LfWvTuPxlvr7OAmEYE6guxrtBRzzYu9r9eb0aaLBhT
         6M7SltAqFcZZt+nP2vG/z5ddoR1OmTpq2/MDi647wF17EE9jnwOqiznpAaBrOlPlUyOc
         CP+XOJFPOU/6YB77+iLxObgvcvBrATDgpQ9MVGKn67HOOL3y9ROBA6S+h02iQaQXuchb
         vg3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684943223; x=1687535223;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7tGw+/RB183XXg/5VnSSbQyfA2HGRV+zIzbBqKjJP9k=;
        b=X2oPXh3QVgJT2hPU8DxmvwfwUOrlvYvigAjJ5dN6yjd+CUk1eGefqftwDo/u5TT6UC
         McnPbhZgG197DVhUm171dgMqlW/zeogHWKXvMDhZwVg4ohw9lovhl+/qhP/wxFxoLBoz
         zGZOWYRr1LsTMCWkdNLyBExaqI408dkF5v8fBSyGwXlaL3bMqgHJnVA9GSPxYc/0v/1v
         VwKME3lYk7OWtgu0FeSQiaq/P2/yCa0L1dzvJ3CeCnGS5o3Xh0eUkQtzTUalHBDi/pTy
         sKFI7Ns5fHLNvDfoTvgHx3dcAx2DEuU6uUyQJTLKUa5+W5VLDowCxjSh9lfvSf4EbcPe
         87Kg==
X-Gm-Message-State: AC+VfDyMJsFkaJQ/m3mhaLEWnXiulghQCJ08nX2zMp9LW03VHJ6wkHH3
	rHMQ73mDkrd50KtUi/3sTHenBDd2OsJEIU71ZKHGUW5vjBElIc4+Tpp9vw==
X-Google-Smtp-Source: ACHHUZ4GruMga8hCQ4YhSH4U/fpRz3k7gyeHaEZ80b7LhSv4VPlweFwQMMelXYfJikcrXCBc7hfapyUHEMuuvkGQdYE=
X-Received: by 2002:a25:6946:0:b0:ba8:8b4d:c1b with SMTP id
 e67-20020a256946000000b00ba88b4d0c1bmr222481ybc.52.1684943221412; Wed, 24 May
 2023 08:47:01 -0700 (PDT)
MIME-Version: 1.0
From: Alexander Potapenko <glider@google.com>
Date: Wed, 24 May 2023 17:46:25 +0200
Message-ID: <CAG_fn=VaYdgreWwCUgrcaCDHH_54hBksvEUD4fijSzRs21ge=A@mail.gmail.com>
Subject: Building UML with ASan on x86
To: linux-um@lists.infradead.org, richard@nod.at, 
	anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230524_084723_081175_C672AC1F 
X-CRM114-Status: UNSURE (   8.97  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

Hi UML maintainers,

I am trying to build and run x86_64 UML with ASan (some patches to do
so are at [1]).
This is more of an experiment, but the idea behind it is that
userspace ASan should be able to instrument the whole kernel code,
while KASAN does not instrument its own building blocks (SLAB/SLUB,
stack unwinder, stackdepot).

The problem I am hitting is that by default my kernel is loaded
between 0x60000000-0x62000000, and UML attempts to allocate its
physical memory so that it starts around those addresses.
Unfortunately ASan's shadow memory on x86_64 Linux is located at
0x00007fff8000-0x10007fff8000, so if I run UML with e.g. `mem=512` the
physical memory allocated by setup_physmem() will overlap with ASan
shadow, leading to crashes.

Is there an easy way to move UML's physical memory above 0x10007fff8000?

I tried e.g. adjusting START in arch/x86/Makefile.um to
0x200060000000, but that led to boot-time vmap allocation failures.
Could it be that there are some implicit conditions on this address -
maybe something related to TASK_SIZE?

Thanks,
Alex

[1] https://github.com/ramosian-glider/linux/commits/uml-asan

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
