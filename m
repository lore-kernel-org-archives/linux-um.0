Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69D7ED6ACCA
	for <linux-um@archiver.kernel.org>; Wed, 27 Nov 2024 13:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pkTk3XHy13zAGY9taqN3APN+Punlp6wKTidyILus54Y=; b=1jimoFz7/VhgNfrvZLLqsJ5wPg
	79FFoSbqVmqA92q39euDI22WqUqD8A0R4AQ5ih+xMt+AG093rAFjq6oXhhp9PKkY5K+FoyxSPYULV
	8SJGyqcqtO7xYfEIJNtld7CY6dQz9hQjQWcE3rLnEfolaDpOzVyMl3Bh2OZ5EWvxlMmF3XsyCfCnM
	ncgUj6i/Bs0BhPgoEj0u7I02MsnA1ebMSIDlthEgko/FzkdguDeF50qip3mSFrCXEracpGmeIhJkd
	vQjAA8YxVHdZY/sJ2thV2IaxQyOt3BVc2d6CR+qTtGyXUUqMoqndq1AzRILr/tJlkM9VJO3EVURjG
	6Kr3vibw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tGHto-0000000DDNH-34gV;
	Wed, 27 Nov 2024 13:16:08 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tGHti-0000000DDM4-2gfe
	for linux-um@lists.infradead.org;
	Wed, 27 Nov 2024 13:16:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=pkTk3XHy13zAGY9taqN3APN+Punlp6wKTidyILus54Y=;
	t=1732713361; x=1733922961; b=WfwFrE6lgZwasGZ/C2N/gvPVQunfkaOuobd98ZsH65bDxhc
	8ETfq6HFk5Ror6HYAM+qrqvWIFlEvvSYwLSfmKlxo4uztTB2VQ3n7H5Zp7X3tcQHG1umxsb6trHhO
	WguTTiPsFYBxsqdn9Ttx+Ai/f+4D2ry538jjEwXVypaLL3lT/1TTc37EOOS2gY33HCs8bY7rwmGc0
	jlSsbHi/Z6ixN+/W/UhGrFoBrSr9oTYWD5uasgz8JR3Y4LACkKyQNIsjs63mlxyrLfTlDvquNvKIy
	jo9PiAxl8ABJ1VRi3Lpy+WIFC0D+zpas8rdnYUK2wFh2SLz+EOxR9XCLvjzOP6aA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tGHta-0000000Ge8T-3zNq;
	Wed, 27 Nov 2024 14:15:55 +0100
Message-ID: <f565e434afc84090ffd7bff69ce9cf5643302233.camel@sipsolutions.net>
Subject: Re: UML mount failure with Linux 6.11
From: Johannes Berg <johannes@sipsolutions.net>
To: Karel Zak <kzak@redhat.com>, Hongbo Li <lihongbo22@huawei.com>
Cc: linux-um@lists.infradead.org, linux-fsdevel@vger.kernel.org, Christian
 Brauner <brauner@kernel.org>, Benjamin Berg <benjamin@sipsolutions.net>,
 rrs@debian.org
Date: Wed, 27 Nov 2024 14:15:54 +0100
In-Reply-To: <uppzc2p5bn6fhrdlzzkbdrkoigurkii5ockigngknm4waewl5z@z2a6c6iivu7s>
References: <420d651a262e62a15d28d9b28a8dbc503fec5677.camel@sipsolutions.net>
	 <f562158e-a113-4272-8be7-69b66a3ac343@huawei.com>
	 <ac1b8ddd62ab22e6311ddba0c07c65b389a1c5df.camel@sipsolutions.net>
	 <b0acfbdf-339b-4f7b-9fbd-8d864217366b@huawei.com>
	 <buizu3navazyzdg23dsphmdi26iuf5mothe3l4ods4rbqwqfnh@rgnqbq7n4j4g>
	 <9f56df34-68d4-4cb1-9b47-b8669b16ed28@huawei.com>
	 <3d5e772c-7f13-4557-82ff-73e29a501466@huawei.com>
	 <ykwlncqgbsv7xilipxjs2xoxjpkdhss4gb5tssah7pjd76iqxf@o2vkkrjh2mgd>
	 <6e6ccc76005d8c53370d8bdcb0e520e10b2b7193.camel@sipsolutions.net>
	 <5e5e465e-0380-4fbf-915d-69be5a8e0b65@huawei.com>
	 <uppzc2p5bn6fhrdlzzkbdrkoigurkii5ockigngknm4waewl5z@z2a6c6iivu7s>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241127_051602_677053_5D140AE1 
X-CRM114-Status: GOOD (  20.71  )
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

Let me try to unify the threads, and perhaps further my understanding -
you seem to already have much more of that than me :)

> > > But this is still a regression, so we need to figure out what to do
> > > short term?
> > >=20
> > So for short term, even long term, can we consider handling the hostfs
> > situation specially within libmount?
>=20
> Yes (see reply to Johannes ).

I'd argue though that this doesn't count as fixing the regression, since
the kernel was fine before the changes there (even before porting hostfs
to the new API) with _any_ version of userspace. Except perhaps for when
there's a comma in the path, which I suppose would've broken one way or
the other by mount(8) moving to the new API?

I'd kind of prefer we fixed the immediate regression, at least without
the comma, in the kernel. But I guess you can do whatever you can get
away with ;-) And it's already broken for two kernel releases now ...
but I guess those haven't percolated through the ecosystem *that* much.

[from the other email]
> I can add a temporary workaround to libmount for hostfs, which will
> automatically add the hostfs=3D key for unnamed paths. This will allow
> you to receive the expected fsconfig() data from userspace.

so I'm not sure this makes too much sense - kernel upgrade broke it, I
guess kernel upgrade should try to fix it?

Assuming no commas, would mount(8) today send the path as the key to a
flag option? We could perhaps find a way to handle that in the kernel,
and then just do the longer-term plan of moving users to hostfs=3D"..."
(by documentation/warning) in the future?


> > Such as treat the whole option as one
> > key(also may be with comma, even with equal)
>=20
> There could be userspace specific options, VFS flags, etc.
>=20
>   -o /home/hostfs,ro,noexec
>=20
> Is it one path or path and two options?

Yeah but there _aren't_ in hostfs, right now. So without the mount API
we'd not even be asking that question since the parsing was in the fs
and hostfs would just never have done it, I guess?

> We can automatically add a key (e.g. hostfs=3D) and use FSCONFIG_SET_FLAG=
.
> The goal should be to get the path as a value, because key is limited to
> 256 bytes.

Right, we can do that going forward, but it doesn't really address the
regression?

johannes

