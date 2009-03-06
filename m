Return-Path: <xiyou.wangcong@gmail.com>
Date: Fri, 6 Mar 2009 19:18:34 +0800
From: =?utf-8?Q?Am=C3=A9rico?= Wang <xiyou.wangcong@gmail.com>
Subject: Re: [PATCH] Fix ARCH=um segfault on x86-64.
Message-ID: <20090306111834.GC8991@hack.private>
References: <200903060042.19084.rob@landley.net> <20090306084848.GO22605@hack.private> <10f740e80903060150p565e9703u81d4fe47cb599ab@mail.gmail.com> <10f740e80903060151w779bbd11ld2fcc437ac7ac321@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <10f740e80903060151w779bbd11ld2fcc437ac7ac321@mail.gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: =?utf-8?Q?Am=C3=A9rico?= Wang <xiyou.wangcong@gmail.com>, Rob Landley <rob@landley.net>, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Fri, Mar 06, 2009 at 10:51:12AM +0100, Geert Uytterhoeven wrote:
>On Fri, Mar 6, 2009 at 10:50, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>> On Fri, Mar 6, 2009 at 09:48, Américo Wang <xiyou.wangcong@gmail.com> wrote:
>>> On Fri, Mar 06, 2009 at 12:42:14AM -0600, Rob Landley wrote:
>>>>Apparently, nobody other than me has ever attempted to use User Mode Linux
>>>>built from 2.6.28 on x86-64, because it doesn't work.  It still doesn't work
>>>>in current git.  I complained about it not working back in January:
>>>>
>>>>http://sourceforge.net/mailarchive/forum.php?thread_name=200901130159.04389.rob%40landley.net&forum_name=user-
>>>>mode-linux-devel
>>>>http://lkml.indiana.edu/hypermail/linux/kernel/0901.2/00669.html
>>>>
>>>>And today, I bothered to track down why.
>>>>
>>>>This is the commit that broke it, when Peter Anvin merged x86 and x86-64 for
>>>>ARCH=um: http://kernel.org/hg/linux-2.6/rev/117978
>>>>
>>>>Here's a patch that fixes it for me:
>>>
>>> Thanks, Bob!
>>
>> I've just did a build of plain v2.6.28 on amd64 aka x86-64. The
>> resulting image ran fine.
>
>So I'm wondering: why does it work for me and not for you?
>

It does work well x86_64, but my question is that whether this will
break i386 or not, since before, CONFIG_3_LEVEL_PGTABLES depends on
EXPERIMENTAL on i386, this patch removes it.

-- 
Do what you love, f**k the rest! F**k the regulations!
 

