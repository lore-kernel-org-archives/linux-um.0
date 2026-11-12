Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B988B606A31C
	for <linux-um@archiver.kernel.org>; Thu, 12 Nov 2026 07:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=O+SKkCC3;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.a=rsa-sha256 header.s=mail header.b=x/DD5Q0k
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=aNozQA4o1upURYxWaEXrzavAa/kCiQMOzOAXy/eko8A=; b=O+SKkCC3gSWE2MSGnbFeigZvZa
	RneGN5n6e00hF9/bWD8VxxjKHs0r+2TmZcqZ0z/UgVE6NnUXjgn8ko3XORD24Go+v6K+MeelTFV2N
	2P8dsCklgKHS7ad9Oxue/JiE9ZKt3lPKcU8BUXXSeZgqto3JLG5akHVmDTDlQVsgRH+9gsZo7i0id
	tjxfYBbuoHJwfOYPIr8a+RMnD7wqLV0vocHzehYjbIdZxitev1glgIwlAtuUKjVnrqiMfL5/L/dVQ
	ZAWOVflni69jkIS47iRo7N7uADcCyUUyRzRjqc4Zu0iWXxZTdmCPk2AcNenJx0OaZjvAJGShiVAzh
	cGdy9wiQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRPEw-00000008vms-0tKh;
	Thu, 12 Nov 2026 07:28:58 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRPEq-00000008vid-1B4x
	for linux-um@lists.infradead.org;
	Thu, 12 Nov 2026 07:28:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=aNozQA4o1upURYxWaEXrzavAa/kCiQMOzOAXy/eko8A=;
	t=1794468532; x=1795678132; b=x/DD5Q0k/6KxMCBViuL9nbt60c4/eNehWaH6gcLlRfTC1nA
	X4EzWKyu3vZShi4wQVedWoUtMS08bzKn+DJzGwJI/CU1tRZRZFBcrwmlrK7CXVr8Ziu32+nFa5yMV
	r8jlltJXWS3FEp0qNRVBacv5pIfJlYy2mGUwFBuJGlnb1wmPTkEwS+kSeZ01OO+HOT+JolRZ9lGt0
	EK/nfjsL0OOPG9p37u574LJ7OHlrm8G869QXqaTtvDBmLEYUYZxnlcqgiZ7GvMNM9uglzaB+BrKlB
	nR774vYDk/LVwEdQaLrllChamJQwPIr5mxxFgS0DTt0jCKgbuH/4lCbiOlaG9Maw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1xRPEd-0000000691I-39rv;
	Thu, 12 Nov 2026 08:28:39 +0100
Message-ID: <199b6e10af2267bb60e7e73fda243f73b1b818ad.camel@sipsolutions.net>
Subject: Re: [PATCH 1/3] um: Define kernel_fpu_begin_mask()
From: Johannes Berg <johannes@sipsolutions.net>
To: Eric Biggers <ebiggers@kernel.org>, akpm@linux-foundation.org, 
	linux-raid@vger.kernel.org
Cc: linux-crypto@vger.kernel.org, x86@kernel.org, Christoph Hellwig
 <hch@lst.de>,  Richard Weinberger	 <richard@nod.at>, Anton Ivanov
 <anton.ivanov@cambridgegreys.com>, 	linux-um@lists.infradead.org
Date: Thu, 12 Nov 2026 08:28:38 +0100
In-Reply-To: <20261111205604.47547-2-ebiggers@kernel.org>
References: <20261111205604.47547-1-ebiggers@kernel.org>
	 <20261111205604.47547-2-ebiggers@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261111_232852_354782_F5830C4F 
X-CRM114-Status: UNSURE (   8.26  )
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
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 2026-11-11 at 12:56 -0800, Eric Biggers wrote:
> Define a stub for kernel_fpu_begin_mask() on user-mode Linux so that
> lib/raid/ can switch from kernel_fpu_begin() to kernel_fpu_begin_mask().
>=20
> Note: this causes a checkpatch error due to the macro's value not having
> outer parentheses, but it's left as-is for consistency with the existing
> kernel_fpu_begin() and kernel_fpu_end() definitions right next to it.
>=20

Probably should've CCed linux-um (done now), but the change seems fine.
There's no FPU handling needed in UM since the host kernel deals with
it.

johannes

