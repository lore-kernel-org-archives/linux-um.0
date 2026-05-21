Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1E50CD5BAC
	for <linux-um@archiver.kernel.org>; Thu, 21 May 2026 17:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JkK65RDtR3mLEPhqVTmKcBBfGABseq6VrGC9TbyXzOU=; b=jnL75FBOuaRgc6YcFDWexV3jxV
	ouJ9Q+A6WkdDXCDf19hugZ/M9tEcK32emDjiIlNUaiS8X7nqDY0zO2+oAg5RDcidPDgH6oSOEkxDT
	6WG9z+m15qL5cuk7IJD2NSGnkugMAVwUmzRcO2plpNw7n5fr8Z6fNp3fYiA4dpaCe2hFgVDu17HyO
	RMlPgTXL7KFYpUnVBGn4JgOoj6bkdK7tb9W+RKUMLoFeasxTuzEH6wr621f27PKq8yQRjB7FTEuzW
	dcOiS0LG77s/OvBZ/t+j+5oQhrk1I9aGqc0fqBYS1AOKzN5SQVLp0aEHbbU4Wia8ty7zm3IGSUcXl
	9kcDdBUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQ7UJ-00000008gkE-27sa;
	Thu, 21 May 2026 17:47:15 +0000
Received: from mgamail.intel.com ([192.198.163.7])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQ7UG-00000008gN6-2zTc
	for linux-um@lists.infradead.org;
	Thu, 21 May 2026 17:47:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779385632; x=1810921632;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=sU3q4ei5VqXFeemg2pdBcbpXy8Z2qTRY4hHBwMHyr+A=;
  b=NvtLlRdDJvaSI7O/dlVC8dv1hT0ORBq2HWgQ2YPUlG7Gs6hMt7teDPQq
   2SI+NoHtw0EtlEc5+IVHPg+RvbOHlFKgRuZgwM8oXFd4T+/fk7scV5cO3
   o7DvrExtTZqpHqJQ4S4RFnts/uRYtReV6p+rGslkNeZT/bqTLBQ/0BaSO
   p5Re7kC0nMYZhuKw1nMpaXCVU+QIz1A03PNAOnk2lH66O/u1RdGcBJ6/Y
   r9Gt5c+J4ZHioByNyKCJg2VRZLnZN2UyU2eNkY93lbflyLeBqI2AitC5+
   C7J2BY5Uonup3w+vfrA5Z5E7h67w6X0oBC/Hl24TBJPsMtO6Dr6sM57fK
   w==;
X-CSE-ConnectionGUID: 3jKJ8w0vSZGlX4E9gyPKgw==
X-CSE-MsgGUID: 6sx+kfQ8Tw6CS2HxQuXSWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11793"; a="105773566"
X-IronPort-AV: E=Sophos;i="6.24,160,1774335600"; 
   d="scan'208";a="105773566"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 10:45:08 -0700
X-CSE-ConnectionGUID: sVvxl8W3QX2Yx8AK13BLJw==
X-CSE-MsgGUID: XZM0S5M8QcaTj4wM3UKoHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,160,1774335600"; 
   d="scan'208";a="236347421"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.167])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 10:44:41 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Kees Cook <kees@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>
Cc: Kees Cook <kees@kernel.org>, Pengpeng Hou <pengpeng@iscas.ac.cn>, Petr
 Pavlu <petr.pavlu@suse.com>, Richard Weinberger <richard@nod.at>, Anton
 Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg
 <johannes@sipsolutions.net>, "Rafael J. Wysocki" <rafael@kernel.org>, Len
 Brown <lenb@kernel.org>, Corey Minyard <corey@minyard.net>, Gabriel Somlo
 <somlo@cmu.edu>, "Michael S. Tsirkin" <mst@redhat.com>, Joonas Lahtinen
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
 =?utf-8?Q?P=C3=A9rez?= <eperezma@redhat.com>, Jason Baron
 <jbaron@akamai.com>, Jim Cromie
 <jim.cromie@gmail.com>, Tiwei Bie <tiwei.btw@antgroup.com>, Benjamin Berg
 <benjamin.berg@intel.com>, Ilpo =?utf-8?Q?J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>,
 "David E. Box" <david.e.box@linux.intel.com>, "Maciej W. Rozycki"
 <macro@orcam.me.uk>, Srinivas Pandruvada
 <srinivas.pandruvada@linux.intel.com>, Peter Zijlstra
 <peterz@infradead.org>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik
 <gor@linux.ibm.com>, Sean Christopherson <seanjc@google.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
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
Subject: Re: [PATCH 10/11] treewide: Manually convert custom
 kernel_param_ops .get callbacks
