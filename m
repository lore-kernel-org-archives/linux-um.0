Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA051CAC58E
	for <linux-um@archiver.kernel.org>; Mon, 15 Sep 2025 06:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QlPxaZpQgAbJ15RgCwCxR2W4D+X5bJYrlbORaI22aqg=; b=KNe7efW/edFbKx2g6UkDfGWe7X
	wTTSOWYD4mkSdWok9T7wDfQ3OL0HV/f5vpKD4H9HciZrzFHuQUhBFkhwM/pGS/IvQ8Sny9XPd9RYR
	Iu/0hOZG4ciR/+vDVM/vgxeM3kt8KjbbvuzM8TvvHgQXTVUiYn5av34V+/aXzCTu0TwmjON9Pcgi+
	XlobbgjjWwWpuLveGay63/l88/arrxvdUrJWDznlKRtGB+HCQXg6O6RKB9rUOIXLX0d65DmtxPVqv
	gVH+SWCPkrbo7/jB7GCbP1dD1HDHhPddi+fXhf33aj/6q1ewcQN55UGJ9FUFqyWhvQZMpKnvdQOdB
	Nys1i6YA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uy2mG-00000002wCI-0sYd;
	Mon, 15 Sep 2025 06:33:28 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uy2mD-00000002wAh-1B5v
	for linux-um@lists.infradead.org;
	Mon, 15 Sep 2025 06:33:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=QlPxaZpQgAbJ15RgCwCxR2W4D+X5bJYrlbORaI22aqg=;
	t=1757918005; x=1759127605; b=s+XRkqyoULAb1F/R9F/xyUegh2E/7WS8w/eGunfLITUR36R
	t+YhmpML/bZOkcSdupIcWgfmbfG175puP/OgnNlzAQ+sFiSBOr/1kVL4RKSabd3Yh9TSDU6lKuYkM
	jAk6XRA+CUv2xvwMInlFUF01cfehL/j4neotca0mEGo2RixFzpuGbPVY2i8jPddjb338IJ6Ez+G0a
	s4tAhWBKi0YKyW5L0e6Z+4STLyT9hIH4mlsxuL33e7YHKwLFAqLtxe4eV+QE8ucKDK5+7WidDculP
	Y3oUEdG3Vt+iIYQ4/E/NVSUhZV5mjHcbP2alty6rnTxj17ObgAarxmla4eCP3evg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uy2lx-00000005sPh-0Vis;
	Mon, 15 Sep 2025 08:33:09 +0200
Message-ID: <8e75d6cc3847899ba8d6a0cbd0ef3ac57eabf009.camel@sipsolutions.net>
Subject: Re: [PATCH 1/4] PCI: Support FIXUP quirks in modules
From: Johannes Berg <johannes@sipsolutions.net>
To: Brian Norris <briannorris@chromium.org>, Bjorn Helgaas
 <bhelgaas@google.com>,  Luis Chamberlain	 <mcgrof@kernel.org>, Petr Pavlu
 <petr.pavlu@suse.com>, Daniel Gomez	 <da.gomez@kernel.org>
Cc: linux-pci@vger.kernel.org, David Gow <davidgow@google.com>, Rae Moar	
 <rmoar@google.com>, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, Sami Tolvanen	
 <samitolvanen@google.com>, Richard Weinberger <richard@nod.at>, Wei Liu	
 <wei.liu@kernel.org>, Brendan Higgins <brendan.higgins@linux.dev>, 
	kunit-dev@googlegroups.com, Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 	linux-um@lists.infradead.org
Date: Mon, 15 Sep 2025 08:33:08 +0200
In-Reply-To: <20250912230208.967129-2-briannorris@chromium.org> (sfid-20250913_010956_669404_FC913C9D)
References: <20250912230208.967129-1-briannorris@chromium.org>
	 <20250912230208.967129-2-briannorris@chromium.org>
	 (sfid-20250913_010956_669404_FC913C9D)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250914_233325_322650_48E89BE8 
X-CRM114-Status: GOOD (  21.54  )
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

On Fri, 2025-09-12 at 15:59 -0700, Brian Norris wrote:
> The PCI framework supports "quirks" for PCI devices via several
> DECLARE_PCI_FIXUP_*() macros. These macros allow arch or driver code to
> match device IDs to provide customizations or workarounds for broken
> devices.
>=20
> This mechanism is generally used in code that can only be built into the
> kernel, but there are a few occasions where this mechanism is used in
> drivers that can be modules. For example, see commit 574f29036fce ("PCI:
> iproc: Apply quirk_paxc_bridge() for module as well as built-in").
>=20
> The PCI fixup mechanism only works for built-in code, however, because
> pci_fixup_device() only scans the ".pci_fixup_*" linker sections found
> in the main kernel; it never touches modules.
>=20
> Extend the fixup approach to modules.

This _feels_ a bit odd to me - what if you reload a module, should the
fixup be done twice?=C2=A0Right now this was not possible in a module, whic=
h
is a bit of a gotcha, but at least that's only one for developers, not
for users (unless someone messes up and puts it into modular code, as in
the example you gave.)

Although, come to think of it, you don't even apply the fixup when the
module is loaded, so what I just wrote isn't really true. That almost
seems like an oversight though, now the module has to be loaded before
the PCI device is enumerated, which is unlikely to happen in practice?
But then we get the next gotcha - the device is already enumerated, so
the fixups cannot be applied at the various enumeration stages, and
you're back to having to load the module before PCI enumeration, which
could be tricky, or somehow forcing re-enumeration of a given device
from userspace, but then you're firmly in "gotcha for the user"
territory again ...

I don't really have any skin in this game, but overall I'd probably
argue it's better to occasionally have to fix things such as in the
commit you point out but have a predictable system, than apply things
from modules.

Perhaps it'd be better to extend the section checking infrastructure to
catch and error out on these sections in modules instead, so we catch it
at build time, rather than finding things missing at runtime?

And yeah, now I've totally ignored the kunit angle, but ... not sure how
to combine the two requirements if they are, as I think, conflicting.

johannes

