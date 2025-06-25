Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 619C7C7EE2A
	for <linux-um@archiver.kernel.org>; Wed, 25 Jun 2025 16:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SJ5NkjC+cOiMPwKXMdsR+3xgXJFhGnL3/wL1U2zUcWg=; b=uCHh3iHGqGrsyWWnNISh0hO8u3
	7bbd8dftb4GXEoqtk69LRVFKHCpZcC3f/RgaYgkjX1rvwXOCefCkQNy0ZmbyoRnJlwVlDH+kaNLBy
	pdjM0JdLdYPbgX7HttTvvZyGNktZ6s0lj+YRiMSg9JJvQxaltIVtRVWolvQzIc0+69CVROL3x0VYx
	vx/9kQg6GtFGhPAWqTg2iqpBGFuUb2Ka6q1iOrWu0WTztB8tdCNFFCPExNu1Le2MzkFwbiI8Rwjnh
	v28Lsl56feq8EWnfYocHYr0EwNbEroOR+vVanYqqtrE615/NMZocYK3hGcO55ti/d5X6mnXPLcJYr
	Ruf6DEnA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUT2i-00000009JT4-0dZ7;
	Wed, 25 Jun 2025 16:32:12 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUPAi-00000008c8B-3lHy;
	Wed, 25 Jun 2025 12:24:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=SJ5NkjC+cOiMPwKXMdsR+3xgXJFhGnL3/wL1U2zUcWg=;
	t=1750854252; x=1752063852; b=MN9Gy31nmfmEakoke2YfP1A50ZTyuhlKb0Cx3lelfP0Zaxj
	eL387tzqooQXuA+ffQ6CcAZcqgvCO6RweS7nRhXLG/hvHvnTZDUj4TQTGtgG7TMVUQkQzG0eJ2dN/
	I2SkU68+kAaLpV9WS3zHXFAD64mfHWgjJLj+zWadbnAKmPBmA9zevr6cgvTsCnBKaJUAj3qVuDSZc
	p3kahB09gue0YfuYh8fgeacKssMXV9XIfLqjoP6vMts+AbklvnX3a0Kv/hR3MickkqqL1LQ06j/g+
	I6j9qFGulQSD73OGIT9g7KhEOfim5wK/HWAGDSQ4l4QyUypCyw7fakG4YZJsJuSA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uUPAV-00000009xvR-1M4X;
	Wed, 25 Jun 2025 14:23:59 +0200
Message-ID: <81a8b60be5b99ecd9b322d188738016376aff4aa.camel@sipsolutions.net>
Subject: Re: [PATCH 2/9] kasan: replace kasan_arch_is_ready with
 kasan_enabled
From: Johannes Berg <johannes@sipsolutions.net>
To: Christophe Leroy <christophe.leroy@csgroup.eu>, Sabyrzhan Tasbolatov	
 <snovitoll@gmail.com>, ryabinin.a.a@gmail.com, glider@google.com, 
	andreyknvl@gmail.com, dvyukov@google.com, vincenzo.frascino@arm.com, 
	catalin.marinas@arm.com, will@kernel.org, chenhuacai@kernel.org,
 kernel@xen0n.name, 	maddy@linux.ibm.com, mpe@ellerman.id.au,
 npiggin@gmail.com, hca@linux.ibm.com, 	gor@linux.ibm.com,
 agordeev@linux.ibm.com, borntraeger@linux.ibm.com, 	svens@linux.ibm.com,
 richard@nod.at, anton.ivanov@cambridgegreys.com, 
	dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
 hpa@zytor.com, 	chris@zankel.net, jcmvbkbc@gmail.com,
 akpm@linux-foundation.org
Cc: guoweikang.kernel@gmail.com, geert@linux-m68k.org, rppt@kernel.org, 
	tiwei.btw@antgroup.com, richard.weiyang@gmail.com, benjamin.berg@intel.com,
 	kevin.brodsky@arm.com, kasan-dev@googlegroups.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
	linux-s390@vger.kernel.org, linux-um@lists.infradead.org, linux-mm@kvack.org
Date: Wed, 25 Jun 2025 14:23:57 +0200
In-Reply-To: <750b6617-7abf-4adc-b3e6-6194ff10c547@csgroup.eu>
References: <20250625095224.118679-1-snovitoll@gmail.com>
	 <20250625095224.118679-3-snovitoll@gmail.com>
	 <750b6617-7abf-4adc-b3e6-6194ff10c547@csgroup.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250625_052412_932909_ABCD4889 
X-CRM114-Status: UNSURE (   8.56  )
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

On Wed, 2025-06-25 at 12:27 +0200, Christophe Leroy wrote:
>=20
> Le 25/06/2025 =C3=A0 11:52, Sabyrzhan Tasbolatov a =C3=A9crit=C2=A0:
> > Replace the existing kasan_arch_is_ready() calls with kasan_enabled().
> > Drop checks where the caller is already under kasan_enabled() condition=
.
>=20
> If I understand correctly, it means that KASAN won't work anymore=20
> between patch 2 and 9, because until the arch calls kasan_init_generic()=
=20
> kasan_enabled() will return false.
>=20
> The transition should be smooth and your series should remain bisectable.
>=20
> Or am I missing something ?
>=20

Seems right to me, it won't work for architectures that define
kasan_arch_is_ready themselves I think?

But since they have to literally #define it, could #ifdef on that
temporarily?

johannes

