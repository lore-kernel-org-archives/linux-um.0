Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21ACECAC5A7
	for <linux-um@archiver.kernel.org>; Tue, 23 Sep 2025 12:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xaIg4jDl9jFZTYzzE1kP2lbNTLyhNR0UhkVfuAOFPbU=; b=TwfZ6F9dNIPIyLBs0RSI/bZr/Q
	b16bMM1q5gGLqKoXHdw3e7zvhScfEIgSwSMeB1A83PzuKEnMKIoYJtf5wbAhPxu61topL+f6SQfxQ
	fnr1COzX++3TiqbHU9VL5LC19KCDpnFrAlDCxZ4T2lp9A2a8TEfCYuzZ0n1w76CID8iitaEeosBcV
	phik4B0i/NR7AD4h75WpI4f9X5P7ZXc2L9xq8b30nUipxLAoyiPESLiErJuEVWq34Ab0ALVBJHuKw
	ccjuluk2jJ8ZoHeUe2SxCHPdt7M6uwHbdtQ7TKkrjoY+kGF/NEFpFF7O8wNHxMwS2iIw0oOBbniDQ
	XeiqkFgQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v12YW-0000000DNBV-1t8o;
	Tue, 23 Sep 2025 12:55:40 +0000
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v12YU-0000000DN8U-147X
	for linux-um@lists.infradead.org;
	Tue, 23 Sep 2025 12:55:39 +0000
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-3f0134ccc0cso4284906f8f.1
        for <linux-um@lists.infradead.org>; Tue, 23 Sep 2025 05:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758632136; x=1759236936; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xaIg4jDl9jFZTYzzE1kP2lbNTLyhNR0UhkVfuAOFPbU=;
        b=gVVrO1sdnRtfnDQZwKs8YwnjpYLJscD/8GjQ7/bFzt2mT/1W9j2zEu8hWdByCxjRFX
         uB2sqvZcXoIz1vs/rZIXQj9nKwQQBr4LBTYMxKo7MGpFkOgN+Nk+LgkowUzhLjR1q4X/
         oCzQaNbSKA8NPd3a7Fr2+FyNOV0AWME32A2VZirNJjbBZehJZBUshNg/mLORgOaOJdLC
         5Rveq0LyngL7UWPjY+D4IG6+LRGXZT8FV91ne1nQh4QYM5XYULi0ZXBwjXnARf5wgEB5
         EvvlBK63YwN7AbdOBrShyiwJewIDUbN57TVq1LCDCegG89FZMM89Od9lkWWpqVVCvKZ0
         cxWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758632136; x=1759236936;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xaIg4jDl9jFZTYzzE1kP2lbNTLyhNR0UhkVfuAOFPbU=;
        b=H2Xe3DIqt0aH4fq0x7uNrBsDkIuWxllfO6kt0o2y5RbWTsMHzqEGUt0R01hFwNHUUm
         Vpuz5peImpJ1I9N3bVDvipag54/WCw0LO4e6n9agibHJpjeevR+upFoHwbflrJ3AyReb
         qioo+wbfVD5HpgRE+hfwEEPtS/cQEbPhsVh/RWYaKlwghKDOktR0D8pdIs7P3beifila
         G1Dl9bgyVd5W825OzURjAehSZ3+Y2WQEC2lUm1ixxbtyOcuKmblzkm6NhtKZqdqe4G3O
         U2EHAkMPKbJG0cG2RIakCaI2S53RC5Z+xG72XsZTwXC8q0lHJflaZrowl+sD6+Cpjgdz
         z7YQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+A8Ryqf4DVjSmJchzs2ZspOT4XqyFbtMFspzECJVPVqPBuG6jUoz5bYbdoOzF4ErVX99xHQ8jnQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YxfczqBW5zCP8v08/JGgHW/HTaJmUFzZ8KJrhY5mdR+I+v4rUDE
	qddL+4fkivOgfbXhAJb/YpSLoQ/Gp+arhJbiHZ3qRe/4JuafVkTZYzx1vm/PkvlQZuc=
X-Gm-Gg: ASbGncsd3s6F3Qc5Gaf7zxRZpBpdr3Lqpl5Swc3In4Mkuogo10/7BAmRr0MrS/QBdLg
	TYdgiNP4gmUES77D6oKDS5TkUJCJ1XAw5a/pGRlp/YpewyCQ4B+Ho0lfzhSH9YRTpbpvEqj+JsI
	kFF8hiusJnRQxOBE/CYSO1ZCwriFdNJOuKnErWE9nXNwP/uh5ig3MneUaNeZWpC6Po4PhERTZ0y
	Ad/VKXOzd2ttXwJOFm6XjqR+OgKsPzuyCwlx7kpK2iWsvRslNA3iXyhVTVYCw6y4yjIW6jR/0JI
	PzpwFi95U1WHhtOmWeP7Ua2TVmWDmz7E8ucWwAFUNWhxjDkx3V0H7SiiWpl6enFWu7l/rdZ7wkv
	QqYGzkikpf4ruU8HYJ5gndpuTOd7iU0A+8uws/pEgBcI=
