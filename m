Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C67E606A326
	for <linux-um@archiver.kernel.org>; Wed, 25 Nov 2026 15:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=tqdLe38G;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.a=rsa-sha256 header.s=20201203 header.b=M6cwfCnT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=JuiFzg0AsuPaU2C/K6V3PlAbkJG/chJ9lFUKLU/ZD68=; b=tqdLe38GYeDpikYMLCPvT7RACr
	8huN1sinhOlASyvbioa0YwvgDNIzJoti+CWuYEtXAZztkpjjf0wlJc0tMp2Ycmk93sXN/3WEP5Fhw
	5r5PdHuKbRFuX12qsOqSbm0/icAIPTU15znE0dF/tw0fPlxMRtHv2HVJSuOIl/8c9/AvfDBgqiGwM
	oDntapq/0ZeM6ypvZBDw5kme5YkzgDOEOUSGAbwKMH7t+tGtFfmv9/YydQUPRPJcAeD5TVW+8bTvM
	cIMWGex6VqXxtIep7vvbwTWBGhydPLc+6jEfan1TuTREOOpt353r5IHtiDxXfDCqCgbUKkERKlsa5
	9EoAIs5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWEsi-0000000ALjt-1STa;
	Wed, 25 Nov 2026 15:26:00 +0000
Received: from ms.lwn.net ([45.79.88.28])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWEse-0000000ALgw-2s2S
	for linux-um@lists.infradead.org;
	Wed, 25 Nov 2026 15:25:59 +0000
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 85285410D8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1795620356; bh=JuiFzg0AsuPaU2C/K6V3PlAbkJG/chJ9lFUKLU/ZD68=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=M6cwfCnT5jW8b6mp6MVqK+/AmNUppc+h3m/N3Hr0AYYpSsvXqiU2/nckkjFoYtTDt
	 ESlDeunY6dVR78DASRTg0irgAE0gcDB0pEgfmLb34MDy99EOUPLyNpIe4QS3c3zcH9
	 YJGffe1IDU7/fkZx0UPw33sL+EDb1ATz5ghIEb98gVRP1Fphr+V1LkaOVbDH9Bkiwx
	 Yn8DS/tNPz2nxySW9qo/6lWotZXcN7XIRHi3l1O3k+Q1Ckk9pq6m0nvJ/L50h0GEg5
	 hk19+GA5jPb/0ZW6ouf0yDr5HD6tUrtrsQX1LRDKBNyzVDKn+Z5qQG1E0wMijeUunz
	 z+ilrB1Cf3zVQ==
Received: from localhost (mdns.lwn.net [45.79.72.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 85285410D8;
	Wed, 25 Nov 2026 15:25:52 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Manuel Ebner <manuelebnerli@mailbox.org>, Richard Weinberger
 <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes
 Berg <johannes@sipsolutions.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>
Cc: Manuel Ebner <manuelebnerli@mailbox.org>, Renzo Davoli
 <renzo@cs.unibo.it>, linux-um@lists.infradead.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] docs: UML: user_mode_linux_howto_v2: Fix bracket
In-Reply-To: <20261120175509.1369714-2-manuelebnerli@mailbox.org>
References: <20261120175509.1369714-2-manuelebnerli@mailbox.org>
Date: Wed, 25 Nov 2026 08:25:44 -0700
Message-ID: <8733spyltz.fsf@trenco.lwn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261125_072556_722005_5C291626 
X-CRM114-Status: UNSURE (   7.79  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Manuel Ebner <manuelebnerli@mailbox.org> writes:

> Add missing ')'.
>
> CC: Renzo Davoli <renzo@cs.unibo.it>
> Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>
> ---
> [v2]
>  Correct position of closing bracket (Randy Dunlap)
>
> [v1]
>  https://lore.kernel.org/all/20260909140051.1365758-2-manuelebnerli@mailbox.org/
> ---
>  Documentation/virt/uml/user_mode_linux_howto_v2.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

jon

