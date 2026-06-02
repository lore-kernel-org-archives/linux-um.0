Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10331CD6E64
	for <linux-um@archiver.kernel.org>; Tue,  2 Jun 2026 12:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3fuMy8ZTlB4sZmM4SRNfS45Rtpr0e2y/Uhs3uZMD108=; b=kKqZpsjPTDJqqdQyPRWQwyQZV9
	l8445Lpu1J8iNAvrOMmIrSIfPYfsNpGX5VCyc73u6gahAbK0HVrMcEaDQx638i0nYtaMb6Xj7oIRJ
	C5zjbkQc9v13fEJbYXqJJmQf+UwDw4z3T9Lx/JLO74gOY3PZy7tr1COf3n5XGl4BKQnDLbpJuIDUq
	+sGbK6sCWExYcBepG6izUa1QsNdsqXuwvCsFsSBHnwjl5VSKqHHyqIVOsrx8NTIIxatexQGfXBQsU
	tKYFylcqJSpe9p09rjppamPGkA5KaHpcMboa3KxMfM4MEOBZzTQvuDAlnK38R5Ugm4uhshC95Au0C
	RYTJ/KPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUOJZ-0000000CzYP-40D5;
	Tue, 02 Jun 2026 12:33:49 +0000
Received: from mail-qt1-x82e.google.com ([2607:f8b0:4864:20::82e])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUOJX-0000000CzXO-1c6q
	for linux-um@lists.infradead.org;
	Tue, 02 Jun 2026 12:33:48 +0000
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-5174a34800fso26645781cf.3
        for <linux-um@lists.infradead.org>; Tue, 02 Jun 2026 05:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1780403626; x=1781008426; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3fuMy8ZTlB4sZmM4SRNfS45Rtpr0e2y/Uhs3uZMD108=;
        b=mb5u0/hIxSig2CRO0rtz6wCNBEH15f9FLMWQMuTJuSkWtTkj+LBT3TjpcsyzwDKcT9
         x9pB+VcOBfYI1Uwivd+lov901oHEo67s6+Km2GAwThXL5HUBq/taPQe+OK0KayweYqs+
         28k+n2OPlnba2wEY04kJKUqsc6GCskzJ5G5RUYOV2Kk5IDDKdEqWV7xEmTkpmW+0tlb4
         PokR5E9aKkegRdlav8SS8mszcfAlyqCDeT3Nx2rCG2ar/Nkeeg/GnKfAlYjaQBXfNcb8
         nIAPJ7laN5Wn9cvvnYZrrqEFiH8ecJ1T6es2MWXmVY0MWk5Nekiflg1RBXaRjmb6Va0O
         7CjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780403626; x=1781008426;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3fuMy8ZTlB4sZmM4SRNfS45Rtpr0e2y/Uhs3uZMD108=;
        b=ZpOiqrcO8zR4xa3OQHAfPFvw2NseDuQgIlwlzyym8BTY7FHa3bWGzpXmQI7GQvQemh
         RgsyN3jzGB8sIHu5gFfLIYK/9s3gKsnUIn6yOTkzxXQC7gO4JcEE0iIyFRPzhTNhbE8j
         npY0iozs1lF2TIThyfMIiqA56FDc6ZKe75TwbOzGyP1jXykG4PIYTKDSsWrHqj46DKUE
         4H9G0A0A/M5VGrEDCSWKKPIMaxUqlPeFK6pxP+MUREIBUevs4D5aP9lOJ4gUzRRvaSfD
         nnf7e8IGck0ozbPS1vo9qIzWllJKWK+e+YprNplA4h4gkEDKn4b+QBZQRb+w/tWBgk/r
         QJvw==
X-Forwarded-Encrypted: i=1; AFNElJ+eD7IjzDg1kO4AWcIHxRGPBPXRvO6q+BTH518zVfnbJwfsXoPqlQlG6QLJ+SIn+/DTBtvrbgIVdA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yzfbs2D2wY0673TihaLKixmPk1zI0bDSsyaYObe99yL/tfarODc
	TAWKa3H5yo/0asD8iQJrmKa/MlHJFxKpiin8KuHxI0OutGFSavLHgiB+pK+IrskCQ3M=
