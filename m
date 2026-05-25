Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0B9ACD5BB1
	for <linux-um@archiver.kernel.org>; Mon, 25 May 2026 17:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=izugkSqOYsBmSyQ8jfD9m1SVj73YG14U78pRBc6Lai0=; b=DmJcPebcrnn5Y2+zwe3dzFwcnc
	emSTMEPqMRKhntDYWw1N0JMmi38qJuazee7M/kl1Qupa36Tt/BXExmUjiLMns8glP2Kfb5tDlbwQt
	BzUKPJ8U2IKlcB2fEI3MNo3QueWv7OBuel/UkwduE2+petn/oDlEeTveMNxLWsGOYIWpsZJqV786k
	zDPSCPjCBte7XNtfqKmZiAxN11GlCeFzJ9kGvxd5Cr9jg/xIDji3MPKT40NQukByNt3QQdt7mJX2v
	oE9V5hn+IloBBUj3u8Y+rtyfQ7fxo+bKnc0GS+zSHe4k2wdXYIRXl5o0sLOIrQXjC9RRUbuB2baZV
	GIFNsLog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRYod-000000006VK-1nBS;
	Mon, 25 May 2026 17:10:11 +0000
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRYoa-000000006Uo-2STE
	for linux-um@lists.infradead.org;
	Mon, 25 May 2026 17:10:09 +0000
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-4903997fcb5so40910535e9.2
        for <linux-um@lists.infradead.org>; Mon, 25 May 2026 10:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1779729007; x=1780333807; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=izugkSqOYsBmSyQ8jfD9m1SVj73YG14U78pRBc6Lai0=;
        b=J+Np1PKopWLT0XOdbPtdhpnnSM9KK3LTx68GZgOKX88xuxY9YZpkP3sMjiDh9vdQAq
         1t9D48n3YB0DsAzXh4GwaWpCY6YDB2nM3lclJNhK/VhLgl4omxGyNqCE4SP0ctWd8ozg
         iDQOVmLyAWI1RISpzqtcuhas2wovx6QB3f0xpIyoDuoVBMA2fOr+yYwqmQoosIzf+Wpl
         TEoXdv9vSd6kbKwAg21JKs0T2YHXFBzxi6jcgBN2vmcgJc+y0ZvSyabiizmUS3o+p0I6
         0VnBlRRasHCuIztuBRRU/RXZrY8blOF2PA6ewqwtcPk5zft7pEJE3DA12Hu/gcwk5VsP
         J6bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779729007; x=1780333807;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=izugkSqOYsBmSyQ8jfD9m1SVj73YG14U78pRBc6Lai0=;
        b=shHI3C5z8FDzLhIbTAe7z+0opsmZyzTYftRRJZ8Cfb0bzp6K7Sqfxv/TA5Z5gvr8gD
         mAops/ehXYBMCuueGDwIIO8fBPhQuSALjmq1tuqg/GAORGAA6A7Bek6x37UI7vGFdYqH
         SkMIxriegYaBDkz25xLUlyuy8auClJtX/FWSNKriNGmOnRNILWJoAKf9x7GDaAFMlk0B
         SJUnYm17DgJrrJecKT3SOFlQKa6nCdFCqEzngTFoaY07IQjSsBav0lCoPa9dFSwsR27S
         wFR6cWz0MEwdxx/8+7GcPuutoXhPCHdRZGjWI0UHIh4nq1K9Cahfl+5ot/wf45Cgpe4n
         aAMg==
X-Forwarded-Encrypted: i=1; AFNElJ/31tQe1dFb0JeVV4okv1bR1jG3/dIWT9pd8QAhA61dGikenxkGOWmeTGKvU68lJbQthycEeVTRMA==@lists.infradead.org
X-Gm-Message-State: AOJu0YzR24r6udkc5+d+80aSaaUb8HnRSzApnQssyl/dJfB1LF0BC0fC
	6lnK2tSiJo4cUxfiLM1L+qFDA+Bb6I6xox87UBLw0gKFKOte78GO2THSOsyT++DVrbY=
X-Gm-Gg: Acq92OF4MgC8yoYbChXs/b6OTvWRXInzOLTav1UV0eLQgDPUNA3uCa8FM+upTuq5OjZ
	RbvJKOOUsc+AEMWZDTGLVIjbFHSRsPJ2Wl98y2iG8HfmdPfTTxmT3ohPp+0a9Ixd0YnBfJ8abdB
	9Zfg5Dy3XkKLQi3KrtLrKqXzz/Vh6fzGFK19Kbq5EyzAqKOFRC8vEmXHJX1mIH298qoDiwHEEEt
	YdVkoEtdfHJebsCOTRGle0GR9ODw2shN9Cfm/SalBRNOmup0nBVCYrHrRZCaTZe0i9zBG2cUcIZ
	sSRk5/c052tDQcOwx+abrCsywJGkuGXkYay22QVml0dOgAnlkfBk6p5JV4D0yGnyxp/2JZ1IGXN
	L9N+y6JvnRThq1+dcE9aw/Rt34UVIZ/3sa/+GRYiIkMk2IdpT3UlkiBGdsGu1Oq7RCnMXMld5aJ
	ro+vUZqjqGNMRxruWLSnbrVQzsGYWyuWak0BgAb/ewimZMHduItFy2sk/tWdCAzgZ2I4lN+Avie
	4R0no+f8Lbfc8Z6UXCzl8FVMzn/Peda0T/0fjnwDairVRqGw7ponaQdj7LjGVwS/MjEak+U20BM
	guV/NBf3t7J76Q4=
X-Received: by 2002:a05:600c:35cf:b0:490:44eb:c1e5 with SMTP id 5b1f17b1804b1-49044ebc257mr277307095e9.31.1779729006482;
        Mon, 25 May 2026 10:10:06 -0700 (PDT)
