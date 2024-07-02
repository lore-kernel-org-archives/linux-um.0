Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7F65C3064D
	for <linux-um@archiver.kernel.org>; Tue,  2 Jul 2024 10:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:To:From:
	Subject:Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=llRdo+u+MnXJr36BuZnbav8pKTadNbtu4Fx6xm9y+sc=; b=rKflYCmwZCSlXcAKQZpfhOt4VB
	v+TrgaCfkyPOB5ZdOlKh4u6A/wKGfkWvdXgi5mi5YWv9TvQgLu2kfNJJJk+F0aAleFz3D4Ds2Xvta
	HYciNyWmnGSmFIcoyyol8gnADJywpJhPUsNN56F0BRnK4xDS6EDnyoK09v821jcHTIotdeeJjS9c5
	sXhj8MufssP8ZViIj92saikZspOqzNXSdjLawNQFw65zZDN/BkwulLckqzAiPt3gLwbW70QexXEYU
	JPFZyJCggmqvIRj0NTHCxTDORQhtYLsQ0P13RN9KezMkmMcugKIKYIZ5u5jn9ic4+YC63AzoZvtie
	UdeFi7/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOaam-00000006KJs-0Gof;
	Tue, 02 Jul 2024 10:18:32 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOaai-00000006KHi-25mp
	for linux-um@lists.infradead.org;
	Tue, 02 Jul 2024 10:18:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=llRdo+u+MnXJr36BuZnbav8pKTadNbtu4Fx6xm9y+sc=;
	t=1719915508; x=1721125108; b=bsUUuZ9I0Fw0hgpnFEBd00WqAXTm4By0szMLmC4Zi4zRw8L
	wGgyl/200J6PdqzXh1iaPy/gTrpWS4SKM8z8iuKPbBCBRhIkVV3AxMB1tox6NEbcvtZrnmy+1u6BP
	FQsOmjYKZyWa5QdTjAXyKVkLPgY20qrXkxHRX4pSSC5dqT+b6IpwY2f5vtOhoQO6woOcjDrwKVGxJ
	iGe3CD8AgRTmQm0LvfUSFaBwCYsvTb8rvRMiSI3MirSZcbWk0kREW2jEZhIQIEnyhZesRrsrV5MxF
	ZUgikmFtTRCg6H3P7RIOyd2sKVjKitWiiSTNU+1WcpOiRu1IpEnZTSTJLaSah3bQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sOaaf-00000005Bvp-2hCG;
	Tue, 02 Jul 2024 12:18:25 +0200
Message-ID: <6d4c32b6237f02b6f53ed91bbc7fdfc0b293874a.camel@sipsolutions.net>
Subject: Re: [PATCH v10] um: Enable preemption in UML
From: Johannes Berg <johannes@sipsolutions.net>
To: Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	linux-um@lists.infradead.org
Date: Tue, 02 Jul 2024 12:18:24 +0200
In-Reply-To: <2c584137-211b-4746-bb6b-ebdec4c486af@cambridgegreys.com>
References: <20240702102549.d2fcea450854.I12f5a53d80ec1e425e66ef272b1e95cb523b608e@changeid>
	 <2c584137-211b-4746-bb6b-ebdec4c486af@cambridgegreys.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240702_031828_555849_F25150A1 
X-CRM114-Status: UNSURE (   8.19  )
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

On Tue, 2024-07-02 at 11:07 +0100, Anton Ivanov wrote:
>=20
>=20
> Is that all we have left?=C2=A0

I think so, yes.

> I lost track of your mm patches and they do not apply cleanly to master a=
t present.

Mine actually mostly went away, in favour of Benjamin's, but his also
didn't apply cleanly due to the compiler warning cleanups.

> Otherwise, the fpu-less on top of the older mm works fine for me. Testing=
 it at the moment.

:-)

We have 40 patches in patchwork now, including the 7 64-bit address
space ones from Benjamin where I think some rework is needed. I've
rebased/applied the other 33, I've just pushed that to the 'pending'
branch:

https://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git/log/?h=3Dpend=
ing

johannes


