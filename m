Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E072D10BF7
	for <linux-um@archiver.kernel.org>; Sat, 26 Oct 2024 12:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7YqNZSlbyRhUbqo70OYFTt0ujOSnS5Sy1lCIJYqT/yQ=; b=GaQlWZcSUQUuBO0YYyfH5qTzpa
	oNNZ9VL+rJ7w5VMf5N+gJAVrszoicqBVD7tJSH/7+nG+xEsdsXe5jBf3vtEHJjqZQtTcAGNKgl9Gv
	7eJU9NW9d1SCStmq0gpeFccK9IH+2s/CZw0PB1/ANh3mym8UA1NB0XoarcNXb3dYPu6Z0syRL2kdC
	ihmmHyYtRycupVVQfevVEgN9mrowfRQuUdZ0KB7nzogJ33XcCJ/BPVSg7+4K40A6bu1pzVY3SI8NM
	BW6aZcTxDatCi8bB0b5PcuqRmd/vjfPHoZU99SoDkD4Svmm6pDiGomBZtBVqwa2rMUcCDjz7HLeDk
	WObvl97w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t4gLh-00000006f54-1RuJ;
	Sat, 26 Oct 2024 12:56:57 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t4gLg-00000006f4p-2D7g
	for linux-um@bombadil.infradead.org;
	Sat, 26 Oct 2024 12:56:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=MIME-Version:Content-Transfer-Encoding
	:Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=7YqNZSlbyRhUbqo70OYFTt0ujOSnS5Sy1lCIJYqT/yQ=; b=mPVac8nVtKIZQTn/Z8ZauPx0dU
	EYUdt6CyTMK5nPMexri23Zs7Osu9a1CgNiDtZIM6WOi3BEWCCLbbyGYpw1CjyHLfF0XXyGVhyabYz
	7M7oWv/v9DOuHnFdHFDo4fbo/ryyKCYOmCo75z6PT4MvtuFY8HzWV6K3WCvOUurgsgi1ofu5zCWYa
	4TXh7HyW9pm6dRbQwJC7LuWC9SJwxro/nI1xIXrajqrI+6wLo/6uUcu8N/7s+OXslEIsdhm+RG2Zc
	APF707mLLs4OP+mRV4Lm8/W9T6U2mlcLvrziBY8W4BcWG825HVuf5c8+f/lq4ULpN/Oi8DK7aRAod
	OVphV9rA==;
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t4gLc-00000009EqW-2ebD
	for linux-um@lists.infradead.org;
	Sat, 26 Oct 2024 12:56:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=7YqNZSlbyRhUbqo70OYFTt0ujOSnS5Sy1lCIJYqT/yQ=;
	t=1729947411; x=1731157011; b=KovbJZFJUb93A96E0W8nZ/awWnL9oZ+00yQsm0VsqOtdxTb
	0m/QeYmtsqMPmWLNurUi4unV/K4loQjTTFoeekEogeBw1BROomDM+VPExz0TXb7tYAuNjBZ9BSAed
	BGlZCcDAb7rsenYX4RtoZuD9UK/rSGUX3/q1AU04Tl9e+mib5k8HYDQQQlG9rPvxVpwYpfRvOofZy
	88z7fi2YvysruoJcyFVuE83Z6FUAICJq5ibC6SwqWX49LG52RSSBQjKEpg7mc8k8psq9s09oQWOIK
	GoFUzV35jtgmr/RJ0j3DcZEBlrvNBR0jLw4B6hGRkrzK12xLzyYCOI3jxIUW5xaw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1t4gLX-00000005P6Q-1M7X;
	Sat, 26 Oct 2024 14:56:47 +0200
Message-ID: <6182ae812f461ae75d11ba1fc78905cf27114d12.camel@sipsolutions.net>
Subject: Re: [RFC PATCH 8/9] um: Implement kernel side of SECCOMP based
 process handling
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Berg <benjamin@sipsolutions.net>, linux-um@lists.infradead.org
Cc: Tiwei Bie <tiwei.btw@antgroup.com>
Date: Sat, 26 Oct 2024 14:56:46 +0200
In-Reply-To: <1aeadd38be5b073cb1f2fd1e1caa55f3997be14e.camel@sipsolutions.net>
References: <20240925203232.565086-1-benjamin@sipsolutions.net>
	 <20240925203232.565086-9-benjamin@sipsolutions.net>
	 <590b1ea94cd8166dde2230e8aa8c80045f30cfe4.camel@sipsolutions.net>
	 <1aeadd38be5b073cb1f2fd1e1caa55f3997be14e.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241026_135653_366272_A777E087 
X-CRM114-Status: GOOD (  10.59  )
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

On Sat, 2024-10-26 at 13:04 +0200, Benjamin Berg wrote:
> > > =20
> > > +#include <linux/kconfig.h>
> >=20
> > Hmm. If this works, why do we have UML_CONFIG_64BIT? For ASM stuff?
>=20
> So, I just had a quick look. It seems that before commit a95b37e20db9
> ("kbuild: get <linux/compiler_types.h> out of <linux/kconfig.h>") doing
> this would have caused compilation errors.

And that commit was pretty much done for the exact same reason!

> With that change, there shouldn't be a reason for the various
> UML_CONFIG_* macros anymore. It should be safe to include
> linux/kconfig.h (and if we are not allowed to do that, we could still
> use generated/autoconf.h).
>=20
> Maybe we should see this as a cleanup opportunity?

Sounds good to me! That also gives us IS_ENABLED() which can be a nice
cleanup opportunity too :-)

johannes

