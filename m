Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08173CD5BC9
	for <linux-um@archiver.kernel.org>; Mon, 25 May 2026 13:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ij+l12dR+ISDUAaA9eJOw0SDQ47xwS4UQDqlRXMB76c=; b=dKqEN9hQd4Zr/fRf8OEJo1oN4R
	q4foG0Y7j2388k3rfCMGDrek/0uDrSLC/GNasPjHjCFveuLzR0GTfcoMyVbqXp6sgQnPwEBpkCJdE
	IRSKF9wQM6edcrgNVecpSbsPoCBd57tRs5o3nWr0BT0i0ydYgCPJhRasQUwQRGWWWmUVkFy1vHJs9
	F2DvWsNECRqMFAKiGAhrFKDZ2kNzDgVvKfeqpD7JLmvRVVEXYB+EKW9Vyv4jhe3P4efrU9EDixZpY
	VLWlr/rkWeGFquwSt2B5ltj/EfyeYZx2XFBLFMF5tRShpUga/cFmLKl9lsXS+7Z8gYoKRxTeBWqZZ
	n0LoGrmw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRVL1-0000000HJSv-3JU1;
	Mon, 25 May 2026 13:27:23 +0000
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRVKx-0000000HJSC-20x7
	for linux-um@lists.infradead.org;
	Mon, 25 May 2026 13:27:20 +0000
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-4891e86fabeso121365995e9.1
        for <linux-um@lists.infradead.org>; Mon, 25 May 2026 06:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1779715637; x=1780320437; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ij+l12dR+ISDUAaA9eJOw0SDQ47xwS4UQDqlRXMB76c=;
        b=FAbibZVJzYpJP6FZ2v9FLL76UWaLvmNjV164x4QPMD3voGtvnubnRfwo5apcouKX7r
         DfhFHQTP8z2b0gpxvi68ESbza1AeDktzJ4FOs0E2g3fxp4e/VCzp3GYOVMzvYnBrBDJp
         Fm94GBqfdTfEDoncz6QpUoxd5mQQloxE/cfZgxW8rYRVjsvkBGB6W/vDe//KN8qxP0sz
         iWOeoWEnshuImiTP7FdOCX1iInRFvPBKNNmfCqLfeaSvEITygAGYG9wgaLubDK5rSOnB
         ht/2p7u0hY/eaU4Euy1YZz67E9N14IgIq1e4eu6n15Ndhd+xKdCzj06sp+R0RXwolIj7
         8f/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779715637; x=1780320437;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ij+l12dR+ISDUAaA9eJOw0SDQ47xwS4UQDqlRXMB76c=;
        b=sjw98ljIQNCf1qJakZ/s/nmQ5ScE4Ohw187UB6apHcsdt/5wRI8KPVoJshwb4aHEuh
         b5nT9lI6OalbInA+HoVb7ht19aFrKm7O64zw6tYP0g2C8hxKQ3RK3KpRYCfN/TmkZAwb
         Shoeig+xThRDbPTqiNwXRASaIqW1h4Fme58p08ev1SRQpRRY5KStQjQZ1svBF1S55Xwt
         y5qV6QMURZxnYceG/5ppxBs6DpnKZMboXgmmIAMuqM0u9WE6WBJEKlEV57NfASPe0ab+
         VCsYLRQwKrOmN00vukMeui4Z/ssa0XDu9gj3BlH/Dp5JtU1CKhE/v58K2FxQtiRVFdgp
         Q40Q==
X-Forwarded-Encrypted: i=1; AFNElJ/dgMjuDn0ADO2m8p3HsfZEwivHcXcOgcjgEyfM21bsapK3Ad8rb+9z5poFPE+XAWuF70eoQI0CYw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yz8l2sOhibTbwJ/z0i4gwn4CQSevbQ6IEtti4Cz6KNFcdvUa+Je
	knvywEJ7EvnrcpF+yhTM8yIU8z7gxyhFxhbmQbN5zcqCg6Ez/D1B8BgZM4fDW/KWKfc=
X-Gm-Gg: Acq92OHpFEsIzY/dwDWfqZJBHAE/f9QgP37Vr+E52L0GEZ5tt8Gj99eFd5aigJrlSVR
	/FXeuxVMnOWQXDXs5EBmzabf/1v9W90F1dFc12UNL2HEGidleUg05R4LOo6KEAknGjj4ctSTem7
	y2pC7zdhwn5RmIfpbIMbXmPNFc6krsQ23W9R2GcSbmm6YdBYBgEPuYQg3gxJ+ec1hYr/+7g8EMQ
	yPLcKZjFxWZEqOawnIy5AKsfJPTmUj7hEdpUyD2zOQUxPS5pvtEtE3Xsm1cnLPSgcbqkpqt1a/y
	0RmpB0QVgAiRwTDIB2p+d7KLGkTU7rZHOvTbfaINvMX77Ku3uTPqca9CVtPg1qceCcWhTMBz8bB
	5enJpgypYFuwVRUcuJxuVA2zxrQuJF8ZwrwH2unECyXmmG/ezVoQE/s0SRzgH/k3j5jk0g6Ru7f
	94gSY7ZlSB4WHoE3Nivqauxr2MQV2PAwQTdbnCVSAU3HazKbxfSx48PZmn7xTlC9W1KMuOIzQGy
	yn4W5g40u9vNclBo6Tntc/a3O5ar9XFcO+NVpCJF2Brq6yqu77pLydcnGi03bmIGZBynr1GqBxD
	H6sg
