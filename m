Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9052FCD3423
	for <linux-um@archiver.kernel.org>; Sat,  2 May 2026 12:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fyZCWSV6uUGBUx7qDOXXlcXryy60JSkhXY/hW5S/TWc=; b=ceCxfaatukSuAfx3gODIp2cIWj
	RKbEXCoHGYwFfgu62vh7dprxGBvEtlfp9e8duuD8l0twLA0oRQ/LeBLMumyXXPRThJ91GRbe6UHEK
	o6dCfwItFV4FwrauJRvAetJIniakdUuDtQyO+TG2Vb5PnLk5AhUrVrekoxQFTY820I0I6VoQ7O4Mz
	8IY4vFWm15QUtw4rgHKXfbMhhl8Of6dSFt7za9D/bKYSiFdax8rtqpkFv/ZOt3iKB39N4G0QWpWi3
	sU2+JxZ6bpHwO6Io4y3ehz41V+YOupuq/KzIdxePzgK3HWlrcWRg7PPx8NUdcRaI5YsrxehPGGQtl
	wpmUOEYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wJ92P-00000008xDG-3sQk;
	Sat, 02 May 2026 12:01:37 +0000
Received: from nestor.xn--rombobjrn-67a.se ([188.126.83.49] helo=smtp.xn--rombobjrn-67a.se)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wJ92N-00000008xBi-0v7v
	for linux-um@lists.infradead.org;
	Sat, 02 May 2026 12:01:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xn--rombobjrn-67a.se;
	s=a; t=1777723287; bh=Ep+PyIxZUxo7I++u34Bl31OMHEHI2GsPl+DkXpzZqCo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:From:Sender:Reply-To:Original-From:
	 Organization:To:CC:Subject:Original-Subject:Date:Message-ID:
	 In-Reply-To:References:Original-Message-ID:
	 Disposition-Notification-To:Disposition-Notification-Options:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:
	 Content-Features:Content-Alternative:Content-Location:
	 TLS-Report-Domain:TLS-Report-Submitter:MT-Priority;
	b=GkRzP7i9RTR0072h+WMkZvMRoCNMwNwC40JfXyxrLS/q1vm3ToFJdUlBmuXUryZif
	 eE5uPAXZpohsnrcGeOv5M/Bys3/quIk76pWdJQYAWB1J15DO5STdJyg8wKp3Bu7GTG
	 LI05A/fqlctPOn4nY48JOgAChIbNlERqIeirinTzgWvOoEuDPUpkFSbfiK4yls+ais
	 sM3HRM42D0IMRV3NIwjesUQmIGkHbkkg2UpFFi7MDGA4cqehu5/SFuy7cBwMe1ZhNk
	 4TpdQ7MxpIlIerzd5ridfX1OJ9cYT9FAgCJACOh/r7YK6iueeHvgXfe4l/OnXfU5PM
	 rsTrnJjSjj9tA==
Received: from tag.xn--rombobjrn-67a.se (tag.xn--rombobjrn-67a.se [192.168.72.9])
	by smtp.xn--rombobjrn-67a.se (Postfix) with ESMTPSA id D7652407BE00;
	Sat,  2 May 2026 14:01:27 +0200 (CEST)
Date: Sat, 2 May 2026 14:01:08 +0200
From: =?UTF-8?B?QmrDtnJu?= Persson <Bjorn@xn--rombobjrn-67a.se>
To: Wang Zihan <3772548978@qq.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, mchehab@kernel.org, richard@nod.at,
 anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-media@vger.kernel.org,
 linux-um@lists.infradead.org
Subject: Re: [PATCH] Documentation: Fix duplicated words
Message-ID: <20260502140108.6643955c@tag.xn--rombobjrn-67a.se>
In-Reply-To: <tencent_B1D6CBBF95486E31D04C2E1B92F5E605A307@qq.com>
References: <tencent_B1D6CBBF95486E31D04C2E1B92F5E605A307@qq.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/s+pt7UBjTtHpjBNxXVWB9kl";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260502_050135_423370_880BF6E7 
X-CRM114-Status: UNSURE (   5.92  )
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

--Sig_/s+pt7UBjTtHpjBNxXVWB9kl
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Wang Zihan wrote:
>  you can always run UML under gdb and there will be a whole section
> -later on on how to do that. That, however, is not the only way to
> +later on how to do that. That, however, is not the only way to

"Later on" is an established English expression. A plain "later" also
works. This isn't a correction of an error; it's a stylistic change.

Bj=C3=B6rn Persson

--Sig_/s+pt7UBjTtHpjBNxXVWB9kl
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signatur

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE52SginNFTPmg+iBb4Tha3NZK5j8FAmn154QACgkQ4Tha3NZK
5j/jXA//VZxalhvXELFLazBqWaE4KMf7cjtx1MrlRygc7caUVnuiH6P2AXJtgQIy
chY2K2gn1yVnHnJsSpSflBQQ8L4lshmP9ZHMKVcU5f7fygL6Ueg6Aa4bBWgbU71B
Y0KPOXE9eHOZfwZ8myMe7OJiRgZkJ4YbrmjFR2DoVx+NZ1eKfFAVUEGfOG3HkZBH
6OKIbHcMbvzjtenrUkdaPOVAmH13GbtSUT17Z2Dm9ifui1wfTA/JAxfAw/MH+Pjd
DyO9RVvhTJRIyr1LdTac1s9PRo2bVt6PV8cktZM9f1Njj1rnYpQhf1w4QH5+2kUV
v9cA5bMaYKOQ2oL1VaHnW9CTm1DhqUN6eIs6IFMk++7Ad/QN2I7uLdp6Xh/rRtY2
oKqOSVN+gWlVQ4MWrdrfRJ0QJ5ZKekmx5YcR7gfL4xYl52dHyA6GpsJozvD0xwTy
6wUJX7skyjtxsVKwgUPyr4EwH7er49NcLjzZK6T70FbJu8c1eCUK92Fad3wzSe1D
qNM3pnWHgaWHn6MrzPfsx1WLDVkDNfgD1leidoXabLJoCxzO6NRBWFtL8qcAI/Kb
0PXcw3gg9f2fQQbRgSYkN9CKA+8WjFpHbqwVbakscxQGdW9KSKS59Kz21yDphswV
IPHeHiN/KKKOf4XS+3qEXWFGIqc90/Pw4Xgpcpgvs9l9lAuiFTo=
=j/I4
-----END PGP SIGNATURE-----

--Sig_/s+pt7UBjTtHpjBNxXVWB9kl--

