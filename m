Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B5A8CAC5A7
	for <linux-um@archiver.kernel.org>; Mon, 22 Sep 2025 12:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ycui7EF1uPqypt1AZAs48YhxpkNn2cVKejuM0yOxXhg=; b=KNWr/orh+aVN4pczOQ7uR0o3dH
	Cnvuupo6Eif4IlNd7pfmFrnWKyz5QZp9jekNleEZXp74Np4lcE5mvroGjgnQ/gAKibdWy58dJ1N1s
	hzEiWHrIJK3cbWStIzD0FRmSlvGTWdt61Gj7sahhACQlM0BzG/rTLMcTYqZNx3xzQ0S43YGxmgD40
	55NfFEJJWWXCdBLM/qXgV2PBV1rsVnU+n5qmKSEUCUIVtc0bkNBU9JNZ5BqNkvU82yU2vR04rT4mY
	BIfLT4+q+2l8xdAAL0IVWXC7zoPz+Rs08dUvKHf0JARtCaCEfYnOKg68/iqKnUCWGaWZcCVB5t92o
	o0pueKhQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0fPj-0000000AIHK-2pPz;
	Mon, 22 Sep 2025 12:13:03 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0fPh-0000000AIGJ-2m4M
	for linux-um@lists.infradead.org;
	Mon, 22 Sep 2025 12:13:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Ycui7EF1uPqypt1AZAs48YhxpkNn2cVKejuM0yOxXhg=;
	t=1758543181; x=1759752781; b=l69VL7uRZ8OyhVtCO/idTaR2cdjIz4ahxGjfJVdpLOeJ+dk
	EtpHPDOf039Lh67U2JD+aOE5OMISKoTnY+hxkswpYuvxwuQvbAL25IXE/p8JVCe1kFjxA+Wu8eKIJ
	nuSLeXxrVdK/EPkBaK4HFexXQ3bHLDE76spWVMrfolMu7Q3OgQxyLGRo1JWJZQ886ldw59CxgZ3JJ
	5HitHHwferLFl6I6pSe/I+H9Rn/narwn3ZK/dJjv6+GWjuVn1inLXexi9es59XizmGB6xeiJzKn0w
	0SdUC9LJ8A/qOvZOp0PPVMGbAsLUxxriUHIXbc79Yg/4Eed1whly5o5QzyCPoZqQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1v0fPZ-00000004XyA-1okk;
	Mon, 22 Sep 2025 14:12:53 +0200
Message-ID: <76b5ba35f864764100c9a5a00d50d8fa4276cd98.camel@sipsolutions.net>
Subject: Re: [PATCH v2 03/10] um: vdso: Implement __vdso_getcpu() via syscall
From: Johannes Berg <johannes@sipsolutions.net>
To: Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>, Tiwei Bie
	 <tiwei.bie@linux.dev>
Cc: richard@nod.at, anton.ivanov@cambridgegreys.com,
 benjamin@sipsolutions.net, 	arnd@arndb.de, linux-um@lists.infradead.org,
 linux-kernel@vger.kernel.org, 	tiwei.btw@antgroup.com
Date: Mon, 22 Sep 2025 14:12:52 +0200
In-Reply-To: <495a5594-8ac6-4b7d-be6b-7c176b741c21@t-8ch.de> (sfid-20250922_140539_000914_4D0E5682)
References: <1568f254-7963-4015-91ed-7630d5d87881@t-8ch.de>
	 <20250922045020.48158-1-tiwei.bie@linux.dev>
	 <495a5594-8ac6-4b7d-be6b-7c176b741c21@t-8ch.de>
	 (sfid-20250922_140539_000914_4D0E5682)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250922_051301_712373_34E402E1 
X-CRM114-Status: GOOD (  17.71  )
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

On Mon, 2025-09-22 at 14:05 +0200, Thomas Wei=C3=9Fschuh wrote:
> > The original issue could now be considered resolved. So in v3, we no
> > longer turn __vdso_getcpu into a syscall wrapper; we simply removed it.
> > Perhaps we could remove the whole VDSO before we implement the "real"
> > VDSO. However, its implementation is clean, so keeping it wouldn't hurt
> > and it could serve as a useful starting point for the "real" VDSO.
>=20
> A "real" vDSO would require quite some more infrastructure.
>=20

What's not "real" about the vDSO now? Yes it just implement syscalls
after the getcpu removal, but ... it's still a vDSO? I _have_ played
with getting data into it for the time-travel case, at least.

> And it is not even clear if such a vDSO will make a difference on UML.

Syscall overhead is _huge_ in UML, if it does anything but syscalls it
will _certainly_ make a difference.

> In my
> opinion if __vdso_getcpu() gets removed, the whole vDSO should go with
> it. The code can still be easily restored from git.

I mean ... on the one hand, sure, it doesn't really do much after this,
but OTOH it lets userspace actually use that path? So might be useful.

> Also the functionality to map the host vDSO and vsyscall page into UML
> userspace looks very weird and error-prone. Maybe it can also go away.

Surely host vDSO etc. is never mapped into UML userspace and never is,
not sure what you're thinking of, but clearly that's wrong as written.

johannes

