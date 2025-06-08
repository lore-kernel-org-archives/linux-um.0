Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BE52C5AD49
	for <linux-um@archiver.kernel.org>; Sun,  8 Jun 2025 18:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9bFddGz119OASHVVBIREKUQQhvueMQpXnAkmgLTGxHs=; b=hbSWGBd5O0zTpKQ7FP6tuyrl2D
	xuHKCit9hizlgZZewzm16J84yN23k0ctQzpbjlE96UmZ9/+jd6ZDG7GQkMw3mA08pfCzRpOoaUmWa
	hIgF5DEQouHTXarMftr1xl0ZSdBdQfz07VioSZvqK9x1iOXSwHJhszyM05CtfMTu+933KTLRlLTP6
	Q0LcABhucB6WkBFgJkIiWdSGf52ZnilcNWm7nMjqWWzRvrO5Ct4yqGQQML7Goe8VH+MIvAgGCqJnv
	dnY4uJAqFcYbnjtzhJFKWZ0nBIuZtaYI/JLIG7d/fybsP563fTw6I4MUF/nU4lui+W5Z3OKacGdDY
	0YJk6+4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOKut-00000002rYs-2iUK;
	Sun, 08 Jun 2025 18:38:47 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOKuq-00000002rXF-3wV2
	for linux-um@lists.infradead.org;
	Sun, 08 Jun 2025 18:38:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=9bFddGz119OASHVVBIREKUQQhvueMQpXnAkmgLTGxHs=;
	t=1749407922; x=1750617522; b=R6GRqaaCp5yBTNlqAPLWOikQ0gw8iPC3zVVXBMIfykN8Z+S
	S2cB69qfZ9uZDy5aAble81gPveCNNF/xvpBHNQ/rdNG9mVrofluKsdWeUbEOEGFkI1bRc3ziNpBCe
	oBei/rcpBw7oBamKUm8B7xfv/VdkhaUsKnbLFSwr1IY9cYthT6qGnEqYMYYNU9SyeXgEZLs8N+h3t
	oJtj7IKfj7fuqDau0L1mH6hmGlFRlT88NL/q68c7hmJs1AJ+SqokzvbS5YeBHrpmFLVclllES7oPx
	YJ+INQ+bRRtgAGzKHTsQWvBsjd9mb9viCFBOAp9aqR325furXQWELsIW+PDm8Bxg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1uOKue-0000000CrnI-0xs9;
	Sun, 08 Jun 2025 20:38:33 +0200
Message-ID: <6b4428e5ec42c926fcc9b6d2fdb9202fc6e87fe8.camel@sipsolutions.net>
Subject: Re: [PATCH] um: fix execve stub execution on old host OSs
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Yonting Lin <linyongting@gmail.com>, development@efficientek.com
Cc: linux-um@lists.infradead.org
Date: Sun, 08 Jun 2025 20:38:30 +0200
In-Reply-To: <20250607042248.87877-1-linyongting@gmail.com> (sfid-20250607_062301_404489_59405A7C)
References: <20250112140736.1fcb25c3@crass-HP-ZBook-15-G2>
	 <20250607042248.87877-1-linyongting@gmail.com>
	 (sfid-20250607_062301_404489_59405A7C)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250608_113844_999773_53C2EF0D 
X-CRM114-Status: GOOD (  12.73  )
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

Hi,

On Sat, 2025-06-07 at 12:22 +0800, Yonting Lin wrote:
> [SNIP]
>=20
> Sorry for my due enquiry, I don't want take a new thread with a patch.
> It is just a short question.
>=20
> Currently(119b1e61a769aa98e68599f44721661a4d8c55f3), there are three piec=
es
> of code calling to syscall __NR_close_range:
>=20
> # grep __NR_close_range -r arch/um/* -n
> arch/um/kernel/skas/stub_exe.c:73:		res =3D stub_syscall3(__NR_close_rang=
e, 1, ~0U, 0);
> arch/um/os-Linux/start_up.c:269:	if (stub_syscall3(__NR_close_range, 1, ~=
0U, 0))
> arch/um/os-Linux/skas/process.c:331:	syscall(__NR_close_range, 0, ~0U, CL=
OSE_RANGE_CLOEXEC);
>=20
> But my host kernel is 5.4 and fails to compile these pieces of codes beca=
use
> there is no this syscall in my older kernel.
>=20
> I was wondering if you are working on this issue. If not, I will try to=
=20
> make a draft solution to review.

I was not yet aware of that problem. Most likely only the one in
start_up.c is a problem for you. All the other ones probably pick up
the correct definition from the Linux tree already.

One can probably solve it by moving the code into another file. Or
maybe by adding an entry for __NR_close_range into common-offests.h and
using that.

Benjamin

