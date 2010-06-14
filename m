Return-Path: <hpa@zytor.com>
Message-ID: <4C1648AD.5020607@zytor.com>
Date: Mon, 14 Jun 2010 08:20:13 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [PATCH] x86, hweight: Fix UML boot crash
References: <201005271944.09541.toralf.foerster@gmx.de> <201006141544.59500.toralf.foerster@gmx.de> <AANLkTik7aQPVl2OsOIhAtMzRHDNw6jkZYzcRNtfi7QSh@mail.gmail.com> <201006141711.26975.toralf.foerster@gmx.de>
In-Reply-To: <201006141711.26975.toralf.foerster@gmx.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Borislav Petkov <bp@amd64.org>, Borislav Petkov <bp@alien8.de>, "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On 06/14/2010 08:11 AM, Toralf Förster wrote:
> 
> Geert Uytterhoeven wrote at 16:39:00
>> I assume you did a `make clean' in between?
> ...
>> BTW, I'm also using ccache. Always. Ever. All my (cross)compilers are
> Well, I'm unsure - might be I made that mistake, especially b/c I use ccache 
> too since years and didn't experienced any fault so far.

I have certainly seen a number of cases where ccache doesn't pick up
sublte differences, for reasons unknown.

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.


