Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: mtd: fix CONFIG_MTD_COMPLEX_MAPPINGS=n compile
From: Artem Bityutskiy <dedekind1@gmail.com>
Reply-To: dedekind1@gmail.com
In-Reply-To: <20101217042759.GA3148@falooley.org>
References: <20071024011712.GA3762@falooley.org>
	 <1193208689.26096.48.camel@pmac.infradead.org>
	 <20071227181524.GA19051@falooley.org>
	 <20071228174853.GA4252@uranus.ravnborg.org>
	 <20101207072919.GA8511@falooley.org>
	 <AANLkTineLxHdcDKZEUGiqVNAauSX_xyQrs49kKaqhiWo@mail.gmail.com>
	 <20101207182012.GA10546@falooley.org> <1292343878.2538.80.camel@localhost>
	 <20101214195124.GA6010@falooley.org> <20101216230110.65156c55@wker>
	 <20101217042759.GA3148@falooley.org>
Content-Type: text/plain; charset="utf-8"
Date: Sun, 19 Dec 2010 18:47:56 +0200
Message-ID: <1292777276.2140.1.camel@koala>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
To: Jason Lunz <lunz@acm.org>
Cc: Anatolij Gustschin <agust@denx.de>, atom ota <atomota@sleepyhammer.com>, user-mode-linux-devel@lists.sourceforge.net, richard -rw- weinberger <richard.weinberger@gmail.com>, Sam Ravnborg <sam@ravnborg.org>, Jeff Dike <jdike@addtoit.com>, lkml <linux-kernel@vger.kernel.org>, linux-mtd@lists.infradead.org, Rob Landley <rob@landley.net>, David Woodhouse <dwmw2@infradead.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Thu, 2010-12-16 at 20:27 -0800, Jason Lunz wrote:
> On Thu, Dec 16, 2010 at 11:01:10PM +0100, Anatolij Gustschin wrote:
> > This change breaks compiling when CONFIG_MTD_COMPLEX_MAPPINGS is not
> > defined in the kernel configuration. Please fix!
> 
> Sorry, sloppy of me. This reverts all changes to mtd.h while keeping the
> ability to compile mtd on ARCH=um, with the exception mtdchar.

Merged with the previous patch, thanks.

-- 
Best Regards,
Artem Bityutskiy (Битюцкий Артём)

