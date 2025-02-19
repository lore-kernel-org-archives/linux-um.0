Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F449C021AA
	for <linux-um@archiver.kernel.org>; Wed, 19 Feb 2025 07:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IYZV4DKyRp83gdcIJ59Kj8qWqMhJv05T8ZY9PYuaYMU=; b=miqScXmzZAHRRAVEJwr5Mjw776
	yx0lUcQNV3vHEATo/VeotkB3t/F4uru+OEDybloEOmSpo4M56LtUJJaXMYVRXV3AdUTXwVoD4tTlF
	319LmYcxvIalf6ThcEFq/P0QRsk82fWCzB33A/GUHgJlCikVVxj8AdLU/ly2FRxy0qtdv4nf9Oh95
	8f92tzxWu9PYWqodUN2y4RBcw9CVGaLY41qKZ1lvj/acGzyIlmtCz7Gbli20amztL7OouqaCg2OhW
	ew83HNCXArh6lhmeE2FpKrpbDrb8FIqXiJg7ySeZM2jmH1EjYQE84Gn+d87TmJf5pfbT4s4qsS3d9
	s+mZTs6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tkekj-0000000BJvN-3QhO;
	Wed, 19 Feb 2025 07:44:17 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tkej0-0000000BJOG-3r2w
	for linux-um@lists.infradead.org;
	Wed, 19 Feb 2025 07:42:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=IYZV4DKyRp83gdcIJ59Kj8qWqMhJv05T8ZY9PYuaYMU=;
	t=1739950948; x=1741160548; b=tVi7mKEEjT997yD7Zs3v+Q+I6ZGSJ5GIfOzOCYiTOSPSlkH
	a/4eZhEcTAfnRpnGWNlaCJCtJAhUYwt7UoHZ/EY1iQ9S++kBngAAXLDBIZrIv4RPLxshoy7sJzpty
	jFGCqg5hJAco+nlqnu0iqHzOGqaQiz/cjIoyvTqP1xeVRklQHyGd9boGq8G9o0YNluhIERaSPMA4Y
	uIWN+ALb/sbhSFhrzFbEhOKKWZWxl/jTKvfha/sulk7JtXr9i2sKC7VYqrTWijLz4GSgNdCseu0Yo
	2LG/FGkCovpvz3XW9k7HGflulu7U+Oykl5on0EsQzFqM66PRKnWAvRf8UkTWL6yA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tkeiZ-00000002TFX-0bSF;
	Wed, 19 Feb 2025 08:42:03 +0100
Message-ID: <c993aa3a8e86e429d2135974929283a33d0f34ca.camel@sipsolutions.net>
Subject: Re: [PATCH AUTOSEL 6.6 14/17] um: virt-pci: don't use kmalloc()
From: Johannes Berg <johannes@sipsolutions.net>
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Cc: Richard Weinberger <richard@nod.at>, anton.ivanov@cambridgegreys.com, 
	mst@redhat.com, jiri@resnulli.us, tglx@linutronix.de,
 viro@zeniv.linux.org.uk, 	krzysztof.kozlowski@linaro.org,
 herve.codina@bootlin.com, 	linux-um@lists.infradead.org
Date: Wed, 19 Feb 2025 08:42:01 +0100
In-Reply-To: <20250218202743.3593296-14-sashal@kernel.org>
References: <20250218202743.3593296-1-sashal@kernel.org>
	 <20250218202743.3593296-14-sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250218_234230_957406_974E9598 
X-CRM114-Status: UNSURE (   8.92  )
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

On Tue, 2025-02-18 at 15:27 -0500, Sasha Levin wrote:
> From: Johannes Berg <johannes.berg@intel.com>
>=20
> [ Upstream commit 5b166b782d327f4b66190cc43afd3be36f2b3b7a ]
>=20
> This code can be called deep in the IRQ handling, for
> example, and then cannot normally use kmalloc(). Have
> its own pre-allocated memory and use from there instead
> so this doesn't occur. Only in the (very rare) case of
> memcpy_toio() we'd still need to allocate memory.

I don't believe this patch, "um: convert irq_lock to raw spinlock" and
"um: virtio_uml: use raw spinlock", are relevant to anything older than
6.12. I don't see how applying them would _hurt_, but I didn't have them
before 6.12 and had no lockdep complaints about it; I believe some other
internal IRQ rework caused the issues to pop up.

Never mind that we (Intel WiFi stuff) are probably the only ones ever
running this virtio_uml/virt-pci with lockdep :)

johannes

