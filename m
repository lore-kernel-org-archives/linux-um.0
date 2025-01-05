Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 364FAE77197
	for <linux-um@archiver.kernel.org>; Sun,  5 Jan 2025 12:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9CZd9YA/vxsfF1o+1S6lXa7zVfnq9bHCryfS5okIqnQ=; b=HJA76HHkGxnuu52K/IVKUqnAQD
	sX4Kg5VNada4yYJoA4heqRkxgSy2M4lMxSpRLD/qdW9t5x6s+n/JQpKKZFqOa8EGe7obZkzCc7yNg
	8HhQnGR7n/XIWg3qOhoFG6gOxMnYj9PJZd5s9KZ7qKVzTCSWeybCWqRj7nGdIRjRiSUL/JnfqTqu8
	XHb5wvexW/a60Wu5J/HrR9WRc2sPWns5VAuVyoCAm72P7rblU2XWs9RwgUGiYl6vpYoxOvHILa3zv
	XVXMrSyOPUQ839UwbJgLuXLJwHxH2QFpBkyZQUM20lQH3UtkhvW+WijLxpjMwsTcgBlqOPHCBqU5o
	w2bi84Og==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tUQ7m-0000000GpkJ-1cJa;
	Sun, 05 Jan 2025 12:52:58 +0000
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tUQ7j-0000000GpjO-2bSk
	for linux-um@lists.infradead.org;
	Sun, 05 Jan 2025 12:52:56 +0000
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-21625b4f978so106585ad.0
        for <linux-um@lists.infradead.org>; Sun, 05 Jan 2025 04:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736081574; x=1736686374; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9CZd9YA/vxsfF1o+1S6lXa7zVfnq9bHCryfS5okIqnQ=;
        b=s5ey7stzsc4IF8dpFQ2Lj0F4Ya2NV/8t3WD8yDua/0ROh8rNwxWFmCKYpOMwjwSTF2
         5l2RCKRG5y7bYL/qqmxbmRMt/MoZD675wK/JFJkdL3vfbnlCGbj8CntgzdmHWudOihHF
         cYcVplYYQlDSw0f8XF8SWbtR/imwINKz5XYcif8mLBY5PDMneUUf6GLiqLHBlX2aWSDN
         VyNAI3Avh0fCvr2ZMXnY69APEHxREoaVmM4kF7cZBehI8EKGTpxOEGa2CrmP5EtRygKJ
         yDV2HhhbdR3w6N3p0VPCuHKAU4XHtapgNPo2IhcsGZAj26zsDMvg1YhTw02SHEXjuUJD
         13HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736081574; x=1736686374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9CZd9YA/vxsfF1o+1S6lXa7zVfnq9bHCryfS5okIqnQ=;
        b=DoxsNCm8vkcEqvz20Fo/Ffku87YRpTWNkYUpYnafyeQV7jdiQpqcJTApmbw6nmx8K7
         G6OGFOdtNeo5gQmvU0ckYL8DoKOwUQlfRAv/c4oWQL1TQnZAcdE7fakLmNVptrNlYrQT
         gF0ROk12p6B9OqXpszW3GjHmtK1txNo5f+o2rQCh+o7LkHhtk+0FE5qyFt6dU4ntpEVP
         VQXMGP02wd2YfFHp0pcWlWlSWfo8lWwTCWvZvXMi505ZuWIu8nR3yRRqP6D8fBwgu+Zl
         dMG7EKjYHjERamC53N55+4dNLlN5US0nb1ddkXODPC6kyKq7eM3Wj1Og/2FzS/FhaSo2
         +dLg==
X-Forwarded-Encrypted: i=1; AJvYcCVXtNu9LnyBOZ0Mlm653yIxaluQUyTan5GTXWvpJBtu9I//1F+/2EH1lmyOyNzhjRaJhScTj1/Kug==@lists.infradead.org
X-Gm-Message-State: AOJu0Yw3WlTRfiXY3chwaHr3SEWCxnzoeMw+TB92xqRRbVzFamO2HGeV
	7nu/2PzsagIqllLibX3C/olqlrmUoNXIkim1RIZzUpgtuigFXzZspN6fG46VsQ9Gw0D3CT/EZUv
	gxEPsZbQispSngsso9aKM11077x6Qo+0Izahk
X-Gm-Gg: ASbGncsytLGrFvOy/EUOVcRVinCx8HtCksDS72SkrZL7Pb/ClQlt2kCnxCAHGpFO625
	KtiSo+FS5enpextn53Ig7oP/r8MVpujOMM6+e
