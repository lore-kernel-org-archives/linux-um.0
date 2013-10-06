MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <5251C334.3010604@gmx.de>
References: <524C6643.2040209@gmx.de>
	<CAFLxGvwiH7L4oAW8tw6FyeGczg+rKjUDCdkLKdegy9yX==2cMA@mail.gmail.com>
	<524DBD5D.1040203@gmx.de>
	<524DBFBB.1050002@nod.at>
	<524DC278.3020106@gmx.de>
	<524DC394.6030406@nod.at>
	<524DC675.4020201@gmx.de>
	<524E57BA.805@nod.at>
	<52517109.90605@gmx.de>
	<CAMuHMdXrU0e_6AxvdboMkDs+N+tSWD+b8ou92j28c0vsq2eQQA@mail.gmail.com>
	<5251C334.3010604@gmx.de>
Date: Sun, 6 Oct 2013 22:26:45 +0200
Message-ID: <CAMuHMdUo8dSd4s3089ZDEc485wL1sFxBKLeaExJuqNiQY+S-Lw@mail.gmail.com>
Subject: Re: [uml-devel] BUG: soft lockup for a user mode linux image
From: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?Q?Toralf_F=C3=B6rster?= <toralf.foerster@gmx.de>
Cc: Richard Weinberger <richard@nod.at>, UML devel <user-mode-linux-devel@lists.sourceforge.net>, trinity@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Sun, Oct 6, 2013 at 10:08 PM, Toralf F=C3=B6rster <toralf.foerster@gmx.d=
e> wrote:
> On 10/06/2013 08:38 PM, Geert Uytterhoeven wrote:
>> On Sun, Oct 6, 2013 at 4:17 PM, Toralf F=C3=B6rster <toralf.foerster@gmx=
.de> wrote:
>>> The UML stopped here :
>>> ...
>>>                 if (unlikely(task_ratelimit =3D=3D 0)) {
>>>                         period =3D max_pause;
>>>                         pause =3D max_pause;
>>>                         BUG_ON(pause < 0);
>>>                         goto pause;
>>>                 }
>>>                 BUG_ON(pages_dirtied < 0);
>>>                 BUG_ON(task_ratelimit < 0);
>>>                 period =3D HZ * pages_dirtied / task_ratelimit;
>>>                 BUG_ON(period < 0);         <----------------------here
>>
>> So pages_dirtied becomes that big compared to task_ratelimit (both are
>> "unsigned long"), that period (which is "long", just like "pause") overf=
lows
>> into a negative number.
>>
>> This is indeed much more likely to happen on 32-bit.
>>
>>> The back trace is :
>>
>>> #9  0x08411c64 in balance_dirty_pages (pages_dirtied=3D9, mapping=3D<op=
timized out>) at mm/page-writeback.c:1471
>>
>> But here pages_dirtied is only 9??

> Well, this points to an overflow or ? :

Negative indicates an overflow, but pages_dirtied doesn't.

> tfoerste@n22 ~/devel/linux $ nl -ba mm/page-writeback.c | grep -A 5 -B 5 =
1468
>   1463                          BUG_ON(pause < 0);
>   1464                          goto pause;
>   1465                  }
>   1466                  period =3D HZ * pages_dirtied / task_ratelimit;
>   1467                  pause =3D period;
>   1468                  BUG_ON(pause < 0 && pages_dirtied > 0 && task_rat=
elimit > 0);
>   1469                  if (current->dirty_paused_when)
>   1470                          pause -=3D now - current->dirty_paused_wh=
en;
>   1471                  /*
>   1472                   * For less than 1s think time (ext3/4 may block =
the dirtier
>   1473                   * for up to 800ms from time to time on 1-HDD; so=
 does xfs,
>
>
> and the back trace is :
>
> #9  0x08411c6c in balance_dirty_pages (pages_dirtied=3D0, mapping=3D<opti=
mized out>) at mm/page-writeback.c:1468

Hmm, now pages_dirtied is zero, according to the backtrace, but the BUG_ON(=
)
asserts its strict positive?!?

Can you please try the following instead of the BUG_ON():

if (pause < 0) {
        printk("pages_dirtied =3D %lu\n", pages_dirtied);
        printk("task_ratelimit =3D %lu\n", task_ratelimit);
        printk("pause =3D %ld\n", pause);
}

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

