Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Co0uh-00055N-Sa for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 10 Jan 2005 06:52:59 -0800
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1Co0uf-0001bH-8g for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 10 Jan 2005 06:52:59 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] uml_console_write
References: <49797.80.203.9.2.1104597206.squirrel@80.203.9.2>
In-Reply-To: <49797.80.203.9.2.1104597206.squirrel@80.203.9.2>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501101554.59810.blaisorblade@yahoo.it>
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
Date: Mon, 10 Jan 2005 15:54:59 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: stian@nixia.no

On Saturday 01 January 2005 17:33, stian@nixia.no wrote:
> if you enable all semaphore locking debuing and such alike, you get a
> warning at uml_console_write calliong __might_sleep with irqs_disabled()

Yes, thanks a lot for reporting it... I've added it to my TODO-list.

 in fact uml_console_write acquires a semaphore with 

        if(con_init_done)
                down(&line->sem);

And if down() sleeps, that thread will sleep with interrupt disabled, i.e. 
crash.

I don't know if it's correct that the interrupts are disabled in the below 
callpath: it would be strange that the code in the call stack before printk 
does it, and I searched for interrupts disabling in the printk() code... it 
happens, but not in the path leading to call_console_drivers.

However, the comments (i.e. the specification) says that release_console_sem() 
can be called from any context, like printk(). So, uml_console_write must be 
fixed.

The solution is to turn line->sem into a spinlock (and rename it as ->lock).

Now, this is due from long time... see line_write() and 
line_write_interrupt(): they should synchronize with line->sem, but since the 
second function is an interrupt, it can't acquire a semaphore. So it does not 
do any locking! So it must be done anyway.

> The callpath are on another machine, byt here the names are

> __might_sleep
> uml_console_write
> __call_console_drivers
> call_console_drivers
> release_console_drives
> vprintk
> printk
> ext2_warning
> ext2_fill_super
> get_sb_bdev
> __kmalloc
> ext2_get_sb
> ext2_fill_super
> do_kern_mount
> do_new_mount
> do_mount
> copy_from_user_tt
> excact_copy_from_user
> copy_mount_options
> sys_mount
> execute_syscall_tt
> syscall_handler_tt
> unblock_signals
> sig_handler_common
> set_user_mode
> sig_handler
> __restore


-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
