Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 029D5CAC5A5
	for <linux-um@archiver.kernel.org>; Wed, 24 Sep 2025 07:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=R8l3AdnOSsRSws2FudDrnNOobQlzeM81boeBiHgd3uA=; b=ozNZVd/Omos/B9Ssq3ztuwQrLc
	WYbd4BZqmMWY81lbcbWadahR5Aber4/1B+F/6pk/FINswOu4HBdWA3fg0T6pA3zoFZI9gol/IlBJf
	tvOZmU93HgJkrrXprHMH7s56DvInGslVqdt0bvlfL6ZiJ4TON+ntKG8UJ5KgxYk3+ySyYVq5OgDJS
	t40VNDs49zJJJnYiX9EimfziSeZZahpLn5urSut6iBDeRHZ6ae31H+QW0DYmO8RmQ3MMwJ9Aq5rPe
	Oe+rOJiywbVHlLy52Cif9kXTWEa5EO6vRF2vWAQ+iIjZONS0LLKGq76b9iJMhhlZdZtMhwH3NG53O
	gB61v1CA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1KFB-0000000FmhK-4BRB;
	Wed, 24 Sep 2025 07:48:54 +0000
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1KF9-0000000FmfF-0CNc
	for linux-um@lists.infradead.org;
	Wed, 24 Sep 2025 07:48:52 +0000
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-45e03730f83so28386795e9.0
        for <linux-um@lists.infradead.org>; Wed, 24 Sep 2025 00:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758700129; x=1759304929; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R8l3AdnOSsRSws2FudDrnNOobQlzeM81boeBiHgd3uA=;
        b=OBdfbrQ56SPGKfERMixIV6zTU4J5YysWudWrS/PWk1A7esTf9YYgjJUGJhw39EvFw8
         aGVrf8sotxfq2Vqcmci2miU15Xdg0Mui10685Bii6z75xT40EnBAX3qmmWerjHmGixkC
         ncGv1LmBMl7/+yGaC+MJ6wLyfn9Me1MEGwM0YNsGWetE/DAMfTlknsLTT5phR9IyKkuY
         W6wv9+SH9ixQhBL9gx+MwPf0ZgtQmofo4OY95KGWp9LDVEHusORrbmJGp5v4w3W3MDgJ
         iHUyPC43acoB0t9/N1fHIjm76mioSEj2im5oA5vcSknkT6b64N98JrHvjCVs93PmSE23
         wx7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758700129; x=1759304929;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R8l3AdnOSsRSws2FudDrnNOobQlzeM81boeBiHgd3uA=;
        b=cmd4gqFCrV9/ZBNt+D2eq7jBDsamc3lmVedcCjubnh0XjCF4DC5sqrMSxxhMn4H4Jv
         unBoaCq+C9hzvK/qqtbJhGqDO/6/MC1vKJohXx/b3Q2oeTYqfu3p/0phkwEY0YTgPKcO
         jGz/y/zEz94cQMHUXTbngQnyVbGf2IdZlivNL/49Uch2M76vMJbqAX35OKYu9o9jYQOe
         Ae5nFZ+SQyWV4iK2o2BtF27HnlsMN2UqMdBBYlP8jYY6MAtfYY1CsYyYTo0UOnOOY2AX
         80Zo/nKydhz9gQRjv6gQB+B8G/x8OI3ug/Nm8wHAsyBt73dmvuuVfYiCDvJSgEuT5jKU
         u12w==
X-Forwarded-Encrypted: i=1; AJvYcCWOYM9G60tAww9a+BFeIVVxjJSXq9UE0tYL7AbYIK1GNhuK4N5UxDtH4+3Z1Sooz+uqtuQYupi7RQ==@lists.infradead.org
X-Gm-Message-State: AOJu0Yw1fhLcKnPr9dH1T6wWFcVSGWo0VRUSzbz9fFWKPIi9dcW6tEaJ
	8FztK+I5gIBiQBjtVQmvm3i4qBcH+FAOWkxuawbsC5I8OECwAEcHgy+R8Y60OWjYP9Q=
X-Gm-Gg: ASbGnctfUZ/tDZKUMKhpYUHMid1Q+SHbgakWVYhjTi8toi9/4zv1Qdlaqj11OTtrrIo
	qhWsnH0ryl5ACGYMDES29iApq4L/bKJHr/cgoXYKf4qFXrCT6DjzTJzeZvj8aoGSsCZqnSeyS/e
	HFSFFpcXwk2UjkO4iMWKEoe26vaLRGdDvipNKHwk74lkcIAjsMj8tuugdqfX3Xs1mif/5Pzrzbw
	23MVWcdJ1ZT3sKUpI6khAl17adCtQedpoCGvs1zhMOwTK6kGzMtliVzWvuVj6f5e/KGknPZIA5U
	lA/sRis3N5MmjRZQDQ3Q+3B27JrxeMoI1cMijOO/n/vFd218fG8dOHVJrtoOkLC8l2k1v6be8+d
	jgZlI+8VH1GfBvCTYXOM1ys42vs6RfSLmQqrCOco2gMSCmiWQrXc=
