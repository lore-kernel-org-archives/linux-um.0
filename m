Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41F70C35FF2
	for <linux-um@archiver.kernel.org>; Tue, 17 Sep 2024 08:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:To:From:
	Subject:Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ff5UJtPKYhLN9EnYho+AvMJ64FTIVHBFwCNp03OVc2c=; b=aETyVoCeJ52pq6x/rJXtslLGkC
	FoAe9Wr8Vt3AM3qxj+ZO4iEB9Au1AxdDfzF22fkySCnJY7cM97tzGd7ocgfF/ulWFqSw8YbJnP0ry
	cHJHehRKXSsc+mnxgFPrcBeKUi6n5A4OfeBFR5VahcudC3aSGG3VPyLorUGwBsG7wY1HrEulnFoUq
	97ltSDoJLt4EpAVznheOfIjnYy1bzSPCa8/3Pmq6AXSgvXPQ+VPqbsDZtWnDm/57IZCfl9sbenOxQ
	RLie75ZXhHGZY7Q8EyKj3yNjYGPW4Uf9ELFdlwD64py88v3VbPNElZJUFRjBM6HBaBEAXPgKU5ddX
	EDzoSE7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sqTGd-00000005eoS-0WaF;
	Tue, 17 Sep 2024 08:08:59 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sqTGa-00000005emI-0Lq4
	for linux-um@lists.infradead.org;
	Tue, 17 Sep 2024 08:08:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Ff5UJtPKYhLN9EnYho+AvMJ64FTIVHBFwCNp03OVc2c=;
	t=1726560534; x=1727770134; b=c6QSMJbNa12OWEr+iGJrYBMGwfel2voFxGn01h9aH1NYjP8
	6bRo/OjVtW1rFpli+G2qtfk2vWertgY4Kr7kKBGi+FnIMh0SygH4sMsAYD++z1IjcppZ0DHV4yQmX
	NHkTB7XpNUcVN2uts7sM5R5i19mhKvYIhQkOWFrbeR/gb8BJPi5UPMOkmyMd8a9PrRhW/OUyd/15c
	7gNB0lIwHU5gg4FmhWSFIjeLVYM7aZGFZ3j4ZbtywPzwu2zIqU5A2BE2BJhF/2ZUO1eENDzUUDrRq
	+1X507bLwpba3kSacKhSQ29w4Npevd0XBvnWwBhiye8sAi8YdVWkvIStjj36VcxQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1sqTGU-0000000Dzds-2UWA;
	Tue, 17 Sep 2024 10:08:51 +0200
Message-ID: <dd55019aced367702379b5ac7e436911d32e06a5.camel@sipsolutions.net>
Subject: Re: UML not coming up on "INTEL(R) XEON(R) GOLD 6542Y"
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Vijay Tandeker <vijayt@tejasnetworks.com>,
 "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>
Date: Tue, 17 Sep 2024 10:08:48 +0200
In-Reply-To: <0fbafcb07dff42eb8dfc9a98c8211f85@tejasnetworks.com>
References: <0fbafcb07dff42eb8dfc9a98c8211f85@tejasnetworks.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240917_010856_161621_2E9350D4 
X-CRM114-Status: GOOD (  11.86  )
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

if it is really only on that CPU, then maybe it is related to AMX
support? Though, not sure how exactly that might be affecting
PTRACE_{S,G}ETFPREGS on x86_64.

Benjamin

On Mon, 2024-09-16 at 13:09 +0000, Vijay Tandeker wrote:
>=20
>=20
> Hi, thanks to all for helping me in the past. I need one more help.
> Getting the below error on running UML:
> ---------------------------------------------------------------------
> -------------------------
> Run /sbin/init as init process
> userspace - ptrace set fp regs failed, errno =3D 14
> Kernel panic - not syncing: Attempted to kill init!
> exitcode=3D0x0000000b
> CPU: 0 PID: 1 Comm: init Not tainted 6.8.9-1 #1
> ---------------------------------------------------------------------
> -------------------------
>=20
> Searched on the internet but didn't find any solution. Any idea, what
> could be the reason for the above error? Below are my UML details:
> 1) root-fs: created by running the command: =E2=80=9Cdebootstrap --arch=
=3Damd64
> noble /tmp http://archive.ubuntu.com/ubuntu/=E2=80=9D
> 2) Linux: created by running the command: "ARCH=3Dum make -j$(nproc)"
> on linux-6.8.9 using defconfig.
> 3) Attached file <uml_crash>: logs on running the UML
> 4) Attached file <system_info>: my host system details
> 5) INTEL(R) XEON(R) GOLD 6542Y
> 6) RAM: 256 GB
> 7) Ubuntu 24.04.1 LTS
>=20
> Please let me know if you need more information.
>=20


