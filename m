Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A199C30653
	for <linux-um@archiver.kernel.org>; Thu,  4 Jul 2024 09:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:To:From:
	Subject:Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lxo2CU+d+dErNEtnrUdo1xMAYX3EAoCY9sYclqsNfgA=; b=1FuKKkisVGx2472+v7OG9Bs4Kd
	rHGWpYNh49+fHsPwxfFL7UlUsLGwn7A/kZeUgW6FO0Vt9dojIyXpNNJsID0Yrsz8/NZq8q83WqYxl
	ymRoEmN33ve+URj6tBiq7KaUs6ChuE9dKSUJFiPU0CVQ8ETbxzcrPURmQLqTXwVw2GtSf7HVZ22e2
	T/7rUSp8jL9Vnrl4AmMVHXCZko3vMRQ1Na/7BhUF9h66lNpMLflqHh4JpXpk1kQzOT51VmVuu+sZ1
	RADuknvZ7fbRDVNCiCTT1jnveh812NFz9qj+0eER1huOyruHVIkbzqbNEeYCQ0S2GBJPzPiEKYs2j
	YBYJlNyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPIeV-0000000CjO3-3ISQ;
	Thu, 04 Jul 2024 09:21:19 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPIeT-0000000CjMo-25o5
	for linux-um@lists.infradead.org;
	Thu, 04 Jul 2024 09:21:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=lxo2CU+d+dErNEtnrUdo1xMAYX3EAoCY9sYclqsNfgA=;
	t=1720084877; x=1721294477; b=GUuFD1xCqei1zG69JAmGSieODbNjSZyllZc7T3hPFWtzn+v
	fHCasgbt5t3y7JXbGvhGs+k++YGtcVIxba6JJ39om9e9HnolF5XbZfgFt1YwA9zXYcjJaH4pUwkp5
	ZQkgz+IcFQJwf29ezJv/9vBhC/wdqt2dmj/dmQOmSGA8g2yuwKRxYR6K/HCQ73zGwIRFaLU1vaelB
	gGGFrBMk1RFrtYiAQkZdVA0k5Fx+EESkJ9ow4ZUKwGHFYjyWZ64hiJT+biSixYj8tWEVDHva91Uzc
	KxRM6NAN2/3MToz4XMZ/PELyDGRdhoVz463nxmQNt1djGAB9jY8U+NZ6hyA/giRg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sPIeR-0000000CLJG-1zKK;
	Thu, 04 Jul 2024 11:21:15 +0200
Message-ID: <f2fcf3ae00e5bcffc0337f3022128dbb5c63c699.camel@sipsolutions.net>
Subject: Re: [PATCH] um: register power-off handler
From: Johannes Berg <johannes@sipsolutions.net>
To: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>, 
	linux-um@lists.infradead.org
Date: Thu, 04 Jul 2024 11:21:14 +0200
In-Reply-To: <456e9b12-fd66-4da2-be6c-ad04222da495@kot-begemot.co.uk>
References: <20240703173839.fcbb538c6686.I3d333f4773cff93c4337c4d128ee0b1b501b3dfa@changeid>
	 <456e9b12-fd66-4da2-be6c-ad04222da495@kot-begemot.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240704_022117_557520_5C1E8839 
X-CRM114-Status: UNSURE (   5.51  )
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

On Thu, 2024-07-04 at 07:58 +0100, Anton Ivanov wrote:
>=20
> > +__initcall(register_power_off);
>=20
> Anton Ivanov <anton.ivanov@cambridgegreys.com>

Heh, I thought I saw an Acked-by from you but then patchwork didn't seem
to pick it up, I guess I'll treat it as one anyway? :)

johannes

