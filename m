Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC763C3ABC0
	for <linux-um@archiver.kernel.org>; Thu,  8 May 2025 05:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=abgIvTl95IldGAjgwx1zwym4dN3voLN7jqSpis9EXko=; b=kUcpepVF9YJ6DyrLY1Telk90XO
	ZsPPJAiM37FIwKPh4F7+hdoCwGwJ9KULTTqJ/oLIEfC7BoE1+niggQQ8ehsDxiPaCummh9MYlTF5V
	/5NKcRUzd1loJX+FJ+JbK+ur44n+9NEZL4vuUM6vWBg+8yFyHPr3pEu1f3MeKyjMTYLvB5TurjZXH
	AhLe3721QdEWzKpeXxRbleao/RJ37jhKf9qzSH3Oy5SLaNde90bOhuQKmYHcnDVafMJd/Yp7u0NhT
	rQSbFAxGxwF0qbXFATK06HJTxmii8np0okHiQkXso4Torolv+UFqKrSITpS7YMhCPGFATcknifpaq
	DBFdimIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCtoq-0000000HNBA-0Qzc;
	Thu, 08 May 2025 05:29:16 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCton-0000000HNAQ-38ff
	for linux-um@lists.infradead.org;
	Thu, 08 May 2025 05:29:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=abgIvTl95IldGAjgwx1zwym4dN3voLN7jqSpis9EXko=;
	t=1746682152; x=1747891752; b=xuOOEdhQa3u/BDSmZ9WDVMLhrIatfcGtnznlBVx6ep8ZK/V
	T+yZtq0bJuQreWvxR7NFccGRCSZO62Ph/uhxBrFWAVHmJ2usoV11oHD85A8ruZ6u6DKuOHIReU9XH
	mmER/qrv3wtz807MPnj9cQRlhF7/ZsqKO6g4Z3xpUlGW+n3vOkGNdhkfJ4v5I1BPucHaxCfi7oLuc
	issDBtxjYAC/BwhTnZD/f0grVFy+YyhBa8ke+Rc0DmEgs61SqbNyTyvRjSntPX+//0q5OgEbODykR
	ft0Ssw0a+sS1OEnZkFQ7rdmF/1cm4rPK+E5hMVgjdCQNKuOhXuNfqlHV3cVKDCCw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uCtog-00000009gKj-3jZY;
	Thu, 08 May 2025 07:29:07 +0200
Message-ID: <b1e4e83c0965e10f2fe59826d19eaf131ec7aef9.camel@sipsolutions.net>
Subject: Re: [PATCH] um: let 'make clean' properly clean underlying SUBARCH
 as well
From: Johannes Berg <johannes@sipsolutions.net>
To: Shuah Khan <skhan@linuxfoundation.org>, Masahiro Yamada
	 <masahiroy@kernel.org>, linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Anton Ivanov
 <anton.ivanov@cambridgegreys.com>,  Richard Weinberger	 <richard@nod.at>,
 linux-um@lists.infradead.org, David Gow <davidgow@google.com>
Date: Thu, 08 May 2025 07:29:06 +0200
In-Reply-To: <9ec50ce0-f60b-4d87-bc44-adaf2a1a97a1@linuxfoundation.org>
References: <20250507074936.486648-1-masahiroy@kernel.org>
	 <9ec50ce0-f60b-4d87-bc44-adaf2a1a97a1@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250507_222913_800909_7884211A 
X-CRM114-Status: GOOD (  11.60  )
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

On Wed, 2025-05-07 at 15:38 -0600, Shuah Khan wrote:
> My workflow:
>=20
> - Build kernel on x86_64 with CONFIG_AMD_MEM_ENCRYPT enabled
>=20
> - Check for arch/x86/realmode/rm/pasyms.h
>    ls arch/x86/realmode/rm/pasyms.h
>       arch/x86/realmode/rm/pasyms.h
>=20
> - make ARCH=3Dum O=3D/linux/build
>   =20
>    This patch cleans the source tree, but doesn't remove
>    arch/x86/realmode/rm/pasyms.h
>=20
> - ls arch/x86/realmode/rm/pasyms.h
>       arch/x86/realmode/rm/pasyms.h

Is that even _expected_ to work? If you have x86 built first, I'd almost
expect you to have to do "make ARCH=3Dx86 mrproper" before building
another ARCH. I don't see how ARCH=3Dum would know how to do a full clean
up of ARCH=3Dx86, unless this is somehow arch-independent?

Or maybe that's not an issue with other architectures because UML is
special in that it uses parts of x86?

Though I guess the patch here should make it do that, more or less, but
it can't, likely because you're also switching from in-tree build to O=3D
build?

johannes

