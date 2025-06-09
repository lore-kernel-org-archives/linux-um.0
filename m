Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EADAEC61CE8
	for <linux-um@archiver.kernel.org>; Mon,  9 Jun 2025 09:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uqj0aPIdzN6xMFNiDXaeJsIfjkw0K8ThuC1zdxEa6VY=; b=4BOGsPaA7RWLDyLuPyY6TFnTYk
	b4BNQPKLsvXDYa93tgyHOXkWxkqIW23T708kyAwcXxycgd0TeULLmO/HZMPj6a0756lWMw6YRc+ph
	E9RrZg9UfZfBybbe3wSAR+aQyXw8ag2o8ItT0HA8QHFc0B0Z9ZPnqrFQhbgx/401AGyq5RSO5imUT
	SNmo+mDNM5EZlqqF/HCByyDzGsT6xun42CmVOgv8Y1DJ6WsWdiO5k4oLX0sdiymdMIo6futa1y00s
	l0v1OvKb8oxZkNeQc129YwH7kQZzIMEqxjnkvBQXgl9pTVAkYmzOA77yhI28bYVKOQcLaaDgOI+72
	Ch0aJvnQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOYp2-00000003mfw-02sD;
	Mon, 09 Jun 2025 09:29:40 +0000
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOYdg-00000003kTk-3M5U
	for linux-um@lists.infradead.org;
	Mon, 09 Jun 2025 09:17:57 +0000
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-ad89f9bb725so763016066b.2
        for <linux-um@lists.infradead.org>; Mon, 09 Jun 2025 02:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749460675; x=1750065475; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uqj0aPIdzN6xMFNiDXaeJsIfjkw0K8ThuC1zdxEa6VY=;
        b=B3/cwFrYj9ZkAmq8tryB+/7igvHLmXKHxLWW0sN9du3TXoudgiZg4xesThuYjr8oX6
         Xmv913fYNdGktD5dzSmJbBT2QX72oprElX/yr/1NN9/wEn8GZPlHvOLY9W3fyvvDdMPx
         AEhrG2++HqOYEZ21YaWHWcupDkOuek/hZa3Ppg55xrOJZDSYmFivl8ja8wQFyzIGoROL
         JqOC+dJVLEvtvfommx35M5QpcLuDP6ozviUvfE/Rhg58KXtJZdZUMazzFgr87on470iZ
         69RIY2BOFWAKxQPyMqey3boQ5B5J90SU7Yvxzp02JKJ75AN+f8bxbbnq/csufShzKBL2
         /Cuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749460675; x=1750065475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uqj0aPIdzN6xMFNiDXaeJsIfjkw0K8ThuC1zdxEa6VY=;
        b=g58LGR+v3P7Why90n8RrGvITABf0DkVttHMOaVvTGB/3PE/CxcH0Yr2Wdm9Kcus/XR
         jyCQBl4dtbT4PEJEDNw5OtwwIs+vlSY8ARdzutaaTLXjgmnflxRfLkcKRtRd04yyPJYJ
         IOGrrjpYXx9QlcTVw6+EbHu9h/zIJPI897eDtbCJF5mb5/VOzZkhil5tNYvvutDVWiak
         10sISMZKcnjMxa32Lj2lEIZCkgLbX12/pu7TL03VVLJmPy7hlj2MNixC4TAq6vJS+HY3
         FvqaVQe5VkMH0ACUigpAiVSOI7ycxjt9t6StgG9HGIbQF+yUwmba4vSJtD4Wn+l1AiYJ
         5N7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVaYvm0ReIT4plEww6Jl3VxBwaZjAbNu+stLOQTzp5o1c7wUfnk4J8kjuXpKl4C9o1b6nYKKKO7jA==@lists.infradead.org
X-Gm-Message-State: AOJu0YxuHAsvQNbnr+Z2LL26cd+ewpZzrydfZrxVkWhVjKELVcXVHcpd
	hvV38VTxhxTDaRV/bXIB1909yUTnyT6hLkerNCcwo7Ed6fCceWzfvDLlUehoaUaArmsg/OmmmSS
	XbsKjOKpyyBBqb9L3asY/cgtd/WQAke8=
