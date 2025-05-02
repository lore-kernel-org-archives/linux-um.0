Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 757C6C3ABAC
	for <linux-um@archiver.kernel.org>; Fri,  2 May 2025 16:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:To:From:
	Subject:Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=38IRzZm7ln5EXeQ4MdJYM1ZNw25TCcB1wHws9NuMglk=; b=BsWR/1dE0Noo0KzEgbjha7+ToV
	87U6iWMjXasJQ4ubDse9q72DPBCcgXgcMSTJmRrZsloqR6icFpTKTf/pvUo8yLPAap23Xic+SqoIj
	2Sse5BusjGo0JmPJANNXG7VnSEcvgbFv7kMRabMwDxsvIx9Nos9ZdiAhVHK6exc+n7zs/VxHix73Q
	K1Iy+LxFbUm//TJhy+cvVgwUsiAZnbEzSQWG9sSFwRyrq/DQN8d1QDdw1kJmflxr/YyPNxtcATpFs
	0wD65oNNsukEt0qkw4Fq/v3G9SvBNNYGXdS7FXo0GIKVahsmYQIPN2rsKiBWem/ihRKzWbFoniqe6
	6Mk1dJsw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAsxf-00000002SHQ-0vuN;
	Fri, 02 May 2025 16:10:03 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAsxc-00000002SFo-1L1V
	for linux-um@lists.infradead.org;
	Fri, 02 May 2025 16:10:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=38IRzZm7ln5EXeQ4MdJYM1ZNw25TCcB1wHws9NuMglk=;
	t=1746202198; x=1747411798; b=JuCI9bid5mLxYQGXVG4HCWbzbK9OEQPZBiaNKUrLpPShQ6d
	20+NFvN0j0cuqBxDGar8WawkbkV/GcDgZDA/8ksoDXGEvhNvgvDJM9Ji2iXlpzb/byS1QtjpIbRyT
	jRQYmh5WeBLPwcuaueYmQ8WCTYeA7U9ufFShSu17OmyEeC+3FlaKFkUrTKW2CjJOkIsJkWktiulDV
	dGytkFLxBaf3yFHabLiebqR1JcrseCOmQCBBQXhSAH7nl5FCOPEz5Tp1cb0Mg//G1feQs+R8olleV
	FRZoOgj+VQJwd+QmDPskO8ApUojXJQVLW9JDxB3QReqVKGrtq4BiBAMZgUrYsIag==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uAsxW-0000000GREw-32op;
	Fri, 02 May 2025 18:09:55 +0200
Message-ID: <62bd586a078ff81ca8cdf4db66f548489f3a3535.camel@sipsolutions.net>
Subject: Re: [PATCH] um: Merge os-Linux/drivers/ into drivers/
From: Johannes Berg <johannes@sipsolutions.net>
To: Anton Ivanov <anton.ivanov@cambridgegreys.com>, Thomas Meyer
	 <thomas@m3y3r.de>, linux-um@lists.infradead.org, Tiwei Bie
	 <tiwei.btw@antgroup.com>, richard@nod.at
Date: Fri, 02 May 2025 18:09:53 +0200
In-Reply-To: <7f55fde9-9753-42b4-856f-2e22a29a555b@cambridgegreys.com>
References: <20250502083152.3791637-1-tiwei.btw@antgroup.com>
	 <2E84324B-747A-4216-804B-921A7AA2F29F@m3y3r.de>
	 <7f55fde9-9753-42b4-856f-2e22a29a555b@cambridgegreys.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250502_091000_360602_A4E2C58A 
X-CRM114-Status: GOOD (  10.41  )
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

On Fri, 2025-05-02 at 10:08 +0100, Anton Ivanov wrote:
>=20
> On 02/05/2025 09:35, Thomas Meyer wrote:
> > Hi,
> >=20
> > Aren't those drivers under exactly this folder because those drivers wi=
ll work only with when the host OS is Linux? I mean this is all hypothetica=
l but when somebody is going to implement UML under Mac OS, this layout won=
't work anymore, or do I err?
>=20
> Yes indeed.
>=20
> However, we have plenty of linux specific dependencies throughout nowaday=
s: EPOLL, vhost-net, etc.
> PTRACE usage is probably OS specific too. SECCOMP. And so on.
>=20
> The original idea to keep Linux dependent stuff under os-Linux is no long=
er realistic.
>=20

Indeed. Also, there's really no need to have that anyway - there are
plenty of drivers that only work on some architectures, and these ones
are anyway going to depend on UM. They could depend on a hypothetical
UM_LINUX_HOST in the future instead?

johannes

