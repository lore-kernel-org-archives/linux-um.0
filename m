Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F825FD5F61
	for <linux-um@archiver.kernel.org>; Wed,  8 Apr 2026 06:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tW4C7DNp4jf59b9gY7OTd32/8qvxX8VgEA1if3v+Irc=; b=YSAUNHXtEZjMArQfdP/heXRMBL
	/CVTKr6RJLnNXRrPS4OkMy+xSFTJzUtbGBFvd2yWTIPD1+VemWhIVyCxTPVjY7HQ5eTAOSqVNJTir
	/IxmIwWI7xf4dgvoxDA5pYtA7aWn2qv9YKPW2RtGJeqJdrjxiWdM7k47rXPKRdx1sNLKWIB0RGhFM
	gVk+fpMPmkejPI5hfX6vJt4A5sQeLkK9rAm5VIJxpMLxW/fqCMwjkYxsdKfhNpA5pziGnmqOPH0pX
	EheHTj7EjggJ+Mk8YOYOlcU3BEysrK9OH/6a1IZa95VAViQbXuiad5bIR/ubkvHLtovkd0b4S4odo
	bywxck+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAMg1-00000008MkS-3Nea;
	Wed, 08 Apr 2026 06:46:13 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAMfy-00000008Mje-3SkH
	for linux-um@lists.infradead.org;
	Wed, 08 Apr 2026 06:46:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=tW4C7DNp4jf59b9gY7OTd32/8qvxX8VgEA1if3v+Irc=;
	t=1775630770; x=1776840370; b=jYTNoB4SEanbtmLj6MI+6suO/sN7IrdM3QU1MOOaiv1s8RC
	h80KrvpQ6TCNR6EVHkpAoSvAY/GwRkV6Px227hQ5Yd2CcwbiKs5TJUwQdBl814v3Mo0bU9Ndr5NQZ
	ZWFvIiD0Tj/eguhrQZdeDswE7GEGLIM3OV0rtijJR808LuqfmMwsHa+U0WTArb3QeLkhTU/QPcfC0
	ttJrLOnAiA/8wj0tkqimOM5rxBSoBCwrbBsj9EGDTNiAAXICVHo40a+bUhna8WznwZH5BjjhPGosR
	TIgOQ7oVcMzkBHfv4NopUnzmaHiFY6LvHOqcJea8MEodCPCO0p0huopj6O+2KY7Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wAMfu-0000000E2kS-1G7r;
	Wed, 08 Apr 2026 08:46:06 +0200
Message-ID: <a2efd8145cfbc207fef5884e93d09f787811becb.camel@sipsolutions.net>
Subject: Re: [PATCH v2] um: drivers: call kernel_strrchr() explicitly in
 cow_user.c
From: Johannes Berg <johannes@sipsolutions.net>
To: Michael Bommarito <michael.bommarito@gmail.com>, Richard Weinberger
	 <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Date: Wed, 08 Apr 2026 08:46:04 +0200
In-Reply-To: <20260407181528.879358-1-michael.bommarito@gmail.com> (sfid-20260407_201538_551551_67B5DCE6)
References: <20260407164435.726012-1-michael.bommarito@gmail.com>
	 <20260407181528.879358-1-michael.bommarito@gmail.com>
	 (sfid-20260407_201538_551551_67B5DCE6)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260407_234610_894973_9B34755B 
X-CRM114-Status: GOOD (  22.08  )
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

