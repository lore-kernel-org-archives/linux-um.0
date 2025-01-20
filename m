Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5607C02185
	for <linux-um@archiver.kernel.org>; Mon, 20 Jan 2025 06:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=o+EwqQAX2AITHvqltiKuB+BnzRqZca4pYHk91wjCxg8=; b=v+50OEo+VZ1WXKhjr5IxfsAAuz
	8/1JAHoE28LUXP4GZ6XBwW0kExKqzDiL/4UKUde0z7L/IaszOZujhKnUU8xxeyULAEfXrFOXM232D
	a4dFUHTr3/k+csh/Or43CkfpuGPtRWejqoIPSyLaUiv0/gLItq29CravnHPWtAB1I7wy2NiRFs6qs
	ja+Q/pPq+IUIeRIXOYncx6P1YbL2x7JlvIjsKHRCDs8rhfGkkJDkzIG2cAF4U0W4CWzHQl1CgsZ+D
	9lCm/fKlQ3RH9uajcm4zw+tsHXTKQ9/tm0I6pbpuUc/w45Ia8zuaPoZM86T9aWD6FsltITca3EvCF
	Mld+4skg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tZkwd-00000004nrb-3qwk;
	Mon, 20 Jan 2025 06:07:31 +0000
Received: from www17.your-server.de ([213.133.104.17])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tZkwb-00000004nr2-0SEb
	for linux-um@lists.infradead.org;
	Mon, 20 Jan 2025 06:07:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=m3y3r.de;
	s=default2402; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-ID:References:In-Reply-To:Subject:CC:To:From:Date:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=o+EwqQAX2AITHvqltiKuB+BnzRqZca4pYHk91wjCxg8=; b=JfEUkvQmDmMK3IrmppVtlRZC3i
	12mLiAlgF7qk3M5bbJ4N2tMDKDWU2vZF/AYeoHLaGmIdn7ZwV7iBMbdhx7xR8mhqEve7tdrxHechf
	YBRUOIppP5YGYL3RequkrKY80qZ9EabFzXLp4BTo1XnS+XdElafWir03DXnEYVeQJrb+uikfeJ6YG
	t6h3mXz6SM2UeSZSQxn2HQBJcqndBcd2LyTey1M9iVRhrE2Ml4Rp2Bcgp31nPOs39iRbdyxF7Zc4I
	f3T3yQgsTWVTO0cpFcCkqxUJz4YW4E3G+S9y8rRu/NkSNT2e8zDwvecQO/PN4oUQW8mxS4X+1AXMN
	ma1Fd+OA==;
Received: from sslproxy08.your-server.de ([78.47.166.52])
	by www17.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <thomas@m3y3r.de>)
	id 1tZkwS-0001Q5-2M;
	Mon, 20 Jan 2025 07:07:20 +0100
Received: from [94.31.73.198] (helo=[127.0.0.1])
	by sslproxy08.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <thomas@m3y3r.de>)
	id 1tZkwS-000AEy-1H;
	Mon, 20 Jan 2025 07:07:20 +0100
Date: Mon, 20 Jan 2025 07:07:20 +0100
From: Thomas Meyer <thomas@m3y3r.de>
To: development@efficientek.com, Glenn Washburn <development@efficientek.com>,
 linux-um <linux-um@lists.infradead.org>,
 Benjamin Berg <benjamin@sipsolutions.net>
CC: Richard Weinberger <richard@nod.at>,
 Johannes Berg <johannes@sipsolutions.net>,
 Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Subject: =?US-ASCII?Q?Re=3A_UML_failing_at_=22Failed_to_initial?=
 =?US-ASCII?Q?ize_default_registers=22_on_kernel_5=2E10?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20250119172535.42b4bca5@crass-HP-ZBook-15-G2>
References: <20250119172535.42b4bca5@crass-HP-ZBook-15-G2>
Message-ID: <74506C86-D705-4B68-8779-BB839B305B9B@m3y3r.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Authenticated-Sender: thomas@m3y3r.de
X-Virus-Scanned: Clear (ClamAV 1.0.7/27523/Sun Jan 19 10:40:50 2025)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250119_220729_452104_882C4A5E 
X-CRM114-Status: UNSURE (   9.63  )
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



Am 20=2E Januar 2025 00:25:35 MEZ schrieb Glenn Washburn <development@effi=
cientek=2Ecom>:
>Hi Benjamin,
>
>After applying the close_range patch, I'm now getting a failure at
>runtime where the last line printed from UML is "Failed to initialize
>default registers"=2E The host is on Debian 11 at kernel 5=2E10=2E216=2E =
I've
>bisected the issue and it looks like the bad commit is: 3f17fed2149
>("um: switch to regset API and depend on XSTATE")=2E
>
>On another machine which is on Debian 12 and kernel 6=2E1=2E119 the UML
>binary compiled from v6=2E13-rc1 runs fine=2E
>
>I notice that the bad commit appears to be using ptrace in a different
>way=2E Perhaps there is a difference in how ptrace operate from 5=2E10 to
>6=2E1 kernels=2E I've tried debugging this without much success, as GDB
>can't be used=2E Any idea on what's going on here?

What processor does those machines have?

>
>Glenn
>

--=20
Diese Nachricht wurde von meinem Android-Ger=C3=A4t mit K-9 Mail gesendet=
=2E

