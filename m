Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AOTZU-00063c-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Mon, 24 Nov 2003 19:09:00 -0800
Received: from m17.lax.untd.com ([64.136.30.80])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.24)
	id 1AOTZT-0007I7-Oc
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 24 Nov 2003 19:08:59 -0800
Subject: Re: [uml-devel] Host panic when UML reads host /dev/shm
Message-ID: <20031124.190229.-373069.0.mcmechanjw@juno.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: James W McMechan <mcmechanjw@juno.com>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Mon, 24 Nov 2003 19:02:25 -0800
To: blaisorblade_spam@yahoo.it
Cc: user-mode-linux-devel@lists.sourceforge.net

> > I have been tracing down the Oops on a vanilla 2.4.22 kernel
> > This appears to be a Oops with a semaphore held that will
> > lock out all other accesses to the tmpfs/shmfs filesystem.
> In fact, I wrote the exact point of the Oops in the host kernel in 
> the first 
> message... it's not clear if you missed this.

No I did not miss it I was working on what tasks were occurring
before the Oops, I used it to generate the test program.

> > I traced it to read_dir in hostfs_user.c by setting
> > breakpoints on all the hostfs_user.c functions.
> Yes, I've get to that point, too.
> > This is very strange my attached test program when run
> > as a unprivileged user Oops the kernel and locks /dev/shm
> > in general a unprivileged user should not be able to do this
> Yes, but it's a kernel bug: provided the kernel doesn't oops, 
> checking for priviledges with semaphore isn't needed. And 
> if someone wants to implement this, he will receive as answer
> "fix the oops and post that. No overhead, please". And 
> actually implementing the fix wouldn't be easy(how do you
> steal a semaphore that a priviledged process holds?)...
> 
> Maybe, releasing semaphores on Oops could be useful. IIRC, the code 
> already releases spinlocks(but not sure at all). But when oopsing, it's
not 
> easy to do anything, since we have already problems.

Ah, no I was not trying to complain about the semaphore
I think the Oops needs fixing also.
It is not that it needs a permission check, but rather that any commands
issued by a unprivileged user (no matter how dumb) should not Oops
the kernel.

> > It has taken a while in order to check that the kernel I was
> > running was without patches (i.e. no skas)
> So, it happens even without SKAS mode.
> The other possible issue(i.e. something unusual which happens only 
> with UML) is with threading. If I have time, I'll check whether a
> program creating threads on the host the way UML does can
> obtain the same Oops. At that point, LKML won't be able to
> ignore it. I mean just a userspace program to run on the host.

You don't need to bother that is what my test program does it will
Oops the host kernel without requiring any UML to be present.
That is why I checked with a vanilla kernel rather then my
normal skas patched version.

> > I have also noted that the tmpfs/shmfs does not have a set
> > of files like other filesystems under fs/ it seems to be located
> > in mm/shmem.c instead... very strange
> Actually, it's based on fs/ramfs... which has only one file because 
> nothing is saved by the FS. Normally dentries(an object which
> represents anything contained inside a dir, a "directory entry")
> are just used to cache access to the FS; for ramfs and tmpfs
> (or better, for all ram-based fs, even the 2.6 sysfs), they are 
> locked in memory and never unloaded.

Yes, I understand mostly how it works, but the layout of the
shmem_* inode ops in mm/shmem.c was confusing I was expecting
TMPFS to be under fs/tmpfs or fs/ramfs, I had to grep the whole
tree to find the CONFIG_TMPFS ifdefs

> > Oh well it is a problem with the vanilla 2.4.22 kernel so
> > more testing and off to the LKML...
> 
> > Anybody have a better guess where to send this?
> Maybe there is a linux-mm mailing list... check Maintainers file. 
> But before LKML we probably need to write a simple test
> program... like the threaded one 
> I said above(if threading is the issue).

Threading is not a issue the test program I attached to yesterdays
e-mail can be run on the host system to Oops the host kernel
without requiring UML and can be run inside of UML to Oops
the UML kernel with all the nice debugging features, while letting
the host system keep running without any Oopses.

It is much simpler to use than using UML to Oops the host kernel

The biggest problem I have been having is all of the inlines hiding
where exactly it is going wrong, it appears that the
dcache_readdir blows up when a invalid ->prev pointer is in
one of the lists it may relate to the list_del(q); list_add(q,
&dentry->d_subdirs); on a empty list that I think is occurring

MAINTAINERS, mm/shmem.c don't seem to list contact
addresses for tmpfs/shmfs :(

here is a even shorter version of the test program
it blows up on the first real entry
The first version is easier to understand what
UML is doing though.

/* by James_McMechan at hotmail com */                                   
      
/* test2 program to Oops shmfs mounted at /dev/shm */
/* yes it is dumb but unprivileged users should not be able */
/* to Oops the kernel regardless of how dumb the program */
#include <sys/types.h>
#include <dirent.h>
main()
{/* off 0 is "." off 1 is ".." off 2 is empty */
seekdir(opendir("/dev/shm"), (off_t) 2);
}

________________________________________________________________
The best thing to hit the internet in years - Juno SpeedBand!
Surf the web up to FIVE TIMES FASTER!
Only $14.95/ month - visit www.juno.com to sign up today!


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
