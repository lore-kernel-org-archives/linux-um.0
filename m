Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail.sf-mail.de ([2a01:4f8:1c17:6fae:616d:6c69:616d:6c69])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oiwa6-00BZew-Mo
	for linux-um@lists.infradead.org; Thu, 13 Oct 2022 11:40:56 +0000
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
Subject: Re: [PATCH v6 5/7] treewide: use get_random_u32() when possible
Date: Thu, 13 Oct 2022 13:40:40 +0200
Message-ID: <11986571.xaOnivgMc4@eto.sf-tec.de>
In-Reply-To: <20221013101635.GB11818@breakpoint.cc>
References: <20221010230613.1076905-1-Jason@zx2c4.com> <3026360.ZldQQBzMgz@eto.sf-tec.de> <20221013101635.GB11818@breakpoint.cc>
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2483664073442164152=="
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Florian Westphal <fw@strlen.de>
Cc: linux-kernel@vger.kernel.org, patches@lists.linux.dev, "Jason A. Donenfeld" <Jason@zx2c4.com>, Andrew Morton <akpm@linux-foundation.org>, Florian Westphal <fw@strlen.de>, Herbert Xu <herbert@gondor.apana.org.au>, Thomas Graf <tgraf@suug.ch>, kasan-dev@googlegroups.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kernel-janitors@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org, linux-crypto@vger.kernel.org, linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-media@vger.kernel.org, linux-mips@vger.kernel.org, linux-mm@kvack.org, linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org, linux-parisc@vger.kernel.org, linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org, linux-um@lists.infradead.org, linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev, netdev@vger.kernel.org, sparclinux@vger.kernel.org, x86@kernel.org

--===============2483664073442164152==
Content-Type: multipart/signed; boundary="nextPart22512332.f9tG50R4rC"; micalg="pgp-sha1"; protocol="application/pgp-signature"

--nextPart22512332.f9tG50R4rC
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: Florian Westphal <fw@strlen.de>
Date: Thu, 13 Oct 2022 13:40:40 +0200
Message-ID: <11986571.xaOnivgMc4@eto.sf-tec.de>
In-Reply-To: <20221013101635.GB11818@breakpoint.cc>
MIME-Version: 1.0

Am Donnerstag, 13. Oktober 2022, 12:16:35 CEST schrieb Florian Westphal:
> Rolf Eike Beer <eike-kernel@sf-tec.de> wrote:
> > Florian, can you comment and maybe fix it?
> 
> Can't comment, do not remember -- this was 5 years ago.
> 
> > Or you wanted to move the variable before the loop and keep the random
> > state between the loops and only reseed when all '1' bits have been
> > consumed.
> Probably.  No clue, best to NOT change it to not block Jasons series and
> then just simplify this and remove all the useless shifts.

Sure. Jason, just in case you are going to do a v7 this could move to u8 then.

--nextPart22512332.f9tG50R4rC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSaYVDeqwKa3fTXNeNcpIk+abn8TgUCY0f5OAAKCRBcpIk+abn8
TncNAKCia3h4AG/9IzqybWbLcwE6uVgTqACfRr3dPUK8JMrKIqGzYOiL96isZhg=
=zppL
-----END PGP SIGNATURE-----

--nextPart22512332.f9tG50R4rC--





--===============2483664073442164152==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

--===============2483664073442164152==--