X-Gm-Gg: ASbGncsHkF5sDiMoZVaH+OnbmYjkmKEoDCMJ41pgKvCfk/LwufoluaGML+0r63jMK1+
	oFSfLe776eOtHrC94KyMwdxN5FSrecoQ2Cxm4gY/kXuI4KCE9S13wbP/M268rTTGizHVrajGpjV
	tid7xfJ+HgbZQOx4IG+RN29eOJaJcooH9KGNe+P/F+pLKgtQ==
X-Google-Smtp-Source: AGHT+IFcDbm1pEyoQVRyQSJI7CysOBXgD61LuTLA2u4hamZSWoxpkj5S0Qg83rEiTGr3l9/GxyBxX8xUD8O9dE3G0kw=
X-Received: by 2002:a17:907:6d0c:b0:ad8:9b5d:2c19 with SMTP id
 a640c23a62f3a-ade1a8da660mr990978666b.9.1749460674447; Mon, 09 Jun 2025
 02:17:54 -0700 (PDT)
MIME-Version: 1.0
References: <20250112140736.1fcb25c3@crass-HP-ZBook-15-G2> <20250607042248.87877-1-linyongting@gmail.com>
 <6b4428e5ec42c926fcc9b6d2fdb9202fc6e87fe8.camel@sipsolutions.net>
In-Reply-To: <6b4428e5ec42c926fcc9b6d2fdb9202fc6e87fe8.camel@sipsolutions.net>
From: ivan lin <linyongting@gmail.com>
Date: Mon, 9 Jun 2025 17:17:43 +0800
X-Gm-Features: AX0GCFu4hmERn4ZED6P8IAE06SWESRc3o9OWE1jv48Gs0Z5Im3v-_X_jxHqqiVY
Message-ID: <CANWV4Vku31oEGpUpcuf3PLNqcMSOsAkXwVbM4cWHo95+GZrkkA@mail.gmail.com>
Subject: Re: [PATCH] um: fix execve stub execution on old host OSs
To: Benjamin Berg <benjamin@sipsolutions.net>
Cc: development@efficientek.com, linux-um@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250609_021756_836352_DBE89A01 
X-CRM114-Status: GOOD (  21.83  )
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

Hi,

On Mon, Jun 9, 2025 at 2:38=E2=80=AFAM Benjamin Berg <benjamin@sipsolutions=
.net> wrote:
>
> Hi,
>
> On Sat, 2025-06-07 at 12:22 +0800, Yonting Lin wrote:
> > [SNIP]
> >
> > Sorry for my due enquiry, I don't want take a new thread with a patch.
> > It is just a short question.
> >
> > Currently(119b1e61a769aa98e68599f44721661a4d8c55f3), there are three pi=
eces
> > of code calling to syscall __NR_close_range:
> >
> > # grep __NR_close_range -r arch/um/* -n
> > arch/um/kernel/skas/stub_exe.c:73:            res =3D stub_syscall3(__N=
R_close_range, 1, ~0U, 0);
> > arch/um/os-Linux/start_up.c:269:      if (stub_syscall3(__NR_close_rang=
e, 1, ~0U, 0))
> > arch/um/os-Linux/skas/process.c:331:  syscall(__NR_close_range, 0, ~0U,=
 CLOSE_RANGE_CLOEXEC);
> >
> > But my host kernel is 5.4 and fails to compile these pieces of codes be=
cause
> > there is no this syscall in my older kernel.
> >
> > I was wondering if you are working on this issue. If not, I will try to
> > make a draft solution to review.
>
> I was not yet aware of that problem. Most likely only the one in
> start_up.c is a problem for you. All the other ones probably pick up
> the correct definition from the Linux tree already.
>
> One can probably solve it by moving the code into another file. Or
> maybe by adding an entry for __NR_close_range into common-offests.h and
> using that.

Benjamin, thanks! I will try a solution and send it out for review.

Yongting
>
> Benjamin

