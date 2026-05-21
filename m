Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31224CD6E6B
	for <linux-um@archiver.kernel.org>; Tue,  2 Jun 2026 13:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NA/nM16UoxaTsk3A7SWQL7q3HkgK647mNtY2rDcRyyc=; b=B+4Rujt65Ure1rBAR7FhuwLpCa
	6WuYNJdk5fpF6rMgjRYy+jAB+1arsDal69SN6if60wg997gvr4f6zDI75nniGf32VQ+AOM24gmJdb
	f54DAoIfvhjHeB4uXe+8Rfw5evHWfLxri5IZeuDtyATKQkRfOrUi7s1CTuG9v3sqviOcMlDhbDI7h
	WBYLRrBbt2P0/zRLE+hqYXuVf86u9oskqYdAV7Qgd5G/OLK8/GjxSSO42RcWHmGe3x6C5qTw8u70L
	LT29lTknOs9NhdJuepxzCxUcH884uT7yz5wd6KJTt7TIglbKVgWaeX/2m77vPWwwpH4UxleCc+PKa
	34ZKQu5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUPKa-0000000D7vH-2KZj;
	Tue, 02 Jun 2026 13:38:56 +0000
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQ6Xd-00000008XIQ-0zDy
	for linux-um@lists.infradead.org;
	Thu, 21 May 2026 16:46:38 +0000
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-490388fd0dbso8750415e9.0
        for <linux-um@lists.infradead.org>; Thu, 21 May 2026 09:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779381995; x=1779986795; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NA/nM16UoxaTsk3A7SWQL7q3HkgK647mNtY2rDcRyyc=;
        b=kgcoCC0GhZft3wfKnLXHb9nomBuCBdkllnjs/manwboKBr9lqnOyqXM52QjDpCxkPr
         O/1oJgVaHtL5tNjB9dE/jkj5IOVE4iD/b2X293Scfxs9KnTAVFn6JViLV6BNNihOflum
         93akSKr7XaFlcxUkoLB77kmm+YBWN+RqMngK4z4X1Y/nNahOeh0Ie6bSu3FygewZHyJz
         aNe52gnpJrlE0HNJUNgZkw48EUaLzkfK0TLbSBODFUNjNuk7zo9BXdz/5FIXepesiKT2
         baLmSYy3JSOVMzSIeiRXrl1fKto8mwPUlRjxs+I/1dXVLL/mHDdsUvo/NeUm2r/oTLKZ
         6Ugg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779381995; x=1779986795;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NA/nM16UoxaTsk3A7SWQL7q3HkgK647mNtY2rDcRyyc=;
        b=LKRwKDc6VG/NKGBJfZlf1mdomYNCR4FblC+TzyR54NCcqlX+4di2z9bE2vUoeSc2mQ
         lq023ceMR9itVAdcTPYGEUnINVJqoyVJcmLLcrcZDnfNtIHF+yRJhq+Ctq9zrXHn7E/u
         GewcIO1IPFUBEmgig/YNtyhjrsmR+LOKTbK45q9hqBaC26/kUfQeBu8q0W+bdZ9I4nv/
         GMqOHczfZNfkL/sVpR00Q7j1dnK4hFJ4cb37Qo7jsow23OYFoGdsJPN3/cuABBuGstPk
         TJmIRXODL0s2eYqTTpXrFrhcgqs9QQB/l3Z2URVeXT/2pEReqVbZsBPWi1rQZP0MAgKg
         /8Nw==
X-Forwarded-Encrypted: i=1; AFNElJ+fYUpN6cCO99p3QVB9vPpN4u9pb4OHYs8qaFJHeyKSVWTL44Dxd8wIhX6B2PabFmdAnRAGwfs3Pw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yxe8H5b+0HhImCXq8xzYcj/kKwZEc5X0VJg93hIKfCWfkFvzOtg
	i9lBPVG70RQvB7FZIud0tNi9vs9kVVI6kyUqna4kJ6jEBY/bvAtTgkbV
X-Gm-Gg: Acq92OF7bL3Y7uBXf0EbAfH558ovJg5gJ2U1xyr8h8d/0iXvR/29rAckudDPaHO221+
	XaLswr8mwa/g/7DDAbZb3iWnjfS8iU59XICa4muzaWq1UJ26QuUGn4cbGXIgOfEuZ4bGuEpfIh2
	5X1xN4YK0SwVW5l5t5T8DMh/VI4A0b3DGwJHQv0svdS03RsLeWJeq2rNhltTiB9s8nWNDgbmnDO
	UT3HB9GlQClVNlAj84LUPKAEojQ8O+LhcnpIu0TpNh/7dWCth/iJ5243abS2aenFbmOtCD0KY8J
	f2US/TgKrh1PGvDTC9drrQ2Q7qe5JtLC0pTGoLT04cUm3hprV/xWxXT9Y8B+JP8O3B+yrVuzvBu
	8evWXFcWWZwFjGrH/6W3Bw4myG5L0OHJ/J70imT565lBfbozGJr2SnPegWUKq30VkyxaOakDooc
	6DUmWz9JmCfD7gQ6OsFlrOJdFiNNT8f1DM2U7UdZdaxiU+f03Atf8hp+54AULePaLd
X-Received: by 2002:a05:600c:45c6:b0:488:ac01:72de with SMTP id 5b1f17b1804b1-49036033502mr53623425e9.5.1779381994891;
        Thu, 21 May 2026 09:46:34 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49035ecac15sm31613075e9.6.2026.05.21.09.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 09:46:34 -0700 (PDT)
