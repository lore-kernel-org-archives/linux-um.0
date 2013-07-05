Return-Path: <chen.gang.flying.transformer@gmail.com>
Message-ID: <51D617E9.8080907@gmail.com>
Date: Fri, 05 Jul 2013 08:48:41 +0800
From: Chen Gang F T <chen.gang.flying.transformer@gmail.com>
MIME-Version: 1.0
References: <20130704011221.GA11230@kroah.com> <20130704061204.GA12148@kroah.com> <51D517A7.6030908@asianux.com> <201307041125.15083.arnd@arndb.de> <51D60D53.7050405@gmail.com> <20130705101446.48deb2694f5fcdb060f41e5b@canb.auug.org.au>
In-Reply-To: <20130705101446.48deb2694f5fcdb060f41e5b@canb.auug.org.au>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] include/asm-generic/io.h: add dummy fuctions to support
 'COMPILE_TEST' in 'asm-generic'.
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Arnd Bergmann <arnd@arndb.de>, Chen Gang <gang.chen@asianux.com>, Greg KH <gregkh@linuxfoundation.org>, Steven Rostedt <rostedt@goodmis.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, David Sharp <dhsharp@google.com>, Ingo Molnar <mingo@kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, uml-user <user-mode-linux-user@lists.sourceforge.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Mark Brown <broonie@kernel.org>, David Miller <davem@davemloft.net>, Andrew Morton <akpm@linux-foundation.org>, Jiri Kosina <trivial@kernel.org>, Jiri Slaby <jslaby@suse.cz>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On 07/05/2013 08:14 AM, Stephen Rothwell wrote:
> On Fri, 05 Jul 2013 08:03:31 +0800 Chen Gang F T <chen.gang.flying.transformer@gmail.com> wrote:
>> >
>> > When a module select "COMPILE_TEST=y" (e.g with allmodconfig), it has
>> > right to compile under the architecture which no related HW support.
>> > 
>> > If it can not pass compiling, at least it is not the module's issue,
>> > neither the architecture's issue.
>> > 
>> > We have to look for who has duty on it. At least now, it seems only
>> > 'asm-generic' can be qualified to play this unlucky role.
> You keep saying this, but others have told you that this is not the
> problem.
> 

In real world, it is not the problem.

But for 'mad users' (e.g. allmodconfig, randconfig, and me too), they
have not provided enough reason for it (prove that is not a problem for
'mad users').


>> > Could you provide your suggestions or completions for this issue ?
> If something doesn't build for a particular config, then either it needs
> to be fixed or excluded from building in that particular config.

I agree with you, if get rid of 'COMPILE_TEST'.

Thanks.
-- 
Chen Gang

