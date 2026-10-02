Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0262CCA5FD6
	for <linux-um@archiver.kernel.org>; Fri,  2 Oct 2026 11:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=20l5MGKYIkk3dxTQvp40s490//vZekkNtR3rks2T+EI=; b=TRZAzz4umoxamSkphjmZwfWDbG
	gMQQtoepGnnXWYCrvFzxFEsbiEhxixVJYFiKynEhEFDKBt9G2JRD42nihPA8I/ndBTVbtzeXdq6/i
	hUCdIJUDFyMYmFJ9U7iJ2J8N4xrk2ZfZkcNXKB52GxG+L2m0nyM6AiK+IZCeZRmWz6hsGEKY3hkl0
	tZ8J90LvZOPdqWJcRwVwLR9LDXotJ+hSY4bmd/vNUPhUMZZWsA1dUB4mxCNBR5rfk2VE3cz+9eNJ7
	o4gKiXpceTdQerqIb79cKqMI1n3r3DSvFE4gwpcQpSYPtmuTsOvPP1iiuNUfpsG1UgIa3us00kliG
	zWrvmA+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xCbbG-0000000BUx6-0RSA;
	Fri, 02 Oct 2026 11:38:50 +0000
Received: from mail-vs2-f38.google.com ([74.125.227.38])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xCbbC-0000000BUvt-36Je
	for linux-um@lists.infradead.org;
	Fri, 02 Oct 2026 11:38:48 +0000
Received: by mail-vs2-f38.google.com with SMTP id 71dfb90a1353d-5da475a08ceso301510e0c.2
        for <linux-um@lists.infradead.org>; Fri, 02 Oct 2026 04:38:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790941125; x=1791545925;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=20l5MGKYIkk3dxTQvp40s490//vZekkNtR3rks2T+EI=;
        b=LREp3tDmc5RaJrBmWK9UZ24/91y80wlp1EeE5mGIPe0qJY280WAWvZ7h9KNGT+MzcX
         Pg9fWbbhWUzCMrJZ9pFgw9o87JvF1kJQLfbtcYeKR4uZ2LCshQqdjF7xoWThc9EW9lql
         jjm7Fff0jBOC7M8B867pQmu191S5GfujXnEMG2rNv0DGrYReHEN7CJA68r2HfO44SU7c
         sBpqzh1Dl17o1oAmFKvPJyBcL8d01U8xZSxRMQBv3sVKuNMaVQVlodV9pO6/ZI9NEKHH
         ZgICuVz3tDZqibSM827j7OtZJBnfEEI8dbdmockWcqeTfEZvUkgPreT5SZaVnTPq5Hl2
         kang==
X-Forwarded-Encrypted: i=1; AKwUvBz9AsJGcClxfjCXjAsApMMVc81Piic4FaSY3O0QKH3zNagBuo/L52U5BBaS82Osm0bGrJA/BS4N1w==@lists.infradead.org
X-Gm-Message-State: AFq9FYJ9xAq9KIaZTIcbGV5tQ+ccYVFpwkDTxb3MdFyozTQbjv6hF8Lc
	Poc8QXGdwLsMK7fQ40deV1ARPrLHTJiH2IL4WwJZrNxBBgIhQYS+p/ca8jPc1Twd
X-Gm-Gg: AYBFou2xBU5vXm69rzxYrRpQASmHsN/7f9b7doltkgDDQvVQOjRA8ppDxBS3R8mK5zi
	T8aQHNTtH3LWOUyV9OAok6jzAcbbSSNcl/y596ednrwgHNnAHFeYUegGr8VDGVyVNEQKmoRCl18
	reZ204ILYQyEBpmD1ERRzICSf8cUWwxGOOPimXt3VMN4TbtDAVDM6yRyaUr1fNZQfH23a9qkaDu
	2P6PtilQX5mTSsY09vP7693SljmA+fP2uafjJC4pwYlATMLYIMjFTnFYZxtQlyIZ9iotDPwP2tU
	5Aqti/Xjp5Ds7nkW8vOtLXyEzUkbOInmHpJaINQ/xggu4DrQl6Dup+EVzq3iX5iDy2IzmxKXOJr
	0LYLI80S3v8/T4RyH0P6J6fmfOf34XIcssI0wTc8Gm0cQdO03AxUKnSvZumqT+NWyK1DDR7MI8S
	MrwrPk9o8oUWGu9hEIkHK/tOq1q04mZhEImXmJ9CQErL7JRbSMC/QFL+X8hOte8nB6e6fBw4Z7a
	t5GEF/nnYYytO92xsAoeXh179Jq8MsPXXz33g==
X-Received: by 2002:a05:6122:488f:b0:5cf:1e68:6015 with SMTP id 71dfb90a1353d-5dab157adb2mr765109e0c.15.1790941124996;
        Fri, 02 Oct 2026 04:38:44 -0700 (PDT)
Received: from mail-ua2-f12.google.com (mail-ua2-f12.google.com. [74.125.226.204])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5da61f8fedesm3053260e0c.9.2026.10.02.04.38.44
        for <linux-um@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2026 04:38:44 -0700 (PDT)
