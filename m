Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DRDt2-0003AE-9v	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 28 Apr 2005 11:37:20 -0700
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1DRDsy-0007hq-CN	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 28 Apr 2005 11:37:20 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] bugs in line.c and stdio_console.c
References: <3BCB5FB76AFFF646BCFBC02A889B64F301799B27@ZCH07EXM05.corp.mot.com>
In-Reply-To: <3BCB5FB76AFFF646BCFBC02A889B64F301799B27@ZCH07EXM05.corp.mot.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504292145.19573.blaisorblade@yahoo.it>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Fri, 29 Apr 2005 21:45:18 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Yu Dong-W4760C <W4760C@motorola.com>

On Thursday 28 April 2005 03:24, Yu Dong-W4760C wrote:
> same bugs in the two files (uml-linux-2.4.26-3):
> arch/um/drivers/line.c

>  down(&line->sem);  ========================> may cause shedule in
> interrrupt 

> in arch/um/drivers/stdio_console.c
> static void console_write(struct console *console, const char *string,
>      unsigned len)
> {

>  if(con_init_done)
>   down(&line->sem);  ========================> may cause shedule in
> interrrupt console_write_chan(&line->chan_list, string, len);
>  if(con_init_done)
>   up(&line->sem);
> }
>
> my fix is change
> [w4760c@w4760c-x3 drivers]$ diff -Nru line.c line.c.old
> --- line.c      2005-04-28 09:22:29.000000000 +0800
> +++ line.c.old  2005-04-26 09:38:18.000000000 +0800
> @@ -134,9 +134,7 @@
>         i = minor(tty->device) - tty->driver.minor_start;
>         line = &lines[i];
>
> -       if(!in_interrupt())
> -               down(&line->sem);
> -
> +       down(&line->sem);
>         if(line->head != line->tail){
>                 local_irq_save(flags);
>                 ret += buffer_data(line, buf, len);
> @@ -159,8 +157,7 @@
>                         ret += buffer_data(line, buf + n, len);
>         }
>   out_up:
> -       if(!in_interrupt())
> -               up(&line->sem);
> +       up(&line->sem);
>
>   out_free:
>         if(from_user)
>
>
> --- stdio_console.c     2005-04-26 14:41:05.000000000 +0800
> +++ stdio_console.c.bak 2005-04-26 14:33:30.000000000 +0800
> @@ -188,10 +188,10 @@
>  {
>         struct line *line = &vts[console->index];
>
> -       if(con_init_done && !in_interrupt())
> +       if(con_init_done)
>                 down(&line->sem);
>         console_write_chan(&line->chan_list, string, len);
> -       if(con_init_done && !in_interrupt())
> +       if(con_init_done)
>                 up(&line->sem);
>  }
>

> please help to confirm if it's correct?

1) The patch is reversed, and after noticing this it seems a bit more 
meaningful.

2)But that's not the correct fix, because data corruption is as bad as 
schedule in interrupt.

3) The correct fix (which I just sent in with the title "uml: redo console 
locking" to this list) is to replace that semaphore with a spinlock.
-- 
Paolo Giarrusso, aka Blaisorblade
Skype user "PaoloGiarrusso"
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade




-------------------------------------------------------
SF.Net email is sponsored by: Tell us your software development plans!
Take this survey and enter to win a one-year sub to SourceForge.net
Plus IDC's 2005 look-ahead and a copy of this survey
Click here to start!  http://www.idcswdc.com/cgi-bin/survey?id=105hix
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
