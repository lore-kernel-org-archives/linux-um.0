Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B73ECCA470
	for <linux-um@archiver.kernel.org>; Mon,  6 Oct 2025 22:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=E/BzR3xcFJ27hJdoJBLSQ8cx3Y7ne92fXQ6+nL97RBI=; b=syTajKIzOlRo4jI0P/5QwK4Oya
	qMxkZCg5XzkEp5xRIdRMRBPgPNJ7ceSjmlxorkXRMIu7CJWfuc0mWnFXpzq7MuAfEzhjJA4LSQlZS
	4uRfFN7xOAEPwRZ/jHuLvSNPFFzjLbXk+/Q6VdncWEj5FikZA1TLfGvBgkN+aO6qiDzH1sQUQcV1O
	Wj/KjlUPdnX66EM5eR5vRCAN7DBUH4ShcIB+pzKvxn8V9UZCVszVtBUzXSPROLHEte1MjCswswBZS
	BOnsAdCc7DbX89aLbEOtugnsj+CO785x5xyMPXYDI4vH1EQHQ4kdnCZm4iTRsa2zJK4tx8SL8CjuJ
	pu6Sp9HQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v5u9q-00000000xe8-0Wcx;
	Mon, 06 Oct 2025 22:58:18 +0000
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v5u9o-00000000xdk-070i
	for linux-um@lists.infradead.org;
	Mon, 06 Oct 2025 22:58:17 +0000
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-b555ab7fabaso5498381a12.0
        for <linux-um@lists.infradead.org>; Mon, 06 Oct 2025 15:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1759791495; x=1760396295; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E/BzR3xcFJ27hJdoJBLSQ8cx3Y7ne92fXQ6+nL97RBI=;
        b=M1r5oiJJDfQj9xh7rXoPQxOwRuPhhvghDzyTrehR4zD3XRcH7+gi+lGpziQP+Jr3z2
         RKxr7KmSsDDT9VHRqsz0DMtH/jbLe093dwIB+6pw+tJAIoS0Ia8PdsYauoGdZ0yuIXcg
         n0Cr82wS8BguWjV5ChfQv+mjtaVwHV/oF4Pyk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759791495; x=1760396295;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E/BzR3xcFJ27hJdoJBLSQ8cx3Y7ne92fXQ6+nL97RBI=;
        b=vshtfG+IXjDN8TDv/KhZAgWF6SAbyQtvnXiKRxsgwJAFb/+p+Mk65fzeJ5JGP4ULqY
         k+Caeys//FvbG9YwC561AOPpW9vzyuSScLzXup5lom/VpjVvdlOx8RJ+kphARZw7szmh
         uZBRj+jumi3N3SdIaL8nNadhRP4bhBSRjiy8FHPTnGYkCLDVOuvPL3Bsufk/mnHddrng
         7wY6ZHcXKogzmfIgB9PPi/3Worzbv8yudZXuH/6kktfgEh2rWne6tOBia3hl8SNdIx7R
         nxONCiA9pq+sGS1x3s3nisur5A2tF4ZzUltGE3WI2VFcRFebSJhPBJO/e+pczBSh5TU+
         xfOg==
X-Forwarded-Encrypted: i=1; AJvYcCWqEToQXKibRulxEn9IqnzjrE94ksonK4Kavl8K2/SXDcxF+oUquSLnsIqRdt/AZdBdcvdDAfCqvg==@lists.infradead.org
X-Gm-Message-State: AOJu0YyKvBrhDDt0fi4e1WhaZpRWT3oEYMhQ6i54SEmTd7gt1xbS8Zze
	/TGnGG5MHwMOUHIJjtGatWxK7vIVekJOeJxA4P6u3C/Rv9BHU0vUhOx0UM1R98/3Sw==
X-Gm-Gg: ASbGncsikqCcHXqJnSCEbN2sI2mbri/AeS6QhiyFwd+fezc4DX7M9gj1KbaGg6ftmzF
	+qkitxq2X2tT+3NkqQYW+ujeG6z9DKt/L9dTOYdLR3s/6TdeqsFdAobQ6aLaVdsXNN2zEhLvWn4
	HnCoBlsv5DYo1j5ZWKgemy4l05dfBFe1U5eI75DSfgGnvWywfZuGlEVN3UYxXDUCybfT+WvW4YB
	Hs4i8XBuWTD5Q8ecwwBtOC93w2FngK4v6hf1554RUfZom9/dG1LLBjFpss0CU0EyJMGx3Du0IWw
	arheG+OqNPpdaGfi1Lbe27c8qRXkUWwVtbAQgzY11DCU5qVrUJVcmdCfscs5f8U4htb5AKZGJpX
	EsTzI6eVIT/1h7fQp7F+rDvov6E9DSnedBawiKK4xy8gGUnekOjj2X2ioUgzfqvCNSi+lXH9lNY
	e+ZzFusfFs
X-Google-Smtp-Source: AGHT+IGVZN5motWy2Ycd10vl3SQ+AaFTmr4hj0xbObvYJTiiiEPPzlHnJXWtgHFm0rxdlAP5PbSCnQ==
X-Received: by 2002:a17:903:2ac3:b0:269:b2ff:5c0e with SMTP id d9443c01a7336-28e9a679f43mr160020265ad.46.1759791494873;
        Mon, 06 Oct 2025 15:58:14 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:299e:f3e3:eadb:de86])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-28e8d1d5e20sm143991805ad.97.2025.10.06.15.58.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 15:58:14 -0700 (PDT)
