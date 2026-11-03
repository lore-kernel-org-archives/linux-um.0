Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9815E606A324
	for <linux-um@archiver.kernel.org>; Tue,  3 Nov 2026 09:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=KlYin5we;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=sipsolutions.net header.i=@sipsolutions.net header.a=rsa-sha256 header.s=mail header.b=PmZrCt7H
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=NHC/W/gqv+Qqn4a4TsBq86CO1FFN/ZhrxFdSCl41UpM=; b=KlYin5wep8JeYNNLjl2fUWw2oa
	b4V1J6MmTc4q3yL+T+Hv25XEMWQ6Mn2eLFWva0FhhhuDShy4rKqON3PEDIauWN2RwUPqF28x3fHJ2
	Wa1lZ2IPBUKtZWV6cvlOyRSoRvV/7F112JSUvZlKZJGsG7Qb7+UyVsPLfgbrs2bdKDgtPKO7zXS0U
	BVHIWG9AN3vIZkL26t7gnagaAMPpEoti4oSYPbTtWZEsiZ7rGXYQ1wBEsjVmFvlPFnID7W/HlcgMr
	YwR/rrgSHh/jGEswm31i34iKTF1EqMQq+RADPR2i0EkMBQQlOZ039/kfd6K88wAQ0NxEBIuWhXmgB
	FnmWd4Mg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOB1n-00000001mk7-1QNt;
	Tue, 03 Nov 2026 09:42:03 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOB1k-00000001mj0-3ise
	for linux-um@lists.infradead.org;
	Tue, 03 Nov 2026 09:42:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=NHC/W/gqv+Qqn4a4TsBq86CO1FFN/ZhrxFdSCl41UpM=;
	t=1793698920; x=1794908520; b=PmZrCt7HezFmqNhJS8gCC6ORsmmYbFmy14jInnTVRA2ojX+
	HDJHhIidZRPSQmWYHE2UooZaIDSsimd/laLN7RVbQZp7euk0RCYN4wxa0AGOUElODn7wlY7eoCk98
	N3cyxZmdYum5uEBPMNnOru0YmTpxkdhBPvzY0OXAeYGvhrSf4o7Iw3e1cANCSulpSG700becHJiml
	vbJ2rle52k5AUWgCMrE8JubagxYAQVtmgOBYAyde0/537z6zQZq97kAgrsGuctre4nE/Kw9blBQxZ
	I+4l/yInhO03Cfw6OLSpScU7h3IJl7yjo3txKk2VkUgVgTv+/sXkwvWVycX2tl9A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1xOB1h-00000003EdL-13tM;
	Tue, 03 Nov 2026 10:41:57 +0100
Message-ID: <635ef2ffdf7c77a35a3c32e5c569b8e46efb9ac0.camel@sipsolutions.net>
Subject: Re: [PATCH] um: vector: Possible underflow and races fixes
From: Johannes Berg <johannes@sipsolutions.net>
To: anton.ivanov@cambridgegreys.com, linux-um@lists.infradead.org
Cc: richard@nod.at, mst@redhat.com
Date: Tue, 03 Nov 2026 10:41:56 +0100
In-Reply-To: <20261021130648.3373281-1-anton.ivanov@cambridgegreys.com>
References: <20261021130648.3373281-1-anton.ivanov@cambridgegreys.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261103_014200_927372_8ABCCC67 
X-CRM114-Status: GOOD (  10.75  )
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

On Wed, 2026-10-21 at 14:05 +0100, anton.ivanov@cambridgegreys.com
wrote:
> From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
>=20
> Michael S. Tsirkin while working on net virtio checksum hardening
> discovered a number of issues in the uml vector driver. This patch
> addresses these issues.
>=20
> 1. Use of header_size, not rx_header_size in some of the runt/underflow
> checks. IPV6 raw socket API for protocols like GRE or L2TPV2 is asymmetri=
c -
> the header format and size in recv and send differ. All rx checks must us=
e
> the rx specific size.
>=20
> 2. Vector reuses rx and tx queue locks for stats. These queues are not
> always allocated as some transports do not use them and they can be
> disabled on the kernel command line. Resetting or accessing ethtool stats
> in this case could lead to a null pointer dereference.
>=20
> 3. virtio_net_header processing was not up to date with all the GSO
> additions and changes and was skipping necessary processing.
>=20
> 4. Missing barrier in vector_send().
>=20
> 5. Incorrect timer destruction in net_close()

This doesn't apply, could you resend it?

Thanks,
johannes

