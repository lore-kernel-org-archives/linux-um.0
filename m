Return-Path: <hpa@zytor.com>
Message-ID: <4C02D408.1030306@zytor.com>
Date: Sun, 30 May 2010 14:09:28 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [PATCH] x86, hweight: Fix UML boot crash
References: <201005271944.09541.toralf.foerster@gmx.de> <AANLkTimKwxYxM_PExplIDK1WPTQ9e_-CHn5SnIvfjfUg@mail.gmail.com> <20100530150214.GA1565@liondog.tnic> <201005301728.25976.toralf.foerster@gmx.de> <20100530170346.GC1565@liondog.tnic> <4C02B020.2040103@zytor.com> <20100530193956.GA2498@liondog.tnic> <20100530201738.GB2498@liondog.tnic>
In-Reply-To: <20100530201738.GB2498@liondog.tnic>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Borislav Petkov <bp@alien8.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Borislav Petkov <borislav.petkov@amd.com>, =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc: Jeff Dike <jdike@addtoit.com>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On 05/30/2010 01:17 PM, Borislav Petkov wrote:
>>> This bothers me, because it really feels like something is fundamentally
>>> broken in UML tryingto track the upstream architecture, and this is just
>>> a bandage.
>>
>> First of all, scratch that patch. It is indeed dumb idea to sprinkle UML
>> special cases in x86 just because they include it.
>>
>> Which begs the question why _is_ UML sucking in x86 stuff and can anyone
>> provide us with some sensible reasons? Because if there aren't any, it
>> is their includes that should be fixed. Let me see what I can do to
>> redirect hweight stuff properly...
> 
> Ok, AFAICT UML is sucking in the includes of the sub-architecture the
> UML "guest" is running on. See below¹ for the whole gcc string make
> executes. Among the switches is
> 
> "-I/home/boris/kernel/linux-2.6/arch/x86/include"
> 
> so there will be no untangling today. Instead, we could do another
> bandaid which is confined to UML include space only and redirect
> arch_hweight.h includes to the generic ones. Check this out, it seems to
> work here:
> 

That looks better to me, although I'm still wondering why UML can't
stomach the register-saving tricks... it is not at all "obvious" why
that can't be done.

Perhaps we can get Jeff to comment on this?

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.