X-Received: by 2002:a05:600c:3b02:b0:48f:e1ac:c94f with SMTP id 5b1f17b1804b1-490424b3938mr247672645e9.10.1779715636631;
        Mon, 25 May 2026 06:27:16 -0700 (PDT)
Received: from ?IPV6:2a00:1028:838d:271e:8e3b:4aff:fe4c:a100? (dynamic-2a00-1028-838d-271e-8e3b-4aff-fe4c-a100.ipv6.o2.cz. [2a00:1028:838d:271e:8e3b:4aff:fe4c:a100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490454b1ab3sm284841905e9.14.2026.05.25.06.27.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 May 2026 06:27:16 -0700 (PDT)
Message-ID: <1c21f66f-0d0f-4a8b-835b-23408242cff1@suse.com>
Date: Mon, 25 May 2026 15:27:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/11] moduleparam: Add DEFINE_KERNEL_PARAM_OPS macro
 family
To: Kees Cook <kees@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Pengpeng Hou
 <pengpeng@iscas.ac.cn>, Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Corey Minyard <corey@minyard.net>, Gabriel Somlo <somlo@cmu.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin
 <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Bart Van Assche <bvanassche@acm.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Hans de Goede <hansg@kernel.org>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Hannes Reinecke <hare@suse.de>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Alan Stern <stern@rowland.harvard.edu>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Jason Baron <jbaron@akamai.com>, Jim Cromie <jim.cromie@gmail.com>,
 Tiwei Bie <tiwei.btw@antgroup.com>, Benjamin Berg <benjamin.berg@intel.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "David E. Box" <david.e.box@linux.intel.com>,
 "Maciej W. Rozycki" <macro@orcam.me.uk>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Vinod Koul <vkoul@kernel.org>,
 Frank Li <Frank.Li@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>,
 Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>,
 Dmitry Vyukov <dvyukov@google.com>, Andrew Morton
 <akpm@linux-foundation.org>, John Johansen <john.johansen@canonical.com>,
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Georgia Garcia <georgia.garcia@canonical.com>, kvm@vger.kernel.org,
 dmaengine@vger.kernel.org, linux-modules@vger.kernel.org,
 kasan-dev@googlegroups.com, linux-mm@kvack.org, apparmor@lists.ubuntu.com,
 linux-security-module@vger.kernel.org, linux-um@lists.infradead.org,
 linux-acpi@vger.kernel.org, openipmi-developer@lists.sourceforge.net,
 qemu-devel@nongnu.org, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
 linux-media@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-pm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org,
 linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, netdev@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20260521133315.work.845-kees@kernel.org>
 <20260521133326.2465264-3-kees@kernel.org>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260521133326.2465264-3-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260525_062719_558033_55A5F022 
X-CRM114-Status: GOOD (  25.13  )
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

On 5/21/26 3:33 PM, Kees Cook wrote:
> Add macros that define a struct kernel_param_ops initializer through a
> macro so the underlying field layout can evolve without touching every
> call site. Three variants cover the three cases:
> 
>  DEFINE_KERNEL_PARAM_OPS(name, set, get) // basic
>  DEFINE_KERNEL_PARAM_OPS_NOARG(name, set, get) // set KERNEL_PARAM_OPS_FL_NOARG
>  DEFINE_KERNEL_PARAM_OPS_FREE(name, set, get, free) // also set .free
> 
> Callers prefix their own visibility qualifiers, e.g.:
> 
>   static DEFINE_KERNEL_PARAM_OPS(my_ops, my_set, my_get);
> 
> Also update module_param_call() and STANDARD_PARAM_DEF() to use
> DEFINE_KERNEL_PARAM_OPS internally so the generated ops table will go
> through the same macro as everything else.
> 
> Subsequent commits convert all open-coded struct kernel_param_ops
> definitions to use these macros, in preparation for migrating to a
> seq_buf .get API.
> 
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
>  include/linux/moduleparam.h | 36 ++++++++++++++++++++++++++++++++++--
>  kernel/params.c             |  6 ++----
>  2 files changed, 36 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/moduleparam.h b/include/linux/moduleparam.h
> index 075f28585074..26bf45b36d02 100644
> --- a/include/linux/moduleparam.h
> +++ b/include/linux/moduleparam.h
> @@ -68,6 +68,39 @@ struct kernel_param_ops {
>  	void (*free)(void *arg);
>  };
>  
> +/*
> + * Define a const struct kernel_param_ops initializer. Callers prefix with
> + * any required visibility qualifiers (typically "static"):
> + *
> + *   static DEFINE_KERNEL_PARAM_OPS(my_ops, my_set, my_get);
> + *
> + * Routing the @_set and @_get function pointers through the macro
> + * (rather than naming the struct fields at every call site) lets the
> + * field layout change in one place when callbacks are migrated to a
> + * new signature.
> + */

Nit: The newly introduced DEFINE_KERNEL_PARAM_OPS*() macros remain in
place at the end of the series after the migration is complete and this
comment is removed in patch 7. It would be helpful to describe in the
commit message why these macros are generally preferable to defining
kernel_param_ops instances directly.

I assume the motivation is that the structure is simple enough and using
macros then makes defining kernel_param_ops instances a bit more
concise. A minor disadvantage is that some analysis tools, such as
ctags, may no longer see the generated definition, but that is also the
case for DEFINE_MUTEX() and other similar macros.

-- 
Thanks,
Petr