Date: Mon, 6 Oct 2025 15:58:12 -0700
From: Brian Norris <briannorris@chromium.org>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Daniel Gomez <da.gomez@kernel.org>, linux-pci@vger.kernel.org,
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-modules@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>,
	Sami Tolvanen <samitolvanen@google.com>,
	Richard Weinberger <richard@nod.at>, Wei Liu <wei.liu@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	kunit-dev@googlegroups.com,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	linux-um@lists.infradead.org
Subject: Re: [PATCH 1/4] PCI: Support FIXUP quirks in modules
Message-ID: <aORJhL1yAPyV7YAW@google.com>
References: <20250912230208.967129-1-briannorris@chromium.org>
 <20250912230208.967129-2-briannorris@chromium.org>
 <c84d6952-7977-47cd-8f09-6ea223217337@suse.com>
 <aNLb9g0AbBXZCJ4m@google.com>
 <2071b071-874c-4f85-8500-033c73dfaaab@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2071b071-874c-4f85-8500-033c73dfaaab@suse.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251006_155816_103432_2864F80A 
X-CRM114-Status: GOOD (  45.16  )
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

Hi Petr,

On Wed, Sep 24, 2025 at 09:48:47AM +0200, Petr Pavlu wrote:
> On 9/23/25 7:42 PM, Brian Norris wrote:
> > Hi Petr,
> > 
> > On Tue, Sep 23, 2025 at 02:55:34PM +0200, Petr Pavlu wrote:
> >> On 9/13/25 12:59 AM, Brian Norris wrote:
> >>> @@ -259,6 +315,12 @@ void pci_fixup_device(enum pci_fixup_pass pass, struct pci_dev *dev)
> >>>  		return;
> >>>  	}
> >>>  	pci_do_fixups(dev, start, end);
> >>> +
> >>> +	struct pci_fixup_arg arg = {
> >>> +		.dev = dev,
> >>> +		.pass = pass,
> >>> +	};
> >>> +	module_for_each_mod(pci_module_fixup, &arg);
> >>
> >> The function module_for_each_mod() walks not only modules that are LIVE,
> >> but also those in the COMING and GOING states. This means that this code
> >> can potentially execute a PCI fixup from a module before its init
> >> function is invoked, and similarly, a fixup can be executed after the
> >> exit function has already run. Is this intentional?
> > 
> > Thanks for the callout. I didn't really give this part much thought
> > previously.
> > 
> > Per the comments, COMING means "Full formed, running module_init". I
> > believe that is a good thing, actually; specifically for controller
> > drivers, module_init() might be probing the controller and enumerating
> > child PCI devices to which we should apply these FIXUPs. That is a key
> > case to support.
> > 
> > GOING is not clearly defined in the header comments, but it seems like
> > it's a relatively narrow window between determining there are no module
> > refcounts (and transition to GOING) and starting to really tear it down
> > (transitioning to UNFORMED before any significant teardown).
> > module_exit() runs in the GOING phase.
> > 
> > I think it does not make sense to execute FIXUPs on a GOING module; I'll
> > make that change.
> 
> Note that when walking the modules list using module_for_each_mod(),
> the delete_module() operation can concurrently transition a module to
> MODULE_STATE_GOING. If you are thinking about simply having
> pci_module_fixup() check that mod->state isn't MODULE_STATE_GOING,
> I believe this won't quite work.

Good point. I think this at least suggests that this should hook into
some blocking point in the module-load sequence, such as the notifiers
or even module_init() as you suggest below.

> > Re-quoting one piece:
> >> This means that this code
> >> can potentially execute a PCI fixup from a module before its init
> >> function is invoked,
> > 
> > IIUC, this part is not true? A module is put into COMING state before
> > its init function is invoked.
> 
> When loading a module, the load_module() function calls
> complete_formation(), which puts the module into the COMING state. At
> this point, the new code in pci_fixup_device() can see the new module
> and potentially attempt to invoke its PCI fixups. However, such a module
> has still a bit of way to go before its init function is called from
> do_init_module(). The module hasn't yet had its arguments parsed, is not
> linked in sysfs, isn't fully registered with codetag support, and hasn't
> invoked its constructors (needed for gcov/kasan support).

It seems unlikely that sysfs, codetag, or arguments should matter much.
gcov and kasan might be nice to have though.

> I don't know enough about PCI fixups and what is allowable in them, but
> I suspect it would be better to ensure that no fixup can be invoked from
> the module during this period.

I don't know of general rules, but they generally do pretty minimal work
to adjust various fields in and around 'struct pci_dev', to account for
broken IDs. Sometimes they need to read a few PCI registers. They may
even tweak PM-related features. It varies based
on what kind of "quriky" devices need to be handled, but it's usually
pretty straightforward and well-contained -- not relying on any kind of
global state, or even all that much specific to the module in question
besides constant IDs.

(You can peruse drivers/pci/quirks.c or the various other files that use
DECLARE_PCI_FIXUP_*() macros, if you're curious.)

> If the above makes sense, I think using module_for_each_mod() might not
> be the right approach. Alternative options include registering a module
> notifier or having modules explicitly register their PCI fixups in their
> init function.

I agree module_for_each_mod() is probably not the right choice, but I'm
not sure what the right choice is.

register_module_notifier() + keying off MODULE_STATE_COMING before
pulling in the '.pci_fixup*' list seems attractive, but it still comes
before gcov/kasan.

It seems like "first thing in module_init()" would be the right choice,
but I don't know of a great way to do that. I could insert PCI-related
calls directly into do_init_module() / delete_module(), but that doesn't
seem very elegant. I could also mess with the module_{init,exit}()
macros, but that seems a bit strange too.

I'm open to suggestions. Or else maybe I'll just go with
register_module_notifier(), and accept that there may some small
downsides still.

Thanks,
Brian

