Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7A95CAC59A
	for <linux-um@archiver.kernel.org>; Thu, 18 Sep 2025 08:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/6bLOYTVutz7OZnWxHl9S+ZPChBSh4f/PGlIXbAKrEI=; b=A8CHU9gy18HUl/76fDxCjsuePX
	+7/hnMyniNJWT6fzVNeHXU8hou6AxZey1RD0oZakohULemb8ei/zSzy71JYwDC7fanYzjMwqsfMlA
	Nyxp/FH3LHpdjqumeSudoxVRre0SAuu1iwuYuaoEoMv883CrcKG6Btt2Ka0+BuIajsgHNBUtCQNSW
	SWQuU8ZiZ3arcc78h1zx5ksT0Ow2gJZ7vbYjvIRbBGb19OaR8Kly++BPuaTFroD7AxyW8T9lG8Bv6
	g1bxRpqmvlcQFpBhsi8n2lH0jCqdxAOIJkZZ5mhw8ph0yT6sqoNL3cZg7KFNK4Is0qCp+0Pjhb0Gb
	U3MrZIvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzA28-0000000Gheh-1JSA;
	Thu, 18 Sep 2025 08:30:28 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzA25-0000000Ghci-3Y4a
	for linux-um@lists.infradead.org;
	Thu, 18 Sep 2025 08:30:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=/6bLOYTVutz7OZnWxHl9S+ZPChBSh4f/PGlIXbAKrEI=;
	t=1758184225; x=1759393825; b=aZM1oanBw0a9pHJZt2IjqJnhYcxFJYRybyjsD1b6GMZp56x
	qjqMbxWrHVHASUdaYt1IFcnq7y5IHxeuO+oZtFYJjHQP8h7c9YQ2gq4Ftpk2WkjsyTT7TqcLf0+EA
	TFYPBALnjunYB64RPBCCTsN6JfeaVzo/ybubXCVs7e/ujlDDK7CRk/WtS3JMTk3EAE40pcxg2Gjv1
	3CSKIIq5it1KZVuOd3RBIANijedBI7Mgap2gBIyEBjmor9cSemd2XXK6ED2CV5LGpY5QUGamq/fqL
	6gprK/j1E4h1gNa3NCPsYv9uTmwKRhyeX1ZXLzMrMaNJ0SJtf5+CgZNaLz4GC39Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uzA22-0000000D9Ud-3eu7;
	Thu, 18 Sep 2025 10:30:23 +0200
Message-ID: <a58620ecefa207e141a435c36492647c3d5bd3df.camel@sipsolutions.net>
Subject: Re: [PATCH RESEND v11 10/13] um: nommu: a work around for MMU
 dependency to PCI driver
From: Johannes Berg <johannes@sipsolutions.net>
To: Hajime Tazaki <thehajime@gmail.com>, linux-um@lists.infradead.org
Cc: ricarkol@google.com, Liam.Howlett@oracle.com,
 linux-kernel@vger.kernel.org
Date: Thu, 18 Sep 2025 10:30:22 +0200
In-Reply-To: <4a9dde10c586883d20a8201ca7d76e6d7d52eaf4.1758181109.git.thehajime@gmail.com>
References: <cover.1758181109.git.thehajime@gmail.com>
	 <4a9dde10c586883d20a8201ca7d76e6d7d52eaf4.1758181109.git.thehajime@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250918_013025_886895_1D572CEC 
X-CRM114-Status: UNSURE (   9.68  )
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

On Thu, 2025-09-18 at 16:39 +0900, Hajime Tazaki wrote:
> The commit 8fe743b5eba0 ("PCI: Add CONFIG_MMU dependency") restricts the
> PCI base driver to depend on MMU.  While nommu UML _can_ implement PCI
> drivers over PCI devices (e.g., virtio-pci), the current nommu UML
> doesn't implement it.
>=20
> But without PCI drivers kunit complains as config for kunit
> (arch_uml.config) defines the dependency to PCI drivers.
>=20
> This commit fixes the issue of this compile failures when building PCI
> drivers with nommu UML.  In particular, the fix is to undefine the
> constant PCI_IOBASE to be able to bypass pci_unmap_iospace() call.

This doesn't make a lot of sense to me. Why would we even want to build
PCI on NOMMU-UML if PCI in general is dependent on MMU now?

It's not like ARCH=3Dum with PCI and NOMMU has any value even for testing
if such a configuration cannot exist in reality?

johannes

