Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4199CD5BB5
	for <linux-um@archiver.kernel.org>; Thu, 21 May 2026 13:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Dnh9Qdh/Ek2SFmUD3YQQhAJ1lm8lFb5yTi3rkZyIV7s=; b=fMyTy+uhDbJmCTRkRpd+0OJD8l
	zYSjFkNjF0rDqlXHzFoqDh9Y1jar+Q0o8y//GrqVd5EQfAHYtjRcPbn/HhmX0rU4BtGINrUjyEx3X
	w09VJ5FellnfFS5RZNwtqSF6zWH1BX1gW1OGP5q9naZVioIZayCxFTjsX2QbvuF6K6WPRBRfZeZIk
	aZ2R0QjiIiZvmDjD/Cw4qH3zrG6ixz8kTCI7jIFPzR11tdoxbgeWqrU7adTxH4Z3hCIzJyTL0vEEv
	POMKs/SSt4ht42QzuneYl8lHYe4mfMdDzGrftzPImrQhTHJYebfqh4i90cEKRZDxc4J3iwlp39fnM
	tYvTIt3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQ3i2-00000007w9a-1od3;
	Thu, 21 May 2026 13:45:10 +0000
Received: from mail-pg1-x549.google.com ([2607:f8b0:4864:20::549])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQ3hz-00000007w82-2vwY
	for linux-um@lists.infradead.org;
	Thu, 21 May 2026 13:45:09 +0000
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-c829586e894so3199307a12.2
        for <linux-um@lists.infradead.org>; Thu, 21 May 2026 06:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779371106; x=1779975906; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Dnh9Qdh/Ek2SFmUD3YQQhAJ1lm8lFb5yTi3rkZyIV7s=;
        b=sD2mP7ftDSt6gNw024tGzLvNZLp4ndzZ8pjYiS6xlVSuUJJWiGIwLYCeFlXf1teKKb
         2gHkFWGKoR/897L/qm9w6KwTOGJ/4yuir0A3bhYvdNEixo5ltbKHLQYOq14uTckwgF3T
         UsS0x0zpeGFpyrs3muY9D8s0yOMC0MqfCrU5vDl3zWwhOgi71zc7UIdC6IsgevBIehf0
         VkxDMMuCkpWwGWhtpRdo0OlqRnciBOPOTjKFpdw1cHUhrw3vTCT81OA60HsD9B/aE9wX
         wcfDajLMc5AYwlhFp3GOLpzIA37UR7pWfXb64JD9MKWJPTdC90d0+faXOBOOFj61w309
         vfyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779371106; x=1779975906;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dnh9Qdh/Ek2SFmUD3YQQhAJ1lm8lFb5yTi3rkZyIV7s=;
        b=lx+ktKiH4MlRI3NThKYe3gPwTW2Dd7ZT4CbMQUhDCXonK3Q+0PnOblDTrdsuw3WoUv
         wbMChMxBi+3f2WXR/Gae3I1ewNmw2jX+eGv2Tm9SbuhElWYEVmftRYeA8zpV4Dt6uf7M
         +kYiUccc4L/OnC1xBjwafPF8tZYdzaLqVqmv3fYPxIdJEh9cWBD9fUStEzTmi/DI/LVY
         /ToOOCMNklxezC4VPUVbqm4LPgXD83j1O9l4Bq8sMtNN1W6bqH+68EFt+cuDiY1yvSKR
         kVFePJFtt+WKYND760Hm8zUCBmZM9iSUBX2hilVVxfp4xrNSRM+mkcojE7PPTn65TN1l
         n1dg==
X-Forwarded-Encrypted: i=1; AFNElJ9/nLMiW4KpqQpw1T96DooX07AcIyJCCo3c/R+W+mvFsQ0CGUcxEjjOgXOTR/LEWyG42las062GIw==@lists.infradead.org
X-Gm-Message-State: AOJu0YywDQatjx3XXRDGEpOApMeOn8g2fJfzDIdYGfecuttvDBfFQg/I
	VMm4INn1JLpQvtzhVe6CKmoTi9q+wSuRrU5B9ocOZvjbWgTOX8Wdy5PvujpuN1cxeZ7BlJYaa4a
	4c629HQ==