X-Google-Smtp-Source: AGHT+IG0uyoZNs0i41rqkNkMaZFqouCej55fWirbDUl/J5m3XVuK1w9+Aykmm/3MDPy3vac3H7+Wyg==
X-Received: by 2002:a05:6000:4025:b0:3e4:957d:d00 with SMTP id ffacd0b85a97d-405cb9a5225mr1756055f8f.58.1758632135758;
        Tue, 23 Sep 2025 05:55:35 -0700 (PDT)
Received: from [10.100.51.209] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-464f5a286edsm273702715e9.16.2025.09.23.05.55.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 05:55:35 -0700 (PDT)
Message-ID: <c84d6952-7977-47cd-8f09-6ea223217337@suse.com>
Date: Tue, 23 Sep 2025 14:55:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] PCI: Support FIXUP quirks in modules
To: Brian Norris <briannorris@chromium.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Luis Chamberlain
 <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 linux-pci@vger.kernel.org, David Gow <davidgow@google.com>,
 Rae Moar <rmoar@google.com>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
 Johannes Berg <johannes@sipsolutions.net>,
 Sami Tolvanen <samitolvanen@google.com>, Richard Weinberger
 <richard@nod.at>, Wei Liu <wei.liu@kernel.org>,
 Brendan Higgins <brendan.higgins@linux.dev>, kunit-dev@googlegroups.com,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-um@lists.infradead.org
References: <20250912230208.967129-1-briannorris@chromium.org>
 <20250912230208.967129-2-briannorris@chromium.org>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20250912230208.967129-2-briannorris@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250923_055538_350612_6EFBC045 
X-CRM114-Status: GOOD (  27.20  )
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