X-Google-Smtp-Source: AGHT+IEHA5ba+jpkkdNpDLtsolTeg8E9FnKLL/jtGaf6DdgcjgXXRiauZ5nf4OWT8s7tM+6ZsYXlno3RjzvbYUw9zeI=
X-Received: by 2002:a17:903:120d:b0:216:6dab:8042 with SMTP id
 d9443c01a7336-21a62b6ffb8mr1842805ad.12.1736081573755; Sun, 05 Jan 2025
 04:52:53 -0800 (PST)
MIME-Version: 1.0
References: <86eba318-464b-4b9b-a79e-64039b17be34@lucifer.local>
 <d48193a3-65fe-4aa9-98f6-dd5869bd9127@citrix.com> <9878d90f-faf3-4853-9a79-a21b4f58ab4c@suse.com>
 <Z3iX2mNtqSYrvYPT@bombadil.infradead.org>
In-Reply-To: <Z3iX2mNtqSYrvYPT@bombadil.infradead.org>
From: =?UTF-8?Q?Marek_Ma=C5=9Blanka?= <mmaslanka@google.com>
Date: Sun, 5 Jan 2025 13:52:27 +0100
Message-ID: <CAGcaFA2Htgu8w6S_Zuz2zn3FwpaetZRbY8n0CWEdh07YfMO==A@mail.gmail.com>
Subject: Re: [PATCH 6/8] modules: switch to execmem API for remapping as RW
 and restoring ROX
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>, 
	Adam Williamson <awilliam@redhat.com>, Andrew Cooper <andrew.cooper3@citrix.com>, 
	lorenzo.stoakes@oracle.com, akpm@linux-foundation.org, 
	anton.ivanov@cambridgegreys.com, bp@alien8.de, brendan.higgins@linux.dev, 
	da.gomez@samsung.com, danielt@kernel.org, dave.hansen@linux.intel.com, 
	davidgow@google.com, dianders@chromium.org, hpa@zytor.com, 
	jason.wessel@windriver.com, jikos@kernel.org, joe.lawrence@redhat.com, 
	johannes@sipsolutions.net, jpoimboe@kernel.org, 
	kgdb-bugreport@lists.sourceforge.net, kirill.shutemov@linux.intel.com, 
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-um@lists.infradead.org, live-patching@vger.kernel.org, luto@kernel.org, 
	mark.rutland@arm.com, mbenes@suse.cz, mhiramat@kernel.org, mingo@redhat.com, 
	peterz@infradead.org, petr.pavlu@suse.com, pmladek@suse.com, richard@nod.at, 
	rmoar@google.com, rostedt@goodmis.org, rppt@kernel.org, 
	samitolvanen@google.com, shuah@kernel.org, song@kernel.org, 
	tglx@linutronix.de, x86@kernel.org, 
	=?UTF-8?Q?Marek_Marczykowski=2DG=C3=B3recki?= <marmarek@invisiblethingslab.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250105_045255_682836_DBFB8C09 
X-CRM114-Status: GOOD (  14.98  )
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

On Sat, Jan 4, 2025 at 3:07=E2=80=AFAM Luis Chamberlain <mcgrof@kernel.org>=
 wrote:
>
> On Fri, Jan 03, 2025 at 07:58:13AM +0100, J=C3=BCrgen Gro=C3=9F wrote:
> > On 03.01.25 03:06, Andrew Cooper wrote:
> > > > Hi Mike,
> > > >
> > > > This commit is making my intel box not boot in mm-unstable :>) I bi=
sected it to
> > > > this commit.
> > >
> > > For what it's worth, we've found the same under Xen too.
> > >
> > > There's one concrete bug in the series, failing to cope with the abse=
nce
> > > of superpages (fix in
> > > https://lore.kernel.org/xen-devel/6bb03333-74ca-4c2c-85a8-72549b85a5b=
4@suse.com/
> > > but not formally posted yet AFAICT).
> >
> > Now sent out:
> >
> > https://lore.kernel.org/lkml/20250103065631.26459-1-jgross@suse.com/T/#=
u
>
> Thanks,
>
> Marek, Adam, can you try this patch? Although the reply here is for
> another future series being worked on the fix is for commit
> 2e45474ab14f ("execmem: add support for cache of large ROX pages").
>
>   Luis

Hi Luis,

I suppose you're referring to the issue described here
https://lore.kernel.org/linux-mm/CAGcaFA2hdThQV6mjD_1_U+GNHThv84+MQvMWLgEuX=
+LVbAyDxg@mail.gmail.com/T/
Unfortnuetly this patch didn't help.

Best,
Marek

