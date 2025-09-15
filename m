Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FFB9CAC597
	for <linux-um@archiver.kernel.org>; Mon, 15 Sep 2025 18:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UNSXkkVhuHJlFNtXimgTWN2ssSCSJ/yVmF41qtJieAc=; b=b1TwuSELNd5RQ96qUDRnwr54PY
	5/PjyMlOJP/Jg49wtNy9TLnkq6sp1XhWtDTRGJYBbuMemV4+JKsQqIOg3U9UfDGCb0BrgCFu6Y1uQ
	5JpK13A1TXyLy6d8Btj4rkN7J1dobS74xB6w9VBpgkvYsBwH+97Ms4e3Ms1VEhVTRpRMqmWu2tIuI
	EYqUoROZntDi5W9xMJ17vsb6LstYcZJydxPfjHy1sWPvMr0BPTemuKGPRyUAO1lwFaeZ12oI46Bzx
	/Qx+QeJPtST+WxA8dkwr0eRil6PRZC94mE5bZU2SH6F/jNa2vz8vm9Hvf7l9mD8DdFgPrywZ+Qf+Z
	2SfBSdaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyE1o-00000005Q3l-47Os;
	Mon, 15 Sep 2025 18:34:16 +0000
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyE1m-00000005Q3J-3hjS
	for linux-um@lists.infradead.org;
	Mon, 15 Sep 2025 18:34:16 +0000
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-26060bcc5c8so24668115ad.1
        for <linux-um@lists.infradead.org>; Mon, 15 Sep 2025 11:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1757961254; x=1758566054; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UNSXkkVhuHJlFNtXimgTWN2ssSCSJ/yVmF41qtJieAc=;
        b=ZCddlYZRDEMMTDJ8JkQAtTyGhU0hQQGG7la2RjGU7Pfrb6AfvOHmrfIiL9xwY1q24C
         bUl3mTklOuqF6UyONRqJZWuXfTfV+1XSmVYUJsskjHIaid/3oyFLxcF2ZS6aJB5GlLT+
         /GA6zMMg02DvBo7kd7FndxrTnYJq7jXK2DqQs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757961254; x=1758566054;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UNSXkkVhuHJlFNtXimgTWN2ssSCSJ/yVmF41qtJieAc=;
        b=QxYreqhV89mMAWGEjZLF5+/Y1T3/u+Ds4r3qjh7kAtKcJ6B7O5HxRIGTDWJLB7Rz/d
         Y5swTLdE6oAj4TOG+X9ZhPpnUQL1HrOzGT7h4EMzu4jfZhlg0nkceDQxWFytSoVcHNb3
         MJKg5tmKuAzisWyfY365XroL61Pl2ljf6PUZ5d3GqusRiZe9vC9JdQjg3ct9YF3z6U5P
         tbBNdL/vBnTOfD8jvIMjebaZJsi82FAWOVXfYFi56EYxEBS/UVS13hRUXX8qZknPOkqB
         FlMfllUnmeI3z+rvdxZz5h0TwJGILbXP4Fq3w4GqOj5Tes0Sgcz9By3/RpXkdFhTHjAx
         ACEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVTQGLjqLUyUn+iRweVL2/V01fHq811xS6tjRU1YUH1WMUjrZvM/tQPJ7Rh5jXYDRonUjMf+WpTQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YwF51uduZCJ4kk6pGrV/RK47hB+7rr2Gf6KFEhLb5GWX7JfiPFN
	3YBZuzQBPpFY713SoDDQ3Q1LsXGvGWcoSKDWKYJ1h6YaO1WLxKVUlUqKVW/fLIAqyQ==
X-Gm-Gg: ASbGncsJVvqlY43JLswBZwJWY/MUw8goWzelo5m9gcsCzycLc53F3BGXY2x/P9K8R0q
	oBuB9ftzJ1XQrIe1hCYZ91x/WOVE0Q5O+XC6AhAzyncYRNLL7JFBoPQOqJnmJpcfavwRntmAVWA
	XD419qCwxuyIO3wS81WkKmF8xIwc/2BhLw9cEPhkmCcq3OTt/MZhOA1ECzVxQdb1WCDGh6qYK6l
	YgUJtbK/0EUWWg+moA2K4hQ4YnlwDFVcM+NZjGVrPEoHBnBggh8GqGCC61D95U+1OsXBX0HmNuD
	ZCdUfDnK7ZpILaH7/sF8nVaRrqsZcOAaSTCTr/WuZh0SCPzU/dkEI4XQYg+BtcYU0QWMGB24bkI
	L7wTqEWCS6/oj3vgYW3zmlP5WbZZoHutT3FOzzlqhujGcsSsMXbbfS5RRu2fd
X-Google-Smtp-Source: AGHT+IH+aA/qD9/tWA4T9bKeTNV4qwrmPWyIWt6h2dj375FkW7TVjYU5fI9lcYTNhfQ0zBY5pwIDPA==
X-Received: by 2002:a17:902:ebc9:b0:24b:4a9a:703a with SMTP id d9443c01a7336-25d24da7536mr207524775ad.17.1757961253707;
        Mon, 15 Sep 2025 11:34:13 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:fd49:49b1:16e7:2c97])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-26175efc667sm75235655ad.112.2025.09.15.11.34.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 11:34:12 -0700 (PDT)
