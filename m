Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07944606D804
	for <linux-um@archiver.kernel.org>; Sun,  8 Nov 2026 16:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=udptdid1;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LMb/InY+
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=Wcu90oheJug2lj3BwNXj66grQCAs2tghFU90gkm7ka0=; b=udptdid1DbdYMD
	YvdubZm5pqIQ48wq51Z51sk2aNFJyB4RxS3SHuSKmTdBFFl/kRft/wsvLdojfqcQ5bUvkEDW5Inix
	EnIcdmFaTBS+IB5vLqyAoWTlMJEwtAZ4WI4uaidrGWbd0XZrvH1YAALH+fbZn3ZtJWbEl4NnWn76r
	ZBAPmTlR29aBAEf7eBwRLTjVZt6pOLwlA69lCpbUd6gMv6hrc1zSAtcdHKpV9QH2eI7VyjVDLX6Uy
	kEa2rmbA8yTJCOqz1DV8gCaPghzwQxFT9pktxWY/NXVw11SZaLnzOJlSDGFHb0HFeG0YfiVR+SJtQ
	fHUn9s3E88hJ4tWcvw5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQ60v-0000000GP4d-3IAo;
	Sun, 08 Nov 2026 16:45:05 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQ60u-0000000GP4O-0c5o
	for linux-um@lists.infradead.org;
	Sun, 08 Nov 2026 16:45:04 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 4AFD04484C;
	Sun,  8 Nov 2026 16:45:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27BE51F00902;
	Sun,  8 Nov 2026 16:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794156302;
	bh=Wcu90oheJug2lj3BwNXj66grQCAs2tghFU90gkm7ka0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LMb/InY+MrS+2WjBowO5gDwe56iBMWk/+U/pzjTzyOOFrLyOHXBEC/PBZpPs1JEfK
	 roNSf4KUdqs9jicBTSdhr9dh+Njykr/hxCvyzqnkdUki+5p7TlXsLWHwl1oGSxZW8f
	 Da0/AYbLWksl6uG1bS2aLlgIbBQe8w2qnKu2zI1t6LWTKZksg7D97M3lzu+JgJYIlI
	 xBmIte+oCiLQmJ8yd4emZrbU1Px2M9e2eWNJUzo8lR8dnyaDnt592jrzCLYEbfyBVa
	 bhBOtZbOCEghMO5efF11uQ9sZwGfSfeabbSkaLHPOzfuNOpACkKmuKe28yRCnbkBYW
	 U6W6sJf3lb9AQ==
From: Sasha Levin <sashal@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>,
	gregkh@linuxfoundation.org,
	achill@achill.org,
	akpm@linux-foundation.org,
	broonie@kernel.org,
	conor@kernel.org,
	f.fainelli@gmail.com,
	hargar@microsoft.com,
	jonathanh@nvidia.com,
	linux-kernel@vger.kernel.org,
	linux@roeck-us.net,
	lkft-triage@lists.linaro.org,
	patches@kernelci.org,
	patches@lists.linux.dev,
	pavel@nabladev.com,
	rwarsow@gmx.de,
	shuah@kernel.org,
	sr@sladewatkins.com,
	stable@vger.kernel.org,
	sudipm.mukherjee@gmail.com,
	torvalds@linux-foundation.org,
	Carlos Maiolino <cem@kernel.org>,
	linux-xfs@vger.kernel.org,
	"Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	loongarch@lists.linux.dev,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org
Subject: Re: [PATCH 6.18 000/869] 6.18.63-rc1 review
Date: Sun,  8 Nov 2026 11:44:49 -0500
Message-ID: <20261108-rc-reply-03-xfs-6.18.63-rc1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261108155416.119775-1-ojeda@kernel.org>
References: <20261107134852.069646174@linuxfoundation.org> <20261108155416.119775-1-ojeda@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> In loongarch64, I am seeing again the XFS issue:

Thanks for the report. The xfs patch ("xfs: cross-reference the primary
superblock") is dropped again from 7.3, 6.18 and 6.12.

-- 
Thanks,
Sasha

