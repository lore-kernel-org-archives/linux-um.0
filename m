Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0181CCAC58D
	for <linux-um@archiver.kernel.org>; Thu, 11 Sep 2025 09:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6zJl6jcafeCZ6YmJZKiwF1mOHdjn2LFeup/aII/uTkE=; b=t5O3zupAz3rAb9qxKh6YTwTaoX
	hSoQH/MjoDxP2c4dCq0gDeRYbJq+7ukJcQssagyLwxXsMBAR5TuiII26uXASvcl0K5/k2nRkIf3CD
	eL+GIr0AuRN9i6AYluaeZMrzI38GUKHTtM/yWdJSCjbF8uz+6B3Ip8KYI1LLBo9POVPmdiX0ZY12R
	qT0kaN1iiksCUgCs03K6XynS8lbymqsSczS1sz+Kd50qT1VHAExR/8Bt84eA09x6uDgZc+ggAIcNp
	Z/DNBdp8HsQsJCqZ6jfyltvSNISRmRPPu7yn5/5TRHDEKMuE3AumG11wjWJLIqBCx21v4UrOptWXB
	OelphXHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwdfs-0000000290g-1gE9;
	Thu, 11 Sep 2025 09:33:04 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwdfq-000000028ys-02NP
	for linux-um@lists.infradead.org;
	Thu, 11 Sep 2025 09:33:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=6zJl6jcafeCZ6YmJZKiwF1mOHdjn2LFeup/aII/uTkE=;
	t=1757583181; x=1758792781; b=k/BNtu8IS74iKhRNOlJDL+9uuOt/OI9pDfYKk3/ipcnYHnq
	mP1XyAfYSbBtuesg6HTH5HGtQ4mi3LIRsREMv125GQQGg76Gd+/jJsVBu88zUCxyfbIpJADbMRlyz
	6WQaUDxE8ZcLo6bv7BBrs1o6L7LbPZN+1R1psnEtz+lyTN5Cv5yLu3wtgbsb99dGVIQcTLoWX9+L1
	ijYCusyYQJF3Nzsc3wBq6CLbkJZ2XOxTO1XmghE40qkf39mGZdu10qt5b1xHVaONs0V8r5UTvmh0n
	lUrNkXhdrYb5uxnF3J7nhIG5rmzkjmWEbf3bjHFg1AachyZyDoQq30dPZp1BWCbQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uwdfk-0000000F14S-3HyQ;
	Thu, 11 Sep 2025 11:32:57 +0200
Message-ID: <03cb4661a6135a641c5a3779f2cb424356b8e345.camel@sipsolutions.net>
Subject: Re: [PATCH v2 08/10] um: Add initial SMP support
From: Johannes Berg <johannes@sipsolutions.net>
To: Tiwei Bie <tiwei.bie@linux.dev>, richard@nod.at, 
	anton.ivanov@cambridgegreys.com
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, 
	benjamin@sipsolutions.net, arnd@arndb.de, tiwei.btw@antgroup.com
Date: Thu, 11 Sep 2025 11:32:56 +0200
In-Reply-To: <20250810055136.897712-9-tiwei.bie@linux.dev> (sfid-20250810_075311_619208_642A3A1A)
References: <20250810055136.897712-1-tiwei.bie@linux.dev>
	 <20250810055136.897712-9-tiwei.bie@linux.dev>
	 (sfid-20250810_075311_619208_642A3A1A)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250911_023302_048228_8A8D853C 
X-CRM114-Status: GOOD (  10.86  )
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

On Sun, 2025-08-10 at 13:51 +0800, Tiwei Bie wrote:
> From: Tiwei Bie <tiwei.btw@antgroup.com>
>=20
> Add initial symmetric multi-processing (SMP) support to UML. With
> this support enabled, users can tell UML to start multiple virtual
> processors, each represented as a separate host thread.
>=20
> In UML, kthreads and normal threads (when running in kernel mode)
> can be scheduled and executed simultaneously on different virtual
> processors. However, the userspace code of normal threads still
> runs within their respective single-threaded stubs.
>=20
> That is, SMP support is currently available both within the kernel
> and across different processes, but still remains limited within
> threads of the same process in userspace.

Another thing that isn't covered is anything relating to interrupt
affinity, I guess? Is that automatically not working, or will it look
like you can change things but that not do anything?

I don't think it's important now (though eventually I would actually
like to have it for our simulations), but was just thinking about it.

johannes

