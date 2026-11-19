Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E0E606A320
	for <linux-um@archiver.kernel.org>; Thu, 19 Nov 2026 13:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=AtB/x6n1;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.a=rsa-sha256 header.s=mail header.b=xLuo+ZLG
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=lHO6Al5D1UOJ2GkOXkMdAANMBrRrim44AFinn44VGFc=; b=AtB/x6n1HDmF/roXUlVIpbRhk3
	PIehBY7yQP1ac771DqqDP4pZPdQGb41XQ9HfZLu/rpwSiTEppbgkNn5pzGiiMe78+hwxFKFXaz3Vw
	gIeU05rSHoBIpRs2CuIliCE6aEflWsfS78w3N9gdgED6r0rey2yOSayBsGiC+sd6N5L/g+gLsxRGQ
	CVzLvyMwa8dxIPFu7wUI+lCqBNSeLAroUEi+Y61PCdTvQtC2RYC/K2sHuo8by/zpZT3OgGooSNUG7
	06igMEiuG+ocESn7LkVAclQ55dkfSfSJ05sZM0wcVyAk193q1TW6yWEMCOlD/zlnmp/prYUgmcwI/
	FE6xrK/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xU27D-0000000C1KX-0fjE;
	Thu, 19 Nov 2026 13:23:51 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xU27A-0000000C1IL-2kus
	for linux-um@lists.infradead.org;
	Thu, 19 Nov 2026 13:23:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=lHO6Al5D1UOJ2GkOXkMdAANMBrRrim44AFinn44VGFc=; t=1795094628; x=1796304228; 
	b=xLuo+ZLGt3Ci2VR5KFX3peX0/femfcmQqfNlG+XtCWgKzcIBMhP78PCLnxaoo3cjAqn1wjhlKQk
	AvU3Z6fm/kDJ47fJS4tcpJaCPBGBZR81dep34LFqfeF6eWfAqmwZGxVa6+eWzKAxGzBd5KaokypZE
	zqefcPUWo2AaZ5zyEFi3Szn03QD7QvN5PZOgrnbWLNkQbJR1p6lD2T6iT/Yyy/fgSA6IKfCvZQTkj
	WpVVSXIm6boXNzIff6XbKHiwB+AdnOakXz/I9BVeImBJkct8TLGEKKqH60P7MEjp3JPdc/A5IgWyp
	KtCTJqPClmkMKLPEQcQMDaCrsNs1w8rCoC4Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1xU275-00000004LIl-3aJV;
	Thu, 19 Nov 2026 14:23:44 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: =?UTF-8?q?=E5=AD=9F=E4=BB=A4=E6=BE=B3?= <menglingao@xiaomi.com>,
	"Theodore Ts'o" <tytso@mit.edu>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	linux-kernel@vger.kernel.org
Subject: [RFC 0/3] um/random: reproducible random
Date: Thu, 19 Nov 2026 14:19:11 +0100
Message-ID: <20261119132340.225696-5-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.56.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261119_052348_697889_00FC9E50 
X-CRM114-Status: GOOD (  10.29  )
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

So these patches are *clearly* (except the first one maybe)
not something we actually want to apply upstream, but we've
been carrying them for years out-of-tree (no problem there)
and Lingao just asked because they have the same need when
testing BT (we did it for testing WiFi):
https://lore.kernel.org/linux-um/D2219FFB-73EF-4E27-B84A-5C8E550E3553@xiaomi.com/

The idea is to even get things like key derivation into a
reproducible state for tests, to make it easier to compare
and be sure the runs are the same.

So at least I figured I'd send them, maybe we _could_ consider
doing something like that behind a scary Kconfig option or one
that depends already on time-travel in UML, or ...

But even if this is going to fly like a lead balloon then the
patches are now out there for whoever wants to pick them up
and run with them when they have the same need.

johannes


