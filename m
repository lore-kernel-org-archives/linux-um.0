Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 994D9CD13CF
	for <linux-um@archiver.kernel.org>; Tue,  3 Sep 2024 09:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:
	To:From:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=G4BItOc8k/hB4suOfWWwTOg/U0FTlHwyCNnKCLPge2w=; b=JXDmbbJmsCnFXP
	DqImyVnlIaKlSYhveH1eBrEmHa3/nAbFgpyHaQIfhZRdgiiYKjs5NMI5GIYmJMlwv0DlfcQzC5cq+
	5tBoGjUBvVSo28Qg4jgllFMqn7WXRcpSfkaWH9xJgrZASnLo/Xwu5mub4tosgXHqI9Vur6oKs6Grg
	tx5vMoWah6dBCZzOqdkzqIOXz99hZ4n0DPBWYePMooggZBFeqJ+auJAWz2E32xsr9QEToFgWsYlF2
	eWDpm/Hb7eJ5vX5EG+896N73o1Pys3+96jdzgM7LTn9haGukHx7pqgu1r7PectR5QQkdTaPypF7E4
	2D1WXnCK07MZaBD8lBaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slPkX-0000000H7ar-3ctS;
	Tue, 03 Sep 2024 09:22:57 +0000
Received: from mod.modforum.org ([192.254.136.77])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slPjU-0000000H7DG-0Y7E
	for linux-um@lists.infradead.org;
	Tue, 03 Sep 2024 09:21:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=basantfashion.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Sender:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=G4BItOc8k/hB4suOfWWwTOg/U0FTlHwyCNnKCLPge2w=; b=J9a7PK9HYFrZggX1+g+7FbkIJh
	SdfQMxABxL1Co73TwE4xapm6q1lXJakoP4/cJpi0eaLxIF2ESxXcp+rzJOidNJVeOhz7AxXrW1mLI
	XkLyz/KvgM8WmCePtd8cv5seS+/n1jdcfZCHv6og7l2+tM+ZYyYsJ/Qwo2x7TP6QvrDAPRkC8YObG
	zB2GIAalVyUjVn7ebvs5MWEl8MwfHCSpMaP+PKQQ/WADHLzx9o50uzrUUI+KMMB8+a6pxWb44IDOo
	JaCnDtArRofBGVuc2jBs5N/PIh2rSXX3BoYpYO3BHMDBuzZJErTNFhtYGaiHu3S82ep/adD8VsqwT
	tt+tVLoA==;
Received: from [162.244.210.121] (port=64888)
	by mod.modforum.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <kuljeet@basantfashion.com>)
	id 1slPiZ-0002Zx-7W
	for linux-um@lists.infradead.org; Tue, 03 Sep 2024 04:20:55 -0500
From: MERCURIA  <kuljeet@basantfashion.com>
To: linux-um@lists.infradead.org
Subject: Request for Quote and Meeting Availability
Date: 3 Sep 2024 02:21:50 -0700
Message-ID: <20240903022149.D4A3E821DCB4C949@basantfashion.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - mod.modforum.org
X-AntiAbuse: Original Domain - lists.infradead.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - basantfashion.com
X-Get-Message-Sender-Via: mod.modforum.org: authenticated_id: kuljeet@basantfashion.com
X-Authenticated-Sender: mod.modforum.org: kuljeet@basantfashion.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240903_022152_206375_FBC5C666 
X-CRM114-Status: UNSURE (  -2.04  )
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
Reply-To: procurement@mercuira.com
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

Greetings,

I hope you are doing great.

We have reviewed your products on your website, and several items=20
have caught our interest. We would like to request a quote the=20
following

Can you ship to the United States?

What are your best prices?

What support do you provide?

We are also interested in your services for this project.

Could you let us know your availability for a virtual meeting on=20
Zoom to discuss this project further?

Please advise us on these matters so that we can prepare a=20
meeting notice for our company executives to effectively engage=20
with you.

Thank you for your attention to this inquiry. We look forward to=20
your prompt response.

Best regards,

Nina Petrova
Procurement Manager
Email: procurement@mercuira.com
12 Marina View, Asia Square Tower 2, #26-01, Singapore, 018961
Phone: +65 641 1080