Date: Thu, 21 May 2026 17:46:31 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Kees Cook <kees@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Pengpeng Hou
 <pengpeng@iscas.ac.cn>, stable@vger.kernel.org, Petr Pavlu
 <petr.pavlu@suse.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov
 <anton.ivanov@cambridgegreys.com>, Johannes Berg
 <johannes@sipsolutions.net>, "Rafael J. Wysocki" <rafael@kernel.org>, Len
 Brown <lenb@kernel.org>, Corey Minyard <corey@minyard.net>, Gabriel Somlo
 <somlo@cmu.edu>, "Michael S. Tsirkin" <mst@redhat.com>, Jani Nikula
 <jani.nikula@linux.intel.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Bart Van Assche <bvanassche@acm.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, Laurent
 Pinchart <laurent.pinchart@ideasonboard.com>, Hans de Goede
 <hansg@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, Bjorn
 Helgaas <bhelgaas@google.com>, Hannes Reinecke <hare@suse.de>, "James E.J.
 Bottomley" <James.Bottomley@HansenPartnership.com>, "Martin K. Petersen"
 <martin.petersen@oracle.com>, Daniel Lezcano <daniel.lezcano@kernel.org>,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Jason Wang
 <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio
 =?UTF-8?B?UMOpcmV6?= <eperezma@redhat.com>, Jason Baron
 <jbaron@akamai.com>, Jim Cromie <jim.cromie@gmail.com>, Tiwei Bie
 <tiwei.btw@antgroup.com>, Benjamin Berg <benjamin.berg@intel.com>, Ilpo
 =?UTF-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, "David E. Box"
 <david.e.box@linux.intel.com>, "Maciej W. Rozycki" <macro@orcam.me.uk>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Peter Zijlstra
 <peterz@infradead.org>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik
 <gor@linux.ibm.com>, Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Vinod Koul <vkoul@kernel.org>, Frank Li
 <Frank.Li@kernel.org>, Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen
 <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, Alexander
 Potapenko <glider@google.com>, Marco Elver <elver@google.com>, Dmitry
 Vyukov <dvyukov@google.com>, Andrew Morton <akpm@linux-foundation.org>,
 John Johansen <john.johansen@canonical.com>, Paul Moore
 <paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn"
 <serge@hallyn.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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
Subject: Re: [PATCH 01/11] params: bound array element output to the
 caller's page buffer
Message-ID: <20260521174631.71a06440@pumpkin>
In-Reply-To: <20260521133326.2465264-1-kees@kernel.org>
References: <20260521133315.work.845-kees@kernel.org>
	<20260521133326.2465264-1-kees@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260521_094637_320087_3C55FB19 
X-CRM114-Status: GOOD (  27.65  )
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

On Thu, 21 May 2026 06:33:14 -0700
Kees Cook <kees@kernel.org> wrote:

> From: Pengpeng Hou <pengpeng@iscas.ac.cn>
> 
> param_array_get() appends each element's string representation into the
> shared sysfs page buffer by passing buffer + off to the element getter.
> 
> That works for getters that only write a small bounded string, but
> param_get_charp() and similar helpers format against PAGE_SIZE from the
> pointer they receive. Once off is non-zero, an element getter can
> therefore write past the end of the original sysfs page buffer.
> 
> Collect each element into a temporary PAGE_SIZE buffer first and then
> copy only the remaining space into the caller's page buffer.

Should this be using a 4k buffer on all architectures?
Initially perhaps just using a different name for the constant until
all the associated PAGE_SIZE limits have been removed.

-- David

> 
> Cc: stable@vger.kernel.org
> Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
>  kernel/params.c | 26 ++++++++++++++++++++------
>  1 file changed, 20 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/params.c b/kernel/params.c
> index 74d620bc2521..752721922a15 100644
> --- a/kernel/params.c
> +++ b/kernel/params.c
> @@ -475,22 +475,36 @@ static int param_array_set(const char *val, const struct kernel_param *kp)
>  static int param_array_get(char *buffer, const struct kernel_param *kp)
>  {
>  	int i, off, ret;
> +	char *elem_buf;
>  	const struct kparam_array *arr = kp->arr;
>  	struct kernel_param p = *kp;
>  
> +	elem_buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
> +	if (!elem_buf)
> +		return -ENOMEM;
> +
>  	for (i = off = 0; i < (arr->num ? *arr->num : arr->max); i++) {
> -		/* Replace \n with comma */
> -		if (i)
> -			buffer[off - 1] = ',';
>  		p.arg = arr->elem + arr->elemsize * i;
>  		check_kparam_locked(p.mod);
> -		ret = arr->ops->get(buffer + off, &p);
> +		ret = arr->ops->get(elem_buf, &p);
>  		if (ret < 0)
> -			return ret;
> +			goto out;
> +		ret = min(ret, (int)(PAGE_SIZE - 1 - off));
> +		if (!ret)
> +			break;
> +		/* Replace the previous element's trailing newline with a comma. */
> +		if (i)
> +			buffer[off - 1] = ',';
> +		memcpy(buffer + off, elem_buf, ret);
>  		off += ret;
> +		if (off == PAGE_SIZE - 1)
> +			break;
>  	}
>  	buffer[off] = '\0';
> -	return off;
> +	ret = off;
> +out:
> +	kfree(elem_buf);
> +	return ret;
>  }
>  
>  static void param_array_free(void *arg)


