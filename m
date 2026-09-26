Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83089C98318
	for <linux-um@archiver.kernel.org>; Sat, 26 Sep 2026 09:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WSCWhK1gKyhlGAlTAcNkQ2dJ3yeDn7O4Y/TX1rbqycg=; b=Yz3iP0fwqzGHhnD4mCsMRnDgCf
	TnwT1EAMz19VSDF/gd2rlryLbc0BQhpK2OHcVdIQaUCDr5jhXJrwg4EGAyoGfkL59+eSEw8n++hgG
	fKuAPZHHujjJ5ikd7vfVSlgx59sCD+/MFAsD7XaLitHe1xIopVbQqOCJIZczqISMg/qvYfbpic4L9
	/3dyGvIURv14urefDN2Y9KZ9lwFuIItU1jYkhKVSNa11aByLmKCHth0GRQ3kIWpHnoaHjlFZTnUtc
	0FsmcXCvdA+JHgGfcgSp8zVA/3VSXOFL38EDrscH7/Nc9T8oKMz4XiweINVLbCc0kDMkg+tb38jZx
	i9DYJr9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xAOWt-0000000FBvB-3vil;
	Sat, 26 Sep 2026 09:17:11 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xAOWp-0000000FBtu-247H
	for linux-um@lists.infradead.org;
	Sat, 26 Sep 2026 09:17:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=WSCWhK1gKyhlGAlTAcNkQ2dJ3yeDn7O4Y/TX1rbqycg=;
	t=1790414227; x=1791623827; b=rVYKrpPcFKj28VNMQF8c34LvMDlT2rC+irEF5QgaAwBMM2g
	Fb76MKbJJ/qY0FPzmt0+00VuUJsQ2qqu37ca4y0rOUp8gFF/+NPMgzyEgkAuKWfbSgKcKpWW0PQhY
	ADEb06WGbCBsDhuw/NHOjKaLqXzfYgRIfxZTZ9S0jAC3T4Fr9XvoZ1A1DnJdeN5v7QbZvFqAj14Lp
	EodDIFyQET02+9ODS0mYUc2nRZLB2KixH+0RdYS1uLOz/tZ1o+kx1JhiDX8PRc6VuUFDrRFDt6YKK
	+aWdwoCwEy+VNJPjE2yQqT3p7oZezVeKUEGvmZukqDqCvounH1czOV+GKRWsZp1Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1xAOWf-0000000B5IL-2VuK;
	Sat, 26 Sep 2026 11:16:57 +0200
Message-ID: <4a99ab637eb8fbe6d72d788ddc0d2e141e7c9821.camel@sipsolutions.net>
Subject: Re: [PATCH] um: mprotect() __init memory
From: Johannes Berg <johannes@sipsolutions.net>
To: Hajime Tazaki <thehajime@gmail.com>
Cc: linux-um@lists.infradead.org
Date: Sat, 26 Sep 2026 11:16:56 +0200
In-Reply-To: <m24ifc4v6m.wl-thehajime@gmail.com> (sfid-20260926_041255_844241_7AADBB53)
References: <20260921122937.3821fec01e82.Ib959ff1baad7a45e2b804209b530040e69e4b046@changeid>
	 <m24ifc4v6m.wl-thehajime@gmail.com> (sfid-20260926_041255_844241_7AADBB53)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260926_021707_817767_4226C8D4 
X-CRM114-Status: GOOD (  12.90  )
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

On Sat, 2026-09-26 at 11:12 +0900, Hajime Tazaki wrote:
> Hello,
>=20
> I recently pulled uml/next branch and faced an issue on the exit.
>=20
> ```
> Thread 1 "vmlinux" received signal SIGSEGV, Segmentation fault.
> 0x0000000060003cf3 in start_uml () at ../arch/um/kernel/skas/process.c:41
> 41      }
> (gdb) bt
> #0  0x0000000060003cf3 in start_uml () at ../arch/um/kernel/skas/process.=
c:41
> #1  0x0000000060003a69 in linux_main (argc=3Dargc@entry=3D9, argv=3Dargv@=
entry=3D0x7fffffffe118,
>     envp=3Denvp@entry=3D0x7fffffffe168) at ../arch/um/kernel/um_arch.c:40=
4
> #2  0x00000000600049dc in main (argc=3D9, argv=3D0x7fffffffe118, envp=3D0=
x7fffffffe168)
>     at ../arch/um/os-Linux/main.c:153
> ```
>=20
> and bisected that this commit is the first rev to introduce this.

I didn't get that, hmm.

> indeed, now .text section is in __init label but some of startup code
> (start_uml, linux_main) remain un-returned even after init is done.
>=20
> a quick change below avoid this issue, but not sure if it is your
> intention of the original patch.

No, clearly not - we shouldn't execute __init code after init either :)

So I guess we found a but elsewhere, but I don't immediately see what
needs to be not marked __init, clearly linux_main() is still used on the
way out so that must be, but ...

Or we could mprotect(..., 0, 0, 1) internally on the way out again,
since really _while_ running we also shouldn't be in __init code, it's
just a side effect of how UML shuts down?

Got a config or so? I really don't see this.

johannes

