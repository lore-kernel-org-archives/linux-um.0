Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DFDBC531FA
	for <linux-um@archiver.kernel.org>; Fri, 24 Jul 2026 07:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2sGTDeVZmg/SUyI/duc97F4Q9NL8O2hwVggA/ZCn4Xo=; b=WTjB5TbO85v5hjS5KP0ONoSefe
	Mb2cyU2T5/VIhdWKII2JsnS75oL21bg7F1Gge8e1dr+sTwlkfsXClkzICXXHHUllm0cAOHnHS6Sjo
	KGyNKi66maPlAngqPoyFe4Y98GL9gW3KXHmmDxTzMvwkZpqKZJeC/umjLJctcj2G90oVa1Gy54s9l
	Y8NcWeHr4Q8j9Vn8eVcnCIr1oGDava5qw72CCS4OILApEqGRrgCSSLhpPlfW6DDJ8tSeUqXJKXnvA
	H9UluWvQo7XggB05+EGQPgnEi04HqRax6YSJNSI+PARnD0IcgoS+OwR39CINrWeQGmmJOugrmmnCz
	WR8XZeHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnAAt-0000000Fg3F-2mqS;
	Fri, 24 Jul 2026 07:18:27 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnAAr-0000000Fg2P-0Xf8
	for linux-um@lists.infradead.org;
	Fri, 24 Jul 2026 07:18:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=2sGTDeVZmg/SUyI/duc97F4Q9NL8O2hwVggA/ZCn4Xo=;
	t=1784877505; x=1786087105; b=tWzoFWNC8JxE3J03ojGsHUiId6inh2UqvB04nBIXO2CPeb2
	uEbWOXaQBdtTNSCHp8qVBEpZtohEnsNfoqP1X33LVRUHGlkQc+QetbdwrK+7ChJX5UF9cSrI/y4A6
	7o89Svjm5zUBChpiqvYWSW9UAolTvMQeKNW15zIdPexKCNxtotVYzqeTr3lpcJV5MYZAiR+0S1LBX
	ybMzklNYkG0qksF5trAEffmADnwuTh/DLerJNKnZEHkV137bpwvu1rRsxYDYepxq7BEbSRNejB2X9
	aZBCUal3qRoIsdfzkWm5OvYOzTc1kh7v/4X4GRWU6KUn/mcjDVxJxeJRJNDz00vg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wnAAn-000000021u1-2ssU;
	Fri, 24 Jul 2026 09:18:21 +0200
Message-ID: <0e040286b4f51fa430951fe117d1e3e281af6181.camel@sipsolutions.net>
Subject: Re: [PATCH v2 04/10] um: change machine name for uname output
From: Johannes Berg <johannes@sipsolutions.net>
To: Hajime Tazaki <thehajime@gmail.com>
Cc: linux-um@lists.infradead.org, liam@infradead.org, ljs@kernel.org, 
	ricarkol@google.com
Date: Fri, 24 Jul 2026 09:18:20 +0200
In-Reply-To: <m1bjbw97sb.wl-thehajime@gmail.com> (sfid-20260724_091657_219127_5E6B1FEA)
References: <20260723093633.140989-12-johannes@sipsolutions.net>
		<20260723113633.bcaf234695c5.I226381aaaf6dd46c559b0e694b29370d0102ce3f@changeid>
		<m1ecgs9908.wl-thehajime@gmail.com>
		<c5c1a16d1be4658e2f797b21fdfe5f4dc3d9a168.camel@sipsolutions.net>
	 <m1bjbw97sb.wl-thehajime@gmail.com> (sfid-20260724_091657_219127_5E6B1FEA)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260724_001825_166313_578F4A6F 
X-CRM114-Status: GOOD (  10.33  )
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

On Fri, 2026-07-24 at 16:16 +0900, Hajime Tazaki wrote:
> >=20
> > Sure, we can drop it. Or arrange so only nommu is different? Or even
> > call it SUBARCH-nommu?
>=20
> systemd detects UML via systemd-detect-virt, not `uname -m`:
>=20
> https://github.com/obbardc/systemd/blob/master/src/basic/virt.c#L298

OK, I never checked :)

> it looks like it uses vendor_id field of /proc/cpuinfo.
> I guess they are right.
>=20
> my original intention for this patch (to uname output) is to avoid
> confusion (of myself) which UML (MMU or NOMMU) I am running so, it's
> purely a kind of debugging purpose.

Sure. I guess you can also always compile an EXTRAVERSION into it/both
if you want.

> I think we can drop it and come back later if we really need to
> provide a way to detect nommu UML (probably extending show_cpuinfo()).

OK, thanks for looking.

johannes