In-Reply-To: <20260521133326.2465264-10-kees@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260521133315.work.845-kees@kernel.org>
 <20260521133326.2465264-10-kees@kernel.org>
Date: Thu, 21 May 2026 20:44:37 +0300
Message-ID: <5cd0c8dde3687d0aea765f2f21f5e1cd8ba83028@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260521_104712_763028_475F90F9 
X-CRM114-Status: GOOD (  20.10  )
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

On Thu, 21 May 2026, Kees Cook <kees@kernel.org> wrote:
> diff --git a/drivers/gpu/drm/i915/i915_mitigations.c b/drivers/gpu/drm/i915/i915_mitigations.c
> index 6061eae84e9c..99cb38f355b6 100644
> --- a/drivers/gpu/drm/i915/i915_mitigations.c
> +++ b/drivers/gpu/drm/i915/i915_mitigations.c
> @@ -95,33 +95,37 @@ static int mitigations_set(const char *val, const struct kernel_param *kp)
>  	return 0;
>  }
>  
> -static int mitigations_get(char *buffer, const struct kernel_param *kp)
> +static int mitigations_get(struct seq_buf *buffer,
> +			   const struct kernel_param *kp)
>  {
>  	unsigned long local = READ_ONCE(mitigations);
> -	int count, i;
>  	bool enable;
> +	int i;

I'm fine with what you have, and I can do these as a follow-up later if
it's too much trouble, but I suggest something like this:

	const char *sep = "";

>  
> -	if (!local)
> -		return scnprintf(buffer, PAGE_SIZE, "%s\n", "off");
> +	if (!local) {
> +		seq_buf_printf(buffer, "%s\n", "off");
> +		return 0;
> +	}
>  
>  	if (local & BIT(BITS_PER_LONG - 1)) {
> -		count = scnprintf(buffer, PAGE_SIZE, "%s,", "auto");
> +		seq_buf_printf(buffer, "%s,", "auto");

		seq_buf_printf(buffer, "%s%s", sep, "auto");
		sep = ",";

(In the printf the sep is just for future expansion, though I don't
expect one.)

>  		enable = false;
>  	} else {
>  		enable = true;
> -		count = 0;
>  	}
>  
>  	for (i = 0; i < ARRAY_SIZE(names); i++) {
>  		if ((local & BIT(i)) != enable)
>  			continue;
> -
> -		count += scnprintf(buffer + count, PAGE_SIZE - count,
> -				   "%s%s,", enable ? "" : "!", names[i]);
> +		seq_buf_printf(buffer, "%s%s,", enable ? "" : "!", names[i]);

		seq_buf_printf(buffer, "%s%s%s", sep, enable ? "" : "!", names[i]);
		sep = ",";

>  	}

	seq_buf_puts(buffer, "\n");

>  
> -	buffer[count - 1] = '\n';
> -	return count;
> +	/* Replace the trailing comma with a newline. */
> +	if (!seq_buf_has_overflowed(buffer) && buffer->len > 0 &&
> +	    buffer->buffer[buffer->len - 1] == ',')
> +		buffer->buffer[buffer->len - 1] = '\n';

Drop the above.

I.e. keep track of sep while printing to avoid removing it later.

BR,
Jani.

> +
> +	return 0;
>  }
>  
>  static DEFINE_KERNEL_PARAM_OPS(ops, mitigations_set, mitigations_get);

-- 
Jani Nikula, Intel

