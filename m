Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 314BEE6896D
	for <linux-um@archiver.kernel.org>; Thu, 31 Oct 2024 10:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:To:From:
	Subject:Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IfgIq+Icsm2SWoAvxs4amvLlgkYlYtcjhSVj1YhtFms=; b=bvne3s8ThvvEmEGx7wVKJWeLnP
	kmU6wYgvDvGi7sZYKeUmOqArpKPO1u/f1Fuj/cVaamKppCXNnt36QH0V6xsZao2rVPi21+fTD5SIR
	DV6PLHpU4pbyE5GrjKHHa5TBTASM+PxFz9Hoj6cyRpLm+8/CvL9mArM7sz3egtRsHm26Ou+TOFjW9
	lnb/krfXi+QUw8opVjQ/cEUKPjlMhTM7RbcUVm93lIxCgEg0semA2U7waRTIEibR8Z+oiVm07Ltxk
	QXnnKUDf+6q7EeanWUtj6Dw8hWJbkHtdjKsdTq5EE3UVvSm9QrrCR2p5hhsCiTz9v4h4CXAD2LBIW
	UUTob6Rg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t6S6J-00000003BNX-0eaH;
	Thu, 31 Oct 2024 10:08:23 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t6S60-00000003BHr-3knD
	for linux-um@lists.infradead.org;
	Thu, 31 Oct 2024 10:08:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=IfgIq+Icsm2SWoAvxs4amvLlgkYlYtcjhSVj1YhtFms=;
	t=1730369284; x=1731578884; b=YJJxWKKY1No/WwFJ1qXWvY/QTvzIABn8SAgdyahASf9nHHq
	S290pTZD63HTRnI+zBBt7BE4VcK/Hotu5TQ4d9qaizJFgM5goZF4LsLWPPHtAtKiU6fhdLPAM4u/h
	6JHZb6TVr8l3YZpNcP+2kbyd2XVWrzq3bCAfrFNdtEUGSySSsSLIKcaFMOmbIxe3liP73OUuVz3Pm
	n0EXYiH1txCG1PYKCnsZnoYs8Ob5z2rj/IdA3k2SyWoduuCUhMZ7JV7BlMlWVUljb65MS2AOw9S+C
	RCLcTCAEdlGfshAEX8g52UL4ZMIKCIbUGXjFFx7X3y3rzakRKNQDzx1HxQ6wiPfg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1t6S5y-0000000AOJr-19T4;
	Thu, 31 Oct 2024 11:08:02 +0100
Message-ID: <2ea3c5c4a1ecaa60414e3ed6485057ea65ca1a6e.camel@sipsolutions.net>
Subject: Re: UML mount failure with Linux 6.11
From: Benjamin Berg <benjamin@sipsolutions.net>
To: rrs@debian.org, linux-um@lists.infradead.org
Date: Thu, 31 Oct 2024 11:07:58 +0100
In-Reply-To: <857ff79f52ed50b4de8bbeec59c9820be4968183.camel@debian.org>
References: <857ff79f52ed50b4de8bbeec59c9820be4968183.camel@debian.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241031_030804_952862_42C23DD5 
X-CRM114-Status: GOOD (  16.38  )
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

Newer kernels have become more picky about that with the new mount API.
This is relevant, see the discussion about "Unknown options":
  https://lwn.net/Articles/979166/

We only use hostfs for the root file system and in that case it works
well if you pass the path using "hostfs=3D/path" on the kernel command
line. Doing that avoids issues when remounting the file system later
on.

I suppose that currently it does not work to mount hostfs later on. No
idea what the right fix is. Maybe the host directory should be an
explicit option like "hostpath=3D..." or so to make it compatible with
the new mount APIs.

Benjamin

On Wed, 2024-10-30 at 13:43 +0530, Ritesh Raj Sarraf wrote:
> Hello,
>=20
>=20
> Recently I updated the UML package to Linux 6.11 in Debian. Upon it,
> it
> reports the below regression wherein UML cannot mount file systems of
> type hostfs
>=20
> We have it reported on the Debian bug tracker as well.
>=20
> * https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D1086194
>=20
>=20
> The mount failures report as:
>=20
> ```
> Oct 30 05:57:41 uml systemd[1]: Mounting usr-lib-modules.mount -
> /usr/lib/modules...
> Oct 30 05:57:42 uml systemd[1]: usr-lib-modules.mount: Mount process
> exited, code=3Dexited, status=3D32/n/a
> Oct 30 05:57:42 uml mount[814]: mount: /usr/lib/modules: fsconfig
> system call failed: hostfs: Unknown parameter '/usr/lib/uml/modules'.
> Oct 30 05:57:42 uml mount[814]:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 dmesg(1) may have more
> information after failed mount system call.
> Oct 30 05:57:42 uml systemd[1]: usr-lib-modules.mount: Failed with
> result 'exit-code'.
> Oct 30 05:57:42 uml systemd[1]: Failed to mount usr-lib-modules.mount
> - /usr/lib/modules.
>=20
> ```
>=20
> As I understand it, the issue was first seen in July, around 6.11
> rc1.
>=20
> *
> https://lore.kernel.org/all/CAHk-=3DwjH5uKPB6xrWoB8WkBMuLEJO2UsidKE1wV8XS=
XjAUFO8Q@mail.gmail.com/
>=20
>=20
> Thanks,
> Ritesh
>=20


