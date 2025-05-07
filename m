Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D8C4C3ABBF
	for <linux-um@archiver.kernel.org>; Wed,  7 May 2025 20:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ebkk7je51it2yTRu26KTlGS0o/RB79MYisu9ONfqvPs=; b=WpUEQ5vemMmRzfIAgAsdLYo0Jb
	sXhiGF21E80ZqN02+D2zKlNsPeOhA+Eg6u434JTnlUvmIrGQMBtl9xAZ0MNu7AqA1tSMEpgpME6w9
	pviZS3PhkR1cHtDq3+d+4/eD7vZpukHojXcuxXMsE3oVaquCfA3g6hwxgy0GtYqK1fOjBgrobimzq
	PRp5YHgmY7bq7mysJ3X0yBSTk41DE0MR99dHGyJ8dl347WdcuMrYXZIkv5RJTWLDUmX8C6+PcaEiM
	Ff1RPmBfR2iKUqLL2feNyZ3uKFaj+ePJogMhYo63qMEd3LMM3hWvFMMvKjC4IhKO5w279Kdkzi9YF
	0s4wV3fg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uClVQ-0000000GhLb-06er;
	Wed, 07 May 2025 20:36:40 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uClVL-0000000GhKK-1A1c
	for linux-um@lists.infradead.org;
	Wed, 07 May 2025 20:36:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Ebkk7je51it2yTRu26KTlGS0o/RB79MYisu9ONfqvPs=;
	t=1746650194; x=1747859794; b=aENTxqdUewQvFXBBFjJYg9rGtKEk0nw6eo4TjewKJCBwKri
	7JetybJCpqG4kHEAqLpjFv9DefTFBukgyapKmI1hcoK+02LmmvRYR1NrYAX04ej1+kpaHISRQDRIq
	CFOVNOEQVqB4cEAtJFnnJOVigrX6+FLr0Nd1/6WlMzzlNk0HspSBajGwOAF/W0rnGe5sDOa0Svf/C
	VtG2ODvOV32ws56qiP6IIeTmYjGU/5K99vq819zsJKDnmAY8QdSMdyM0zaR50u3wUUe3IdaNNVXFj
	LBuwnfHxiTlZDRXMPvarEJWoP7CHkecUVHtZmeE3o9/SIdNYKMFE0IlRxo/NOmIA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uClVH-00000008YNN-1Tjh;
	Wed, 07 May 2025 22:36:31 +0200
Message-ID: <007a7132d1396912b1381e96cc4401a10071ed24.camel@sipsolutions.net>
Subject: Re: [tip: x86/msr] um: Add UML version of <asm/tsc.h> to define
 rdtsc()
From: Johannes Berg <johannes@sipsolutions.net>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
 "linux-tip-commits@vger.kernel.org"
	 <linux-tip-commits@vger.kernel.org>
Cc: lkp <lkp@intel.com>, Ingo Molnar <mingo@kernel.org>, "x86@kernel.org"
	 <x86@kernel.org>, linux-um@lists.infradead.org
Date: Wed, 07 May 2025 22:36:30 +0200
In-Reply-To: <174664324585.406.10812098910624084030.tip-bot2@tip-bot2>
References: <202505080003.0t7ewxGp-lkp@intel.com>
	 <174664324585.406.10812098910624084030.tip-bot2@tip-bot2>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250507_133635_316908_CCABBCE3 
X-CRM114-Status: GOOD (  12.81  )
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

+linux-um

On Wed, 2025-05-07 at 18:40 +0000, tip-bot2 for Ingo Molnar wrote:
>=20
> To resolve these kinds of problems and to allow <asm/tsc.h> to be include=
d on UML,
> add a simplified version of <asm/tsc.h>, which only adds the rdtsc() defi=
nition.

OK, weird, why would that be needed - UM isn't really X86.

>  arch/um/include/asm/tsc.h | 25 +++++++++++++++++++++++++

Feels that should be in arch/x86/um/asm/ instead, which I believe is
also included but then at least pretends to keep the notion that UML
could be ported to other architectures ;-)

> +static __always_inline u64 rdtsc(void)
> +{
> +       EAX_EDX_DECLARE_ARGS(val, low, high);
> +
> +       asm volatile("rdtsc" : EAX_EDX_RET(val, low, high));
> +
> +       return EAX_EDX_VAL(val, low, high);
> +}

Though I also wonder where this is called at all that would be relevant
for UML? If it's not then perhaps we should just make using it
unbuildable, a la

u64 __um_has_no_rdtsc(void);
#define rdtsc() __um_has_no_rdtsc()

or something like that... (and then of course keep it in the current
location). But looking at the 0-day report that'd probably break
building the driver on UML; while the driver doesn't seem important we
wouldn't really want that...

Actually, that's just because of the stupid quirk in UML/X86:

config DRM_ACCEL_HABANALABS
        tristate "HabanaLabs AI accelerators"
        depends on DRM_ACCEL
        depends on X86_64

that last line should almost certainly be "depends on X86 && X86_64"
because ARCH=3Dum will set UM and X86_64, but not X86 since the arch
Kconfig symbols are X86 and UM respectively, but the UML subarch still
selects X86_64 ...


I dunno. I guess we can put rdtsc() into UML on x86 as I suggested about
the file placement, or we can also just fix the Kconfig there.

johannes

