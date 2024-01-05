Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C019C3DA6E
	for <linux-um@archiver.kernel.org>; Fri,  5 Jan 2024 13:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:References:In-Reply-To:Message-ID:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iQk2XLhF9BeCDwKseCnKpn4cB14xh9423iQVivqel7c=; b=OG5SrFEQvyJzHenZo4u9Zg5FMR
	LL6gX5dCn/RI/t1ewHdJ5pADs+VwxsOe5FRK7OctjRw/p2+uDcEUSVw/s1XtIWqMhFQofWbOvEtiK
	vUnAwoqC7Tdf2Ztwy9gMPtVasrvs7fu1RVWS1LSc2yzz12fgSEpSwl4Ow2PaTrN94sEAgWEwNCsx/
	rfp2BuZcShfUpOqHAR5kE8UgLVueL/Pz0TfK9428PTPFoInTF5FMqgqGZy3wfrI4/cl7ZPvy/YQ2m
	AKTPPQIR/milIzBq1+0KHqLvNotHgGuKwnkq991CW6iSOzlKUp9Wx3QN4bIokQbSG5RxkEP98tl51
	8OOTX1mQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rLkH2-00Gy3K-08;
	Fri, 05 Jan 2024 13:30:08 +0000
Received: from lithops.sigma-star.at ([195.201.40.130])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rLkGy-00Gy1w-0p
	for linux-um@lists.infradead.org;
	Fri, 05 Jan 2024 13:30:06 +0000
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 81551626FAE4;
	Fri,  5 Jan 2024 14:29:56 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id cL9c2lENbU2l; Fri,  5 Jan 2024 14:29:55 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id D8E726343B33;
	Fri,  5 Jan 2024 14:29:55 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 5nUPE1HnGPSG; Fri,  5 Jan 2024 14:29:55 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 866B2626FAE4;
	Fri,  5 Jan 2024 14:29:55 +0100 (CET)
Date: Fri, 5 Jan 2024 14:29:55 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: Benjamin Berg <benjamin@sipsolutions.net>
Cc: Richard Weinberger <richard.weinberger@gmail.com>, 
	linux-um <linux-um@lists.infradead.org>
Message-ID: <965367427.201125.1704461395241.JavaMail.zimbra@nod.at>
In-Reply-To: <9ec2eafe0ea44e3bce1e5fa96c4a9488c3d43a8c.camel@sipsolutions.net>
References: <20231110110348.1815612-1-benjamin@sipsolutions.net> <20231110110348.1815612-10-benjamin@sipsolutions.net> <CAFLxGvx6zVDy8pjacb8Dq9d884gTjpnPUapJ61GZAMy_39wGWg@mail.gmail.com> <9ec2eafe0ea44e3bce1e5fa96c4a9488c3d43a8c.camel@sipsolutions.net>
Subject: Re: [PATCH v3 09/11] um: Rely on PTRACE_SETREGSET to set FS/GS base
 registers
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: Rely on PTRACE_SETREGSET to set FS/GS base registers
Thread-Index: inGGs1y1gTUWKZex4eU4OWVKaC/22w==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240105_053004_479688_1E95989F 
X-CRM114-Status: UNSURE (   9.72  )
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

----- Urspr=C3=BCngliche Mail -----
> Von: "Benjamin Berg" <benjamin@sipsolutions.net>
> On Fri, 2024-01-05 at 00:05 +0100, Richard Weinberger wrote:
>> On Fri, Nov 10, 2023 at 12:03=E2=80=AFPM <benjamin@sipsolutions.net> wro=
te:
>> >=20
>> > From: Benjamin Berg <benjamin@sipsolutions.net>
>> >=20
>> > These registers are saved/restored together with the other general
>> > registers using ptrace. In arch_set_tls we then just need to set
>> > the
>> > register and it will be synced back normally.
>> >=20
>> > Most of this logic was introduced in commit f355559cf7845 ("[PATCH]
>> > uml:
>> > x86_64 thread fixes"). However, at least today we can rely on
>> > ptrace to
>>=20
>> Do you know since when exactly? I don't want to break UML in subtle ways
>> on old kernels.
>=20
> To be honest, I don't remember, and I doubt I really understood what I
> was doing.
>=20
> Anyway, I now found this commit now, which is contained in v2.6.25:

Okay, 2.6.26 is way older than anything supported. So I'll apply our patch.=
 :-)

Thanks,
//richard

