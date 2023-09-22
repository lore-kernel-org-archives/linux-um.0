Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D2DACE7A81
	for <linux-um@archiver.kernel.org>; Fri, 22 Sep 2023 22:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=o9XvNdYDqs7Igdv0mGZ8w3FtTOI1xLPJgy0rrUIediE=; b=wnLsMxL76gODz8
	rrtuZ+9E+Ao4oW7ezO72Rh687F4GUmCMzWpWPP/csE6U52jo9UnkBu0KjFNtUKmmH3EUjcKBNhlUe
	+MZLUJWWvMpDaUWf6ueyLO6tIeBhtU8GF5wBVQ1mRHhSun84QseVg2F0pcA3xW5/04A53KddF0l56
	h0nh/rsyYm2Ssgk8JOOqBo/JlG+0RlLXkxdAwYt0FR8UQ/PkYamVwscU7F8XrU8XH7BkROsT68D9H
	avKHFCyFm6rdFAczucFzM9M20N2eSFsq/dj9fIz1SLwTllYxFNwXVBWss7ziEQpO199WuvMRqNhAJ
	XTwtzhl2hp0MkmjWn13w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qjoo5-009vXg-34;
	Fri, 22 Sep 2023 22:39:29 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qjoo2-009vWC-2Z
	for linux-um@lists.infradead.org;
	Fri, 22 Sep 2023 22:39:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=bIZgN1LlHrSaU+oT6b1t4Ebp+Pyml7VHOWnW0T4o/vE=; t=1695422362; x=1696631962; 
	b=GXJMJM/gjZx8BIs2Ve4rHcWF3Mrgujh/D7n+edNEnicxLhGqmxOLZVi299P1X8nuP9k4LuwV9i/
	WsH5yXTdPLUDDSIIBwu551DPi29lv4hHapn6X0rp6lvsOan/DOLeqOKa1eJrL99tLfTJXTa1Dxyyw
	Q/J2vARBgKO1x25CwpDumctkbW2XEKjcn49IW/pC9PU3/BN7GN0NZHycymS2wwHPpW1012f6CAy/k
	l8xqxSjf/7bTZxJ4hYJ0axOEHL2IszDDAwDmMU/1BQLiZLyQTTv63CJ8xSZ3hY5G3FQFh4gqIljB/
	JZRFp53DCF4LOc7yVg69L6J1aqRtPJwnNwtw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <johannes@sipsolutions.net>)
	id 1qjonv-00FtWi-2M;
	Sat, 23 Sep 2023 00:39:20 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Subject: [RFC PATCH 0/3] um: clean up mm creation - another attempt
Date: Sat, 23 Sep 2023 00:37:38 +0200
Message-ID: <20230922223737.1206223-4-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230922_153926_885880_5B1A5CAD 
X-CRM114-Status: UNSURE (   5.15  )
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

This shouldn't pessimize since we keep copy_context_skas0() and
the setup there, but still clean up the code there to not rely on
current, and move the force_flush_all() to a more appropriate
place, which fixes the issue with that in the fork_handler().

johannes



_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
