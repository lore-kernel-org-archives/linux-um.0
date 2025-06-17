Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0CC5C7114A
	for <linux-um@archiver.kernel.org>; Tue, 17 Jun 2025 06:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MtYHNp8aAYCgkeanBg8ddRHBfnD96tPaecDXDyyDoRg=; b=3K6Alv7Upepar+xlZczihWkWSX
	kMp0fL5078AdaRF9cWIl1kKocC0eMP9cTiVo3l5XCp0wlXor2ywDU68fsYo3GGWnwIsy93/jOTqcz
	dNndFHndVPqr/Q56ywZJpE6lEZApCGk0kunnlBxWi5ZC5yMWa850gDTijkQUHfArWt0hjnPnSeReW
	7e79lIqSw1kDKjByQFz8XgG8EZBOu8mp2JdJs+JMINi2Lv5h5KGJd8hTNlf1RALs/affxkUfQ3xlO
	WJoqL9/7qOR4Hqjkt0mjHr1yUAo7x78GqvDB5rihUHtZkdYfWC+L4dYN/IB6tAb+jlRaHZPJ2iCqz
	8zmmRQMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uRQ0m-00000006Nmz-3Eaq;
	Tue, 17 Jun 2025 06:41:36 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uRPx7-00000006NNj-37qy;
	Tue, 17 Jun 2025 06:37:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=MtYHNp8aAYCgkeanBg8ddRHBfnD96tPaecDXDyyDoRg=;
	t=1750142266; x=1751351866; b=jrLqQT/10Yarp1qLpXtM4q9Vsb39esJbfUoeAMAPtYTg3gc
	dGFiJLj3tn1WTJU7ogaEoW2OGFmheGPQdfWRZrJ0ki4mxzlLq9BqAdOseN86RVZNRlwLZY+99KF3K
	hSQ55iarvqKAVPJTN3mj9n8vM3imMhQ0qqZyS+sD1j744jHeHq5Y9UCiaGkSG5V1rgcMDexWiU9mp
	kqGLaGh7sZq8m1NAPKVo4MYx7qoY5y++K7WdK3ZzFYnnfk+fH0aXIZ0skuY3vTzT9+Q/vXyB04xZa
	LmUnC9+p51uts+F/rQ9f1o8CGa2XasPgkB1tnkdACOT9a5szpWkZq2XveNrFiU2Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uRPwt-0000000DxWc-1HS8;
	Tue, 17 Jun 2025 08:37:36 +0200
Message-ID: <59c92abd11fdc0ba0a30c174cabc749cf74cb717.camel@sipsolutions.net>
Subject: Re: [PATCH] sonypi: add depends on HAS_IOPORT
From: Johannes Berg <johannes@sipsolutions.net>
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@kernel.org>, Niklas Schnelle
 <schnelle@linux.ibm.com>,  Mattia Dongili <malattia@linux.it>,
 platform-driver-x86@vger.kernel.org, linux-um@lists.infradead.org, Hans de
 Goede <hdegoede@redhat.com>, Ilpo =?ISO-8859-1?Q?J=E4rvinen?=
 <ilpo.jarvinen@linux.intel.com>,  Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Date: Tue, 17 Jun 2025 08:37:30 +0200
In-Reply-To: <20250615183642.902070-1-rdunlap@infradead.org>
References: <20250615183642.902070-1-rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250616_233749_788621_C5F0306C 
X-CRM114-Status: UNSURE (   5.57  )
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


>  config SONYPI
>  	tristate "Sony Vaio Programmable I/O Control Device support"
> -	depends on X86_32 && PCI && INPUT
> +	depends on X86_32 && PCI && INPUT && HAS_IOPORT

I sent the same fix b efore, but not sure it ended up going anywhere,
although Greg said he'd pick it up, I think:

https://lore.kernel.org/lkml/20250606071255.7722-2-johannes@sipsolutions.ne=
t/

Anyway don't really care which one gets applied, they're the same anyway
:-)

johannes

