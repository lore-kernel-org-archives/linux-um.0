Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DC73C531C7
	for <linux-um@archiver.kernel.org>; Thu, 23 Jul 2026 07:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=J6FdlpU/cU1raG9v1u+8LCRFO3SVTila/2vWVU1uiPo=; b=We8dLqIBFM181hm9WOjZIHhwey
	XmQOGiAd8or4WzE0AGeOOqoCdeixLEdi2z9UPjLpO3+O3R7oHIs/cIVx4dG5vNJcYWEMsHNtME5/b
	l5dOpbUhYzh15AJRvPyWdbuuHQ+iysRJuvQkF/svxMhqj41PRHOtdkZU4a5r16JoCuuo1GnmaNe8o
	e0v58nqvCT/O8VWnkXO50ZsYPAhv5s6Tc1YWX4N5Ek2D+yUJfjaga1pPUoHM+KT5czaFeB6VLDFIH
	hReX8E3ZGPz/V/KL8bRBCxiagtNOQtNmR9YTP5xHYmACRiECefI86IwIetTvMxxug7q2Kvwus5VOB
	OxbtnRYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmoIJ-0000000DgRU-3TIh;
	Thu, 23 Jul 2026 07:56:39 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmoIG-0000000DgQZ-1tyh
	for linux-um@lists.infradead.org;
	Thu, 23 Jul 2026 07:56:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=J6FdlpU/cU1raG9v1u+8LCRFO3SVTila/2vWVU1uiPo=;
	t=1784793396; x=1786002996; b=xqEyRdoxJMk56KT4LFjc4rrKO4w7uoU8oS1HOq1E4oIT+Z9
	JA0bXLrxAFN3NUnSS26I3O+skFG/KCClhsW62IiVnDuy3PyqClOxyeGJ9q3y+ovXVf7RL07w4V6aH
	OILOVjcO94WU5QSl+e6Mn1diKoCXH1VVAIYHGeLDsX0Qz7/vaElD3yd1X24DVOhA+GxFLiDIQvFIe
	YiJCWnFdNgltrnH1gWTZwzUDH3njbToSza1v9/GWwlWwimYKqMrAHX1/EeBMrtnIs6pFjUtgchzFM
	jG0hwsy1dKPnd3dWAF5+R8Df89gqTFU465AxLGRLdgvyyMh7MDRBmpD0Wgkd2tGw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wmoI9-0000000AEYc-3pY9;
	Thu, 23 Jul 2026 09:56:30 +0200
Message-ID: <d53e890b8d164a61251d5639273f38d7ba05c3b9.camel@sipsolutions.net>
Subject: Re: [RFC PATCH 8/9] um: nommu: add userspace runner processes
From: Johannes Berg <johannes@sipsolutions.net>
To: Hajime Tazaki <thehajime@gmail.com>
Cc: linux-um@lists.infradead.org
Date: Thu, 23 Jul 2026 09:56:29 +0200
In-Reply-To: <m25x26z501.wl-thehajime@gmail.com> (sfid-20260723_064750_269959_6A611F61)
References: <20260720185103.530603-11-johannes@sipsolutions.net>
		<20260720205103.5a666eac428b.I9f810f3ed177d6dc980cad36c231f8c745dee48f@changeid>
		<m27bmn4xqv.wl-thehajime@gmail.com>
		<f749582f2e2fe9219a854b8645c58df3f6b9ebf7.camel@sipsolutions.net>
	 <m25x26z501.wl-thehajime@gmail.com> (sfid-20260723_064750_269959_6A611F61)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260723_005636_772790_CC212E25 
X-CRM114-Status: GOOD (  33.81  )
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

On Thu, 2026-07-23 at 13:47 +0900, Hajime Tazaki wrote:
> As you see, nommu doesn't mean it cannot have protection (or
> isolation) features (e.g., with some CPU extension etc). that's why I
> said it doesn't have to be (if it is documented).

Yeah, fair, I admit I'm conflating a bit. But even for the real hardware
MPU case, it's not really protecting all of the kernel from userspace,
the MPU protections apply equally to anything the CPU runs.

I'm not aware of any general MMU-less cores that have sort of "privilege
levels", and I couldn't find anything like that in the Linux code
either.

So of course we could build it, it's just software, and it might (though
perhaps not highly likely) even be useful to someone for debugging. I
certainly didn't want to include such highly speculative features in the
code now though.

> >=20
> > It's still the case, in the runner startup I mapped the whole thing int=
o
> > the runner process(es):
> >=20
> > + map(&r->mm_id, uml_reserved, high_physmem - uml_reserved,
> > + UM_PROT_READ | UM_PROT_WRITE | UM_PROT_EXEC, fd, offset);
> >=20
> > > a program accessing kernel address may fail (or crash in some case),
> > > but with the runner it won't ?
> >=20
> > It still will, I believe, since it is mapped into the same address
> > space.
>=20
> I thought the kernel address is invisible/inaccessible, or isolated
> (somehow) from the userspace code.
>=20
> let me check more and get you back here if I have any questions.

Sure.

Actually though what I said before isn't quite right - uml_reserved is
at the end of the UML image binary, so that the actual binary itself
already is not accessible to userspace. All other kernel structures etc.
are though.

Speculating - maybe with some tricks we could get the image binary into
the physmem file, but it doesn't really matter.

It does mean, however, that my concern about the kernel intentionally
sharing some kernel address with userspace in NOMMU was unfounded at
least as far as the testing I did is concerned.

> > I also just realized I didn't really respond fully to your question
> > about what I want to do with this ... so if you're happy with this set
> > and I can hopefully get some of the others to review it, then I think
> > I'll send it as real [PATCH] and we can merge it, and go from there. I
> > also had some docs (based on yours) that I didn't include here, but tha=
t
> > I should include then.
>=20
> thanks, it works for me as well.
> Please Cc Lorenzo and Liam as well to the patch (as I have requested
> from them).

Ack. I'll try to send it out later today.

> > And then we can see - maybe we want to rename "skas" (after you pointed
> > out what that really means), maybe we want to more generally clean up o=
r
> > separate out the code a bit?
>=20
> for the rename, well, Im not sure.

Right, you mentioned elsewhere.

> for the clean up, I agree and wish to help this.

I think I'd really like to pull this code out of the last millennium,
but it's going to be tricky to clean up with other things going on, so I
guess small steps eventually ... we'll see. First things (like this
series) first :)

johannes

