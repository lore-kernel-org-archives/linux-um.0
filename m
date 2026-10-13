Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C41FDCC6B03
	for <linux-um@archiver.kernel.org>; Tue, 13 Oct 2026 12:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ooKLa1R3KGvywNv1R+3CFpG+InkWtGBVvbQRUtpRSf4=; b=Fkt7u6GTa+tLx//pNJmtFPECDx
	F45c+DNuFKtJMkoqNUME41w336X/sD/cnTgM3MOQaNVdHlLeQQRoO2Yy+yojfAkrAUyhYX7FRzKwt
	KEVK0qy/M9OekH6msrWlzkuZ7DGE0nNBoFWhbH05hA0dqU6sRkRNgtQyXhQjEYFcUFdOQAGrRRsl+
	cJTz4sh4MGBXqFee1+YUuoF7xjPApmjhSwVv9YbyopeStkRhgoDAoUJYYdDScJfzLDEmqUwaQvV5q
	qyc1PVZp9jugnGLiX1dOHb1AHvp0I7QkdQE9Md4AGHl+U4n7TK2NbjD0Q7BqvCeLQ/aU6hrXVCP18
	CKLcKATA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGbjl-0000000Cpje-3zNY;
	Tue, 13 Oct 2026 12:36:09 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGbjh-0000000Cpiq-2HnX
	for linux-um@lists.infradead.org;
	Tue, 13 Oct 2026 12:36:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791894963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ooKLa1R3KGvywNv1R+3CFpG+InkWtGBVvbQRUtpRSf4=;
	b=HEzqavGDVm27rpHXWPwhy/SncpPuXeG2heUDAh+82wPoVFN4EOHMPspodITW890lZv9RK/
	bK359dt+dUCsO7TQkf/IYO16RpEOb7bTivPq9DaXBrStYQcQHFNM8//ryCg2d9HsL43XTm
	iIHcvaV66rA15qIKn8AwEHHqY55PlJU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-8-ZkhB086iOwi4D2HzKt_7pw-1; Tue, 13 Oct 2026 12:36:01 +0000
X-MC-Unique: ZkhB086iOwi4D2HzKt_7pw-1
X-Mimecast-MFC-AGG-ID: ZkhB086iOwi4D2HzKt_7pw_1791894960
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c2942fa0995so304913266b.1
        for <linux-um@lists.infradead.org>; Tue, 13 Oct 2026 05:36:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791894960; x=1792499760;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ooKLa1R3KGvywNv1R+3CFpG+InkWtGBVvbQRUtpRSf4=;
        b=MaNjnCcfdasZuNdC0f2o0w8bauAgjPG/KVM4uIdLohyjUnWxG7p4TamjCpNJBlTFFh
         /w0ZeWlwHLdugpn7U+AWSADknfdOA+/vU0eUvwYl3q0ErNBSn6aDWVH0IbMmTQkOrhr2
         nhsBKQawhLtyuhVz9qnAlkBHRW4o1VR/HhZITOLD+aeByEr818ffyFhKYM+wYf1ls5nn
         xUZOzpTjhQLP3vmLj2UxlIL2rwpyHb5bRY3OTNClmlQr+McRGbHurZ1mq4FZ93E7hiiC
         XdSYecBJ+ndYMtT7tdzF4TBxTzylXSnU/8IcnlKwGPsE+YyrjGespWN7zPFqhwuUh6yt
         Qn0g==
X-Forwarded-Encrypted: i=1; AKwUvByo4C3sh13KVDynlm2HRiX9izIMu2zyZC2uYdblc3/WCAlX00Ee7yWrjNlYqtXaYntG8p8OgvGtQQ==@lists.infradead.org
X-Gm-Message-State: AFq9FYL67niWSk0sDSzvuQO+mhElmH+Ni1zjxgJQNJULe+fJhykoCXYP
	yeXEQUW8NhZiiAx/ytY0Y5M3Pufn5tSgz8LAZ70h8XGC3N8xkgVqF/bsiP+ia9y+rQ2nVVkWG99
	6KVZHGDl07HpVmvkbII4QBLFie9TfesSvBkK1e8QWv9YAJ0Q7hPe5SDboYg9LC+ShwbEOFKMo7g
	p0a0lo/esFCbA+g11MaT64m1C5Ux/O+RbdNDEAsVTF
X-Gm-Gg: AYBFou0hlP8QKWxjmyC/jZwv1pgslcVrJX6cHUiF6I9exIn039E9tMi2eNq/2amknih
	wGEOesPujw0RSMYnT7jzu8AmisGUXjpNPwgj0o/h1nnmz+3K96/yOOGMEqaLILWfCgmqaaYL7Zv
	aE0aMaGCLOYfvX0X/5GEbiCT9lwq8lBSnC03yfvFQG1p0fcr6vvOsbCtGC3xgSZYR0v/lzxEFkB
	xXhDPvsn4ClhU429ILKkxEzobxHiPZegQC/xhvhnxjSff2DxYApoYWsRN0KjHEzZ3VEVPSpnY6Q
	ths=