On 9/13/25 12:59 AM, Brian Norris wrote:
> The PCI framework supports "quirks" for PCI devices via several
> DECLARE_PCI_FIXUP_*() macros. These macros allow arch or driver code to
> match device IDs to provide customizations or workarounds for broken
> devices.
> 
> This mechanism is generally used in code that can only be built into the
> kernel, but there are a few occasions where this mechanism is used in
> drivers that can be modules. For example, see commit 574f29036fce ("PCI:
> iproc: Apply quirk_paxc_bridge() for module as well as built-in").
> 
> The PCI fixup mechanism only works for built-in code, however, because
> pci_fixup_device() only scans the ".pci_fixup_*" linker sections found
> in the main kernel; it never touches modules.
> 
> Extend the fixup approach to modules.
> 
> I don't attempt to be clever here; the algorithm here scales with the
> number of modules in the system.
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
> 
>  drivers/pci/quirks.c   | 62 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/module.h | 18 ++++++++++++
>  kernel/module/main.c   | 26 ++++++++++++++++++
>  3 files changed, 106 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index d97335a40193..db5e0ac82ed7 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -207,6 +207,62 @@ extern struct pci_fixup __end_pci_fixups_suspend_late[];
>  
>  static bool pci_apply_fixup_final_quirks;
>  
> +struct pci_fixup_arg {
> +	struct pci_dev *dev;
> +	enum pci_fixup_pass pass;
> +};
> +
> +static int pci_module_fixup(struct module *mod, void *parm)
> +{
> +	struct pci_fixup_arg *arg = parm;
> +	void *start;
> +	unsigned int size;
> +
> +	switch (arg->pass) {
> +	case pci_fixup_early:
> +		start = mod->pci_fixup_early;
> +		size = mod->pci_fixup_early_size;
> +		break;
> +	case pci_fixup_header:
> +		start = mod->pci_fixup_header;
> +		size = mod->pci_fixup_header_size;
> +		break;
> +	case pci_fixup_final:
> +		start = mod->pci_fixup_final;
> +		size = mod->pci_fixup_final_size;
> +		break;
> +	case pci_fixup_enable:
> +		start = mod->pci_fixup_enable;
> +		size = mod->pci_fixup_enable_size;
> +		break;
> +	case pci_fixup_resume:
> +		start = mod->pci_fixup_resume;
> +		size = mod->pci_fixup_resume_size;
> +		break;
> +	case pci_fixup_suspend:
> +		start = mod->pci_fixup_suspend;
> +		size = mod->pci_fixup_suspend_size;
> +		break;
> +	case pci_fixup_resume_early:
> +		start = mod->pci_fixup_resume_early;
> +		size = mod->pci_fixup_resume_early_size;
> +		break;
> +	case pci_fixup_suspend_late:
> +		start = mod->pci_fixup_suspend_late;
> +		size = mod->pci_fixup_suspend_late_size;
> +		break;
> +	default:
> +		return 0;
> +	}
> +
> +	if (!size)
> +		return 0;
> +
> +	pci_do_fixups(arg->dev, start, start + size);
> +
> +	return 0;
> +}
> +
>  void pci_fixup_device(enum pci_fixup_pass pass, struct pci_dev *dev)
>  {
>  	struct pci_fixup *start, *end;
> @@ -259,6 +315,12 @@ void pci_fixup_device(enum pci_fixup_pass pass, struct pci_dev *dev)
>  		return;
>  	}
>  	pci_do_fixups(dev, start, end);
> +
> +	struct pci_fixup_arg arg = {
> +		.dev = dev,
> +		.pass = pass,
> +	};
> +	module_for_each_mod(pci_module_fixup, &arg);

The function module_for_each_mod() walks not only modules that are LIVE,
but also those in the COMING and GOING states. This means that this code
can potentially execute a PCI fixup from a module before its init
function is invoked, and similarly, a fixup can be executed after the
exit function has already run. Is this intentional?

>  }
>  EXPORT_SYMBOL(pci_fixup_device);
>  
> diff --git a/include/linux/module.h b/include/linux/module.h
> index 3319a5269d28..7faa8987b9eb 100644
> --- a/include/linux/module.h
> +++ b/include/linux/module.h
> @@ -539,6 +539,24 @@ struct module {
>  	int num_kunit_suites;
>  	struct kunit_suite **kunit_suites;
>  #endif
> +#ifdef CONFIG_PCI_QUIRKS
> +	void *pci_fixup_early;
> +	unsigned int pci_fixup_early_size;
> +	void *pci_fixup_header;
> +	unsigned int pci_fixup_header_size;
> +	void *pci_fixup_final;
> +	unsigned int pci_fixup_final_size;
> +	void *pci_fixup_enable;
> +	unsigned int pci_fixup_enable_size;
> +	void *pci_fixup_resume;
> +	unsigned int pci_fixup_resume_size;
> +	void *pci_fixup_suspend;
> +	unsigned int pci_fixup_suspend_size;
> +	void *pci_fixup_resume_early;
> +	unsigned int pci_fixup_resume_early_size;
> +	void *pci_fixup_suspend_late;
> +	unsigned int pci_fixup_suspend_late_size;
> +#endif
>  
>  
>  #ifdef CONFIG_LIVEPATCH
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index c66b26184936..50a80c875adc 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -2702,6 +2702,32 @@ static int find_module_sections(struct module *mod, struct load_info *info)
>  					      sizeof(*mod->kunit_init_suites),
>  					      &mod->num_kunit_init_suites);
>  #endif
> +#ifdef CONFIG_PCI_QUIRKS
> +	mod->pci_fixup_early = section_objs(info, ".pci_fixup_early",
> +					    sizeof(*mod->pci_fixup_early),
> +					    &mod->pci_fixup_early_size);
> +	mod->pci_fixup_header = section_objs(info, ".pci_fixup_header",
> +					     sizeof(*mod->pci_fixup_header),
> +					     &mod->pci_fixup_header_size);
> +	mod->pci_fixup_final = section_objs(info, ".pci_fixup_final",
> +					    sizeof(*mod->pci_fixup_final),
> +					    &mod->pci_fixup_final_size);
> +	mod->pci_fixup_enable = section_objs(info, ".pci_fixup_enable",
> +					     sizeof(*mod->pci_fixup_enable),
> +					     &mod->pci_fixup_enable_size);
> +	mod->pci_fixup_resume = section_objs(info, ".pci_fixup_resume",
> +					     sizeof(*mod->pci_fixup_resume),
> +					     &mod->pci_fixup_resume_size);
> +	mod->pci_fixup_suspend = section_objs(info, ".pci_fixup_suspend",
> +					      sizeof(*mod->pci_fixup_suspend),
> +					      &mod->pci_fixup_suspend_size);
> +	mod->pci_fixup_resume_early = section_objs(info, ".pci_fixup_resume_early",
> +						   sizeof(*mod->pci_fixup_resume_early),
> +						   &mod->pci_fixup_resume_early_size);
> +	mod->pci_fixup_suspend_late = section_objs(info, ".pci_fixup_suspend_late",
> +						   sizeof(*mod->pci_fixup_suspend_late),
> +						   &mod->pci_fixup_suspend_late_size);
> +#endif
>  
>  	mod->extable = section_objs(info, "__ex_table",
>  				    sizeof(*mod->extable), &mod->num_exentries);

Nit: I suggest writing the object_size argument passed to section_objs()
here directly as "1" instead of using sizeof(*mod->pci_fixup_...) =
sizeof(void). This makes the style consistent with the other code in
find_module_sections().

-- 
Thanks,
Petr

