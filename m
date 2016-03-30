Return-Path: <linux-arch-owner@vger.kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/2] asm-generic/io.h: provide default ioremap/iounmap for !HAS_IOMEM
Date: Wed, 30 Mar 2016 12:03:52 +0200
Message-ID: <6282729.XLLXSxbzQJ@wuerfel>
In-Reply-To: <56FB8AC1.4070209@nod.at>
References: <1459275781-3863-1-git-send-email-robh@kernel.org> <6746826.YZLTqKTgkv@wuerfel> <56FB8AC1.4070209@nod.at>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-arch-owner@vger.kernel.org
To: Richard Weinberger <richard@nod.at>
Cc: Rob Herring <robh@kernel.org>, Lee Jones <lee.jones@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Wednesday 30 March 2016 10:13:53 Richard Weinberger wrote:
> 
> I fully understand your point of view. COMPILE_TEST is a monster that
> can do the heavy lifting for you, but monsters also have claws and fangs. 
> 
> Having COMPILE_TEST having depend on !UML works for me. But don't
> we have other archs without io mem? At least a few years ago while
> porting nandsim to UML I found s390 that lacks of io mem too.

s390 gained IOMEM support when they started having PCI attachments.

arch/score selects NO_IOMEM, though they do in fact use MMIO, and
I'm sure their architecture has lots of other problems with build
testing that nobody cares about.

arch/tile can select NO_IOMEM when PCI is disabled, they might
care about this, though I think they also have other build-time
issues.

> Maybe we depend COMPILE_TEST on HAS_IOMEM?

That sounds fine with me as well.

	Arnd
