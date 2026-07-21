Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51A96C4451C
	for <linux-um@archiver.kernel.org>; Tue, 21 Jul 2026 11:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oHHW7nX2/0Co9VfEwkSXj25ZJ+oDvMRUElhCYL6+uTc=; b=i0qrHCsGLBLTzIwuP+O+410DDI
	liiXppriGiSxBIi2rjt8IhAmMh8wWclHsLzClb7CpKDtJw2CU4Rdna2oGBTTxSMbdiOQ6sQqkgIMV
	XY82DiBuxoTx4IVgo0roDeKB2uvlllx+rn0caSPP8P08ZD9jNOggwm3LCOrRbhCB1eiGTSu/hXCxn
	De8gy+2feZwc1Nk67x6kYl/0x6lsZO7VCP7Rfou0+yMxcFccK8mipmGwiz9HTssJIiYKt2d+spxqx
	9GNoMfmTgOedoG8cK/pAgNcXsgsL4PvOpb7sK+thb0KfUG/A9brRu953352krXMaUibTCBNjDMt8N
	4rMBlEXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wm8Wc-00000009J33-26lq;
	Tue, 21 Jul 2026 11:20:38 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wm8Wa-00000009J28-3G9b
	for linux-um@lists.infradead.org;
	Tue, 21 Jul 2026 11:20:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=oHHW7nX2/0Co9VfEwkSXj25ZJ+oDvMRUElhCYL6+uTc=;
	t=1784632836; x=1785842436; b=vpg9CcaqLxFkbCVDqj8KGKdagHBzZ8DlCWHhZ9+JLzBuuKf
	Qy0I+73Ysyfq/eDfLW+0jfnz/WY6JfOMWwv/pyEjYd2l8NVPCiXe2wsLYhZAzzJKGR5gdgzrFEkie
	M4khl0AoFfDoS5SOAocJFqTeKY8ALGh7QBVnykpGV+v0EeodAzDZnWRIqvl1lBo1lYiiTscEBCjNS
	T4tN2FhWrpa4tU+7MABALO39ivFFDLwnpiYeqpaQAqv38pzlsdH5GPGNJdtFjuQG1SrLPGA3iSuzW
	JSi2veYe8Uo6XdHYl4qDeNm1Et8PIL02cZXA+BxtNeXiHSWKjYIwACpgAZvm00aQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wm8WU-000000020Bh-2CQq;
	Tue, 21 Jul 2026 13:20:30 +0200
Message-ID: <b7681544269644a65e2f64a96a00cdb86ed04d37.camel@sipsolutions.net>
Subject: Re: [RFC PATCH 0/6] um: introduce pidfd_mmap()/pidfd_munmap()
 syscalls
From: Johannes Berg <johannes@sipsolutions.net>
To: Cong Wang <xiyou.wangcong@gmail.com>, Richard Weinberger
 <richard@nod.at>,  Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Benjamin Berg <benjamin@sipsolutions.net>, linux-um@lists.infradead.org,
 	linux-kernel@vger.kernel.org
Date: Tue, 21 Jul 2026 13:20:29 +0200
In-Reply-To: <20260710205324.1343217-1-xiyou.wangcong@gmail.com> (sfid-20260710_225357_064327_367AF1B5)
References: <20260710205324.1343217-1-xiyou.wangcong@gmail.com>
	 (sfid-20260710_225357_064327_367AF1B5)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260721_042036_810916_3E78CFA3 
X-CRM114-Status: GOOD (  12.53  )
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

On Fri, 2026-07-10 at 13:53 -0700, Cong Wang wrote:
> This RFC adds two syscalls, pidfd_mmap() and pidfd_munmap(), that let a
> supervisor install or remove a mapping in another process's address space
> without target-side cooperation, and converts User Mode Linux to use them=
.

Seems simple enough, but I can't really comment on it.

> As this is an RFC, the UML side _intentionally_ does not handle host
> portability: it assumes a host kernel that provides pidfd_mmap() and
> deliberately omits any detection or fallback for older hosts (which would
> otherwise pick the ptrace path, or fail the seccomp probe). That belongs
> in a non-RFC version and is left out here to keep the series focused on
> demonstrating the impact on UML.

Makes sense for the RFC, but I think the fallback to seccomp as-is might
be useful still, we did see some benefit of seccomp and cannot
necessarily update the host kernels _that_ quickly. Maybe do that only
if forced by the user with seccomp=3Dinsecure or something, not pick it
with =3Dauto and fail with seccomp=3Don if it's not available? That'd be
good enough for us, and not really leave a potential security trap (that
we have now for people who don't read the docs ;) ).

johannes

