Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83EDFD69105
	for <linux-um@archiver.kernel.org>; Thu, 28 Nov 2024 12:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1fdMBII0YIecx9BgjS6+RL2RExw4PaItvLvWv4UXsTU=; b=UJgwVCnnhgDimhDI0rgKgz3qUn
	PVVAa97+On3E+F7RIHmuD8ga946PznF7fjiFkH0VHXt3q1lMUciyG4PhkXZ4pXjjFnQjfd3epR+qU
	HhT6htYS3Ck1S/DXKFBDH1L+iimywS+v4kAdtm+rJFJyRUM/HRO2t3iI/XTrj5JhRxi6E8CT/hjns
	lPEuqxfitPP0QNjZF6OUmgZSaQH+jJatU2fiHWBXmfLLxd2s7FPvkcZ70ZTLyeXZF8UmfR0DoGwYV
	uxuPN33S1KmZ2Tmc1vf4N4qbbPDeo3md9tYj8G0E8HlYbt0t/EaFG8tXYPG60SUhBarGWADOCUbB/
	uX/oANNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tGe3t-0000000FYyI-0KcJ;
	Thu, 28 Nov 2024 12:56:01 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tGe3q-0000000FYwu-3SpG
	for linux-um@lists.infradead.org;
	Thu, 28 Nov 2024 12:55:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=1fdMBII0YIecx9BgjS6+RL2RExw4PaItvLvWv4UXsTU=;
	t=1732798556; x=1734008156; b=Yt1FlSFNj92DO52aAiQjBA0CesGD2YUaXK0oYA7hZzLNLEe
	CRCQEiZxDGrIkBrb4eQtvj9evHpQayzdRG5NOb1DCGBB+Vt6cEMlOWzLJi82DfxQzQTq8AXAymOmK
	8Tx6/3ZGZZFRd+d7dnH2TOSoRJiVhZwtRQrIwi3z5gS28wbgDCZ4CR3D2hZwHLmkhllAORM91JUBM
	U0cHSETuAGEAnw4QWRitEBFRHiyLBYRFvNkVHUhCasEC/IRkKPtpI8UqYt5YssAfhu/NriKwDbS8k
	q1BKUqC+ymmF6gdMxPmrSMCdaMbOb6GG90mubmedn2LHvdpo0jfgLjr+AcfABA8Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tGe3g-00000000D12-1x0E;
	Thu, 28 Nov 2024 13:55:48 +0100
Message-ID: <2fb819b00563afbeb69c156b463dd41335c430b6.camel@sipsolutions.net>
Subject: Re: UML mount failure with Linux 6.11
From: Johannes Berg <johannes@sipsolutions.net>
To: Karel Zak <kzak@redhat.com>
Cc: Hongbo Li <lihongbo22@huawei.com>, linux-um@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
 Benjamin Berg <benjamin@sipsolutions.net>, rrs@debian.org
Date: Thu, 28 Nov 2024 13:55:47 +0100
In-Reply-To: <c7hrptra3k6g6jwemz3h5gp4syyz4bttpnepdhpa33htnrltxu@iuusct5yzaso>
References: <ac1b8ddd62ab22e6311ddba0c07c65b389a1c5df.camel@sipsolutions.net>
	 <b0acfbdf-339b-4f7b-9fbd-8d864217366b@huawei.com>
	 <buizu3navazyzdg23dsphmdi26iuf5mothe3l4ods4rbqwqfnh@rgnqbq7n4j4g>
	 <9f56df34-68d4-4cb1-9b47-b8669b16ed28@huawei.com>
	 <3d5e772c-7f13-4557-82ff-73e29a501466@huawei.com>
	 <ykwlncqgbsv7xilipxjs2xoxjpkdhss4gb5tssah7pjd76iqxf@o2vkkrjh2mgd>
	 <6e6ccc76005d8c53370d8bdcb0e520e10b2b7193.camel@sipsolutions.net>
	 <5e5e465e-0380-4fbf-915d-69be5a8e0b65@huawei.com>
	 <uppzc2p5bn6fhrdlzzkbdrkoigurkii5ockigngknm4waewl5z@z2a6c6iivu7s>
	 <f565e434afc84090ffd7bff69ce9cf5643302233.camel@sipsolutions.net>
	 <c7hrptra3k6g6jwemz3h5gp4syyz4bttpnepdhpa33htnrltxu@iuusct5yzaso>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241128_045558_862610_D1EB6BF8 
X-CRM114-Status: GOOD (  24.17  )
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

> > I'd argue though that this doesn't count as fixing the regression, sinc=
e
> > the kernel was fine before the changes there (even before porting hostf=
s
> > to the new API) with _any_ version of userspace. Except perhaps for whe=
n
> > there's a comma in the path, which I suppose would've broken one way or
> > the other by mount(8) moving to the new API?
>=20
> Another option is to hardcode a libmount exception that, for hostfs,
> the default behavior should be to use the classic mount(2) syscall if
> the hostfs=3D option is not present.

I'm not sure using the old mount API would work because the kernel
converted internally to the new one now. Anyway it'd still be a kernel
regression if we have to fix it in userspace, no? :)

> > Assuming no commas, would mount(8) today send the path as the key to a
> > flag option?=20
>=20
>  Yes, (I have no hostfs here, so example with ext4):
>=20
>  # strace -e fsconfig mount -t ext4 -o /home/hostfs none /mnt/test
>=20
>  fsconfig(3, FSCONFIG_SET_STRING, "source", "none", 0) =3D 0
>  fsconfig(3, FSCONFIG_SET_FLAG, "/home/hostfs", NULL, 0) =3D -1 EINVAL (I=
nvalid argument)

So I guess that means for paths without comma (almost certainly the
overwhelming majority) we could somehow work around it in the kernel.
Hongbo, what do you think?

> > We could perhaps find a way to handle that in the kernel,
> > and then just do the longer-term plan of moving users to hostfs=3D"..."
> > (by documentation/warning) in the future?
>=20
> The question is whether investing time in using the path-as-key
> approach makes sense. Perhaps it would be better to stick with the old
> mount(2)

I think it's a matter of not regressing for users, if they just update
the kernel and have old or existing mount tools. And I'm not convinced
using the old API will actually fix the issue, I think maybe the kernel
itself would break that too by parsing it now for the new API?

> and focus on developing a new API that does not have any
> legacy issues. Users who choose to use the hostfs=3D option and the new
> kernel will be able to utilize the new API.

Right, but we already have that - you can specify hostfs=3D"quoted path"
when everything is new and it'll work just fine?

Question is more around the regression, to me.

johannes

