Return-Path: <rob@landley.net>
From: Rob Landley <rob@landley.net>
Subject: Re: [PATCH] Fix ARCH=um segfault on x86-64.
Date: Fri, 6 Mar 2009 16:22:21 -0600
References: <200903060042.19084.rob@landley.net> <20090306111834.GC8991@hack.private> <20090306143543.GA6983@c2.user-mode-linux.org>
In-Reply-To: <20090306143543.GA6983@c2.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200903061622.22289.rob@landley.net>
To: Jeff Dike <jdike@addtoit.com>
Cc: Am??rico Wang <xiyou.wangcong@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Friday 06 March 2009 08:35:43 Jeff Dike wrote:
> On Fri, Mar 06, 2009 at 07:18:34PM +0800, Am??rico Wang wrote:
> > It does work well x86_64, but my question is that whether this will
> > break i386 or not, since before, CONFIG_3_LEVEL_PGTABLES depends on
> > EXPERIMENTAL on i386, this patch removes it.
>
> As long as CONFIG_3_LEVEL_PGTABLES is off on 32-bit, it should be fine.
>
> It did work, last I checked, but 3-level page tables on 32-bit is a
> very rarely used combination, and not useful.

I have no idea if my patch is the _right_ fix, I just know I couldn't use UML 
for 2 months and now I can.

If you enable CONFIG_EXPERIMENTAL, then it writes it out to the config file.  
If you don't, it hides it and doesn't write it out even though the value would 
be y.  (The visibility predicates affect the resulting data.)

Rob

