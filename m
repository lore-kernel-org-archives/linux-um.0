Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E0F606A335
	for <linux-um@archiver.kernel.org>; Mon,  9 Nov 2026 10:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=IiX7khDE;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=l08yKITc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:To:Subject:Message-ID:Date:From:MIME-Version:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=F+yqhQDeAedT4lTew8UAL3NbzmMFTV2CQnmnjNU4sI8=; b=IiX7khDEHHQ0fE7DxGVz5UTOou
	4WmddoohveHmHQi5Fz1JfEv/GL0AnMcSCPoJzOFcG2norkaizlEO8ItI8Xy+td6A5z9Mg4KLowhEt
	LLqRxw3ydzspxgtOo/NqxbwQ1ZYqD7mNFBO4qGW/MjDKlLNYZGM1/BMxJno34bp31N3o4KH+9mVob
	yaf2YaD/v8UgpnNyOuUBwO2C3EWd0QNAPdl/6aydibyLBbiaAHFGWpoc6YWl9/93BCMLAIsJ7SOWm
	VKXpSv5ahEcWdwfmuzZQgBtSSm5P0YWa+ZJXxYtYaDbh+uCDuS5gKaSlM9tr+pOu2tP0zevgoTxBg
	wQzaK5cw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQMiW-00000000Qg7-22NV;
	Mon, 09 Nov 2026 10:35:12 +0000
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQMiS-00000000Qek-19zt
	for linux-um@lists.infradead.org;
	Mon, 09 Nov 2026 10:35:11 +0000
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-2e940d5d2beso2149055ad.0
        for <linux-um@lists.infradead.org>; Mon, 09 Nov 2026 02:35:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794220506; cv=none;
        d=google.com; s=arc-20260327;
        b=sxgIYbc77WhgsaBaDXf1wn0tuNP/XVw/+Kd99XaqFbaZEfG9jQvefi5nBrhMQMbzHq
         KrqJICIH1DYtPrm6NHNqSt6VnIe72o9kChuVABx1CXAkWv0N6hLL6++gku+mfnOS8Abt
         +SdhuxrD8RAo/Aqe2SMZapPj2gRcjtbXtiJ00ZeChwEOzou0t4siDVbhnxSU8INLY6Ky
         IRzj/X71x7qwSzNz8WxLP1XQX50sVhXM9UHB1w39M4zj9EXUPZT3balYMWjGkqzz1Ct6
         MHjUUqnTWG99nNntV0sxJrEa/MwO22njR73VUkuKr/THu3sv3YR2tXfB7LsobVb7gF5P
         CfYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=F+yqhQDeAedT4lTew8UAL3NbzmMFTV2CQnmnjNU4sI8=;
        fh=o0nxhNHagDXxtpgNKrcwPwoNl/0hh+QY1hqd23hVpUA=;
        b=nAhJdnhIoy+NncXq93RJosh3Io5upmGR1OiogmauHAxNPghKtSnWkjt4TR3uiyQzEM
         s1f1am/4jxJwPGjj6hONauevFWBJ7qtsZ4Pys5K1y363/zmv7MIW65pxW36YtlRaPJe8
         3Q1LUem8iQvsQ1bYt3nkXe0dkliDsR8VarctKRJMNIgzThwRlZjOusFYa401/pW5yjoz
         3zb6WvikDjfAbWCw5KypUTDzIPZ/hbYrI4fV4opMquvcEfUkxTKL5E42FNBUNkwzGSb2
         JjQtSCBfBTEgAPiFIw4Iei0JcO1/pb5738Ivmm/i83OQvqVSFGV+Az8QdWWrRqmRZkgH
         uQGg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794220506; x=1794825306; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F+yqhQDeAedT4lTew8UAL3NbzmMFTV2CQnmnjNU4sI8=;
        b=l08yKITcldTFGJ1t6cH5SToriTFWbFlk97ZHtfDYxDZ4afo583UdEtoPlJxuemI3QR
         qedNsBF/VbHOIdlLXoSd75Cb5h0e8dlAymHY4sLyPnO9zse2uDLp+g5AVHn747X6F26S
         wWkAUcb2yW+jObpPmMuFjtOkAHz1JRDB0XUBZpF8G/t7h+nfeQ48wKx8zlOhnsPhfNvV
         kOhj6OK9Jww8pRHhcDvXZoakxqzS9drlPDh1Sm656ZoD/CMr79H8h/ySL0GOt/WGIenZ
         m00WBEeQ6YqbVjhDfe/G6iSbaO8SN0wY5yn9mDW1jpkEyCVGDm1Y4n6FisfZQVpJcTll
         nv+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794220506; x=1794825306;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=F+yqhQDeAedT4lTew8UAL3NbzmMFTV2CQnmnjNU4sI8=;
        b=U3dzNf/AuOFqPJyj4VU/NWsj0ED7CCQTtbF1pWUKvfC637cU8LfYRCWzVmtsouH0IC
         Ikfm3569EfXPm+lAHUIEY4ywq3WUW6/tqmlO4wpDXiDKXyb1KqXaXcSiuD1biNdtOSDh
         aVlyfI/0oaiObrJRVvedOm2onV019TlxooOR2UUZRfsclX0RprnJ718ax7HH+7ibxruA
         Uo9oeFeytCltdPPGGWjbSZ+3wMcovJCjuA13CrJM9qFNCdGEPdLmqmPon7Mpqv/ThFIo
         eRHOsErQPJ9CH3rQiEcD6j3okRqp6mX4gsQqFXySSW4a5iINGMZ2aaJPgii2+wMrOs7L
         PSew==
