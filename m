Return-Path: <toralf.foerster@gmx.de>
Message-ID: <52546386.3050608@gmx.de>
Date: Tue, 08 Oct 2013 21:56:54 +0200
From: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>
MIME-Version: 1.0
References: <524C6643.2040209@gmx.de>	<CAFLxGvwiH7L4oAW8tw6FyeGczg+rKjUDCdkLKdegy9yX==2cMA@mail.gmail.com>	<524DBD5D.1040203@gmx.de>	<524DBFBB.1050002@nod.at>	<524DC278.3020106@gmx.de>	<524DC394.6030406@nod.at>	<524DC675.4020201@gmx.de>	<524E57BA.805@nod.at>	<52517109.90605@gmx.de>	<CAMuHMdXrU0e_6AxvdboMkDs+N+tSWD+b8ou92j28c0vsq2eQQA@mail.gmail.com>	<5251C334.3010604@gmx.de> <CAMuHMdUo8dSd4s3089ZDEc485wL1sFxBKLeaExJuqNiQY+S-Lw@mail.gmail.com>
In-Reply-To: <CAMuHMdUo8dSd4s3089ZDEc485wL1sFxBKLeaExJuqNiQY+S-Lw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [uml-devel] BUG: soft lockup for a user mode linux image
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Richard Weinberger <richard@nod.at>, UML devel <user-mode-linux-devel@lists.sourceforge.net>, Linux Kernel <linux-kernel@vger.kernel.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Well, the quick&dirty hack below at least works for the moment to
overcome the soft lookup and the hang/unresponsiveness of the 32 bit
user mode linux guest :


diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index f5236f8..7e9483c 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -1503,6 +1503,8 @@ static void balance_dirty_pages(struct
address_space *mapping,
                }

 pause:
+               if (pause < 0)
+                       break;
                trace_balance_dirty_pages(bdi,
                                          dirty_thresh,
                                          background_thresh,



I'm not proud of it but after starring at the source code in
mm/page-writeback.c too often and too long currently I don't have any
better clue.

WRT to debug of the culprit: neither printk nor friends worked (maybe
b/c the affected process is just hanging ?) and BUG_ON doesn't gave me
any new clues.


On 10/06/2013 10:26 PM, Geert Uytterhoeven wrote:
> On Sun, Oct 6, 2013 at 10:08 PM, Toralf Förster <toralf.foerster@gmx.de> wrote:
>> On 10/06/2013 08:38 PM, Geert Uytterhoeven wrote:
>>> On Sun, Oct 6, 2013 at 4:17 PM, Toralf Förster <toralf.foerster@gmx.de> wrote:
>>>> The UML stopped here :
>>>> ...
>>>>                 if (unlikely(task_ratelimit == 0)) {
>>>>                         period = max_pause;
>>>>                         pause = max_pause;
>>>>                         BUG_ON(pause < 0);
>>>>                         goto pause;
>>>>                 }
>>>>                 BUG_ON(pages_dirtied < 0);
>>>>                 BUG_ON(task_ratelimit < 0);
>>>>                 period = HZ * pages_dirtied / task_ratelimit;
>>>>                 BUG_ON(period < 0);         <----------------------here
>>>
>>> So pages_dirtied becomes that big compared to task_ratelimit (both are
>>> "unsigned long"), that period (which is "long", just like "pause") overflows
>>> into a negative number.
>>>
>>> This is indeed much more likely to happen on 32-bit.
>>>
>>>> The back trace is :
>>>
>>>> #9  0x08411c64 in balance_dirty_pages (pages_dirtied=9, mapping=<optimized out>) at mm/page-writeback.c:1471
>>>
>>> But here pages_dirtied is only 9??
> 
>> Well, this points to an overflow or ? :
> 
> Negative indicates an overflow, but pages_dirtied doesn't.
> 
>> tfoerste@n22 ~/devel/linux $ nl -ba mm/page-writeback.c | grep -A 5 -B 5 1468
>>   1463                          BUG_ON(pause < 0);
>>   1464                          goto pause;
>>   1465                  }
>>   1466                  period = HZ * pages_dirtied / task_ratelimit;
>>   1467                  pause = period;
>>   1468                  BUG_ON(pause < 0 && pages_dirtied > 0 && task_ratelimit > 0);
>>   1469                  if (current->dirty_paused_when)
>>   1470                          pause -= now - current->dirty_paused_when;
>>   1471                  /*
>>   1472                   * For less than 1s think time (ext3/4 may block the dirtier
>>   1473                   * for up to 800ms from time to time on 1-HDD; so does xfs,
>>
>>
>> and the back trace is :
>>
>> #9  0x08411c6c in balance_dirty_pages (pages_dirtied=0, mapping=<optimized out>) at mm/page-writeback.c:1468
> 
> Hmm, now pages_dirtied is zero, according to the backtrace, but the BUG_ON()
> asserts its strict positive?!?
> 
> Can you please try the following instead of the BUG_ON():
> 
> if (pause < 0) {
>         printk("pages_dirtied = %lu\n", pages_dirtied);
>         printk("task_ratelimit = %lu\n", task_ratelimit);
>         printk("pause = %ld\n", pause);
> }
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
> 


-- 
MfG/Sincerely
Toralf Förster
pgp finger print: 7B1A 07F4 EC82 0F90 D4C2 8936 872A E508 7DB6 9DA3