X-Received: from pgvm13.prod.google.com ([2002:a65:62cd:0:b0:c85:1159:ffbd])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7491:b0:3a0:bc61:62e5
 with SMTP id adf61e73a8af0-3b30883a17bmr3700528637.44.1779371104725; Thu, 21
 May 2026 06:45:04 -0700 (PDT)
Date: Thu, 21 May 2026 06:45:04 -0700
In-Reply-To: <20260521133326.2465264-9-kees@kernel.org>
Mime-Version: 1.0
References: <20260521133315.work.845-kees@kernel.org> <20260521133326.2465264-9-kees@kernel.org>
Message-ID: <ag8MYC6pOZvvYHMp@google.com>
Subject: Re: [PATCH 09/11] treewide: Convert custom kernel_param_ops .get
 callbacks to seq_buf via cocci
From: Sean Christopherson <seanjc@google.com>
To: Kees Cook <kees@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Pengpeng Hou <pengpeng@iscas.ac.cn>, 
	Petr Pavlu <petr.pavlu@suse.com>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Corey Minyard <corey@minyard.net>, 
	Gabriel Somlo <somlo@cmu.edu>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jani Nikula <jani.nikula@linux.intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Bart Van Assche <bvanassche@acm.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Leon Romanovsky <leon@kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Hans de Goede <hansg@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Hannes Reinecke <hare@suse.de>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Alan Stern <stern@rowland.harvard.edu>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"Eugenio =?utf-8?B?UMOpcmV6?=" <eperezma@redhat.com>, Jason Baron <jbaron@akamai.com>, 
	Jim Cromie <jim.cromie@gmail.com>, Tiwei Bie <tiwei.btw@antgroup.com>, 
	Benjamin Berg <benjamin.berg@intel.com>, 
	"Ilpo =?utf-8?B?SsOkcnZpbmVu?=" <ilpo.jarvinen@linux.intel.com>, 
	"David E. Box" <david.e.box@linux.intel.com>, "Maciej W. Rozycki" <macro@orcam.me.uk>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	John Johansen <john.johansen@canonical.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
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
Content-Type: text/plain; charset="us-ascii"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260521_064507_744611_C7E3C2F9 
X-CRM114-Status: GOOD (  15.39  )
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

On Thu, May 21, 2026, Kees Cook wrote:
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 07f4c7209ac0..00317774a90b 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -368,12 +368,16 @@ static int vmentry_l1d_flush_set(const char *s, const struct kernel_param *kp)
>  	return ret;
>  }
>  
> -static int vmentry_l1d_flush_get(char *s, const struct kernel_param *kp)
> +static int vmentry_l1d_flush_get(struct seq_buf *s,
> +				 const struct kernel_param *kp)
>  {
> -	if (WARN_ON_ONCE(l1tf_vmx_mitigation >= ARRAY_SIZE(vmentry_l1d_param)))
> -		return sysfs_emit(s, "???\n");
> +	if (WARN_ON_ONCE(l1tf_vmx_mitigation >= ARRAY_SIZE(vmentry_l1d_param))) {
> +		seq_buf_printf(s, "???\n");
> +		return 0;
> +	}
>  
> -	return sysfs_emit(s, "%s\n", vmentry_l1d_param[l1tf_vmx_mitigation].option);
> +	seq_buf_printf(s, "%s\n", vmentry_l1d_param[l1tf_vmx_mitigation].option);
> +	return 0;

For this one, can you manually change it to this?

	if (WARN_ON_ONCE(l1tf_vmx_mitigation >= ARRAY_SIZE(vmentry_l1d_param)))
		seq_buf_printf(s, "???\n");
	else
		seq_buf_printf(s, "%s\n", vmentry_l1d_param[l1tf_vmx_mitigation].option);
	return 0;

>  }
>  
>  /*
> @@ -459,9 +463,11 @@ static int vmentry_l1d_flush_set(const char *s, const struct kernel_param *kp)
>  	pr_warn_once("Kernel compiled without mitigations, ignoring vmentry_l1d_flush\n");
>  	return 0;
>  }
> -static int vmentry_l1d_flush_get(char *s, const struct kernel_param *kp)
> +static int vmentry_l1d_flush_get(struct seq_buf *s,
> +				 const struct kernel_param *kp)
>  {
> -	return sysfs_emit(s, "never\n");
> +	seq_buf_printf(s, "never\n");
> +	return 0;
>  }
>  #endif

