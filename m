Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9F55C282EC
	for <linux-um@archiver.kernel.org>; Tue, 18 Mar 2025 10:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vJv1KkdXbPcvAghM29T8PsBL8Lb4ASjOFhvS2uQ91tE=; b=Q4WOHMSiJQtxMJurRh3J5f9rt6
	eJ8OiED3G1GplfzHeIiajmawTRSRrLQ3EW+byH9kXYmlYrC8J0797d8uHhzWPNPEZG8qJ1Z5sm7X6
	2p0MO5dnju/nJkC2jAsAjvC4l9Pz0qVr0PNZQfOd+l97PrKBahbS/Ows59Su4zS9EeWzxSL/0XhPH
	3z0vNkXB9kHwrZXxlxFqvGMdg1X2+wWTwU/ZnmYacfryMYO1Hj0axQ0cjWTnTuU88K1E5mUCKtm6x
	D/Xhxak5MGPhUrW2FL665tDLbt3mcqQJDLOI0mr2xXQml92MsuvsPI6lxZQgbbgt6KjhCp2GqHlP5
	lS8FMfWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tuTk6-00000005PbE-3jYu;
	Tue, 18 Mar 2025 10:00:14 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tuTk1-00000005PXo-3Zcw
	for linux-um@lists.infradead.org;
	Tue, 18 Mar 2025 10:00:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=vJv1KkdXbPcvAghM29T8PsBL8Lb4ASjOFhvS2uQ91tE=;
	t=1742292007; x=1743501607; b=TeJwVBvxGSQjTuEjrUERrN/XW0NV7u5hliNGC1v9dTPwrWU
	JjwEv942DDZBuDDJ1dk2Zm/fx/6wZPoKbYJ9bWFVeA7I0dSLtw3R4Nr+7FhTtUfemQE6RpjUnIzh1
	a+MRCua4acO0HxvX6Tte/ACDLvTWRYBSRayt/a/bwDdJrRFGhMVK8l2Xl38L+LqO176qsHXNQ+8cv
	ioHytm7qWDxrGJRcnkQQUR0wqX7bgHss2u2/EbipbVln4xL61oUvpYVtWbtKyNYdc6uIRFX9ZG7kK
	qpxpkFll38CpvgqKWG4rPXSIFUNCvPXC7aCxmAy/gJ26BSWBNiU5sQirTfCxjNUw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tuTjs-0000000FCgD-2h9m;
	Tue, 18 Mar 2025 11:00:00 +0100
Message-ID: <45e2f8f566539a766bc7e089e71211e320bc4fa6.camel@sipsolutions.net>
Subject: Re: [PATCH 35/41] um: Replace __ASSEMBLY__ with __ASSEMBLER__ in
 the usermode headers
From: Johannes Berg <johannes@sipsolutions.net>
To: Thomas Huth <thuth@redhat.com>, linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Richard
 Weinberger <richard@nod.at>, Anton Ivanov
 <anton.ivanov@cambridgegreys.com>, 	linux-um@lists.infradead.org
Date: Tue, 18 Mar 2025 10:59:59 +0100
In-Reply-To: <20250314071013.1575167-36-thuth@redhat.com>
References: <20250314071013.1575167-1-thuth@redhat.com>
	 <20250314071013.1575167-36-thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250318_030010_159776_1F5DC870 
X-CRM114-Status: UNSURE (   9.57  )
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

On Fri, 2025-03-14 at 08:10 +0100, Thomas Huth wrote:
> While the GCC and Clang compilers already define __ASSEMBLER__
> automatically when compiling assembly code, __ASSEMBLY__ is a
> macro that only gets defined by the Makefiles in the kernel.
> This can be very confusing when switching between userspace
> and kernelspace coding, so let's standardize on the __ASSEMBLER__
> macro that is provided by the compilers now.
>=20
> This is a completely mechanical patch (done with a simple "sed -i"
> statement).
>=20

Looks fine, I guess - I'll assume that since it's part of a larger
series you'll merge it elsewhere.

johannes