Received: from ?IPV6:2a00:1028:838d:271e:8e3b:4aff:fe4c:a100? (dynamic-2a00-1028-838d-271e-8e3b-4aff-fe4c-a100.ipv6.o2.cz. [2a00:1028:838d:271e:8e3b:4aff:fe4c:a100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4904526c926sm456877405e9.1.2026.05.25.10.10.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 May 2026 10:10:06 -0700 (PDT)
Message-ID: <a192eb5c-5d16-483d-862e-d937fa1b8269@suse.com>
Date: Mon, 25 May 2026 19:10:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/11] params: Convert generic kernel_param_ops .get
 helpers to seq_buf
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
 <20260521133326.2465264-8-kees@kernel.org>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260521133326.2465264-8-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260525_101008_667216_00AD9D58 
X-CRM114-Status: GOOD (  30.47  )
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
> Convert the generic struct kernel_param_ops .get helpers in
> kernel/params.c directly to the seq_buf signature, drop their legacy
> "char *" form, and refresh prototypes in <linux/moduleparam.h>:
> 
>   param_get_byte/short/ushort/int/uint/long/ulong/ullong/hexint
>   param_get_charp/bool/invbool/string
>   param_array_get
> 
> The STANDARD_PARAM_DEF() macro expands to a seq_buf body for every
> numeric helper. param_array_get() now writes element output directly
> into the parent seq_buf when the element ops provide .get; it only
> allocates the per-call PAGE_SIZE bounce buffer when the element ops
> still use the legacy .get_str path. The common "rewrite the prior
> element's trailing newline as a comma" step lives outside both
> branches so the two paths share it.
> 
> The non-core changes in this commit (arch/x86/kvm, mm/kfence,
> drivers/dma/dmatest, security/apparmor) are the small set of callers that
> directly invoke one of the converted generic helpers from their own .get
> callback (e.g. an apparmor wrapper that adds a capability check and then
> delegates to param_get_bool()). Because the helpers' signature changes
> here, these wrappers must move in lockstep. Each of them is updated
> to take "struct seq_buf *" and pass it through; param_get_debug() in
> apparmor also pulls aa_print_debug_params() (and its val_mask_to_str()
> helper, in security/apparmor/lib.c) over to seq_buf, since that is the
> only consumer. No other behavioural change is intended.
> 
> Custom .get callbacks that do not delegate to a generic helper (and
> therefore still match the .get_str signature) are routed automatically
> to the .get_str field by the DEFINE_KERNEL_PARAM_OPS _Generic dispatcher
> and are deliberately left alone here, to be changed separately within
> their respective subsystems.
> 
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> [...]
> @@ -453,36 +457,46 @@ static int param_array_set(const char *val, const struct kernel_param *kp)
>  			   arr->num ?: &temp_num);
>  }
>  
> -static int param_array_get(char *buffer, const struct kernel_param *kp)
> +static int param_array_get(struct seq_buf *s, const struct kernel_param *kp)
>  {
> -	int i, off, ret;
> -	char *elem_buf;
>  	const struct kparam_array *arr = kp->arr;
>  	struct kernel_param p = *kp;
> +	char *elem_buf = NULL;
> +	int i, ret = 0;
>  
> -	elem_buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
> -	if (!elem_buf)
> -		return -ENOMEM;
> +	for (i = 0; i < (arr->num ? *arr->num : arr->max); i++) {
> +		size_t before = s->len;
>  
> -	for (i = off = 0; i < (arr->num ? *arr->num : arr->max); i++) {
>  		p.arg = arr->elem + arr->elemsize * i;
>  		check_kparam_locked(p.mod);
> -		ret = arr->ops->get_str(elem_buf, &p);
> -		if (ret < 0)
> -			goto out;
> -		ret = min(ret, (int)(PAGE_SIZE - 1 - off));
> -		if (!ret)
> +
> +		if (arr->ops->get) {
> +			ret = arr->ops->get(s, &p);
> +			if (ret < 0)
> +				goto out;
> +		} else {
> +			if (!elem_buf) {
> +				elem_buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
> +				if (!elem_buf) {
> +					ret = -ENOMEM;
> +					goto out;
> +				}
> +			}
> +			ret = arr->ops->get_str(elem_buf, &p);
> +			if (ret < 0)
> +				goto out;
> +			seq_buf_putmem(s, elem_buf, ret);
> +		}
> +
> +		/* Nothing got written (e.g. overflow) — stop. */
> +		if (s->len == before)
>  			break;
> +
>  		/* Replace the previous element's trailing newline with a comma. */
> -		if (i)
> -			buffer[off - 1] = ',';
> -		memcpy(buffer + off, elem_buf, ret);
> -		off += ret;
> -		if (off == PAGE_SIZE - 1)
> -			break;
> +		if (i && s->buffer[before - 1] == '\n')
> +			s->buffer[before - 1] = ',';
>  	}
> -	buffer[off] = '\0';
> -	ret = off;
> +	ret = 0;
>  out:
>  	kfree(elem_buf);
>  	return ret;

Since you're almost completely rewriting the logic in param_array_get(),
I suggest tightening it up a bit. The function could warn or return an
error when a kernel_param_ops::get/get_str() call adds a string that
doesn't terminate with '\n', specifically, when the call adds either
a zero-length string or a non-zero-length string that ends with
a different character (unless an overflow occurred).

The updated code silently stops the loop when a get call returns
a zero-length string. Similarly, handling of a string not terminated by
'\n' is halfway there because of the added check
"s->buffer[before - 1] == '\n'".

-- 
Thanks,
Petr

