Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BDldD-0006A7-Uk for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 14 Apr 2004 07:44:51 -0700
Received: from marasystems.com ([213.150.153.194] helo=filer.marasystems.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BDldD-0003L5-8W for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 14 Apr 2004 07:44:51 -0700
From: Henrik Nordstrom <uml@henrik.marasystems.com>
Subject: Re: [uml-devel] [patch] Re: Reboot failing with file locked,
	CLONE_FILES and host kernel BUG()
In-Reply-To: <20040414133215.GA7464@mpmain>
Message-ID: <Pine.LNX.4.44.0404141623190.2915-100000@filer.marasystems.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
Date: Wed, 14 Apr 2004 16:44:43 +0200 (CEST)
To: Marcin Pawlik <wapkil@op.pl>
Cc: Henrik Nordstrom <uml@henrik.marasystems.com>, user-mode-linux-devel@lists.sourceforge.net

On Wed, 14 Apr 2004, Marcin Pawlik wrote:

> Do you know where and which thread closes the files? I tried to add file
> closing to kill_io_thread() (patch attached) and it helps but I think it
> should also be performed without my code.

No, I do not remember, but the thread which originally opened and locked 
the file is apparently not around after the UML has booted.

> The problem with host kernel is that it sometimes doesn't release the
> lock even after all threads are finished and on 2.6.5 always hits a
> BUG() line in locks_remove_flock. I don't see how this could be
> exploited but it should be corrected anyway. On 2.6.5 it leaves
> filesystem in inconsistent state with kernel unable to umount it.
> I thought it would be nice to reproduce this with something simpler than
> UML before reporting. Unfortunately I don't have sufficient UML
> internals knowledge to mimic its threads creation, ptracing, file
> locking and reboot which should lead to the same behavior.

Indeed. I am not of much help here however..

> >  int os_lock_file(int fd, int excl)
> >  {
> > +#if USE_FCNTL_LOCK
> >  	int type = excl ? F_WRLCK : F_RDLCK;
> >  	struct flock lock = ((struct flock) { .l_type	= type,
> >  					      .l_whence	= SEEK_SET,
> > @@ -710,6 +711,21 @@
> >  	err = save;
> >   out:
> >  	return(err);
> > +#else
> > +	int type = excl ? LOCK_EX : LOCK_SH;
> 
> I don't understand this. IMO excl should be F_RDLCK or F_WRLCK. F_RDLCK
> is 0, F_WRLCK is 1 and LOCK_EX is 2 so you will always use LOCK_SH.

???

excl is a boolean, true if the lock should be exclusive (write access),
false if it is a shared lock (read-only). This is how the UML function 
os_lock_file is defined. This function does not expect fcntl lock names as 
argument.

In addition the flock api does not use the F_XXX flags. None of the code
mentioning F_XXX flags is relevant to the flock implemention which is
below after the #else.

What the patch does is that it completely replaces os_lock_file with 
another implementation using flock instead of fcntl, with the old 
implementation #ifdef USE_FCNTL_LOCK (which is not defined).

> Anyway I tried the patch on 2.4.24 with uml-patch-2.4.24-2 and it breaks
> UML. It is unable to halt or restart with some of its processes left.
> I don't know why, maybe because of mixed flock/fcntl calls.

Seems to works here.. there os no other uses of F_SETLK in my uml tree.  
Using this successfully on RedHat-8 (2.4.20 somthing host kernel, no SKAS)  
and Fedora Core 2 test 1 + SKAS (2.6.something + SKAS host kernel)..

Regards
Henrik



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
