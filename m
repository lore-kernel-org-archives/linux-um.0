Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D8O86-0004ZV-7C for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 07 Mar 2005 11:43:02 -0800
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1D8O84-0005xG-AK for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 07 Mar 2005 11:43:02 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
References: <20041128010910.1b5478c7.akpm@osdl.org>
In-Reply-To: <20041128010910.1b5478c7.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200503051858.05050.blaisorblade@yahoo.it>
Subject: [uml-devel] Re: Fw: [patch] uml: terminal cleanup
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
Date: Sat, 5 Mar 2005 18:58:04 +0100
To: Gerd Knorr <kraxel@bytesex.org>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Sunday 28 November 2004 10:09, Andrew Morton wrote:

> Date: Wed, 24 Nov 2004 19:53:41 +0100
> From: Gerd Knorr <kraxel@bytesex.org>
> To: Andrew Morton <akpm@osdl.org>, Linux Kernel Mailing List
> <linux-kernel@vger.kernel.org>, uml devel
> <user-mode-linux-devel@lists.sourceforge.net> Subject: [patch] uml:
> terminal cleanup

>   Hi,
>
> This is a major cleanup of the uml terminal drivers and console handling
> (console as in "where the kernel messages go to", not as in "linux
> virtual terminals").  The changes in detail:


>  (2) Ditched the early-console-init hackery in stdio_console.c
>      (open_console(NULL) + related stuff) into the waste basket, not
>      needed any more as you can use the new stderr console driver to
>      get the kernel messages if your kernel crashes very early in the
>      boot process.
>
>  (3) Handle console initialitation for the uml stdio console and
>      virtual serial lines the normal way using the console->setup()
>      function.  Now all kernel messages appear on your console device
>      once it is initialized without any dirty tricks.


> Index: linux-2004-11-23/arch/um/drivers/chan_user.c
> ===================================================================
> --- linux-2004-11-23.orig/arch/um/drivers/chan_user.c 2004-11-24
> 12:50:38.560153813 +0100 +++
> linux-2004-11-23/arch/um/drivers/chan_user.c 2004-11-24 18:15:00.027153605
> +0100 @@ -110,7 +110,7 @@ static int winch_thread(void *arg)
>   }
>  }
>
> -static int winch_tramp(int fd, void *device_data, int *fd_out)
> +static int winch_tramp(int fd, struct tty_struct *tty, int *fd_out)
>  {
>   struct winch_data data;
>   unsigned long stack;
> @@ -144,7 +144,7 @@ static int winch_tramp(int fd, void *dev
>   return(pid);
>  }
>
> -void register_winch(int fd, void *device_data)
> +void register_winch(int fd, struct tty_struct *tty)
>  {
>   int pid, thread, thread_fd;
>   int count;
Hmm, I saw you have put a forward declaration of struct tty_struct, however it 
does not seem nice anyway... I don't think that using void* is nice either, 
but both things have pitfalls.

> -void line_close(struct line *lines, struct tty_struct *tty)
> +void line_close(struct tty_struct *tty, struct file * filp)
>  {
> - struct line *line;
> - int n;
> -
> - if(tty == NULL) n = 0;
> - else n = tty->index;
> - line = &lines[n];
> + struct line *line = tty->driver_data;
>
>   down(&line->sem);
>   line->count--;
> -
> - /* I don't like this, but I can't think of anything better.  What's
> -  * going on is that the tty is in the process of being closed for
> -  * the last time.  Its count hasn't been dropped yet, so it's still
> -  * at 1.  This may happen when line->count != 0 because of the initial
> -  * console open (without a tty) bumping it up to 1.
> -  */
> - if((line->tty != NULL) && (line->tty->count == 1))
> -  line->tty = NULL;
> - if(line->count == 0)
> -  line_disable(line, -1);
> + if (tty->count == 1) {
> +  line_disable(tty, -1);
> +  tty->driver_data = NULL;
> + }
>   up(&line->sem);
>  }
Why did you delete this comment? I don't think you fixed the problem, you just 
worked it around the other way...

Or better, you removed the initial console open, if it refers to the item #2 
above... but the code isn't clean...

-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade





-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
