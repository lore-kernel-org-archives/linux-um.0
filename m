Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB83DCF11F5
	for <linux-um@archiver.kernel.org>; Thu, 10 Oct 2024 13:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:To:From:
	Subject:Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=G6VduJXFBOyOCsaDURkWy5h1d0F8k6Fs9XuOFJczoEs=; b=0zDW8F2DyWDgL+mPUNeG+3ud2P
	oUfqVKDTdlxbT37tSlMUxI67CiA/fsnkUfDbJ2KoD6/QDY88CpEdTlj7VmlQYkRI8U/aPgKzeM2g0
	Fp1liRGJqqL1Sops1ZeL+NZC4JvnyZ2d9CDM2nsQ5tvGVTZ5dOWRGC17NPh5WPmskWyZZClSLOu73
	1uSwiNwSIfEFC6KGcD/+Ng7UgH9C4dDSeh9Bg6qb5vsg6RUBggQzNL2PZrKuYjBvuuO90Ht/I+JEe
	Re34EyOopMcxWD+gMHgj3T12HmO+p2ic1pMsbZ6tbYNIGnj3oMd9P4jEGWXnd2KUldEGpOC/bHQ0i
	UknvYbAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sytG4-0000000Cv7O-1hW2;
	Thu, 10 Oct 2024 13:31:12 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1syrlN-0000000CcWF-0tUm
	for linux-um@lists.infradead.org;
	Thu, 10 Oct 2024 11:55:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=G6VduJXFBOyOCsaDURkWy5h1d0F8k6Fs9XuOFJczoEs=;
	t=1728561324; x=1729770924; b=K9wp4zngA4YjMV1jY44RDHJ9XJuZyWENaO0jyAPX5Tx1lJF
	9f7UDdPOGGeGQjuFVQeUo3JdrGzkYJ49XVzAK2H65pMPMoxk1ORd2dWu7LwCKkHT+vPjVcWj9gTZn
	meW4PGHvSFZVU9i6uwVBaxYOCKKW47o2u2uMkmap8/J2GgxjO5IMa010976zZoFyTOSt3eeKUeQTS
	OCwQuHTBD8Scv8WKUH37BrM2EsLkoipx5OTCYBdX5Tqe6c4FugHI+wBRo5GfqNd1WBYjaeVIyWqvm
	dpzY/h+dIafBmChDseSTfrWTfF1wVfDKknNszkMGiU5E84WZUUCvHT5fPz+t3X3g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1syrlJ-0000000646x-1EUQ;
	Thu, 10 Oct 2024 13:55:21 +0200
Message-ID: <4aaebfda4cf5a0f5f2dad650b24d829416daad11.camel@sipsolutions.net>
Subject: Re: [RFC PATCH 4/9] um: Add stub side of SECCOMP/futex based
 process handling
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org
Date: Thu, 10 Oct 2024 13:55:19 +0200
In-Reply-To: <c2cf9536c7dc5f0d805d6f79961c05bc0b8936bb.camel@sipsolutions.net>
References: <20240925203232.565086-1-benjamin@sipsolutions.net>
	 <20240925203232.565086-5-benjamin@sipsolutions.net>
	 <c2cf9536c7dc5f0d805d6f79961c05bc0b8936bb.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241010_045525_277519_C02F562E 
X-CRM114-Status: GOOD (  11.65  )
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

On Thu, 2024-10-10 at 13:51 +0200, Johannes Berg wrote:
> On Wed, 2024-09-25 at 22:32 +0200, Benjamin Berg wrote:
> >=20
> > --- /dev/null
> > +++ b/arch/x86/um/shared/sysdep/stub-data.h
> > @@ -0,0 +1,18 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
>=20
> That new file should possibly have double-include guards as common.
>=20
> Can we use #pragma once yet? ;)

Can we? That would be really nice!

> > +static __always_inline void
> > +stub_seccomp_restore_state(struct stub_data_arch *arch)
> > +{
> > +	/* TODO: Use _writefsbase_u64/_writegsbase_u64 when
> > possible */
>=20
> Don't remember that, what was that about?

Don't think we ever discussed that. I think those map to instructions
that directly set the registers from userspace. But I feel like there
was no guarantee that this works on all machines/CPUs so the syscall
may still be needed.

Benjamin