X-Received: by 2002:a17:907:7b8a:b0:c2e:1b4d:e9e9 with SMTP id a640c23a62f3a-c31a9f6ade4mr1135544866b.30.1791894960267;
        Tue, 13 Oct 2026 05:36:00 -0700 (PDT)
X-Received: by 2002:a17:907:7b8a:b0:c2e:1b4d:e9e9 with SMTP id
 a640c23a62f3a-c31a9f6ade4mr1135542366b.30.1791894959880; Tue, 13 Oct 2026
 05:35:59 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1790088067.git.rrobaina@redhat.com> <CAHC9VhQ=FFYVNmQdiMsqg+5KDDrSC3SZS+H2=r_GkhfwQox8tg@mail.gmail.com>
In-Reply-To: <CAHC9VhQ=FFYVNmQdiMsqg+5KDDrSC3SZS+H2=r_GkhfwQox8tg@mail.gmail.com>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Tue, 13 Oct 2026 09:35:48 -0300
X-Gm-Features: AclHuK-0QABZ6yrPwALI3VDGc1f2HfQWIB06SZ96BvTfEuUJkskwg4GU5NbIk1c
Message-ID: <CAABTaaBL=TScs8Qqu3b8F6KZPGMyvwy6cBC3teDaBL6MGMucNg@mail.gmail.com>
Subject: Re: [PATCH v3 00/14] audit: log all six syscall arguments in the
 SYSCALL record
To: Paul Moore <paul@paul-moore.com>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, bpf@vger.kernel.org, eparis@redhat.com, 
	sgrubb@redhat.com, oleg@redhat.com, richard.henderson@linaro.org, 
	mattst88@gmail.com, linmag7@gmail.com, linux@armlinux.org.uk, 
	catalin.marinas@arm.com, will@kernel.org, guoren@kernel.org, monstr@monstr.eu, 
	tsbogend@alpha.franken.de, jonas@southpole.se, 
	stefan.kristiansson@saunalahti.fi, shorne@gmail.com, 
	James.Bottomley@hansenpartnership.com, deller@gmx.de, 
	ysato@users.sourceforge.jp, dalias@libc.org, glaubitz@physik.fu-berlin.de, 
	davem@davemloft.net, andreas@gaisler.com, richard@nod.at, 
	anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net, chris@zankel.net, 
	jcmvbkbc@gmail.com, tglx@kernel.org, peterz@infradead.org, luto@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fV7WCntCDQMA5ziQEHmop3lQxIg4QhcSX7xnmKDEvJs_1791894960
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261013_053605_655891_071C5D90 
X-CRM114-Status: GOOD (  30.97  )
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

On Thu, Oct 1, 2026 at 6:06=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
>
> On Tue, Sep 22, 2026 at 3:21=E2=80=AFPM Ricardo Robaina <rrobaina@redhat.=
com> wrote:
> >
> > The SYSCALL record currently logs only four of the six syscall
> > arguments (a0-a3), silently discarding the remaining two. This
> > leads to the need for auxiliary records when audit-relevant
> > data lands in the 5th or 6th argument of a syscall.
> >
> > This series extends the SYSCALL record to log all six arguments,
> > by adding arguments a4 and a5 inline within the existing record.
>
> Thanks Ricardo, this looks great!

Thanks, Paul!

>
> There are a few things in some of the individual patches which I reply
> to in a minute, but there are a couple of "global" things that I
> wanted to mention:
>
> * As pointed out by Sashiko, when you were converting all of the
> arches, it looks like you missed alpha.  I took a quick look and it
> appears that it should be a pretty straightforward conversion like
> most of the others.

I've actually dropped the alpha patch as per Magnus's request [1].

[1] https://lore.kernel.org/audit/CA+=3DFv5T4826T2sd0Gbh-nfZsqcWK_phdBKy4BL=
WOvDTt92t5Eg@mail.gmail.com/

>
> * We need to get ACKs from all the various arch maintainers.  Aside
> from the parisc changes all of your arch specific patches are trivial
> (and cleaner than the existing code IMO) so I don't expect anyone to
> complain, but getting ACKs will likely take some time.  Even the
> parisc patches aren't that bad, and arguably they fix a problem for
> seccomp so that should make asking for ACKs easier :)
>
> Since I expect chasing down all the various maintainers for ACKs will
> take a little while, and I'd like to start getting this patchset some
> basic testing, I'm going to merge it into dev-staging now.  While the
> dev-staging branch doesn't feed into linux-next (this isn't likely to
> land in the next merge window) it is one of the branches that gets
> tested automatically and included in my kernel-secnext RPM builds.
> This also means you won't need to worry about keeping this patchset
> up-to-date with rebasing, as I rebase dev-staging as needed (it
> intentionally isn't a stable branch).  Going forward, if there are any
> minor changes to this patchset, e.g. a few line change in one of two
> patches, please just send a fixup patchset based against
> audit/dev-staging and I'll squash it into the relevant patch in the
> series.  However, in the unlikely event that a major rewrite is
> needed, just send a new patchset ... but I'll be very surprised if
> that happens here :)

Sounds good!

>
> --
> paul-moore.com
>

-Ricardo


