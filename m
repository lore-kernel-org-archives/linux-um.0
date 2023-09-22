Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2BC0CD4F27
	for <linux-um@archiver.kernel.org>; Fri, 22 Sep 2023 07:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wujLnuGGOV+hr/FYQcU3ubS3yJgj0aQkOg7pSYBvyLo=; b=QTkkc2gyGvIKyI
	D0Ebpt+JXZ9p0998Aqg27jI6gUmh+rGljdorQtMiQ0RSG4U6/RMUWCJk5LA5QXgDnpxR8BPnygt/7
	DbaGGgK4n7GCVOTtTf/9qj8FheJGMdCLnmkSWeE/O3A1JhAyFBRPlyb+zQYLKAAK/rnWDL+NnEezs
	lmD5dCkccH9WgWu8XEgRhsWno99B4hpFMIO7AttUVJR4/zbpGzVXDdTX8EJlEpQ3r11NDDBpokzXK
	hAfqWQLWDOfR7AzNetPu+bijK3kGqX8tJU4mcQajfoj/j5kU5C4oWKUlU2NYXG+sGV50Pg5b9hp6b
	q2WrOWf8X2+Xy5hQxzLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qjamZ-008DuY-2H;
	Fri, 22 Sep 2023 07:40:59 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qjamW-008Dtd-1d
	for linux-um@lists.infradead.org;
	Fri, 22 Sep 2023 07:40:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=97AG6plwjbYaEhkLqaFMdfr/BHNUH5wUgH7ftHRicsk=;
	t=1695368456; x=1696578056; b=WwdAF3UZMB++Zr5REcYoMrwQslBLr3n8NwVjwCkiLzmcAr6
	CO89XtxbGtXr+fHgFSycz4TmX8ZzItsgVUMDwAmgVRyjARNp/dU3yeIkhnFVgJdWB7wXOD3bbN6YA
	dKKJczGdms3nFzBSrnH8PxlRD4H1kWKJ0G01RmjDN2vBfD1mM2oZk8cbPrGOwOBOswa/REKHTzrJ4
	RdQqqqlZM58dWZqpdGGms553BGgxrqslOBmVvvc7QK8NH9j58DbOqQs9pbl0aARfpdLFQChwuh2jw
	3b2EJkwGCo+sVdY6DzXm3+u+VTqPG9E1aUohqwJF2/L9Ljsb4PJcnEiq/9dXYP5w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <johannes@sipsolutions.net>)
	id 1qjamU-00Ezla-01;
	Fri, 22 Sep 2023 09:40:54 +0200
Message-ID: <2de07f54b33dc060b75d982d4d8189f12e0d4c45.camel@sipsolutions.net>
Subject: Re: [PATCH v5] um: Enable preemption in UML
From: Johannes Berg <johannes@sipsolutions.net>
To: Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	linux-um@lists.infradead.org
Cc: richard@nod.at
Date: Fri, 22 Sep 2023 09:40:53 +0200
In-Reply-To: <fa4069f1-e026-7672-4f71-9319cdd683a2@cambridgegreys.com>
References: <20230922065212.484385-1-anton.ivanov@cambridgegreys.com>
	 <fae1103161cf8c7bac8a138b267d2288ebb32a08.camel@sipsolutions.net>
	 <fa4069f1-e026-7672-4f71-9319cdd683a2@cambridgegreys.com>
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230922_004056_541643_6709E74C 
X-CRM114-Status: GOOD (  16.14  )
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

On Fri, 2023-09-22 at 08:38 +0100, Anton Ivanov wrote:
> > 
> > I had enabled CONFIG_DEBUG_ATOMIC_SLEEP because that's actually
> > something I'd really like to have in our testing.
> > 
> > But with that issue I don't even know how we get there really. It
> > doesn't even happen every time we fork?
> > 
> > I'll dig a little bit, but did you try enabling
> > CONFIG_DEBUG_ATOMIC_SLEEP also?
> 
> Will do. I have no crashes over here so I need to trigger this one first.
> 
> Though, frankly, if it is a race in a tlb flush it may be subject to local conditions. So it will be difficult to reproduce.
> 

Yes, it might be a race in the fork handler maybe? IOW, whenever we
actually do fork, it depends on what conditions the rest is in? I'm not
sure I fully figured out right now how the fork handler is doing all
this, but I sent my mail before I could since you were discussing :)

But it shouldn't be impossible - while I don't see it for every fork, it
does happen 8 or 9 times in a very simple test that just boots, pings a
bit, and then shuts down, so ...

johannes

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
