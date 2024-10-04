Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00B15CF8840
	for <linux-um@archiver.kernel.org>; Fri,  4 Oct 2024 17:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:To:From:
	Subject:Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OzIuS+hqMR4Y+Ao7/LfzYi8jgJf2KYFXR8G7/TIUoC4=; b=HixJZ6AtEVGJvyzb4jWWYyI6ax
	9KPiStb27J+UPoBfv79TcEBREi3d6vJqCJJf6wGLQWOmh7bsxRFQCnSGAcwJCZbQwyi9d8ZGnyReX
	0w3J2NXi7SjcpMqKeu2ql/GqemXaZXxBpAopi9A3cp7SvHDSqvSmqMB2ykRZYZTVJ6QWEa65xeopD
	zNEhF33tyPVnMNbxVSZNMjFna1mc1DT6y98SulnEdVrXHl+JS5JpFjwWgn429QU+BJ908amXvpid2
	X81SDa4qQDJqwF5VxTCz4VWw94ropKNobQB8a+YSA1mZBXez/vEE8/OpFJKViaZeCyEW19hPyKc9V
	a9RSthkQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1swls3-0000000DTJo-1hVz;
	Fri, 04 Oct 2024 17:13:39 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1swlOZ-0000000DJMk-46ZE
	for linux-um@lists.infradead.org;
	Fri, 04 Oct 2024 16:43:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=OzIuS+hqMR4Y+Ao7/LfzYi8jgJf2KYFXR8G7/TIUoC4=;
	t=1728060189; x=1729269789; b=BfpHvM6pAGlHifWQg7/wTCqcdMXeavE+Lqwza5cZpD2FZ8u
	v4+jW1vZzxrMMnlvQihbiYxqj4Fx+b/HVh2X+AwDxoZJ8UXh6RiVcR9I9wid1vKc9OvChzFkGw3Hj
	gikLrJRFtXpRWMuK/cxzkN9QWn5+uB5vFsOd/2TMUQplGEJD4TsPzEbuLIi0YXChtyWD2vTy9lC+F
	tGGxFuvNsdM7rLEDRUtmzPzZvG8OXoCXkrAjkoIejZ7tMfzUSxtE0LS177p7atXALvNEvGtMHQ+7E
	P628fsGXb13OH0Q0RUOCqnggfbg6VS5gEEGBh2/MBSnY9jL8amsyCy7aSW5IGAUw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1swlOU-0000000HYjD-09YQ;
	Fri, 04 Oct 2024 18:43:06 +0200
Message-ID: <d75d12337dc0dd2ccc83c673ec1c40591bd0d581.camel@sipsolutions.net>
Subject: Re: UML not coming up on "INTEL(R) XEON(R) GOLD 6542Y"
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Vijay Tandeker <vijayt@tejasnetworks.com>,
 "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>
Date: Fri, 04 Oct 2024 18:43:04 +0200
In-Reply-To: <dd55019aced367702379b5ac7e436911d32e06a5.camel@sipsolutions.net>
References: <0fbafcb07dff42eb8dfc9a98c8211f85@tejasnetworks.com>
	 <dd55019aced367702379b5ac7e436911d32e06a5.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241004_094312_049558_EEDF31AF 
X-CRM114-Status: GOOD (  20.27  )
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

On Tue, 2024-09-17 at 10:08 +0200, Benjamin Berg wrote:
> if it is really only on that CPU, then maybe it is related to AMX
> support? Though, not sure how exactly that might be affecting
> PTRACE_{S,G}ETFPREGS on x86_64.

Just, FYI, it really cannot work if the host kernel has AMX enabled.
The reason is that PTRACE_SETREGSET on NT_X86_XSAVE expects that the
passed buffer has the maximum theoretical size (I suppose even if the
feature isn't even enabled for the process).

Seems like the only way to make this work is to discover the xstate
size from the host kernel. I guess by passing a very large buffer to
PTRACE_GETREGSET and checking the iovec for the filled in length.

I think you can work around it by setting
  clearcpuid=3Damx_tile
on the host kernel command line.

Benjamin


> On Mon, 2024-09-16 at 13:09 +0000, Vijay Tandeker wrote:
> >=20
> >=20
> > Hi, thanks to all for helping me in the past. I need one more help.
> > Getting the below error on running UML:
> > -------------------------------------------------------------------
> > --
> > -------------------------
> > Run /sbin/init as init process
> > userspace - ptrace set fp regs failed, errno =3D 14
> > Kernel panic - not syncing: Attempted to kill init!
> > exitcode=3D0x0000000b
> > CPU: 0 PID: 1 Comm: init Not tainted 6.8.9-1 #1
> > -------------------------------------------------------------------
> > --
> > -------------------------
> >=20
> > Searched on the internet but didn't find any solution. Any idea,
> > what
> > could be the reason for the above error? Below are my UML details:
> > 1) root-fs: created by running the command: =E2=80=9Cdebootstrap --
> > arch=3Damd64
> > noble /tmp http://archive.ubuntu.com/ubuntu/=E2=80=9D
> > 2) Linux: created by running the command: "ARCH=3Dum make -j$(nproc)"
> > on linux-6.8.9 using defconfig.
> > 3) Attached file <uml_crash>: logs on running the UML
> > 4) Attached file <system_info>: my host system details
> > 5) INTEL(R) XEON(R) GOLD 6542Y
> > 6) RAM: 256 GB
> > 7) Ubuntu 24.04.1 LTS
> >=20
> > Please let me know if you need more information.
> >=20
>=20
>=20
>=20


