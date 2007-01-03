Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1H29n0-0004xz-Lj for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 03 Jan 2007 09:20:34 -0800
Received: from smtp010.mail.ukl.yahoo.com ([217.12.11.79])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1H29mx-0004KT-DR
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 03 Jan 2007 09:20:34 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Wed, 3 Jan 2007 16:07:34 +0100
References: <200612292341.kBTNfR3s005529@ccure.user-mode-linux.org>
In-Reply-To: <200612292341.kBTNfR3s005529@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200701031607.34683.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [PATCH 1/6] UML - Console locking fixes
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net
Cc: akpm@osdl.org, Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org

On Saturday 30 December 2006 00:41, Jeff Dike wrote:
> Clean up the console driver locking.  There are various problems here,
> including sleeping under a spinlock and spinlock recursion, some of
> which are fixed here.  This patch deals with the locking involved with
> opens and closes.  The problem is that an mconsole request to change a
> console's configuration can race with an open.  Changing a
> configuration should only be done when a console isn't opened.  Also,
> an open must be looking at a stable configuration.  In addition, a get
> configuration request must observe the same locking since it must also
> see a stable configuration.  With the old locking, it was possible for
> this to hang indefinitely in some cases because open would block for a
> long time waiting for a connection from the host while holding the
> lock needed by the mconsole request.
>
> As explained in the long comment, this is fixed by adding a spinlock
> for the use count and configuration and a mutex for the actual open
> and close.
>
> Signed-off-by: Jeff Dike <jdike@addtoit.com>

> +
>  int line_open(struct line *lines, struct tty_struct *tty)
>  {
> -	struct line *line;
> +	struct line *line = &lines[tty->index];
>  	int err = -ENODEV;
>
> -	line = &lines[tty->index];
> -	tty->driver_data = line;
> +	spin_lock(&line->count_lock);
> +	if(!line->valid)
> +		goto out_unlock;
> +
> +	err = 0;
> +	if(tty->count > 1)
> +		goto out_unlock;
>
> -	/* The IRQ which takes this lock is not yet enabled and won't be run
> -	 * before the end, so we don't need to use spin_lock_irq.*/
> -	spin_lock(&line->lock);
> +	mutex_lock(&line->open_mutex);
> +	spin_unlock(&line->count_lock);

This is an obnoxious thing to do unless you specifically prove otherwise. You 
cannot take a mutex (and possibly sleep) while holding a spinlock.

You must have either:
+	spin_unlock(&line->count_lock);
+	mutex_lock(&line->open_mutex);

or take count_lock inside open_mutex (which looks like being correct here).

In the first solution, you can create a OPENING flag (via a state variable), 
and add the rule that (unlike the count) nobody but the original setter is 
allowed to change it, and that who finds it set (say a concurrent open) must 
return without touching it.

The state diagram is like:
CLOSED -> OPENING -> OPEN
(only the function which triggered the transition from CLOSED to OPENING can 
trigger the transition from OPENING to OPEN). It can probably be simplified 
to OPENING <-> ! OPENING.
-- 
Inform me of my mistakes, so I can add them to my list!
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade

Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
