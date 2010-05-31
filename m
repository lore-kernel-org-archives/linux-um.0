Return-Path: <jdike@addtoit.com>
Date: Sun, 30 May 2010 22:32:12 -0400
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [PATCH] x86, hweight: Fix UML boot crash
Message-ID: <20100531023212.GA22673@c-98-229-117-200.hsd1.ma.comcast.net>
References: <201005271944.09541.toralf.foerster@gmx.de> <AANLkTimKwxYxM_PExplIDK1WPTQ9e_-CHn5SnIvfjfUg@mail.gmail.com> <20100530150214.GA1565@liondog.tnic> <201005301728.25976.toralf.foerster@gmx.de> <20100530170346.GC1565@liondog.tnic> <4C02B020.2040103@zytor.com> <20100530193956.GA2498@liondog.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100530193956.GA2498@liondog.tnic>
To: Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Borislav Petkov <borislav.petkov@amd.com>, Toralf =?iso-8859-1?Q?F=F6rster?= <toralf.foerster@gmx.de>, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Sun, May 30, 2010 at 09:39:56PM +0200, Borislav Petkov wrote:
> Which begs the question why _is_ UML sucking in x86 stuff and can anyone
> provide us with some sensible reasons? Because if there aren't any, it
> is their includes that should be fixed. Let me see what I can do to
> redirect hweight stuff properly...

Generally, UML pulls in the host arch headers because they work.  When
they are only architecture-dependent (and not, say, depending on the
host task struct or something), they're fine.

What's the include path from UML to the x86 hweight stuff?

				Jeff

-- 
Work email - jdike at linux dot intel dot com

