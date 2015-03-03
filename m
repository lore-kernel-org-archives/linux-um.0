Return-Path: <richard@nod.at>
Message-ID: <54F57EE8.3030609@nod.at>
Date: Tue, 03 Mar 2015 10:29:12 +0100
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
References: <CAKD1Yr31WXUM-s71bUw+N13AmuAaT0cEhNGYp+VyOA1biGg16w@mail.gmail.com>	<CAFLxGvzOyRKxQxtCSXePZWiH4SaJKhErKq20Hucx-_=_eXd8aw@mail.gmail.com>	<CAKD1Yr2s_KFBv_GZipeeRDY+MkpLkMHahhdkOReqdSQy5ifhLA@mail.gmail.com>	<54F57579.9@nod.at> <CAMuHMdWw6ZoqD5tmA1QhmYZfvvLXX=wb_Ux-h+xhGWjepVRRUQ@mail.gmail.com>
In-Reply-To: <CAMuHMdWw6ZoqD5tmA1QhmYZfvvLXX=wb_Ux-h+xhGWjepVRRUQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [uml-devel] Warning in syscall_trace_enter
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Lorenzo Colitti <lorenzo@google.com>, Erik Kline <ek@google.com>, "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Am 03.03.2015 um 10:26 schrieb Geert Uytterhoeven:
> On Tue, Mar 3, 2015 at 9:48 AM, Richard Weinberger <richard@nod.at> wrote:
>> Am 03.03.2015 um 09:39 schrieb Lorenzo Colitti:
>>> On Tue, Mar 3, 2015 at 5:32 PM, Richard Weinberger
>>> <richard.weinberger@gmail.com> wrote:
>>>> IIRC the big plan is to make tracehook_report_syscall_entry() tree-wide void.
>>>
>>> Ack, thanks. In the meantime, for trees we already build with -Werror,
>>> we'll put a temporary local hack in place.
>>
>> As long GCC has a shitload of completely useless warnings building with -Werror
>> is just a PITA. That's why Linux does not use that flag. :-)
> 
> For some classes of warnings yet.
> 
> For this particular case, given the tree-wide void plan, it can easily be
> resolved by dropping the __must_check attribute from
> tracehook_report_syscall_entry() now.

Yep. Currently I'm searching the archives for that plan.
I was about to fix that warning a few months ago but I was told
that is not needed...

Thanks,
//richard