Date: Mon, 15 Sep 2025 11:34:10 -0700
From: Brian Norris <briannorris@chromium.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>, linux-pci@vger.kernel.org,
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-modules@vger.kernel.org,
	Sami Tolvanen <samitolvanen@google.com>,
	Richard Weinberger <richard@nod.at>, Wei Liu <wei.liu@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	kunit-dev@googlegroups.com,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	linux-um@lists.infradead.org,
	Manivannan Sadhasivam <mani@kernel.org>
Subject: Re: [PATCH 1/4] PCI: Support FIXUP quirks in modules
Message-ID: <aMhcIsO3KmthtrIL@google.com>
References: <20250912230208.967129-1-briannorris@chromium.org>
 <20250912230208.967129-2-briannorris@chromium.org>
 <8e75d6cc3847899ba8d6a0cbd0ef3ac57eabf009.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8e75d6cc3847899ba8d6a0cbd0ef3ac57eabf009.camel@sipsolutions.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250915_113414_957743_30DA351F 
X-CRM114-Status: GOOD (  41.22  )
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

Hi Johannes,

On Mon, Sep 15, 2025 at 08:33:08AM +0200, Johannes Berg wrote:
> On Fri, 2025-09-12 at 15:59 -0700, Brian Norris wrote:
> > The PCI framework supports "quirks" for PCI devices via several
> > DECLARE_PCI_FIXUP_*() macros. These macros allow arch or driver code to
> > match device IDs to provide customizations or workarounds for broken
> > devices.
> > 
> > This mechanism is generally used in code that can only be built into the
> > kernel, but there are a few occasions where this mechanism is used in
> > drivers that can be modules. For example, see commit 574f29036fce ("PCI:
> > iproc: Apply quirk_paxc_bridge() for module as well as built-in").
> > 
> > The PCI fixup mechanism only works for built-in code, however, because
> > pci_fixup_device() only scans the ".pci_fixup_*" linker sections found
> > in the main kernel; it never touches modules.
> > 
> > Extend the fixup approach to modules.
> 
> This _feels_ a bit odd to me - what if you reload a module, should the
> fixup be done twice? Right now this was not possible in a module, which
> is a bit of a gotcha, but at least that's only one for developers, not
> for users (unless someone messes up and puts it into modular code, as in
> the example you gave.)

My assumption was that FIXUPs in modules are only legitimate if they
apply to a dependency chain that involves the module they are built
into. So for example, the fixup could apply to a bridge that is
supported only by the module (driver) in question; or it could apply
only to devices that sit under the controller in question [1].

Everything I see that could potentially be in a module works like this
AFAICT.

To answer your question: no, the fixup should not be done twice, unless
the device is removed and recreated. More below.

[1] The quirks in drivers/pci/controller/dwc/pci-keystone.c look like
this. (Side note: pci-keystone.c cannot be built as a module today.)

> Although, come to think of it, you don't even apply the fixup when the
> module is loaded, so what I just wrote isn't really true. That almost
> seems like an oversight though, now the module has to be loaded before
> the PCI device is enumerated, which is unlikely to happen in practice?
> But then we get the next gotcha - the device is already enumerated, so
> the fixups cannot be applied at the various enumeration stages, and
> you're back to having to load the module before PCI enumeration, which
> could be tricky, or somehow forcing re-enumeration of a given device
> from userspace, but then you're firmly in "gotcha for the user"
> territory again ...

With my assumption above, none of this would really be needed. The
relevant device(s) will only exist after the module is loaded, and they
will go away when the module is gone.

Or am I misreading your problem statements?

> I don't really have any skin in this game, but overall I'd probably
> argue it's better to occasionally have to fix things such as in the
> commit you point out but have a predictable system, than apply things
> from modules.

FWIW, I believe some folks are working on making *more* controller
drivers modular. So this problem will bite more people. (Specifically, I
believe Manivannan was working on
drivers/pci/controller/dwc/pcie-qcom.c, and it has plenty of FIXUPs.)

I also don't think it makes things much less predictable, as long as
developers abide by my above assumption. I think that's a perfectly
reasonable assumption (it's not so different than, say,
MODULE_DEVICE_TABLE), but I could perhaps be convinced otherwise.

> Perhaps it'd be better to extend the section checking infrastructure to
> catch and error out on these sections in modules instead, so we catch it
> at build time, rather than finding things missing at runtime?

Maybe I'm missing something here, but it seems like it'd be pretty easy
to do something like:

#ifdef MODULE
#define DECLARE_PCI_FIXUP_SECTION...) BUILD_BUG()
#else
... real definitions ...
#endif

I'd prefer not doing this though, if we can help it, since I believe
(a) FIXUPs are useful in perfectly reasonable ways for controller
    drivers and
(b) controller drivers can potentially be modules (yes, there are some
    pitfalls besides $subject).

> And yeah, now I've totally ignored the kunit angle, but ... not sure how
> to combine the two requirements if they are, as I think, conflicting.

Right, either we support FIXUPs in modules, or we should outlaw them.

For kunit: we could still add tests, but just force them to be built-in.
It wouldn't be the first kernel subsystem to need that.

Brian

