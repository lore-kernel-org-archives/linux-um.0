MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <54F57579.9@nod.at>
References: <CAKD1Yr31WXUM-s71bUw+N13AmuAaT0cEhNGYp+VyOA1biGg16w@mail.gmail.com>
	<CAFLxGvzOyRKxQxtCSXePZWiH4SaJKhErKq20Hucx-_=_eXd8aw@mail.gmail.com>
	<CAKD1Yr2s_KFBv_GZipeeRDY+MkpLkMHahhdkOReqdSQy5ifhLA@mail.gmail.com>
	<54F57579.9@nod.at>
Date: Tue, 3 Mar 2015 10:26:28 +0100
Message-ID: <CAMuHMdWw6ZoqD5tmA1QhmYZfvvLXX=wb_Ux-h+xhGWjepVRRUQ@mail.gmail.com>
Subject: Re: [uml-devel] Warning in syscall_trace_enter
From: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
To: Richard Weinberger <richard@nod.at>
Cc: Lorenzo Colitti <lorenzo@google.com>, Erik Kline <ek@google.com>, "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Tue, Mar 3, 2015 at 9:48 AM, Richard Weinberger <richard@nod.at> wrote:
> Am 03.03.2015 um 09:39 schrieb Lorenzo Colitti:
>> On Tue, Mar 3, 2015 at 5:32 PM, Richard Weinberger
>> <richard.weinberger@gmail.com> wrote:
>>> IIRC the big plan is to make tracehook_report_syscall_entry() tree-wide void.
>>
>> Ack, thanks. In the meantime, for trees we already build with -Werror,
>> we'll put a temporary local hack in place.
>
> As long GCC has a shitload of completely useless warnings building with -Werror
> is just a PITA. That's why Linux does not use that flag. :-)

For some classes of warnings yet.

For this particular case, given the tree-wide void plan, it can easily be
resolved by dropping the __must_check attribute from
tracehook_report_syscall_entry() now.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

