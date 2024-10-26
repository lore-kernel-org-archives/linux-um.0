Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51367D10BF0
	for <linux-um@archiver.kernel.org>; Sat, 26 Oct 2024 11:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MWv9SIGWLoXaRtPBxnj57WshNuZuEhlTKGMPUdnxNEw=; b=Ydl3/Sswb0MbRNg7sVrqONsj2p
	E+9gtCOdrmRv32UOusJPv/UlH5nxbZzc0RNzYzoTgjFytiuoR2Mrf/lwfB4sBCq6R9WUXYVQrWzzb
	Q0cRtYYXUQiN2CeGgLLPkl8TCAfSjc7+Qe4SP6osMXaGDgp22SdhWCWSBx7Mv7u+KGqnl2Eq2CeWH
	Vqd9c4lhrMeEwt/zDT0+lfis9BhyQfwRC1iN42FObALbNxHrgT2fiRR2/L/P33AkYaTl9WZNChg/a
	zLHbHCeZjtBmWhyfIriSmNPCe6+y14gumNU0PHhYUf7TAF2Jb/c4VfS/sMMvZe75ZZ6kpSXpYopPj
	EsS0BGxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t4ebQ-00000006QKx-1DPn;
	Sat, 26 Oct 2024 11:05:04 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t4ebN-00000006QJh-1cxI
	for linux-um@lists.infradead.org;
	Sat, 26 Oct 2024 11:05:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=MWv9SIGWLoXaRtPBxnj57WshNuZuEhlTKGMPUdnxNEw=;
	t=1729940700; x=1731150300; b=OOawgvXM3CVNv0+8Tg5nRfimF4i7eS+wFUDYGPTlTvw3NhK
	XzHowymyCJ5kikTlGMWosc0OqtgvrTd5w2rzMdwmg1pbpYeQOqaOYoj84u8/9nadYJpr85ebIlJ0x
	oXNYuO4I7K+h417r7MSnJpEOiD368cqG2pallEJHiiXi73g7vZAcqtVECIUDiinXTpfOxZgHvBdS0
	Q31eOe5dMmTq5kZREA1WZLBQxK0EGOqn/R6jLUKIQRsfO/ffuecqeCWTOtljvYmBUrVU05SW2McMU
	Ftih4PWpi+SmZGEyvgMN9pC6/6/a29ef9CM7C0zpEg+RG8HffR+NOVzpQUDAUIUw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1t4ebI-00000005NAQ-4Bqa;
	Sat, 26 Oct 2024 13:04:57 +0200
Message-ID: <1aeadd38be5b073cb1f2fd1e1caa55f3997be14e.camel@sipsolutions.net>
Subject: Re: [RFC PATCH 8/9] um: Implement kernel side of SECCOMP based
 process handling
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org
Cc: Tiwei Bie <tiwei.btw@antgroup.com>
Date: Sat, 26 Oct 2024 13:04:43 +0200
In-Reply-To: <590b1ea94cd8166dde2230e8aa8c80045f30cfe4.camel@sipsolutions.net>
References: <20240925203232.565086-1-benjamin@sipsolutions.net>
	 <20240925203232.565086-9-benjamin@sipsolutions.net>
	 <590b1ea94cd8166dde2230e8aa8c80045f30cfe4.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241026_040501_650845_21C75FF8 
X-CRM114-Status: UNSURE (   8.45  )
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
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

Hi,

On Thu, 2024-10-10 at 14:12 +0200, Johannes Berg wrote:
> > +++ b/arch/um/os-Linux/skas/process.c
> > @@ -1,9 +1,11 @@
> > =C2=A0 // SPDX-License-Identifier: GPL-2.0
> > =C2=A0 /*
> > + * Copyright (C) 2021 Benjamin Berg <benjamin@sipsolutions.net>
> > =C2=A0=C2=A0 * Copyright (C) 2015 Thomas Meyer (thomas@m3y3r.de)
> > =C2=A0=C2=A0 * Copyright (C) 2002- 2007 Jeff Dike
> > (jdike@{addtoit,linux.intel}.com)
> > =C2=A0=C2=A0 */
> > =C2=A0=20
> > +#include <linux/kconfig.h>
>=20
> Hmm. If this works, why do we have UML_CONFIG_64BIT? For ASM stuff?

So, I just had a quick look. It seems that before commit a95b37e20db9
("kbuild: get <linux/compiler_types.h> out of <linux/kconfig.h>") doing
this would have caused compilation errors.

With that change, there shouldn't be a reason for the various
UML_CONFIG_* macros anymore. It should be safe to include
linux/kconfig.h (and if we are not allowed to do that, we could still
use generated/autoconf.h).

Maybe we should see this as a cleanup opportunity?

Benjamin

