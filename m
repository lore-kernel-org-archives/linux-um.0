Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sun, 30 May 2010 17:46:27 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: current git kernel crashes UML system during boot
Message-ID: <20100530154627.GB1565@liondog.tnic>
References: <201005271944.09541.toralf.foerster@gmx.de>
 <AANLkTimYeMO_fc8C5MQedwF646_au4lvEbXkBPmQSxb9@mail.gmail.com>
 <AANLkTimKwxYxM_PExplIDK1WPTQ9e_-CHn5SnIvfjfUg@mail.gmail.com>
 <20100530150214.GA1565@liondog.tnic>
 <AANLkTimo-kuzlyQvraLnYBZKlGQHr23ZiMeWmTaj4Yea@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <AANLkTimo-kuzlyQvraLnYBZKlGQHr23ZiMeWmTaj4Yea@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Toralf =?utf-8?Q?F=C3=B6rster?= <toralf.foerster@gmx.de>, Borislav Petkov <borislav.petkov@amd.com>, "H. Peter Anvin" <hpa@zytor.com>, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, May 30, 2010 at 05:18:21PM +0200

> Works, thanks!
> 
> BTW, if you want to check yourself:
> 
>     make ARCH=um defconfig
>     make ACH=um
>     ./linux
> 
> If it panics because it cannot mount the root file system, it works.

Cool, thank you both for testing. I'll add your Tested-by:'s.

-- 
Regards/Gruss,
    Boris.
