Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59684CA5FA1
	for <linux-um@archiver.kernel.org>; Mon, 28 Sep 2026 18:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:To:From:
	Subject:Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kYJumJOd0QxU6ssNyRi2Gtbrjq9S4WH0OPews3xRSNU=; b=uCsgD/3cU7e9Vcj0t3sPd4GcPN
	Q0KJqYDfkE2V/oaonYfoy8lEHRNSZP+Jm4f25ImPiHYsU3IHTOTwVwGG3W9C5GS1A55EIhH9zeGqC
	hsrJfblXcW0JNQOw53KkzqVZxeRaoQIIUwoauQiem7d+nhbEchBSFcuIKJZPknmg09hpiUC90OgsK
	1INmvV5MP5HMDd8ByHATJGiT9Q2lKNrxQS4wrCJuCCC2ephNW7Rr9mo7DjALLxdPfdvYSO7hD385W
	ubUS+lDxlGzRpWMI1cMkfGyb5M4dMD4nLnqfJ8aQ5n4MDyRvWQq798WR9KPxZyw1cUaTVNWuWLfrp
	bZoS2uzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBFmx-00000001HIS-36lp;
	Mon, 28 Sep 2026 18:09:19 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBFmu-00000001HI4-2fAC
	for linux-um@lists.infradead.org;
	Mon, 28 Sep 2026 18:09:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=kYJumJOd0QxU6ssNyRi2Gtbrjq9S4WH0OPews3xRSNU=;
	t=1790618956; x=1791828556; b=VZRyKlhKqwjVkn1GDS48FZx1xsu2KoCVPwdzlOrwCh7yz25
	2eHPj/N+x10er6kHZhmx1MmWK+zgmb9XaCFsKj3c3Yk+Y85+yzLEVPBRtZg7XIrSmY+RGPBz7TifD
	Ef9Y87AqAwt9pK9CyR6ajrTQYyehkpP6wjIW88G3U9XTKUbUuR3BX+Tusi2r7dg0AIorFB9lYzzRR
	+7iYnaR14e5sMWWyO3y4026mEfZwAR4URJhMI2iik2V+USo2pzR0Wra+6m9o7ccphF6QWfsacSopB
	0htu9izI0E4uFWQauGi/09Yn9ZzX5J1V29dXNFgMSK4TU+exttm5TmvLXy04n8ew==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1xBFmp-0000000DmUf-3dvf;
	Mon, 28 Sep 2026 20:09:12 +0200
Message-ID: <8ae8d2c029018a00f437d7ff5ff34d54318ef5f8.camel@sipsolutions.net>
Subject: Re: [PATCH] um: fix CONFIG_GCOV for built-in code
From: Johannes Berg <johannes@sipsolutions.net>
To: Kees Cook <kees@kernel.org>, richard@nod.at, 
	anton.ivanov@cambridgegreys.com, linux-um@lists.infradead.org, Alex Hung
	 <alex.hung@amd.com>, Mariia Nikitash <nikitash.mariiaw@gmail.com>
Date: Mon, 28 Sep 2026 20:09:10 +0200
In-Reply-To: <179022133928.127266.18052172879787586674.b4-ty@kernel.org>
References: <20260727195515.2306731-1-alex.hung@amd.com>
	 <179022133928.127266.18052172879787586674.b4-ty@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260928_110916_674756_8A0E3A40 
X-CRM114-Status: UNSURE (   6.63  )
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

On Wed, 2026-09-23 at 20:42 -0700, Kees Cook wrote:
>=20
> What else is needed from the original series to get the full coverage?
> https://lore.kernel.org/all/20210312095526.197739-1-johannes@sipsolutions=
.net/

Back then I gave up and wasn't convinced it's actually doable in
general:
https://lore.kernel.org/all/d36ea54d8c0a8dd706826ba844a6f27691f45d55.camel@=
sipsolutions.net/

johannes

