Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6703CD1039A
	for <linux-um@archiver.kernel.org>; Fri, 25 Oct 2024 15:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JYrZXhwmtDcf9qMhZqaxZ9uI/0pW3qOQNP+2Ezkgw00=; b=nWgmEMpMWuibpRUu2P/MfIarvg
	1lkgdBeYR/sIJlgB9YGFHko3NvZ6b350xkKci8BTS6jAdinLU94uEH5+S4lpP8ebbroJsxGo/MeFv
	x5gZUb1XrViJEjOTEkq5mQc1eTf+2d19AdzwKCBuCSQJ7QRZ+XU5UR2muOfqP0M0GsDJSIbha8k++
	rAQqAJDNqSpnGWNqWpiF9Wzz8kIrC2CM76cuMsy0t5qtTBALVSGP//R2vxIDuV/0pVfoaUivvUKpt
	cvt68HKr6BNbXiLsPTnZ7EFh/Ryw8TY4kBvvnQCGb4lpl60nV4SicPPIWI6UlhM4xHlaoWSPjke3Y
	LMsQJtBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t4MLi-00000004Gg7-2tDj;
	Fri, 25 Oct 2024 15:35:38 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t4M7R-00000004DmX-0Gmj
	for linux-um@lists.infradead.org;
	Fri, 25 Oct 2024 15:20:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=JYrZXhwmtDcf9qMhZqaxZ9uI/0pW3qOQNP+2Ezkgw00=;
	t=1729869652; x=1731079252; b=xuKlW8z/qDe+t7DW8wG/h/4WVowMIjpwAeM9Wgi2Sh0qYKR
	2BfvF3q0Sp6eSqm6/5DNOCqbr+wFHWO6Xk6PjoySTDlmVbH1h4MQZ0nLl/5pjDIN1H5OoS3M3bEcv
	Qim3emJjHXwrYqOg7wunGDLdJx8JMV0ST6V804XOgGeKFhyga8TeO6HmD3Ilh5vF2LfNYBlaxxrrz
	2W9cgBJ3qFvQFpXPsb/2jc2EMU4IpVndnJ6UWW4emwKVX/D/41NUu5xH9yqpBUW5sdIS4lKp4Zxra
	RBEnTrrZoYPnQoIBvbB0YElwqUuNElTid+tnY5UqgSM7uEeAq+MMRnmhME+YBOGg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1t4M7O-00000004aiG-1LR2;
	Fri, 25 Oct 2024 17:20:50 +0200
Message-ID: <6769bac56b1d20233dae036aba2067da3eaf7779.camel@sipsolutions.net>
Subject: Re: [RFC PATCH 05/13] x86/um: nommu: syscall translation by zpoline
From: Johannes Berg <johannes@sipsolutions.net>
To: Hajime Tazaki <thehajime@gmail.com>
Cc: linux-um@lists.infradead.org, jdike@addtoit.com, richard@nod.at, 
	anton.ivanov@cambridgegreys.com, ricarkol@google.com
Date: Fri, 25 Oct 2024 17:20:49 +0200
In-Reply-To: <m2r084nxu6.wl-thehajime@gmail.com>
References: <cover.1729770373.git.thehajime@gmail.com>
	 <2f3537884533232ab2ef2937e392d32736527bdc.1729770373.git.thehajime@gmail.com>
	 <75c9b237111431362458ced4c5213b74ca8fcb13.camel@sipsolutions.net>
	 <m2r084nxu6.wl-thehajime@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241025_082053_168368_48E39CF5 
X-CRM114-Status: GOOD (  19.07  )
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

On Fri, 2024-10-25 at 21:58 +0900, Hajime Tazaki wrote:
>=20
> > > +	if (down_write_killable(&mm->mmap_lock)) {
> > > +		err =3D -EINTR;
> > > +		return err;
> >=20
> > ?
>=20
> the lock isn't needed actually so, will remove it.

Oh, I was just looking at the weird handling of the err variable :)

> > What happens if the binary JITs some code and you don't find it? I don'=
t
> > remember from your talk - there you seemed to say this was fine just
> > slow, but that was zpoline in a different context (container)?
>=20
> instructions loaded after execve family (like JIT generated code,
> loaded with dlopen, etc) isn't going to be translated.  we can
> translated it by tweaking the userspace loader (ld.so w/ LD_PRELOAD)
> or hook mprotect(2) syscall before executing JIT generated code.
> generic description is written in the document ([12/13]).

Guess I should've read that, sorry.

> > Perhaps UML could additionally install a seccomp filter or something on
> > itself while running a userspace program? Hmm.
>=20
> I'm trying to understand the purpose of seccomp filter you suggested
> here; is it for preventing executed by untranslated code ?

Yeah, that's what I was wondering.

Obviously you have to be able to get rid of the seccomp filter again so
it's not foolproof, but perhaps not _that_ bad?

I'm not worried about security or so, it's clear this isn't even _meant_
to have security. But I do wonder about really hard to debug issues if
userspace suddenly makes syscalls to the host, that'd be ... difficult
to understand?

johannes

