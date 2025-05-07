Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DC53C3ABC0
	for <linux-um@archiver.kernel.org>; Wed,  7 May 2025 17:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MqGIOCVMPo1HNFOMfB65N3JXumwu7kUo9lvLDc+biAw=; b=hb9Z6JrpvPNO3Ws7Re71mEROhX
	svH21dahMH4wBNVm1VpHha5SpE8C3Q6Auib/e+fV48q4B4r6WzgvunNrzdQUC3udre4COaxUMTCaf
	eNtyBrmYAGaiG0tGseWvdYjgcVHAx1B/17TmqQepyN+JbzJoaz4vy0OpalSKkhEf2lbUtqoK5/M/G
	z+FTd7D+klxeYGjfo5/oBLe2L5pq6qA38sydWJT91CKroPh8Qv9jeXN+CcjaCfs3sME1qyZPWUrB3
	mRr3VAtUCmr9dh7H7Jb6Y4vm+q1fvXyUJJw/5/eq3m00PBc7Jlv16ITpXKTG2B2GSyCv8p543YvHW
	I78xbXXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCiXF-0000000GJ8c-1fqE;
	Wed, 07 May 2025 17:26:21 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uChPJ-0000000G7UL-3wFq
	for linux-um@lists.infradead.org;
	Wed, 07 May 2025 16:14:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=MqGIOCVMPo1HNFOMfB65N3JXumwu7kUo9lvLDc+biAw=;
	t=1746634445; x=1747844045; b=lvNyyKpb5QUV3JFk7wL8Z1mlVXTja/n0o+r90B0Ln8cOZrr
	/1HaeywBwPigt0puFAEmbDv7pkswss3QzCMSKmVCiEb6pZgclNZ6sdXDhNsHsV1HjFRV1l15AfzzG
	f9WR5vW3xjJ553ajm1QXFNBCQDinqjtIC/uypkBW/+5UTch+vIul5gXD/l5HF7ivIuKsvcEkV2pa6
	TI9X+iNv3ExBCWvCDj+FXk9DazSroDZ7ZL5s8BqFaSL9RSB3nbjaNax4jcodAo1nfwH84b8xtckdB
	0i5RiNyQbMFdE2d1TQmmXNctq4MP58VvjOkKiC0A1tNSc/+iR6qLYJt9m9r/Ug8g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uChPE-00000008Jel-2P8T;
	Wed, 07 May 2025 18:14:00 +0200
Message-ID: <7a92e3eb5947837d16f8b7f1adec9ffc4fda397d.camel@sipsolutions.net>
Subject: Re: [PATCH] um: let 'make clean' properly clean underlying SUBARCH
 as well
From: Johannes Berg <johannes@sipsolutions.net>
To: Masahiro Yamada <masahiroy@kernel.org>, linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, Richard Weinberger
 <richard@nod.at>, 	linux-um@lists.infradead.org
Date: Wed, 07 May 2025 18:13:59 +0200
In-Reply-To: <20250507074936.486648-1-masahiroy@kernel.org>
References: <20250507074936.486648-1-masahiroy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250507_091405_989452_EC6685A2 
X-CRM114-Status: GOOD (  12.97  )
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

On Wed, 2025-05-07 at 16:49 +0900, Masahiro Yamada wrote:
> Building the kernel with O=3D is affected by stale in-tree build artifact=
s.
>=20
> So, if the source tree is not clean, Kbuild displays the following:
>=20
>   $ make ARCH=3Dum O=3Dbuild defconfig
>   make[1]: Entering directory '/.../linux/build'
>   ***
>   *** The source tree is not clean, please run 'make ARCH=3Dum mrproper'
>   *** in /.../linux
>   ***
>   make[2]: *** [/.../linux/Makefile:673: outputmakefile] Error 1
>   make[1]: *** [/.../linux/Makefile:248: __sub-make] Error 2
>   make[1]: Leaving directory '/.../linux/build'
>   make: *** [Makefile:248: __sub-make] Error 2
>=20
> Usually, running 'make mrproper' is sufficient for cleaning the source
> tree for out-of-tree builds.
>=20
> However, building UML generates build artifacts not only in arch/um/,
> but also in the SUBARCH directory (i.e., arch/x86/). If in-tree stale
> files remain under arch/x86/, Kbuild will reuse them instead of creating
> new ones under the specified build directory.
>=20
> This commit makes 'make ARCH=3Dum clean' recurse into the SUBARCH directo=
ry.

Do you want to take that through your tree? I'm not sure we'd get it
into 6.15 at this point via uml, if you have some other material feel
free to take it:

Acked-by: Johannes Berg <johannes@sipsolutions.net>

Otherwise we can take it via uml tree for 6.16 too, let us know.

johannes

