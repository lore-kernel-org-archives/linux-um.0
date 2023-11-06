Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32CFCC4332F
	for <linux-um@archiver.kernel.org>; Mon,  6 Nov 2023 20:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qhKHMXeSksb9jeuIzWAr9aKBHAX+7Bnwe1YSHGy6Tv8=; b=P2qYZZ2a2V593W
	8a7D5sQw0hW+fUHTc4UK1M0pACUyJNXvjh4VIk2Va67SfLhlLfM/3LyAUrn12pD6C4Jy1leddqz2H
	JOASD8zfArn8/9y5Gy+OJjFTLhsATdRtEDTegSXOfD2GGLD0nNX0NPNQNdLeGvu3q8r2j+50pg1a0
	NUPiHwQE6E16bfbXhCA9S8g7vh9HRtdZ4cLvVRYkQ28vj5g0QVK9aHP+5EUNLI7NFJw6BuHeIEDN+
	l6EMuD7RbAULraqfVbYfTRxh4HotN1IU6dCt4ZQp1AnsC9IidEmtePef0JAjAgGe5ZZ3d4qKqpdR1
	+nsf/pIHFcaUtkJSfOcQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r06I4-00HVZZ-2k;
	Mon, 06 Nov 2023 20:33:44 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r06I3-00HVZN-29
	for linux-um@bombadil.infradead.org;
	Mon, 06 Nov 2023 20:33:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=MIME-Version:Content-Transfer-Encoding
	:Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=nyqs1Cmk/d7b1tOIxtYWJamN4Ni7cedT82rF1CLEnoQ=; b=Pce52M42OrfAQt6zUMAN4PulAh
	Ijz8ukF0HDmQamfHhzRaaNByy7AGNtCg2eutE4A0qe3sbYvVftFRvRCr3j2s0lvsGyiGQnzPI/BgJ
	7Zme3kvsh95NiiKRi1mdLm5dYx4it2gh9ReEyJnw8wzAlo5f0/ynwg+uCoxD9viw1FvPm9fRQpkjF
	sWkuIRDfRv+JHcI6zxUX4PsZ+1RGCuqstgy/NVFzydg2s+dt55j9YxLzkSsRdVX3fJ0fHFlsMeFT0
	Xx77qN1SEGWQoHZLnjwRZ1JSsum6a5pENACDIeMHSJ+gm0FAIZQ381HJjGlseTi+hyWMwPrFFXVst
	4XUtxhHg==;
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by desiato.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r06I0-00AmUc-0a
	for linux-um@lists.infradead.org;
	Mon, 06 Nov 2023 20:33:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=nyqs1Cmk/d7b1tOIxtYWJamN4Ni7cedT82rF1CLEnoQ=;
	t=1699302820; x=1700512420; b=vm9KVJdni0XmM8ePLW6I3KnUuwYlduBnnQbByRmOW5HD7mK
	szjzAfeP9Q7mJzJW8rUT9QePB/aca9UNAG7CY+Lt/k3SmNHPBZPbEkjPgfXBWY7Q3tnSSf2dUHFVW
	bADEsAhb0SqDm9OHFgmsAqpH0/+DLrQhzvfTsenRAT1VUzeedZN+TZ0UFjL9SXtHvxjA8larXNg/F
	nkjUncB4Tf2HPB3ka8DZqeZfkb4V/z5NY4ZMvRNhAH64PWEJkOXUHPjKdL6UGRkg012rA0jLrqJZS
	ZiegVTsqNVrQUAkFmBi3pBoYDY4uS/sfyUkEcwmdiVjzBWBC2R2a7vnTVx6OVT7g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97-RC1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1r06Hz-0000000Fszl-013S;
	Mon, 06 Nov 2023 21:33:39 +0100
Message-ID: <883e7458a05db3ec4733c2cb3bf46f2ae4ec9ee6.camel@sipsolutions.net>
Subject: Re: [PATCH RFC 07/11] um: add TIMETRAVEL_REQUEST handler to request
 latest event
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Beichler <benjamin.beichler@uni-rostock.de>, Richard Weinberger
	 <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: linux-um@lists.infradead.org
Date: Mon, 06 Nov 2023 21:33:37 +0100
In-Reply-To: <20231103-bb-timetravel-patches-v1-7-e2c68efcf664@uni-rostock.de>
References: <20231103-bb-timetravel-patches-v1-0-e2c68efcf664@uni-rostock.de>
	 <20231103-bb-timetravel-patches-v1-7-e2c68efcf664@uni-rostock.de>
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231106_203340_693942_24E0F5EC 
X-CRM114-Status: UNSURE (   6.87  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

On Fri, 2023-11-03 at 16:41 +0000, Benjamin Beichler wrote:
> Allow the so called Calendar (or simulation master) to request the
> latest timetravel event. This can be used in situations, where the
> former request message from UML to Calendar was missed.

How ... is it possible to _miss_ a message?! It must've even sent an ACK
to it...?

johannes

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
