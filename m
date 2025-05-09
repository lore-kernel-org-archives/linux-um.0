Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 683D8C3ABBC
	for <linux-um@archiver.kernel.org>; Fri,  9 May 2025 10:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=k54YIIAt1HX3qxqsLaJ9Pdr+Jyv+TK7yUdd/QX5Nw1g=; b=wcEj2raOM5xFrOQFDSqCgPy5Dm
	0hRi6Nsqf6S/wF1aGV1G7NTrt7ti+taifhms8O0Oa6Qg4euAHa5wTKm9JMhwXwWSGeQtNy3cHH51E
	S4Tmr5b0M3+bfMh+Uk4ON/5x9Of454BuN4qIuwmYcOGqcOFIJTftppQ167XoBmoAlkdm9O7LhdnAG
	onNfIdHlTW2nKqt5DNZcK59d7nysLesVzl5dv4BfiM+q2rcILsM2rQjs2ZrhkjbBatatlAxanIJkP
	AZosGRtUr4mQyHCkzkHumumTu4wpcms0gt1aBpwQ8V6AKSJuQZE6i1ldNYjWmiOahrIa3AvbM/61P
	RCM22tAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDLFl-00000003Kox-1Ciz;
	Fri, 09 May 2025 10:46:53 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDKZW-00000003CBa-1x85
	for linux-um@lists.infradead.org;
	Fri, 09 May 2025 10:03:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=k54YIIAt1HX3qxqsLaJ9Pdr+Jyv+TK7yUdd/QX5Nw1g=;
	t=1746784992; x=1747994592; b=vPzg09k/u1lQD8FBNv8lz+A7mmXPdgZpnTZLaOgw4JLr21a
	diaK1F4V8W99yOIW5/rXAXYWpa8fx7TM35cmMB/pM2ow6SgyKPMBkv2B4/IA5i8wu5V9NRCpeQdKB
	KdyhCvtAc3soTaLBon3gbQ7lP0+1+3V819qVzynrQ2BPRb92VyDuJTy/Yu08RiXjZsQltq8Gu4H/4
	KLf1T64xbYP+Un3WMbtGNlTQtwVJEBeooQR3qBl98D3h/2tfJ2Aoez5UNs2UMcJ5VdSL08WYlTK8j
	+10yL8HCLLN0nZN53CZaTKHj5zrb2QEYjPolQLhy1LTxyqOOSsvFSBECdVjqJm/w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uDKZQ-0000000DFW4-1AvP;
	Fri, 09 May 2025 12:03:08 +0200
Message-ID: <05954e6dde3369a0ecf26f5225643afa15850f60.camel@sipsolutions.net>
Subject: Re: [PATCH 6.12] Revert "um: work around sched_yield not yielding
 in time-travel mode"
From: Johannes Berg <johannes@sipsolutions.net>
To: Christian Lamparter <chunkeey@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-um@lists.infradead.org
Cc: benjamin.berg@intel.com, sashal@kernel.org, richard@nod.at, 
	stable@vger.kernel.org
Date: Fri, 09 May 2025 12:03:07 +0200
In-Reply-To: <20250509095040.33355-1-chunkeey@gmail.com>
References: <20250509095040.33355-1-chunkeey@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250509_030314_786535_90C35F92 
X-CRM114-Status: UNSURE (   9.65  )
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

On Fri, 2025-05-09 at 11:50 +0200, Christian Lamparter wrote:
>=20
> What's interessting/very strange strange about this time-travel stuff:
> > commit 0b8b2668f998 ("um: insert scheduler ticks when userspace does no=
t yield")
>=20
>  $ git describe 0b8b2668f998
> =3D> v6.12-rc2-43-g0b8b2668f998
> (from what I know this is 43 patches on top of v6.12-rc2 as per the man p=
age:
> "The command finds the most recent tag that is reachable from a commit. [=
...]
> it suffixes the tag name with the number of additional commits on top of =
the tagged
> object and the abbreviated object name of the most recent commit."
>=20
> But it was merged as part of: uml-for-linus-6.13-rc1 :
> https://lore.kernel.org/lkml/1155823186.11802667.1732921581257.JavaMail.z=
imbra@nod.at/

That's not all that implausible - UML maintenance is slow and we all
have a lot of things to do... so chances are we just didn't send a pull
request for 6.12-rc even though the tree was already there. I'm trying
to improve that but it's not really a focus for any of us.

johannes

