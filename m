Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 830AEC3DA4A
	for <linux-um@archiver.kernel.org>; Mon, 19 Aug 2024 12:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DXZ9OYYdz38AQ8gXsqwwGM7UvJTsd4FhVUqGMHaS2z4=; b=pctLxhfytirtQYDMHbzowZS34Z
	85bDpD0nDKjJmDYPSC2DFsBg3eEoevxY9uk6vkn8pVI4TwmWr7BcicyqqlSLpwNHnfJC3gSZx3p8y
	2q/krA3OnwPlQHAUDBLmKiJSNTwQrv3j2IzQW9GjxAu6X37PpQ5guox6mBYX05itXRPpWy5Ewrlxa
	GMCITOsRykaOd1/xS3lMLKpOD60Ep93NaaUDHs5aAD/FkQpRoaB0TzmgxotGe45p0xRa2FFTGw3TJ
	QMT4s1YAkh65yIrGxCY5RZ7D6Yt9g+Z5DXB4kaqO4HIvGVMGiYbRmJpDJlkdmkdH+WW+Ru3Ekh+43
	jn9QP16w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sg1Qs-00000001Q8d-0fBj;
	Mon, 19 Aug 2024 12:24:22 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sg1Pu-00000001Ppg-1PX7
	for linux-um@lists.infradead.org;
	Mon, 19 Aug 2024 12:23:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=DXZ9OYYdz38AQ8gXsqwwGM7UvJTsd4FhVUqGMHaS2z4=;
	t=1724070199; x=1725279799; b=h82oaNS6u/x+338QaHttTML+cEmDkurSXj3EDEJJYSDM8iZ
	Lbnsvoib2+cdGYRIXwCFJtF4KLDCHY6peRZ68Zc93ucIJdCdEOQUrme390jB/U2wSKpUR7+Oi83DJ
	Tm2HOfpjs1lyzdVhY9TFYpdWsqboRQU+15GSUAI7DC57vMqQUvWupFdMXWg45Vky91ImrjKNDRknl
	c7MNI6Nbiq/62Jj2sQFo+qm/K51zu1TT638cMP3bdeMlOJ7r/QqghdQaeAxWGjsuBzLEHMGnVZOC6
	WX+GgaV8BJAQCy01JgNPBjuvCkXpbLwpn1dBcOIyRuN1PjRLSEnlcAadVq/1CHDA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sg1Pl-00000007YDs-0Y6D;
	Mon, 19 Aug 2024 14:23:13 +0200
Message-ID: <efbb6394805f11de27cace9817418744d8e69506.camel@sipsolutions.net>
Subject: Re: [PATCH] um: make personality(PER_LINUX32) work on x86_64
From: Johannes Berg <johannes@sipsolutions.net>
To: Maciej =?UTF-8?Q?=C5=BBenczykowski?= <maze@google.com>, Maciej
 =?UTF-8?Q?=C5=BBenczykowski?=
	 <zenczykowski@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Richard
 Weinberger <richard@nod.at>, Anton Ivanov
 <anton.ivanov@cambridgegreys.com>,  linux-um@lists.infradead.org
Date: Mon, 19 Aug 2024 14:23:12 +0200
In-Reply-To: <20240813234755.3615697-1-maze@google.com>
References: <20240813234755.3615697-1-maze@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240819_052322_430988_0C002465 
X-CRM114-Status: UNSURE (   7.09  )
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

On Tue, 2024-08-13 at 16:47 -0700, Maciej =C5=BBenczykowski wrote:
> Without this patch:
>   #!/usr/bin/python3
>   import ctypes
>   import os
>   personality =3D ctypes.CDLL(None).personality
>   personality.restype =3D ctypes.c_int
>   personality.argtypes =3D [ctypes.c_ulong]
>   PER_LINUX32=3D8
>   personality(PER_LINUX32)
>   print(os.uname().machine)
> returns:
>   x86_64
> instead of the desired:
>   i686
>=20

But ... why should it work? UML has no 32-bit compat support anyway.

johannes

