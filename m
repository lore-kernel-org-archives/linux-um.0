Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E32CACAC5AC
	for <linux-um@archiver.kernel.org>; Tue, 23 Sep 2025 17:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=p5fCe8unG2HiHz5XK0SHyJ7RQ4XF1Lq7hOFJcFoGeh8=; b=qFJe5J7iDGnGFl/EjSeiqwHaAK
	oVd8i6YSO313YFG16+QyDuX13aeDEbhG7rYMTkvhYFY/kt/E5LOjZ6bgXV5A2JHPWMysQD0j8P0EF
	jhmHQMqC1ygG9QFYvhcdDlKRN05fZEMqn7p7zpjNUKKtM5Yg8CfBErD4Ltp3IPIgbidGNIdpdTXnW
	pLF4Ack+FjxLopEgzL1KvCbLc6c+57CfSCQ+t4+yQcZ5lBUpLPApv6puMUHkK66k4PJaMbLYKBk8f
	XX5gvv8JUrbQc/D7I3UsXLkbqSB0e9F2/FYhFlbFfiSlrNlHKeVZ9jYTflTnBtZPvEAV+dQ8B/UCg
	lehnkBAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v171w-0000000EPyE-0cKy;
	Tue, 23 Sep 2025 17:42:20 +0000
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v171t-0000000EPxL-1Vzs
	for linux-um@lists.infradead.org;
	Tue, 23 Sep 2025 17:42:18 +0000
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-b4fb8d3a2dbso4136670a12.3
        for <linux-um@lists.infradead.org>; Tue, 23 Sep 2025 10:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1758649336; x=1759254136; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p5fCe8unG2HiHz5XK0SHyJ7RQ4XF1Lq7hOFJcFoGeh8=;
        b=S4RbZml2Ds5ShwYwtZB5MRO38E+8UxXnw36AKpgpB6Zhnk070R+jtxduV3nOOVDGsH
         FbtEO/EU92vjsoxkBL3tyIHIMrTaXA6lzZO9THLyGAwpy50rjnYL56Z3z/asGy7nGQlj
         hGMnDSvLr0aAra0Mcg9RfpezYNNuD+x5stoF8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758649336; x=1759254136;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p5fCe8unG2HiHz5XK0SHyJ7RQ4XF1Lq7hOFJcFoGeh8=;
        b=We8o9I/b9aW0xfzZA7D1nu+mtqm8xlsPquJUdnVD8NuzXPUSHa3w84gUE/JMBBi/1F
         BrlR5SKJTDedHAe2U6U+hyaSsk8Ljbsng0wf9/8M7i+ZltvYtcc/YF+epRWMbp551+pZ
         pOoj5yOOJnlho7kzmjwWL6wae3L7mkAb0cH4NXF8UJiacyzGRr1/K0ljt9L/Cy6OEYjc
         CNCBZhRNsIgalmHQm13CaV2p6tfYpRxu9A1YHAPVTnWaaHkHssX0qFL1nPr1bYPfSq4L
         l8bCtqTNjmYYmyvZD2vf+NRnGxr26RlUUVn6rOkii6KlgWEEEYe3uZ6his4JrqBDZYWX
         2/TQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjfeqCtT6ckN0MlfbuQa42jmyQZhvQgWEguwOvb5B1N/CooBcobv1NKJZf6SGXEhUDfIts2Z4ReA==@lists.infradead.org
X-Gm-Message-State: AOJu0YyWa52GnkOEwj6QdjfvhzKgGFYfOOcofZ/VQohqCWwzcf64acW5
	cxpa/BTY6Ez1H324MrMacJjcByBxzSk+vKm1nKIu3C5t4k7ryIGPgV75qaz2uFFPmw==
X-Gm-Gg: ASbGnctpFHTafVwo+EnRvhYXHCsnoRg3B+WEDDHkSZsYDl0Nl8cZcCcUYBPkOM+SQwz
	rLCxkGVywR6yyx9ZgXjDHidjQHV13+yoKOGCrjucEuIBK0CERT386SnEh6WffBHaXF3RNEUiVGg
	JA2NDhPjuv0EpaXG/9gBJXnuo+6lWYwdDLvUHT+ues4ZWVyiKlcm+jI4aXmS58Oeae7JTrcdPAm
	uze01xrLzQ77sma59922tfzG6XhT43iPq3+gjelEt7CI+5mdRMRYo6Iiw21CRthUiYn1ajAOKz0
	m7qNbMeA6Bu9bmIrV2c7JxtCZRgipiEWF86eNsUFAA6glpXoRXCwpRgbyXQhorwZlENHMSUiC0R
	NP0tEGuwE4smpVQnJv9O68ukskWtJRd8j3CCiGXhwSdEcDXy9Gs+txUlgVm+2Q54hjEvd1cEiXd
	bFe7E=
