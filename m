Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39D41C30653
	for <linux-um@archiver.kernel.org>; Thu,  4 Jul 2024 09:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uuCF7jSSHrAFatgfNniczfQxBtAcSqfV8Djlh+k/wj8=; b=N9K+C+/hmjhsjmluJZkGqqcNCx
	nFMTjLzwGGi93B+mkUlhSoLXUOJW6QkYkm5M8XMaoi1ygc/Eibic6/1ktUx2d3iT4fMQOajeUM63e
	VmAB8lDGDcGy8AYr7xhayPRu1cBjhratIC9Dn9uw8sO1buU03SS+90JcB+INpWvmAIs24LA+QUogK
	Hi6ln4dV2rMZoXaYFpcgrz/lPZnzZFPPeYlfjaVcZw4EJ+Ii8BVN4Gday+nb95e9w+8WPMJF2Iljt
	VgZb46LmY8QHJING4PoQ7Sl7f/tW/S+yA6yHCFBr43Uwd90cIg+Ri9Dgq5loB3axXLZF0AzsUnb/A
	r7bs5/3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPJC8-0000000CnoP-3e3q;
	Thu, 04 Jul 2024 09:56:04 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPJBk-0000000CneE-23Iv
	for linux-um@lists.infradead.org;
	Thu, 04 Jul 2024 09:55:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=uuCF7jSSHrAFatgfNniczfQxBtAcSqfV8Djlh+k/wj8=;
	t=1720086939; x=1721296539; b=shJNc2IwkzrOzAhspQZBZj8KJDjAtlrQkZjeFBBCtAUj7/P
	Qe/WAe9+XaAzMLUFWd3wshpnT60in/Nha1dt22ZHhzjMKWf7RunB2M/Mm7dbwZOdU7hzm4uaQeB49
	pQwdQZBWwlbldiKvHyASBU6C+5AbyQABdGE2tjd7Uir8knntvIHb8FgRNTb/T8F05xsMVXPQWzEga
	ur5luz6VKdKJVg67m/rECi4X54UHWZiL/Bl3134EnG96XaOSBsWqZXmjOMBA4l82UNskDM8t6IsUg
	cHMejxykmb7jo7vDbuzS5QXZaFYwAhtzty3blyNykaSUQlTZVFunmlnebicwj5/Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sPJBi-0000000CQ24-03st;
	Thu, 04 Jul 2024 11:55:38 +0200
Message-ID: <78132ecdf0eecd3b78c16499989c1a36ef7c8603.camel@sipsolutions.net>
Subject: Re: [PATCH] um: vector: Replace locks guarding queue depth with
 atomics
From: Johannes Berg <johannes@sipsolutions.net>
To: Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	linux-um@lists.infradead.org
Cc: richard@nod.at
Date: Thu, 04 Jul 2024 11:55:36 +0200
In-Reply-To: <d9367dcf-5383-4dc4-ac84-fae5e104eccc@cambridgegreys.com>
References: <20240704072154.1716301-1-anton.ivanov@cambridgegreys.com>
	 <43f01cf5b1e55730ee06a42136a8814a61a84951.camel@sipsolutions.net>
	 <8b581760-1ac3-4aa0-9257-aac2799e02c0@cambridgegreys.com>
	 <d9367dcf-5383-4dc4-ac84-fae5e104eccc@cambridgegreys.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240704_025540_545854_D152454E 
X-CRM114-Status: UNSURE (   7.47  )
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

On Thu, 2024-07-04 at 10:52 +0100, Anton Ivanov wrote:
> >=20
> > There is an extra issue there - stats. I need to double-check the locki=
ng when
> > they are being fetched.
>=20
> Same story - these need atomics. Otherwise we can potentially get the sam=
e ABBA
> lock issue when they are being fetched.
>=20

Email overlap ...

I don't think so? If no other path now uses _both_ locks, the stats path
can, it'll just be "AB" never "BA".

johannes