X-Forwarded-Encrypted: i=1; AL+hErF53R4WO6r4wJP1UwydDh0qR06xj33lxHEnNXiGX6JWCROek8FnUHRNdpLYxAIlu6gnmE9motJjqQ==@lists.infradead.org
X-Gm-Message-State: APuU4Z97yvndzB0/LMImacgD++KIiZkthM8meGS/ZXDbOt+huHD681aM
	PB/Z+VLtwcU3ydtGHS7F1uQWu/To/ChsB9ANmfOPDMRU64qncj1qXZGdAhtpzbWYb+G+5AIPtIw
	e4CO74lQKwUZjWcZXsl2qfpGTcxa2R+4=
X-Gm-Gg: AYBFou1FQo+GSZcq4W7Va30BVDihGanqOpf/K6aDMwQgVr7Aa2Vc9+BByN+sTeDCbKf
	058MIa9kuyCStcbKbCILnuriQ3Yt7SZyyI2NAehkXCwB4WUuJRmy6u3Y/2eOo53N4hRug9ScLVn
	spLQpMN7SNCQ+bV8aTCXbleT6QkdhCHQC94TcpdZHYqSxBQQobE6Q8pna+7QtNYHp7wOVf3n628
	AoxLDp+toSi01dlZPCSIIJfQhK0/DubRXqmTqfgabqqXM8ZfCK00QOHOVo0Bbk/LJVpDCIwJzRR
	pam8suot1Tzgouv1oHsjeETQg/q5oLg65UNiWWb/r8iraprNSEPNuSD2/BNqgMpPwvqrqZRLIQy
	6rEm36qKfNrCITZ5ryPXxqO5xCJNisrsn1L4+VR0kwD8Asp/Fr+T/vUGzOkRcf9YI10GI
X-Received: by 2002:a17:902:ec86:b0:2ed:42d5:e682 with SMTP id
 d9443c01a7336-2ed837c255bmr34675915ad.41.1794220506202; Mon, 09 Nov 2026
 02:35:06 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?THXDrXMgTWVuZGVz?= <luis.p.mendes@gmail.com>
Date: Mon, 9 Nov 2026 10:34:54 +0000
X-Gm-Features: AclHuK-U3DKb3ufYToRYwdsnyxbkh0WoJb17z-XizpY9m9_hsc3E6wlTiHHbwTc
Message-ID: <CAEzXK1pdhEyOgQ4owkeRmyEP6Pyfhk=OsMHdzU4xwNMCmCsd6g@mail.gmail.com>
Subject: Some observations regarding the ongoing x86-32 CPU configuration cleanups
To: Arnd Bergmann <arnd@arndb.de>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	Gary Guo <gary@garyguo.net>, Yury Norov <yury.norov@gmail.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, 
	Alexander Usyskin <alexander.usyskin@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, x86@kernel.org, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-um@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261109_023508_324703_E374DB81 
X-CRM114-Status: GOOD (  12.85  )
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi everyone,

First of all i would like to say that i both admire and appreciate all
your hard work with this lovely OS. I do understand that maintaining
some systems can cause additional burden on maintenance, but there are
some aspects that i would like you to reconsider.

I am writing because I  believe that some aspects have not been taking
into consideration regarding the removal of the 80486 32-bit support
from the kernel, namely:
- There is this active Linux distribution:https://tinycorelinnux.net/
and the Damn Smal Linux DSL (https://damnsmalllinux.org).
- There are also these CPUs: https://www.vortex86.com/products/Vortex86EX
- There may be only a few vintage 486 systems still working, but there
are also other new x86 CPUs systems, especially in FPGAs like the
https://github.com/MiSTer-devel/ao486_MiSTer which is a 486SX core
that operates at 90MHz and can use up to 256MB RAM memory. There are
plans to update this CPU IP core to become a full 486DX core, by
adding a FPU unit to it and would turn this into a usable Desktop
system with tineycorelinux. There is a considerable retro-computing
community that utilizes the AO486 core on the MiSTer FPGA platform.
There is even a Voodoo 3dfx accelerator card:
https://github.com/victor-fisyuk/voodoo-fpga-public.

Overall i just want to inform you that some new x86 32-bit systems are
still being sold brand new and can be utilized with Linux. I would
like that you consider this with regard to how much 80486 support
should be removed from Linux.

Personally i do have plans to extend the AO486 core to have the FPU
and would like to be able to run a modern Linux on it. It would have
entertainment and educational applications. With tinycoreinux it can
have a usable desktop.


Thanks & Best regards,
Lu=C3=ADs Mendes

