Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Message-Id: <200401060259.i062xGFI023152@ccure.user-mode-linux.org>
In-Reply-To: Your message of "Thu, 25 Dec 2003 14:03:31 +0100."
	<3FEAE023.6040908@darkman.de> 
References: <3FEAE023.6040908@darkman.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] Re: [uml-user] ubd=mmap problem
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
Date: Mon, 05 Jan 2004 21:59:16 -0500
To: Sven 'Darkman' Michels <sven@darkman.de>
Cc: UML devel list <user-mode-linux-devel@lists.sourceforge.net>, user-mode-linux-user@lists.sourceforge.net

sven@darkman.de said:
> i noticed that the uml can't reboot anymore cause it hangs in an
> endless loop when unmounting the devices. all i saw was: 
> map : /proc/mm map failed, err = 9 

I take it this is reproducable?  ubd-mmap has been stable here, so there's
something about what you're doing that's sending it off the deep end.

The best way I can think to debug it is to stick printks where /proc/mm and
ubd devices get opened and closed showing what file descriptor is involved.
Apparently, the ubd driver is closing a file descriptor that UML thinks is 
a /proc/mm descriptor.

So, could you add printks for the following values in the following places -
    fd in arch/um/kernel/skas/process.c:get_mm() after the os_open_file
    mm->context.skas.mm_fd in arch/um/kernel/skas/mmu.c:destroy_context_skas()
    
    fd in arch/um/drivers/ubd_user.c:open_ubd_file() before the os_lock_file
    dev->fd and dev->cow.fd in arch/um/drivers/ubd_kern.c:ubd_close() before
their respective calls to os_close_file

Make sure that logging is set up so that printks show up in the messages file
or on the console so that you don't lose any of it.

What I think you're looking for is ubd_close closing a /proc/mm descriptor.
This would explain things going to hell when devices are being unmounted.

I'm a little suspicious of the fact that ubd_close doesn't set the descriptors
to -1 after closing them, but I don't see a bug there offhand.

				Jeff


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
