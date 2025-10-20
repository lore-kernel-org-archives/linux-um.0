Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD156CCD193
	for <linux-um@archiver.kernel.org>; Mon, 20 Oct 2025 11:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nxLi65g4dGwi3ujksBH+bmbmQ5CpFWJvidjZ0C43bek=; b=gY3eDzZvvvkU71xm3ox9plz7fL
	wZwBfUnYHyjjweSc9faneuUcRPe9uZ1WXm0MnV8ZCg3og2jWqGNwpRhIyvkdC4DQn2Bm94EnzkJmD
	bvcyIw8gTUJQ/w0S0FY/Gw7tFMurvBaJlddkQSuAjAzn2ycYp75ZB53kIL279ziuvwrrBamrGMOIM
	vQGw5KO8FkB0YvNx7URH7aCnI9j6pgm+7xd4CHjAk1aB1V8gJaV3cU4Qg+PJeDjZh3GxcrS1LIBKZ
	ikn13lw2BZ+AK5lAkpjo1gvjly0atFxVfTNxDpeTw1eJ3TFLkg3GUbtLfnR/sC03oHYvODAAeL5Zc
	mfA3nudg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAoSc-0000000D8Nb-0orC;
	Mon, 20 Oct 2025 11:53:58 +0000
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAoSZ-0000000D8N0-2fLz
	for linux-um@lists.infradead.org;
	Mon, 20 Oct 2025 11:53:57 +0000
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-4270a3464caso1756677f8f.1
        for <linux-um@lists.infradead.org>; Mon, 20 Oct 2025 04:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1760961233; x=1761566033; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nxLi65g4dGwi3ujksBH+bmbmQ5CpFWJvidjZ0C43bek=;
        b=GTPnUgDhLggneCbz7LJD6DziBIDwHJ2b2GfA/W73VaYbxqy88l/UD/HvYsJZv2a4Sx
         BuGzy01jdsLA9IBK3pbpHwqOPyedGXPjrX80Wxe141QewUiGVW5SNT8mxXGSoS1YazJx
         LB/Tvkw5ihcPetpUjZ1gVyhHMTgvL+1YGupaHQwtjKXz7VMd+HsPEyGgFXrtSTh0Ghfy
         FqJV6hjGRF9aCJll//Bjl1zqwL8qn8AvCA9zZsRxO0efezIruY/01w6BQvAJ/MWnjRMX
         Qu+PVHYdnTZ9KdJg9ElWDH9vjd2LBInjKDovSR/Pm+bFPONgk6QRCwwCMn3GVkdKajmV
         a4Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760961233; x=1761566033;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nxLi65g4dGwi3ujksBH+bmbmQ5CpFWJvidjZ0C43bek=;
        b=QfpPbg+cs5pp5Ns0GipPWD2T2rPw2pZOqOuEX28RTCk7a00G33cvlR6Y/BgKvetCSw
         avQt3U9MsS8J+0AdVdhHOxT+lgre6ZSst3mQlUjCtRQtcNoSG6fnY4X3mO5liIpnGHdB
         MpYNzQbt0O35r7c973CnWQ04a3ec1L9y8Bjk76wnoRHwsbPZpRvwhkLvwbdFnFOOe8hr
         Re0SUkW8XlY5lWAzSwlzh6NzKAkVO+s2X7juKLSJDCb135XMFi0H0YtRfEeWvTGJxB2v
         9DguCjNW8/veERkCw/4UgZw6ha7P7OoaYohm88xj03adL5EbvT10XdxuVgveuu8F8RmF
         5A7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUYUsCX+qAudPu6Vx1AOqgKPzZiwrE32PSpOHZemasWu+Y+OVpsL6BoiKhRbJZn39rKRG0wmL/V9A==@lists.infradead.org
X-Gm-Message-State: AOJu0Yzs82uTUmv48KU8v6fawL9vhFLO6pjjbv/8rWlmiBpNPc4KdLv5
	UbEVrSrH/eb1B9i/39M+w0n9MKD0RfHFISmzFb8t28+Op5YhX3x0+2L0ZOn214Can0A=
