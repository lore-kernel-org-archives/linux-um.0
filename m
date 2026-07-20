Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FE0DC44520
	for <linux-um@archiver.kernel.org>; Mon, 20 Jul 2026 19:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nX+2U60NM/XmiYctNQ51boM9xzSnXq+D+nCd8hsQMxQ=; b=Kuo+BH54+7JQSf1QjKjPOsUNjR
	u25HogTr7lVNoLabwjfIYE/L+b7miYep81BIi7vRLZ3gyRBqf728u2VwmZIsjGExZfOfoGxdv+Zhf
	8JHuhkPToAvT4FXT80NQFgfFIs/ANNjyA1g+g9GMLbEH5TKak70D2JJfW0qeMTih86HAIH83jO+eG
	P/MDWfhRr71cQJOiWQUz/zLsK9GW6bbtIB1t0hHnr02DTfOIoBlqu1KRe/j/RomQ7ICkCtqXciXrJ
	m/oodRCqYGr9wwoK4biC5FuTA2AcVogWRUxG9Kfv5UtpSr+X3vVJ5O9hIUW7j5iHoVUC3Zch+ycZf
	UUpNhhyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wltJi-00000007ivj-3W4T;
	Mon, 20 Jul 2026 19:06:18 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wltJg-00000007ivF-3BY3
	for linux-um@lists.infradead.org;
	Mon, 20 Jul 2026 19:06:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=nX+2U60NM/XmiYctNQ51boM9xzSnXq+D+nCd8hsQMxQ=;
	t=1784574376; x=1785783976; b=JQTenH9bBKPpsJrPdjW0BWMrmp0c1oPK5gAfaSbI6eqWX9I
	qQP8wnzKpH0vBSxolcSusmzOBmGR8VTlx1QTJqKwWn19nJGay/Mto4EdL8gKjZ55YZPfKRxLFaw34
	xUSBhd6CPH03NtmzkdnSaqZLoqnOsJJI1jnWk/02Pal0Iik4tXRLjjlyWTkTlbBRUdDvXLxQQWIxy
	SYKX9ucpIiQL4pnDboY63orL0oRm/AuUVtq5yIKuMQM8gd2NKaOyIEeNzYvHLUgXZXQBuV9thBpMq
	n3hmALC1yAQc8q9cfQCqSYs2Ujd5y3Uu0/8Ifj90SfSqwGrjyoI/cELHod9mbIBA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wltJd-0000000Gsxw-3Zp6;
	Mon, 20 Jul 2026 21:06:14 +0200
Message-ID: <c88c02961cb99d80ef1a0e88d321b5f86bd5eae1.camel@sipsolutions.net>
Subject: Re: [RFC PATCH 7/9] um: nommu: add SMP futex operations
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Hajime Tazaki <thehajime@gmail.com>
Date: Mon, 20 Jul 2026 21:06:13 +0200
In-Reply-To: <20260720205103.4b4ce01cd017.I0a83e5ca6be6c95a81d4b2ec69677bbea5889d7d@changeid>
References: <20260720185103.530603-11-johannes@sipsolutions.net>
	 <20260720205103.4b4ce01cd017.I0a83e5ca6be6c95a81d4b2ec69677bbea5889d7d@changeid>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260720_120616_797194_20A849C5 
X-CRM114-Status: UNSURE (   9.68  )
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

On Mon, 2026-07-20 at 20:26 +0200, Johannes Berg wrote:
>=20
> +static inline int
> +arch_futex_atomic_op_inuser(int op, u32 oparg, int *oval, u32 __user *ua=
ddr)
> +{
> +	u32 oldval, newval;
> +	u32 *p =3D (u32 __force *)uaddr;
> +
> +	do {
> +		oldval =3D READ_ONCE(*p);
> +
> +		switch (op) {
> +		case FUTEX_OP_SET:
> +			newval =3D oparg;
> +			break;
> +		case FUTEX_OP_ADD:
> +			newval =3D oldval + oparg;
> +			break;
> +		case FUTEX_OP_OR:
> +			newval =3D oldval | oparg;
> +			break;
> +		case FUTEX_OP_ANDN:
> +			newval =3D oldval & ~oparg;
> +			break;
> +		case FUTEX_OP_XOR:
> +			newval =3D oldval ^ oparg;
> +			break;
> +		default:
> +			return -ENOSYS;
> +		}
> +	} while (!try_cmpxchg(p, &oldval, newval));
> +
> +	*oval =3D oldval;

Wait ... this is also garbage, it should just be the switch() and then

	*oval =3D cmpxchg(p, oldval, newval);

not the loop...

> +	/* FIXME - shouldn't it be *uval =3D cmpxchg()? */
> +	*uval =3D *p;
> +	cmpxchg(p, oldval, newval);

And yes, I think the FIXME is right and our uaccess.c implementation is
wrong.

johannes

