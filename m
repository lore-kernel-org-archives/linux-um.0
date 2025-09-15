Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABD65CAC597
	for <linux-um@archiver.kernel.org>; Mon, 15 Sep 2025 18:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yvNrOR4ellqZqvuE2ABZzj31gMsgVuW0rC+wrpkvP4k=; b=LsOgNvv+1vQjRXvijziZXmqZUH
	5+b6PluPKsPunnn6VXbFGYySBBMSoo62XbQAV3DPaqxfQmoD5aFWK9K/dN5VbD7bWsBGmOTCRmfRh
	YpZx+uGUM+M+jZqOOKHeO0DCjfALo493UqjGc/dNgZoXEp7o4/nfcKGccgmZLjROqSruVyEyqepyK
	oOjkqUmpECx6GQiOa7V1irRagZzYFfCwWBRCrMDN83dgRtVuNAT7uT/AEysFN/auCFc6WfnWgdovh
	GFcQVVwZ0ta1ytJ0kLzZyrb8rslwDWqK5WWfNq3SfvqZ8EghntZ8iT3S1CkhiXOdRi/Hpoaf9imSt
	dFjq5Zhw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyE90-00000005R4h-0XMt;
	Mon, 15 Sep 2025 18:41:42 +0000
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyE8y-00000005R3Y-1edb
	for linux-um@lists.infradead.org;
	Mon, 15 Sep 2025 18:41:41 +0000
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-76e4f2e4c40so3944729b3a.2
        for <linux-um@lists.infradead.org>; Mon, 15 Sep 2025 11:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1757961699; x=1758566499; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yvNrOR4ellqZqvuE2ABZzj31gMsgVuW0rC+wrpkvP4k=;
        b=l9nKBgxizcMKqjo7XOFhpZP98VU/eWVYiCkO9PXelht4iFosKRe+GE8+cqBf/0rKEq
         7vyzP7DCz7dgPAzkMvR7GcWiJRZtsKRjUIlmBndVhYzDDjHVGn5NhToyI5uY6AWgRP6j
         F8q2Ikwyz4t62RDN13TVK0hCQPC/F6Ibde0VY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757961699; x=1758566499;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yvNrOR4ellqZqvuE2ABZzj31gMsgVuW0rC+wrpkvP4k=;
        b=s32rkTE94YEhQigYMMrGCppqp9qn1Cbycanpu5Y9V02e3rZ2Q5N/EGod2jvrttaTus
         WnEUDaKFJqogTfKtDmJL3YJZ9NLZtBvdssF1uaoUgMM7VDV9lGChxn0ASqaI118cBLoi
         qIah+TYnh10CdfLex+joBqx0g0YozWcsj3v8CrCWAjnr02eCizUROMGJtbrHFlN3mRE1
         cYjIOePREOsLFaXatTT8/bPoN1wDUfKH9M+u2eUkylo7qqyfRnRRlUOl0sjdfQEGhMlm
         XsYCEI/B4oYXkLHOA6aAFLnAvNOkYcKhAyJoli5WNPzRAJ96xaHwdedbSPWwbHTIkykn
         5Eng==
X-Forwarded-Encrypted: i=1; AJvYcCUvKaKdVmCiU+W5q22DqWcoOPBP4zh+BW5t0ke4bMDRPWHQKDSL+4fkVXoNIvU1P8VUELNP+Kdg+Q==@lists.infradead.org
X-Gm-Message-State: AOJu0YxRfF7L8PWDRJ6hBGPo5MHGkvpbzdGTEe60MigBKSgEHVqI9xyG
	oo9t/nQ9RZ8FBfjZ9/Dk97ijAOFw7pJgHRudPsmdK4+5P9lz9AFOcjcGHEzj6DtCBA==
X-Gm-Gg: ASbGncsthiEkTLHz2wbrjd0KglWJ9nJ0NSILyDC9evXcnmdmk7W/SljmkcEbTo+yFqJ
	8h2Gr0soOju4xAcU7DNmoa6A+M1uSxBbceO7VmAVFHwpXmPSUUng+J5k5E6RBBrYavp5Brqq6Ah
	g69mDen/o0QnogeqI5xSgHoA+4s8/m6O5gKHoCzi24zLvk4LnGYpT/uRgryLDzCt7EolfiepdIT
	FFDdvyCKNtbF8g69WBlv3qrNN8uZudOAuhOjuRknPVwgrFOeLgW6ZgHTW06dWGSUwA9hrnJNC8a
	hkunh+BT4NhhpAs9kPuQxI5rOAIYXhRFw9brAsmy9DmmihrtgpxRgO3NjT7LVJ0fHTNdiZfSfiz
	ohwZZXhzCQIk8HIr8NkcvyeHVmONii76jEKTR2hyVtJxAuEfFzkbeTUhv0jIHPBBaRAbPVuk=
X-Google-Smtp-Source: AGHT+IGlRm1d0pxmlp5QnmWl5T2hIZtYHRH5ZefBsxntjPmY3kpOuBh7Py9dWQ+bly9aiTvcXCvOzw==
X-Received: by 2002:a05:6a00:9289:b0:772:4759:e433 with SMTP id d2e1a72fcca58-7761209bdeemr15688778b3a.2.1757961699464;
        Mon, 15 Sep 2025 11:41:39 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:fd49:49b1:16e7:2c97])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-77607b33c45sm13983580b3a.71.2025.09.15.11.41.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 11:41:38 -0700 (PDT)
Date: Mon, 15 Sep 2025 11:41:37 -0700
From: Brian Norris <briannorris@chromium.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
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
Subject: Re: [PATCH 0/4] PCI: Add support and tests for FIXUP quirks in
 modules
Message-ID: <aMhd4REssOE-AlYw@google.com>
References: <20250912230208.967129-1-briannorris@chromium.org>
 <aMgZJgU7p57KC0DL@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMgZJgU7p57KC0DL@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250915_114140_450022_09145F93 
X-CRM114-Status: GOOD (  22.73  )
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

Hi Christoph,

On Mon, Sep 15, 2025 at 06:48:22AM -0700, Christoph Hellwig wrote:
> On Fri, Sep 12, 2025 at 03:59:31PM -0700, Brian Norris wrote:
> > This series primarily adds support for DECLARE_PCI_FIXUP_*() in modules.
> > There are a few drivers that already use this, and so they are
> > presumably broken when built as modules.
> 
> That's a reall bad idea, because it allows random code to insert quirks
> not even bound to the hardware they support.

I see fixups in controller drivers here:

drivers/pci/controller/dwc/pci-imx6.c
drivers/pci/controller/dwc/pci-keystone.c
drivers/pci/controller/dwc/pcie-qcom.c
drivers/pci/controller/pci-loongson.c
drivers/pci/controller/pci-tegra.c
drivers/pci/controller/pcie-iproc-bcma.c
drivers/pci/controller/pcie-iproc.c

Are any of those somehow wrong?

And if they are not wrong, then is this a good reason to disallow making
these drivers modular? (Yes, few of them are currently modular; but I
don't see why that *must* be the case.)

I agree, as with many kernel features, there are plenty of ways to use
them incorrectly. But I'm just trying to patch over one rough edge about
how to use them incorrectly, and I don't really see why it's such a bad
idea.

> So no, modules should not allow quirks, but the kernel should probably
> be nice enough to fail compilation when someone is attemping that
> instead of silently ignoring the quirks.

Sure, if consensus says we should not support this, I'd definitely like
to make this failure mode more obvious -- likely a build error.

Thanks for your thoughts,
Brian

