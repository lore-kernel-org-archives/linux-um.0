Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F69606A324
	for <linux-um@archiver.kernel.org>; Thu, 19 Nov 2026 13:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=OSM3DP0N;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.a=rsa-sha256 header.s=mail header.b=hfLB58e0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=y6HekCBwuxrRdNz4z0xdp1oVlJfY3SjbPA0mXWRN/lI=; b=OSM3DP0NceKo4UFdkUva8YCn48
	gV3+YzTEku8X71OTuq4Ccn5y3Wcd6eiIrgKa1u9adgHBIHgHY5ALXwIB3E3u14Dz1WmEjq/Egtpfl
	A/A0/+tddF0uZoSZ/HSJ22z0yvR+q8JOXj9CoSwMiI1AbTJo3tushjBQUJHS9PPkS5GPj24dAFdCi
	BU2oAPdlHZ8lJPDexOOlr/I5I24tnfT8nLViHcZjxUuM4gt/V3/ZlrxcHZiQGUrutjp/55Xs0OkUR
	cCeCbSCul5mEpIsgctNcvxQyi8N/I21DenAf/C32vFN8wSIWBNP+tOiCQOOC9gfqDgI+g077l+3Pu
	tD4oxaYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xU29M-0000000C1eU-3WDP;
	Thu, 19 Nov 2026 13:26:04 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xU29K-0000000C1cF-2l3C
	for linux-um@lists.infradead.org;
	Thu, 19 Nov 2026 13:26:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=y6HekCBwuxrRdNz4z0xdp1oVlJfY3SjbPA0mXWRN/lI=; t=1795094762; x=1796304362; 
	b=hfLB58e0CiFbT4dtAIOH+4Z1fdeMoNZ4VX+BtKoUlBa7uFDrV/2zNpt7U8Uyl1MwiaVfmr0/prh
	rVbkIprOhaJ+oqvgWsmY0Xc61dRIrqBgxtyuyXSwv8CcleCFz48nHiEA2fhem2Mdu5Dp6dQZwVZKi
	Df0sfhjmkRUPAMGXRugFFwXNON8yxpcy5znky5km5KPi07WjG3Fm+8pFz6CDYNlNnaYeVOLFHyH0r
	6ALm4X+OqI423EWQnJ8VwrwJGiOlfaP2fARD+bO84HamjCyddKho1yxDZwM610eQdnGLcOEdU3Zsc
	+lCg0DIraXm/vYWqy2vTVqKusgfSY8mgZmkg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1xU29G-00000004LQj-1PDO;
	Thu, 19 Nov 2026 14:25:58 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: =?UTF-8?q?=E5=AD=9F=E4=BB=A4=E6=BE=B3?= <menglingao@xiaomi.com>
Subject: [RFC 0/5] hostfs: reproducibility patches
Date: Thu, 19 Nov 2026 14:24:37 +0100
Message-ID: <20261119132555.228479-7-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.56.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261119_052602_715879_51A6584F 
X-CRM114-Status: UNSURE (   4.66  )
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
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Lingao says they run with a read-only rootfs, and we use
hostfs for various reasons, but then carry these patches
to make hostfs more reproducible inside the UML guest even
if the order of files/operations/etc. on the host might
differ.

johannes


