Return-Path: <xiyou.wangcong@gmail.com>
Date: Tue, 10 Mar 2009 22:29:29 +0800
From: =?utf-8?Q?Am=C3=A9rico?= Wang <xiyou.wangcong@gmail.com>
Subject: Re: [PATCH] Fix ARCH=um segfault on x86-64.
Message-ID: <20090310142929.GG3157@hack>
References: <200903060042.19084.rob@landley.net> <20090306084848.GO22605@hack.private> <10f740e80903060150p565e9703u81d4fe47cb599ab@mail.gmail.com> <10f740e80903060151w779bbd11ld2fcc437ac7ac321@mail.gmail.com> <20090306111834.GC8991@hack.private> <20090306143543.GA6983@c2.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090306143543.GA6983@c2.user-mode-linux.org>
To: Jeff Dike <jdike@addtoit.com>
Cc: Am??rico Wang <xiyou.wangcong@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Rob Landley <rob@landley.net>, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Fri, Mar 06, 2009 at 09:35:43AM -0500, Jeff Dike wrote:
>On Fri, Mar 06, 2009 at 07:18:34PM +0800, Am??rico Wang wrote:
>> It does work well x86_64, but my question is that whether this will
>> break i386 or not, since before, CONFIG_3_LEVEL_PGTABLES depends on
>> EXPERIMENTAL on i386, this patch removes it.
>
>As long as CONFIG_3_LEVEL_PGTABLES is off on 32-bit, it should be fine.
>
>It did work, last I checked, but 3-level page tables on 32-bit is a
>very rarely used combination, and not useful.
>

So this patch should be fine, right? :)

Thanks for your comments!

-- 
Do what you love, f**k the rest! F**k the regulations!
 

