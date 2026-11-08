Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1FE606A321
	for <linux-um@archiver.kernel.org>; Sun,  8 Nov 2026 15:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=0cqFf9EO;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZJmK8oUf
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=5GBHjUTFcUUKHRDe6Uz5ToMncS7KWKXWOvxbmPEhwVE=; b=0cqFf9EOhPg9Up
	huj1S4y72d3hH4gfqUWK+W+8lCFAmhUYvPyNHQ9oh14jWtcmFywWkZJ0hfpX2rdOq1MhD9PQT667E
	QWz7byILdjkX9dnof6JXuOItOydOF+qtHcNbBA0LLCbppzml+dNPyOD2beReUj5WrfScgfs7lYx5y
	N/m2bOv0v4leSe38qP3/OFSJSHaIjdTMwl4u0CKCE0i0mST5KhnaE08FPXqy3E7DJ1bQXQXyyn5aL
	kcMP8VUeXdPnIWzMQW03T7dCCEkcRZKpmXcR0uGQc1NSWfZxJ4g/dM1yoGFaunerp5brviuTGvFx0
	GBj79x8N877v+74L0/pw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQ5E1-0000000GMiM-0E0t;
	Sun, 08 Nov 2026 15:54:33 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQ5Dz-0000000GMiG-0pDS
	for linux-um@lists.infradead.org;
	Sun, 08 Nov 2026 15:54:31 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 6A27160008;
	Sun,  8 Nov 2026 15:54:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 041841F0089F;
	Sun,  8 Nov 2026 15:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794153270;
	bh=5GBHjUTFcUUKHRDe6Uz5ToMncS7KWKXWOvxbmPEhwVE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZJmK8oUfB5GK4SbMw3dQ4gH4wjlNa4ufA6yaxygD3Pbs5aQPHdlk4heug6b52tepR
	 HDxpJJlU8tRKZUgzaTxtMt5yfwa6BJUtuObFCmPlQp5ro1G/aANuVZyCqpQyvuACBd
	 xQCn+U+Ijo6zuGkJ2P84IAnkz63BANh0VFfve8TpGzqv/J3WeIZpC75uiyvmv2YXa8
	 TsQJxAJxz8iLLP+w6S1PYYF6XGDXOJq7Yspz2c9uANiujJOPDZ53koYaa7XAmvDESh
	 qfV16MLzWmPUrgefTB0jcFCI8f2brVRUadBdyxsFQ5aUyC1DtJHF8qO9VpNcFrUyj0
	 FSoBfoNzq3IQw==
From: Miguel Ojeda <ojeda@kernel.org>
To: gregkh@linuxfoundation.org
Cc: achill@achill.org,
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
	Miguel Ojeda <ojeda@kernel.org>,
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
Date: Sun,  8 Nov 2026 16:54:16 +0100
Message-ID: <20261108155416.119775-1-ojeda@kernel.org>
In-Reply-To: <20261107134852.069646174@linuxfoundation.org>
References: <20261107134852.069646174@linuxfoundation.org>
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, 07 Nov 2026 08:44:42 -0500 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.18.63 release.
> There are 869 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Mon, 09 Nov 2026 13:46:08 +0000.
> Anything received after that time might be too late.

Boot-tested under QEMU for Rust x86_64, arm64 and riscv64; built-tested
for loongarch64 and arm32:

Tested-by: Miguel Ojeda <ojeda@kernel.org>

In loongarch64, I am seeing again the XFS issue:

  https://lore.kernel.org/stable/20261106071743.90363-1-ojeda@kernel.org/

Cc: Carlos Maiolino <cem@kernel.org>
Cc: linux-xfs@vger.kernel.org
Cc: Darrick J. Wong <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>

Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>
Cc: loongarch@lists.linux.dev

For completeness, for UML I have been seeing (I will skip reporting these):

  arch/um/drivers/ubd_kern.c:780:13: warning: stack frame size (1480) exceeds limit (1024) in 'ubd_device_release' [-Wframe-larger-than]

  lib/kunit/test.c:684:5: warning: stack frame size (1208) exceeds limit (1024) in 'kunit_run_tests' [-Wframe-larger-than]

Cc: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-um@lists.infradead.org

Thanks!

Cheers,
Miguel

