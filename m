Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF71CC44515
	for <linux-um@archiver.kernel.org>; Mon, 20 Jul 2026 19:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bznKShHtfkBFVelF+5JPRZMQIQ3/WV9LoW3BQU5V2F0=; b=SDHhDpU0bnIK2DE03NZEafIQfx
	3ZEHzKGSd9qGGBIcFgyidKSj0hEd3weE/jvDJAx6jTKQqlYCZUfuaG6iU/flLqFKtgqXvDCOwr1i3
	NJvd4IpAs/ts726x5DuynJE2QKVVuXqrs2eVbgDL33OCz+KWTK2uRhnOsrrjH6zO7tBaDBhimvEaM
	dzAwD27n1+1wXEphHZxdMcO85koAXLJ/uVYDx2mhe4XbX+bTregureIY33WlL/9ghMRLojAdTk2vX
	AHDcm0GDULMOLDqHIwG7O1QXKVcDOSpd7ycLQkUxF97nGx5ptWWS0nXp37Zzf7986H3WmdbfDX0NS
	IiQmGDYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wltNQ-00000007j6c-0qDi;
	Mon, 20 Jul 2026 19:10:08 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wltNN-00000007j5x-2Pd2
	for linux-um@lists.infradead.org;
	Mon, 20 Jul 2026 19:10:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=bznKShHtfkBFVelF+5JPRZMQIQ3/WV9LoW3BQU5V2F0=;
	t=1784574605; x=1785784205; b=gIU9IJg3jdDOImIO+xQjET/lOoROJ7Z/b3GYxx23e2ZD/Qa
	lrvKmyT1gpiVmBdCQw52FgQ+zeIAexxPVPJVMpepgzypPfKY0UrB1ygqwOjyjEJW5Gk938hkdhxg6
	OiR2M6YPlY38Ir7qdteIKlZfQsCiZqGkKlFDEboYiNv5p8xfcpzzT5Y0cxvhRbVpso6fQ8PXn1hFJ
	SxUvPgw/bwwfGzAqyakIzKMmgsuVk3e36yRE7OXy433XUe/R7ITutIZWy6OaBKUIbMB4UV26ktY6k
	ZTfnTwkzoW5dkZktP0L2TUAHUmd0EDiYjOFwLJFI7B11/oLXgXBoextvbeCaeT8g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wltNK-0000000Gt4X-21mj;
	Mon, 20 Jul 2026 21:10:02 +0200
Message-ID: <d8847ea88be191bc1e2ccb6d6e6e79119e653179.camel@sipsolutions.net>
Subject: Re: [RFC PATCH 7/9] um: nommu: add SMP futex operations
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Hajime Tazaki <thehajime@gmail.com>
Date: Mon, 20 Jul 2026 21:10:01 +0200
In-Reply-To: <c88c02961cb99d80ef1a0e88d321b5f86bd5eae1.camel@sipsolutions.net>
References: <20260720185103.530603-11-johannes@sipsolutions.net>
		 <20260720205103.4b4ce01cd017.I0a83e5ca6be6c95a81d4b2ec69677bbea5889d7d@changeid>
	 <c88c02961cb99d80ef1a0e88d321b5f86bd5eae1.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260720_121005_614859_4594A046 
X-CRM114-Status: GOOD (  10.72  )
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

On Mon, 2026-07-20 at 21:06 +0200, Johannes Berg wrote:
> On Mon, 2026-07-20 at 20:26 +0200, Johannes Berg wrote:
> >=20
> > +static inline int
> > +arch_futex_atomic_op_inuser(int op, u32 oparg, int *oval, u32 __user *=
uaddr)
> > +{
> > +	u32 oldval, newval;
> > +	u32 *p =3D (u32 __force *)uaddr;
> > +
> > +	do {
> > +		oldval =3D READ_ONCE(*p);
> > +
> > +		switch (op) {
> > +		case FUTEX_OP_SET:
> > +			newval =3D oparg;
> > +			break;
> > +		case FUTEX_OP_ADD:
> > +			newval =3D oldval + oparg;
> > +			break;
> > +		case FUTEX_OP_OR:
> > +			newval =3D oldval | oparg;
> > +			break;
> > +		case FUTEX_OP_ANDN:
> > +			newval =3D oldval & ~oparg;
> > +			break;
> > +		case FUTEX_OP_XOR:
> > +			newval =3D oldval ^ oparg;
> > +			break;
> > +		default:
> > +			return -ENOSYS;
> > +		}
> > +	} while (!try_cmpxchg(p, &oldval, newval));
> > +
> > +	*oval =3D oldval;
>=20
> Wait ... this is also garbage, it should just be the switch() and then
>=20
> 	*oval =3D cmpxchg(p, oldval, newval);
>=20
> not the loop...

Err, no. But our uaccess.c implementation here also seems wrong and
should be more like this one?

OK I'm confused, but I think we need to clean up uaccess.c before
implementing this for real...


johannes

