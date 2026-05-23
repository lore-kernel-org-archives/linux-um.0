Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EB90CD6E6A
	for <linux-um@archiver.kernel.org>; Tue,  2 Jun 2026 13:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ke0QgGP72oU1/KHDzVSs1lh/gkg7Mw8fFDTolKbzoHA=; b=KFnsh6LRLOh3fy66DLSzjclxCo
	Cuisk8m3NFadoNpmHROCu991veX7DI74/FGwoMvY/rJQHHGLEw0HpI6ZWJTVdSaRuUb+FVOiBKjn2
	Psm0WRviAtczgvvWLMuaTcoKfcdLRaccha4YicFqMJv7oTd8bE9BKtgzLilhgfC/zzzfGiHYTpiFb
	p5M8luKOk2nNb3MTEcdOk+bUGCiBummXKTswsgn9gJPQTiKijeU2vBrmlLrU1lDcR28Px+U2d6+Ut
	HC/gucuD4jyH7ccwHZABJlb9r97RgyVfJ+rmY2m5HP9VTkFyt62aV9MS3YfDX9VkobIRkcZtXuReN
	82k9id+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUPKa-0000000D7vM-2ZzI;
	Tue, 02 Jun 2026 13:38:56 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQaNW-0000000CKh7-1IST
	for linux-um@lists.infradead.org;
	Sat, 23 May 2026 00:38:12 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 7697440390;
	Sat, 23 May 2026 00:38:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDCE81F000E9;
	Sat, 23 May 2026 00:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779496688;
	bh=ke0QgGP72oU1/KHDzVSs1lh/gkg7Mw8fFDTolKbzoHA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=W/qwAMS1ok+56HAwvYiYz0R5wmKsD0RscuUhy5BVEzThMnr+wQxbKIW0Yk+lqtg0R
	 dxN4FM+nLAHenqFi1JvSelOt20CYFnYpdSX3hvz5/mvzq/JXO7gcBTjSStG/A5FM8j
	 0Dk4RFZ90/nX0Xzby8V+5D3uQDTYP8o1bo3XSKlx4rKPB6vCO/Oui18woqanoP+n4U
	 enXhw+/EJeP6Kw2ZiII29eiMOdyHFC3VD0U1T97Mm+aD6rZa6A+hyeA7zcgLPdsptw
	 8LWGxoojes1mewesgkVxxy+dLIhtJlwu3XyRYodcKxBzIRSnWjQs++a/owD5p2CmBM
	 RNz3sazG7iMhQ==
From: SeongJae Park <sj@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: SeongJae Park <sj@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Corey Minyard <corey@minyard.net>,
	Gabriel Somlo <somlo@cmu.edu>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Bart Van Assche <bvanassche@acm.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Hans de Goede <hansg@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Hannes Reinecke <hare@suse.de>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Jason Baron <jbaron@akamai.com>,
	Jim Cromie <jim.cromie@gmail.com>,
	Tiwei Bie <tiwei.btw@antgroup.com>,
	Benjamin Berg <benjamin.berg@intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"David E. Box" <david.e.box@linux.intel.com>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Georgia Garcia <georgia.garcia@canonical.com>,
	kvm@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-modules@vger.kernel.org,
	kasan-dev@googlegroups.com,
	linux-mm@kvack.org,
	apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	openipmi-developer@lists.sourceforge.net,
	qemu-devel@nongnu.org,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-rdma@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-serial@vger.kernel.org,
	linux-usb@vger.kernel.org,
	usb-storage@lists.one-eyed-alien.net,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH 04/11] treewide: Convert struct kernel_param_ops initializers to DEFINE_KERNEL_PARAM_OPS
Date: Fri, 22 May 2026 17:38:01 -0700
Message-ID: <20260523003801.86344-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260521133326.2465264-4-kees@kernel.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260522_173810_392638_ACBAF5F0 
X-CRM114-Status: GOOD (  12.79  )
X-Mailman-Approved-At: Tue, 02 Jun 2026 06:38:56 -0700
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

On Thu, 21 May 2026 06:33:17 -0700 Kees Cook <kees@kernel.org> wrote:

> Using Coccinelle, rewrite every struct kernel_param_ops initializer that
> sets .get into a DEFINE_KERNEL_PARAM_OPS-family macro invocation,
> for example:
> 
> @@
> declarer name DEFINE_KERNEL_PARAM_OPS;
> identifier OPS;
> expression SET, GET;
> @@
> - const struct kernel_param_ops OPS = {
> -       .set = SET,
> -       .get = GET,
> - };
> + DEFINE_KERNEL_PARAM_OPS(OPS, SET, GET);
> 
> Using the macro for initialization means future changes can manipulate
> the struct layout and callback prototypes without having to change every
> initializer.
> 
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
[...]
>  mm/damon/lru_sort.c                           | 19 ++---
>  mm/damon/reclaim.c                            | 19 ++---
>  mm/damon/stat.c                               |  6 +-
[...]
>  samples/damon/mtier.c                         |  6 +-
>  samples/damon/prcl.c                          |  6 +-
>  samples/damon/wsse.c                          |  6 +-

For the above DAMON part changes,

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]