On Tue, 2026-04-07 at 14:15 -0400, Michael Bommarito wrote:
> Building ARCH=3Dum on a host with glibc >=3D 2.43 fails:
>=20
>   arch/um/drivers/cow_user.c:156:17: error: implicit declaration of
>   function 'strrchr' [-Wimplicit-function-declaration]
>=20
> cow_user.o is a host-side helper (compiled with -D__UM_HOST__) that
> calls strrchr().  It inherits the global -Dstrrchr=3Dkernel_strrchr
> remap from arch/um/Makefile, which is intentionally kept in
> USER_CFLAGS to prevent libc/kernel symbol clashes.
>=20
> This combination was harmless until glibc 2.43, which added (glibc
> commit cd748a63ab1a, "Implement C23 const-preserving standard library
> macros"):
>=20
>   #define strrchr(S,C) __glibc_const_generic(S, const char *, strrchr(S, =
C))
>=20
> The glibc function-like macro replaces the -D object-like macro.  The
> inner strrchr token in the expansion is protected from recursive
> expansion, so it refers to the bare symbol strrchr -- but the header
> declaration was already rewritten to kernel_strrchr by the -D.  The
> result is an implicit-declaration error.
>=20
> The global -Dstrrchr=3Dkernel_strrchr remap was originally added in
> commit 2c51a4bc0233 ("um: fix strrchr() problems") to resolve a
> linker clash when both CONFIG_STATIC_LINK and CONFIG_UML_NET_VDE are
> set.  Recently, commit a74b6c0e53a6 ("um: Don't rename vmap to
> kernel_vmap") trimmed the now-obsolete vmap remap and updated the
> comment in arch/um/Makefile to explicitly call out
> -Dstrrchr=3Dkernel_strrchr as one of the remaps that still prevents
> libc symbol clashes.  That global remap stays in place.
>=20
> Rather than exempting cow_user.o from the remap at build time, call
> kernel_strrchr() explicitly in the source.  This is slightly more
> honest about which strrchr the code wants (the kernel's, as it has
> been since 2011), sidesteps the interaction with glibc's C23 macro
> entirely, avoids adding a new libc strrchr dependency to the UML
> binary, and is robust to future C23 const-preserving macros for
> strchr, memchr, strstr, etc.
>=20
> cow_user.o is built whenever CONFIG_BLK_DEV_UBD=3Dy (the standard UML
> block device), so this affects most non-trivial UML configurations.
> cow_user.c is the only file under arch/um/ that calls strrchr(), so
> no other translation units need changes.
>=20
> Standalone reproducer (fails on glibc >=3D 2.43, succeeds on older):
>=20
>   printf '#include <string.h>\nvoid f(void) { char *p =3D strrchr("foo", =
47); }\n' \
>     | gcc -c -Dstrrchr=3Dkernel_strrchr -x c - -o /dev/null
>=20
> Tested on:
>   - Host:   Ubuntu, glibc 2.43-2ubuntu1, gcc 15.2.0
>   - Kernel: v7.0-rc6 (3aae9383f42f); verified that neither
>             arch/um/drivers/Makefile nor arch/um/drivers/cow_user.c
>             changed between rc6 and rc7, so the fix applies and
>             behaves identically on both
>   - Build:  ARCH=3Dum defconfig + CONFIG_BLK_DEV_UBD=3Dy, clean compile
>             with no warnings
>   - nm:     cow_user.o references 'U kernel_strrchr' (not libc
>             strrchr), and the final linux binary has no
>             strrchr@GLIBC_2.2.5 symbol anywhere; kernel_strrchr is
>             defined exactly once by lib/string.o and
>             EXPORT_SYMBOL'd
>   - Boot:   UML boots to Debian bookworm multi-user and graphical
>             targets with a COW overlay (ubd0=3Dcow,backing), which
>             exercises the patched absolutize() -> kernel_strrchr()
>             code path in cow_user.c
>=20
> AI coding tools (Claude Code with Opus 4.6, and Codex with GPT-5.4)
> assisted with debugging, test design, and drafting; the author
> manually reviewed every line and executed every build and boot test
> on the host.  Full disclosure was posted with v1; a shorter summary
> is in the Assisted-by: trailers below.

I think you should remove about 75% of that commit message, much of it
is noise, and some of it is simply wrong (in particular, "exempting
cow_user.o" really ever only existed in your earlier patch.)

Try without an LLM perhaps.

johannes