X-Gm-Gg: Acq92OFFVbEfBtRvdYdeozaqvbgZ5du5Kh6q33JlxJp/aDwIZE0noblt5LjM9hKHuT+
	zTH2dTkl9ZEo5ZTGXIavmxqPUkJil30fAECIVxSpDgRQsH264M9zQvzFg7NrKI9ODsvCx8JXR6d
	JTxLhxuJEOxgbkW0TWgrXfslFEGz6biZNhj7ZdnL6amgB7cfjh9XirrAUqB5F5pcM/eoGxDprV5
	z3hduwac3MkUGEU+7S7a21eanHkSlCsOGvufRA+34ZFTSb6/QT2TfPXuZtSmLrfb67gpyeGAGKT
	3sQD/NY8EiLa0tDU9bWpwIMU6AICuzNc5J7oP2200tzX6kivS0Fu3Enrk20A8f1mLVkHr+VJ0WU
	cEEfzcjN3VsGGG5rtyzPwuQT5T/45xq6IyrH/35KueYtqp7NhceSbQjCaUOF5+O0mEWGA/tpa0s
	RFyCMlfg1d/loEmIeMuHXZl8QqwcnX7bJdo+IVHoH4AYQg6Ryv1Q7xM2mC7CFd100xsEtOunVjQ
	wTM6cmLh9rwSst5
X-Received: by 2002:a05:622a:190a:b0:509:2527:d789 with SMTP id d75a77b69052e-5173a5c05ecmr228232631cf.6.1780403625864;
        Tue, 02 Jun 2026 05:33:45 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51741d6a240sm78686221cf.18.2026.06.02.05.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 05:33:45 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wUOJU-00000003m5x-3DKO;
	Tue, 02 Jun 2026 09:33:44 -0300
Date: Tue, 2 Jun 2026 09:33:44 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Kees Cook <kees@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>,
	Pengpeng Hou <pengpeng@iscas.ac.cn>, stable@vger.kernel.org,
	Petr Pavlu <petr.pavlu@suse.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Corey Minyard <corey@minyard.net>,
	Gabriel Somlo <somlo@cmu.edu>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Bart Van Assche <bvanassche@acm.org>,
	Leon Romanovsky <leon@kernel.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Hans de Goede <hansg@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Hannes Reinecke <hare@suse.de>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Jason Baron <jbaron@akamai.com>, Jim Cromie <jim.cromie@gmail.com>,
	Tiwei Bie <tiwei.btw@antgroup.com>,
	Benjamin Berg <benjamin.berg@intel.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	"David E. Box" <david.e.box@linux.intel.com>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Georgia Garcia <georgia.garcia@canonical.com>, kvm@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-modules@vger.kernel.org,
	kasan-dev@googlegroups.com, linux-mm@kvack.org,
	apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
	linux-um@lists.infradead.org, linux-acpi@vger.kernel.org,
	openipmi-developer@lists.sourceforge.net, qemu-devel@nongnu.org,
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-rdma@vger.kernel.org, linux-media@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
	usb-storage@lists.one-eyed-alien.net,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, netdev@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 01/11] params: bound array element output to the caller's
 page buffer
Message-ID: <20260602123344.GG2487554@ziepe.ca>
References: <20260521133315.work.845-kees@kernel.org>
 <20260521133326.2465264-1-kees@kernel.org>
 <ah699hwLxIIOZ0-7@ashevche-desk.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ah699hwLxIIOZ0-7@ashevche-desk.local>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260602_053347_437915_06D01C68 
X-CRM114-Status: GOOD (  16.64  )
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

On Tue, Jun 02, 2026 at 02:26:46PM +0300, Andy Shevchenko wrote:
> On Thu, May 21, 2026 at 06:33:14AM -0700, Kees Cook wrote:
> > 
> > param_array_get() appends each element's string representation into the
> > shared sysfs page buffer by passing buffer + off to the element getter.
> > 
> > That works for getters that only write a small bounded string, but
> > param_get_charp() and similar helpers format against PAGE_SIZE from the
> > pointer they receive. Once off is non-zero, an element getter can
> > therefore write past the end of the original sysfs page buffer.
> > 
> > Collect each element into a temporary PAGE_SIZE buffer first and then
> > copy only the remaining space into the caller's page buffer.
> 
> ...
> 
> > +	elem_buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
> 
> get_free_page() (or how it is called)?

I thought modern mm guidance was to use kmalloc whenever possible and
not use get_free_page() unless you intend to use the struct page bits?

Jason