X-Google-Smtp-Source: AGHT+IHJbwEaaCpD6dZUF3mz350pgxjUUNoYTVUR2WMjcFJjbWFfvBHQKr1Y1HlZkG2OkTtL8B8Dkg==
X-Received: by 2002:a17:90b:3cc5:b0:32e:8931:b59c with SMTP id 98e67ed59e1d1-332a9909c66mr4171539a91.27.1758649336532;
        Tue, 23 Sep 2025 10:42:16 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:f126:ac9b:b8ac:e280])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-33060803335sm17000731a91.24.2025.09.23.10.42.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 10:42:15 -0700 (PDT)
Date: Tue, 23 Sep 2025 10:42:14 -0700
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
Message-ID: <aNLb9g0AbBXZCJ4m@google.com>
References: <20250912230208.967129-1-briannorris@chromium.org>
 <20250912230208.967129-2-briannorris@chromium.org>
 <c84d6952-7977-47cd-8f09-6ea223217337@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c84d6952-7977-47cd-8f09-6ea223217337@suse.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250923_104217_434280_AE02D98C 
X-CRM114-Status: GOOD (  21.65  )
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

On Tue, Sep 23, 2025 at 02:55:34PM +0200, Petr Pavlu wrote:
> On 9/13/25 12:59 AM, Brian Norris wrote:
> > @@ -259,6 +315,12 @@ void pci_fixup_device(enum pci_fixup_pass pass, struct pci_dev *dev)
> >  		return;
> >  	}
> >  	pci_do_fixups(dev, start, end);
> > +
> > +	struct pci_fixup_arg arg = {
> > +		.dev = dev,
> > +		.pass = pass,
> > +	};
> > +	module_for_each_mod(pci_module_fixup, &arg);
> 
> The function module_for_each_mod() walks not only modules that are LIVE,
> but also those in the COMING and GOING states. This means that this code
> can potentially execute a PCI fixup from a module before its init
> function is invoked, and similarly, a fixup can be executed after the
> exit function has already run. Is this intentional?

Thanks for the callout. I didn't really give this part much thought
previously.

Per the comments, COMING means "Full formed, running module_init". I
believe that is a good thing, actually; specifically for controller
drivers, module_init() might be probing the controller and enumerating
child PCI devices to which we should apply these FIXUPs. That is a key
case to support.

GOING is not clearly defined in the header comments, but it seems like
it's a relatively narrow window between determining there are no module
refcounts (and transition to GOING) and starting to really tear it down
(transitioning to UNFORMED before any significant teardown).
module_exit() runs in the GOING phase.

I think it does not make sense to execute FIXUPs on a GOING module; I'll
make that change.

Re-quoting one piece:
> This means that this code
> can potentially execute a PCI fixup from a module before its init
> function is invoked,

IIUC, this part is not true? A module is put into COMING state before
its init function is invoked.


> > --- a/kernel/module/main.c
> > +++ b/kernel/module/main.c
> > @@ -2702,6 +2702,32 @@ static int find_module_sections(struct module *mod, struct load_info *info)
> >  					      sizeof(*mod->kunit_init_suites),
> >  					      &mod->num_kunit_init_suites);
> >  #endif
> > +#ifdef CONFIG_PCI_QUIRKS
> > +	mod->pci_fixup_early = section_objs(info, ".pci_fixup_early",
> > +					    sizeof(*mod->pci_fixup_early),
> > +					    &mod->pci_fixup_early_size);
> > +	mod->pci_fixup_header = section_objs(info, ".pci_fixup_header",
> > +					     sizeof(*mod->pci_fixup_header),
> > +					     &mod->pci_fixup_header_size);
> > +	mod->pci_fixup_final = section_objs(info, ".pci_fixup_final",
> > +					    sizeof(*mod->pci_fixup_final),
> > +					    &mod->pci_fixup_final_size);
> > +	mod->pci_fixup_enable = section_objs(info, ".pci_fixup_enable",
> > +					     sizeof(*mod->pci_fixup_enable),
> > +					     &mod->pci_fixup_enable_size);
> > +	mod->pci_fixup_resume = section_objs(info, ".pci_fixup_resume",
> > +					     sizeof(*mod->pci_fixup_resume),
> > +					     &mod->pci_fixup_resume_size);
> > +	mod->pci_fixup_suspend = section_objs(info, ".pci_fixup_suspend",
> > +					      sizeof(*mod->pci_fixup_suspend),
> > +					      &mod->pci_fixup_suspend_size);
> > +	mod->pci_fixup_resume_early = section_objs(info, ".pci_fixup_resume_early",
> > +						   sizeof(*mod->pci_fixup_resume_early),
> > +						   &mod->pci_fixup_resume_early_size);
> > +	mod->pci_fixup_suspend_late = section_objs(info, ".pci_fixup_suspend_late",
> > +						   sizeof(*mod->pci_fixup_suspend_late),
> > +						   &mod->pci_fixup_suspend_late_size);
> > +#endif
> >  
> >  	mod->extable = section_objs(info, "__ex_table",
> >  				    sizeof(*mod->extable), &mod->num_exentries);
> 
> Nit: I suggest writing the object_size argument passed to section_objs()
> here directly as "1" instead of using sizeof(*mod->pci_fixup_...) =
> sizeof(void). This makes the style consistent with the other code in
> find_module_sections().

Ack.

Thanks,
Brian