X-Gm-Gg: ASbGncuZYG/Wpq862+YvaRcUWUicszSXk39jlT1ssBcHmZUps3OdKMcnTHmxyRdJ1MT
	2PAHdGMWqxlYWbZ1Lju3KeqZKx2xYCXXfMA29Ys7pYtC7QA9/ytEcsI6OfQsrAHuOTUoIdt46jX
	4NYQtvArtNHe+ZbbqEdDOPr4owhynQ4vONmbHbVCgYgSXUtIdCHkp1LjvqmyyKy5sSORySPHqkK
	KTPlbOnaxivfvCsOkmMeTEgs8hIpAUlehO3TruaNrXU7b7epKamy2CKk3yjmnXcTdc0reldQHMU
	OQa4CIevQacdSfigEJh6JsdjCuY+4kv/MNosAkyzjXBEmV8kfcMWyvltATs7iyAPPXyv/yOMgpL
	0B4iF2XwJFHij+8+WzgfojXhNi4KF+ByiofTBOaCg0poE/+RFnGpYePY2ROag8vTQsT1/D6l6s3
	gQQSx7xgAKewivhVUaCfmb
X-Google-Smtp-Source: AGHT+IErqGtubFP6M8NiY7VOpNWyIz/IZypNc+TYzCMimJqqWR79oYHNIBLeUwbSgQtIWQOkjfgZRw==
X-Received: by 2002:a5d:5d01:0:b0:427:7ac:528f with SMTP id ffacd0b85a97d-42707ac53b8mr8364947f8f.33.1760961233199;
        Mon, 20 Oct 2025 04:53:53 -0700 (PDT)
Received: from [10.100.51.209] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-891cf590691sm544700785a.52.2025.10.20.04.53.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 04:53:52 -0700 (PDT)
Message-ID: <eca6031d-7f72-4f24-bbd4-95354d5c9ca5@suse.com>
Date: Mon, 20 Oct 2025 13:53:49 +0200
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
 <2071b071-874c-4f85-8500-033c73dfaaab@suse.com> <aORJhL1yAPyV7YAW@google.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <aORJhL1yAPyV7YAW@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251020_045355_720992_C1E7EC11 
X-CRM114-Status: GOOD (  44.56  )
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

