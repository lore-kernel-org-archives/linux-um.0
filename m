Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF857E7716D
	for <linux-um@archiver.kernel.org>; Thu,  5 Dec 2024 13:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XxnxqgeSdIykO7o5n+oIUBy1mmfJAsw847516YiPhXU=; b=aC902pUvfia1UUnEJthpnst/EP
	A00wsFAl0GlD0rUDmj50DWu+yVbU/7nKROLHYw1nqt7CrsIEePqMK/2U8oiCWOiO/PzRFU3myBPZM
	Z7+doqGVZlvMqdkJNfWg8M+I2WEkRvuDoJijbD6+RInuIJ/CjYD85XvZKLLoENe17AspvPbLsJkwW
	gC4dCoa7nHD3ZHOlXNMj5u89v8r1HKtr5C4GC7j7EQ/VueKB7Anrbke+kPQquGSOnFRSYExs42qQ9
	bdugOL7pu8T4I9OzyZKE6T5ngSoy8kFCTAXcIXmr4gGXv4ANYS1ofPwWw1cM6uQQwe/mlAIxKKdC7
	xWgBWjQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tJCJH-0000000GF18-0kaJ;
	Thu, 05 Dec 2024 13:54:27 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tJCJF-0000000GF0i-3nER
	for linux-um@lists.infradead.org;
	Thu, 05 Dec 2024 13:54:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=XxnxqgeSdIykO7o5n+oIUBy1mmfJAsw847516YiPhXU=;
	t=1733406865; x=1734616465; b=uCeJE+vLjl4K0OkC5jWFOQ/76zi/crzfGzjV4a5BTtlrrcv
	/nRx7ChqBhgvFOiiORh1+1Q7AVlVNKoAxXyZJZ+1/L+ho/7kYniN15bvQ9eXhTpEkv2oPSWxVF0GV
	0k1XIiYBTziS3pwEeAIbST9/IGx13vDvUFkAzqp4xifX2JAXfsg6nKbnU86VDOfiNMJMXpKkUIKfQ
	WBMBh/qQZfT24XyXWpFMtwLmOY9HgzbGnYG+xDe/lN5kDjW04Ui7YzDc5it88YqU0wVRCaL8LSNg1
	rj9OQHPzAOSm3tt9NmhbyC8hMXF5R40g38hXUOX0AInikbgkZ3ysWGCEqps2Jz8g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tJCJC-0000000BKoU-0txG;
	Thu, 05 Dec 2024 14:54:22 +0100
Message-ID: <09c2f373dadbdc7f369742662ab43d6b5af66698.camel@sipsolutions.net>
Subject: Re: [PATCH v3 06/13] um: nommu: syscalls handler from userspace by
 seccomp filter
From: Johannes Berg <johannes@sipsolutions.net>
To: Hajime Tazaki <thehajime@gmail.com>
Cc: linux-um@lists.infradead.org, ricarkol@google.com,
 Liam.Howlett@oracle.com, 	kenichi.yasukata@gmail.com
Date: Thu, 05 Dec 2024 14:54:21 +0100
In-Reply-To: <m234j2w83v.wl-thehajime@gmail.com>
References: <cover.1733199769.git.thehajime@gmail.com>
		<f1aed0f9233f49880510e9506deddd52b33c2fc6.1733199769.git.thehajime@gmail.com>
		<c5c8a72aa008fd23fd1c7f64def54e94253b3016.camel@sipsolutions.net>
	 <m234j2w83v.wl-thehajime@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241205_055425_944048_1B9B313B 
X-CRM114-Status: UNSURE (   8.69  )
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

On Thu, 2024-12-05 at 22:51 +0900, Hajime Tazaki wrote:
> >=20
> > I don't understand why this behaves differently with and without
> > zpoline, it seems it shouldn't need to. Anyway, still think zpoline is
> > future work.
>=20
> I will remove the zpoline part.
> When zpoline is used, SIGSYS signal is a sign of unexpected syscall
> invocation, and raise this signal to userspace (with printing
> message).
>=20

But why? We already established that zpoline cannot translate
everything, e.g. JIT code and similar. So even if you have zpoline you
can just have seccomp handle the syscall as a fallback, to catch cases
like that rather than failing, no?

johannes