X-Google-Smtp-Source: AGHT+IFwNQTWzI6GYN83BC1thuAIQC8cKI7ga+QSPsI75xrmILyCBppuSPCKc3GbCcHRTNLHchQcjw==
X-Received: by 2002:a05:600c:1c87:b0:456:19eb:2e09 with SMTP id 5b1f17b1804b1-46e1d9746d5mr69959415e9.8.1758700128971;
        Wed, 24 Sep 2025 00:48:48 -0700 (PDT)
Received: from [10.0.1.22] (109-81-1-107.rct.o2.cz. [109.81.1.107])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2a9af289sm20857535e9.6.2025.09.24.00.48.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 00:48:48 -0700 (PDT)
Message-ID: <2071b071-874c-4f85-8500-033c73dfaaab@suse.com>
Date: Wed, 24 Sep 2025 09:48:47 +0200
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
 <c84d6952-7977-47cd-8f09-6ea223217337@suse.com> <aNLb9g0AbBXZCJ4m@google.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <aNLb9g0AbBXZCJ4m@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250924_004851_129400_F94BDE87 
X-CRM114-Status: GOOD (  28.47  )
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

On 9/23/25 7:42 PM, Brian Norris wrote:
> Hi Petr,
> 
> On Tue, Sep 23, 2025 at 02:55:34PM +0200, Petr Pavlu wrote:
>> On 9/13/25 12:59 AM, Brian Norris wrote:
>>> @@ -259,6 +315,12 @@ void pci_fixup_device(enum pci_fixup_pass pass, struct pci_dev *dev)
>>>  		return;
>>>  	}
>>>  	pci_do_fixups(dev, start, end);
>>> +
>>> +	struct pci_fixup_arg arg = {
>>> +		.dev = dev,
>>> +		.pass = pass,
>>> +	};
>>> +	module_for_each_mod(pci_module_fixup, &arg);
>>
>> The function module_for_each_mod() walks not only modules that are LIVE,
>> but also those in the COMING and GOING states. This means that this code
>> can potentially execute a PCI fixup from a module before its init
>> function is invoked, and similarly, a fixup can be executed after the
>> exit function has already run. Is this intentional?
> 
> Thanks for the callout. I didn't really give this part much thought
> previously.
> 
> Per the comments, COMING means "Full formed, running module_init". I
> believe that is a good thing, actually; specifically for controller
> drivers, module_init() might be probing the controller and enumerating
> child PCI devices to which we should apply these FIXUPs. That is a key
> case to support.
> 
> GOING is not clearly defined in the header comments, but it seems like
> it's a relatively narrow window between determining there are no module
> refcounts (and transition to GOING) and starting to really tear it down
> (transitioning to UNFORMED before any significant teardown).
> module_exit() runs in the GOING phase.
> 
> I think it does not make sense to execute FIXUPs on a GOING module; I'll
> make that change.

Note that when walking the modules list using module_for_each_mod(),
the delete_module() operation can concurrently transition a module to
MODULE_STATE_GOING. If you are thinking about simply having
pci_module_fixup() check that mod->state isn't MODULE_STATE_GOING,
I believe this won't quite work.

> 
> Re-quoting one piece:
>> This means that this code
>> can potentially execute a PCI fixup from a module before its init
>> function is invoked,
> 
> IIUC, this part is not true? A module is put into COMING state before
> its init function is invoked.

When loading a module, the load_module() function calls
complete_formation(), which puts the module into the COMING state. At
this point, the new code in pci_fixup_device() can see the new module
and potentially attempt to invoke its PCI fixups. However, such a module
has still a bit of way to go before its init function is called from
do_init_module(). The module hasn't yet had its arguments parsed, is not
linked in sysfs, isn't fully registered with codetag support, and hasn't
invoked its constructors (needed for gcov/kasan support).

I don't know enough about PCI fixups and what is allowable in them, but
I suspect it would be better to ensure that no fixup can be invoked from
the module during this period.

If the above makes sense, I think using module_for_each_mod() might not
be the right approach. Alternative options include registering a module
notifier or having modules explicitly register their PCI fixups in their
init function.

-- 
Cheers,
Petr