On 10/7/25 12:58 AM, Brian Norris wrote:
> Hi Petr,
> 
> On Wed, Sep 24, 2025 at 09:48:47AM +0200, Petr Pavlu wrote:
>> On 9/23/25 7:42 PM, Brian Norris wrote:
>>> Hi Petr,
>>>
>>> On Tue, Sep 23, 2025 at 02:55:34PM +0200, Petr Pavlu wrote:
>>>> On 9/13/25 12:59 AM, Brian Norris wrote:
>>>>> @@ -259,6 +315,12 @@ void pci_fixup_device(enum pci_fixup_pass pass, struct pci_dev *dev)
>>>>>  		return;
>>>>>  	}
>>>>>  	pci_do_fixups(dev, start, end);
>>>>> +
>>>>> +	struct pci_fixup_arg arg = {
>>>>> +		.dev = dev,
>>>>> +		.pass = pass,
>>>>> +	};
>>>>> +	module_for_each_mod(pci_module_fixup, &arg);
>>>>
>>>> The function module_for_each_mod() walks not only modules that are LIVE,
>>>> but also those in the COMING and GOING states. This means that this code
>>>> can potentially execute a PCI fixup from a module before its init
>>>> function is invoked, and similarly, a fixup can be executed after the
>>>> exit function has already run. Is this intentional?
>>>
>>> Thanks for the callout. I didn't really give this part much thought
>>> previously.
>>>
>>> Per the comments, COMING means "Full formed, running module_init". I
>>> believe that is a good thing, actually; specifically for controller
>>> drivers, module_init() might be probing the controller and enumerating
>>> child PCI devices to which we should apply these FIXUPs. That is a key
>>> case to support.
>>>
>>> GOING is not clearly defined in the header comments, but it seems like
>>> it's a relatively narrow window between determining there are no module
>>> refcounts (and transition to GOING) and starting to really tear it down
>>> (transitioning to UNFORMED before any significant teardown).
>>> module_exit() runs in the GOING phase.
>>>
>>> I think it does not make sense to execute FIXUPs on a GOING module; I'll
>>> make that change.
>>
>> Note that when walking the modules list using module_for_each_mod(),
>> the delete_module() operation can concurrently transition a module to
>> MODULE_STATE_GOING. If you are thinking about simply having
>> pci_module_fixup() check that mod->state isn't MODULE_STATE_GOING,
>> I believe this won't quite work.
> 
> Good point. I think this at least suggests that this should hook into
> some blocking point in the module-load sequence, such as the notifiers
> or even module_init() as you suggest below.
> 
>>> Re-quoting one piece:
>>>> This means that this code
>>>> can potentially execute a PCI fixup from a module before its init
>>>> function is invoked,
>>>
>>> IIUC, this part is not true? A module is put into COMING state before
>>> its init function is invoked.
>>
>> When loading a module, the load_module() function calls
>> complete_formation(), which puts the module into the COMING state. At
>> this point, the new code in pci_fixup_device() can see the new module
>> and potentially attempt to invoke its PCI fixups. However, such a module
>> has still a bit of way to go before its init function is called from
>> do_init_module(). The module hasn't yet had its arguments parsed, is not
>> linked in sysfs, isn't fully registered with codetag support, and hasn't
>> invoked its constructors (needed for gcov/kasan support).
> 
> It seems unlikely that sysfs, codetag, or arguments should matter much.
> gcov and kasan might be nice to have though.
> 
>> I don't know enough about PCI fixups and what is allowable in them, but
>> I suspect it would be better to ensure that no fixup can be invoked from
>> the module during this period.
> 
> I don't know of general rules, but they generally do pretty minimal work
> to adjust various fields in and around 'struct pci_dev', to account for
> broken IDs. Sometimes they need to read a few PCI registers. They may
> even tweak PM-related features. It varies based
> on what kind of "quriky" devices need to be handled, but it's usually
> pretty straightforward and well-contained -- not relying on any kind of
> global state, or even all that much specific to the module in question
> besides constant IDs.
> 
> (You can peruse drivers/pci/quirks.c or the various other files that use
> DECLARE_PCI_FIXUP_*() macros, if you're curious.)
> 
>> If the above makes sense, I think using module_for_each_mod() might not
>> be the right approach. Alternative options include registering a module
>> notifier or having modules explicitly register their PCI fixups in their
>> init function.
> 
> I agree module_for_each_mod() is probably not the right choice, but I'm
> not sure what the right choice is.
> 
> register_module_notifier() + keying off MODULE_STATE_COMING before
> pulling in the '.pci_fixup*' list seems attractive, but it still comes
> before gcov/kasan.
> 
> It seems like "first thing in module_init()" would be the right choice,
> but I don't know of a great way to do that.

We could introduce a new module state and have the module notifier fire
with this state at the required point. This seems to align best with how
other code is hooked into the module loader, although I dislike the idea
of introducing a new module state.

It might also be possible to insert a quirk registration function into
.init_array so it is called by do_mod_ctors().

> I could insert PCI-related
> calls directly into do_init_module() / delete_module(), but that doesn't
> seem very elegant. I could also mess with the module_{init,exit}()
> macros, but that seems a bit strange too.

I don't think you want to modify module_{init,exit}(), but you could
introduce something like module_pci_controller(), along with
pci_register_quirks() and pci_unregister_quirks(), which would handle
quirk registration, somewhat similar to how module_pci_driver() works.

> 
> I'm open to suggestions. Or else maybe I'll just go with
> register_module_notifier(), and accept that there may some small
> downsides still.

If it turns out there is no better way than register_module_notifier(),
then as mentioned above, it is possible to add a new module state to
properly support this case.

-- 
Thanks,
Petr

