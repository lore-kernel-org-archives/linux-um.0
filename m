Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73741C3ABBE
	for <linux-um@archiver.kernel.org>; Thu,  8 May 2025 09:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=69xk8QN9LbecGAAun+SdXIlnEDtczaO/7wGswwvBris=; b=mywjTpx+mxiv5EPgzv/TtGuqw2
	Tv8Y+8P4jTinSgCVpmy8IFGrFxuABmZJVtu0Wqkv8MS1r/pV4b1tnaeF8fJ1qHCTt5QZfNUmOvE+x
	LRpHEJYX3H8nzuE/smK1Awd4M5+i7QOs4+sbOGsBLJEjpjoDXiLnw3HUqlRmShZijOLUMlcAhtZ50
	/Wm3cJrHvFoZT/Qm4WKMa5FZUUzclixCqTMYRSCKvI+C2JdG/vNLrx7TsDiEtxoNQwZTG04yslZ2Z
	OtWxPuo54mD38GR51FgBGhbfPJf/8MhGnvHeRR4Igs2RWBGO/7qm6xHVzy8ilq/QWuIkBpRYRlsaz
	bzfqvWkQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCxOI-00000000EiI-0MHQ;
	Thu, 08 May 2025 09:18:06 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCx4n-00000000BiA-0JJe
	for linux-um@lists.infradead.org;
	Thu, 08 May 2025 08:57:59 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 2A677A4AFCE;
	Thu,  8 May 2025 08:57:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48B85C4CEEB;
	Thu,  8 May 2025 08:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746694675;
	bh=wHPATXC9LkJsZRMeS2x8lNdgUXoYaxjzLb5iBN80POk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m+bi/J7r34LfUr94fxQXkxjMN93ATfTaQ26PPYNkdilIHd3MkJ78rtWPVgL7iTZ3c
	 DZZEL8XgkNfveoCLgQemc6R6LWGfBb98fV4a/b9oqP+4ttnKUy7KLhFbwHZYBtQgKE
	 kaWTMbPIwphXJyXeF3QoOwjNv4B7c7egGeE/fiAzh57y9UdQx0acsfVHhWmVHBeeGu
	 DcDcmZlpKWfcHJfQeAwvwfTyo7RyhpSvmnPKdUhic3BKS8Gh7m0ZLad/d4DcHQhLaA
	 hPd5scmwhnFt8Acf71o5Tz8i1C/PxZyzByZBIDgJd0u2pznhweP4PDli34VM/Wrnn/
	 vaGJoIVprpjpQ==
Date: Thu, 8 May 2025 10:57:51 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-tip-commits@vger.kernel.org" <linux-tip-commits@vger.kernel.org>,
	lkp <lkp@intel.com>, "x86@kernel.org" <x86@kernel.org>,
	linux-um@lists.infradead.org
Subject: [PATCH -v2] accel/habanalabs: Don't build the driver on UML
Message-ID: <aBxyDyVT5QbOlhPq@gmail.com>
References: <202505080003.0t7ewxGp-lkp@intel.com>
 <174664324585.406.10812098910624084030.tip-bot2@tip-bot2>
 <007a7132d1396912b1381e96cc4401a10071ed24.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <007a7132d1396912b1381e96cc4401a10071ed24.camel@sipsolutions.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250508_015757_252149_D681D070 
X-CRM114-Status: GOOD (  29.94  )
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


* Johannes Berg <johannes@sipsolutions.net> wrote:

> +linux-um
> 
> On Wed, 2025-05-07 at 18:40 +0000, tip-bot2 for Ingo Molnar wrote:
> > 
> > To resolve these kinds of problems and to allow <asm/tsc.h> to be included on UML,
> > add a simplified version of <asm/tsc.h>, which only adds the rdtsc() definition.
> 
> OK, weird, why would that be needed - UM isn't really X86.
> 
> >  arch/um/include/asm/tsc.h | 25 +++++++++++++++++++++++++
> 
> Feels that should be in arch/x86/um/asm/ instead, which I believe is
> also included but then at least pretends to keep the notion that UML
> could be ported to other architectures ;-)
> 
> > +static __always_inline u64 rdtsc(void)
> > +{
> > +       EAX_EDX_DECLARE_ARGS(val, low, high);
> > +
> > +       asm volatile("rdtsc" : EAX_EDX_RET(val, low, high));
> > +
> > +       return EAX_EDX_VAL(val, low, high);
> > +}
> 
> Though I also wonder where this is called at all that would be relevant
> for UML? If it's not then perhaps we should just make using it
> unbuildable, a la
> 
> u64 __um_has_no_rdtsc(void);
> #define rdtsc() __um_has_no_rdtsc()
> 
> or something like that... (and then of course keep it in the current
> location). But looking at the 0-day report that'd probably break
> building the driver on UML; while the driver doesn't seem important we
> wouldn't really want that...
> 
> Actually, that's just because of the stupid quirk in UML/X86:
> 
> config DRM_ACCEL_HABANALABS
>         tristate "HabanaLabs AI accelerators"
>         depends on DRM_ACCEL
>         depends on X86_64
> 
> that last line should almost certainly be "depends on X86 && X86_64"
> because ARCH=um will set UM and X86_64, but not X86 since the arch
> Kconfig symbols are X86 and UM respectively, but the UML subarch still
> selects X86_64 ...
> 
> 
> I dunno. I guess we can put rdtsc() into UML on x86 as I suggested about
> the file placement, or we can also just fix the Kconfig there.

The Kconfig solution looks much simpler to me too :)

Patch attached, does this look good to you?

Thanks,

	Ingo

===================================>
From: Ingo Molnar <mingo@kernel.org>
Date: Wed, 7 May 2025 20:25:59 +0200
Subject: [PATCH] accel/habanalabs: Don't build the driver on UML

The following commit:

  288a4ff0ad29 ("x86/msr: Move rdtsc{,_ordered}() to <asm/tsc.h>")

removed the <asm/msr.h> include from the accel/habanalabs driver, which broke
the build on UML:

   drivers/accel/habanalabs/common/habanalabs_ioctl.c:326:23: error: call to undeclared function 'rdtsc'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]

Make the driver depend on 'X86 && X86_64', instead of just 'X86_64',
thus it won't be built on UML.

Suggested-by: Johannes Berg <johannes.berg@intel.com>
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Ofir Bitton <obitton@habana.ai>
Cc: Oded Gabbay <ogabbay@kernel.org>
Link: https://lore.kernel.org/r/202505080003.0t7ewxGp-lkp@intel.com
---
 drivers/accel/habanalabs/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/accel/habanalabs/Kconfig b/drivers/accel/habanalabs/Kconfig
index be85336107f9..1919fbb169c7 100644
--- a/drivers/accel/habanalabs/Kconfig
+++ b/drivers/accel/habanalabs/Kconfig
@@ -6,7 +6,7 @@
 config DRM_ACCEL_HABANALABS
 	tristate "HabanaLabs AI accelerators"
 	depends on DRM_ACCEL
-	depends on X86_64
+	depends on X86 && X86_64
 	depends on PCI && HAS_IOMEM
 	select GENERIC_ALLOCATOR
 	select HWMON