Received: by mail-ua2-f12.google.com with SMTP id a1e0cc1a2514c-97e7c796e3aso1845468241.1
        for <linux-um@lists.infradead.org>; Fri, 02 Oct 2026 04:38:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwuoYXiu+EXR94AY4aWQIDUch5mX1UKQccudptwMQQCgKqkewB217B6w5zChWGWMtXjWrWjVV2zlQ==@lists.infradead.org
X-Received: by 2002:a05:6102:14aa:b0:7bd:b263:14c8 with SMTP id
 ada2fe7eead31-7c0f60ae056mr564893137.30.1790941124266; Fri, 02 Oct 2026
 04:38:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260929235711.2287931-1-thehajime@gmail.com> <20260929235711.2287931-2-thehajime@gmail.com>
 <bda5eeaa-7868-4d4a-9026-9e99347afd7c@kernel.org> <ar4br2vW7yZGd3gt@gremlin>
 <94759bed23f00d2044005e36be6f72f297e092f0.camel@sipsolutions.net>
 <m2se2o3jyc.wl-thehajime@gmail.com> <a65f4431-d225-4535-b921-00319ceeb2a2@kernel.org>
 <ar9ldn036SgT-bq1@gremlin>
In-Reply-To: <ar9ldn036SgT-bq1@gremlin>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 2 Oct 2026 13:38:31 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUKcUxHZKhTEF1gwWrU1o8O6jt6N3r90V5hynrLFdwY0A@mail.gmail.com>
X-Gm-Features: AclHuK8oY5W9edeNeZu9OdjhmLKHIkhJXkjnhYM2yOIrkiFEQlBpS9n1EzHgsaE
Message-ID: <CAMuHMdUKcUxHZKhTEF1gwWrU1o8O6jt6N3r90V5hynrLFdwY0A@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] selftests: run tests on nommu architecture
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, Hajime Tazaki <thehajime@gmail.com>, johannes@sipsolutions.net, 
	linux-mm@kvack.org, liam@infradead.org, rbm@suse.com, 
	akpm@linux-foundation.org, luto@amacapital.net, brendan.jackman@linux.dev, 
	liuhangbin@gmail.com, corbet@lwn.net, kees@kernel.org, broonie@kernel.org, 
	mhocko@suse.com, rppt@kernel.org, shuah@kernel.org, surenb@google.com, 
	vbabka@kernel.org, wad@chromium.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-um@lists.infradead.org, 
	daniel@thingy.jp
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261002_043846_785751_8234870E 
X-CRM114-Status: GOOD (  34.49  )
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

Hi Lorenzo,

On Fri, 2 Oct 2026 at 10:10, Lorenzo Stoakes (ARM) <ljs@kernel.org> wrote:
> On Fri, Oct 02, 2026 at 08:08:44AM +0200, David Hildenbrand (Arm) wrote:
> > On 10/2/26 04:38, Hajime Tazaki wrote:
> > > On Thu, 01 Oct 2026 19:01:45 +0900,
> > > Johannes Berg wrote:
> > >>>
> > >>> I thought maybe uname could help but our LLM overlords tell me no.
> > >>
> > >> Hajime originally wanted uname to indicate it, but that caused
> > >> regressions elsewhere, so we dropped that commit. I guess we could put
> > >> _something_ back?
> > >
> > > systemd uses uname information and our (old) patch changing the format
> > > triggered the regression.  thus, we dropped it.
> > >
> > >>> It pointed at something though.
> > >>>
> > >>> In fs/proc/meminfo.c:
> > >>>
> > >>> #ifndef CONFIG_MMU
> > >>>   show_val_kb(m, "MmapCopy:       ",
> > >>>               (unsigned long)atomic_long_read(&mmap_pages_allocated));
> > >>> #endif
> > >>>
> > >>> So MmapCopy in /proc/meminfo tells us definitively, weirdly enough.
> > >>
> > >> Hyrum's law and all that, but I guess it's not highly likely to (want
> > >> to) change :)
> > >
> > > a runtime detection is nice.
> > >
> > > scanning /proc/meminfo might be useful. although it requires to mount
> > > procfs (we can actually skip procfs mount as it is optional) so, this
> > > is not 100% portable.
> > >
> > > checking ENOSYS like syscall(SYS_mprotect) might be useful but I
> > > wasn't sure if this is always the case of NOMMU or not.
> > >
> >
> > I assume there are plenty of other mechanisms. Like testing if fork isn't allowed.
>
> Yup that's an obvious candidate!
>
> You actually need to check for both -EINVAL and -ENOSYS since, of course, we are
> inconsistent with this.
>
> Some nommu arches specify __ARCH_WANT_SYS_FORK unconditionally for both
> mmu/nommu variants meaning you get -EINVAL in that case:
>
> https://elixir.bootlin.com/linux/v7.2.8/source/kernel/fork.c#L2830
>
> Otherwise you get -ENOSYS because it's not defined.
>
> But fork() -> -EINVAL or -ENOSYS = nommu, then just have the child quit and
> etc. should do it.

fork() is not strictly an MMU-feature (you can implement fork on nommu
if all memory accesses are done relative to a base address register),
while I think mprotect() is an MMU-feature. Unless it can also be used
to change the protection using the one or two BARs most MCU haves?
Anything else that is a real MMU-feature? Non-identity mmap()?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

