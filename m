Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BDkVd-0006rn-Oz for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 14 Apr 2004 06:32:57 -0700
Received: from smtp1.poczta.onet.pl ([213.180.130.31])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BDkVd-0007NF-1l for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 14 Apr 2004 06:32:57 -0700
From: Marcin Pawlik <wapkil@op.pl>
Subject: Re: [uml-devel] [patch] Re: Reboot failing with file locked,
	CLONE_FILES and host kernel BUG()
Message-ID: <20040414133215.GA7464@mpmain>
References: <20040413212307.GA14758@mpmain>
	<Pine.LNX.4.44.0404140305370.20676-200000@filer.marasystems.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="UugvWAfsgieZRqgk"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0404140305370.20676-200000@filer.marasystems.com>
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
Date: Wed, 14 Apr 2004 15:32:15 +0200
To: Henrik Nordstrom <uml@henrik.marasystems.com>
Cc: user-mode-linux-devel@lists.sourceforge.net



--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline

On Wed, Apr 14 at 03:13, Henrik Nordstrom wrote:
> On Tue, 13 Apr 2004, Marcin Pawlik wrote:
> 
>> #v+
>> F_SETLK failed, file already locked by pid 32589
>> Failed to lock 'fs', err = 11
>> #v-
> 
> Have been plauged by this quite a lot.. tried to narrow it down the
> other day but the conclusion was that the host fcntl locking
> implementation is buggy and stale locks easily gets left behind even
> after application has closed the file 

Do you know where and which thread closes the files? I tried to add file
closing to kill_io_thread() (patch attached) and it helps but I think it
should also be performed without my code.

> or even terminated. Probably related to the use of clone() which
> somewhat messes up the hosts view of which process owning the lock..

If it works as I suspected clone is used with CLONE_FILES. The lock is
released if any of file-sharing threads closes the file or all of them
are finished. The tracing thread is never finished so if the file is not
explicitly closed the host kernel shouldn't release the lock. This is
correct (the files should simply be closed by UML before reboot). 

The problem with host kernel is that it sometimes doesn't release the
lock even after all threads are finished and on 2.6.5 always hits a
BUG() line in locks_remove_flock. I don't see how this could be
exploited but it should be corrected anyway. On 2.6.5 it leaves
filesystem in inconsistent state with kernel unable to umount it.
I thought it would be nice to reproduce this with something simpler than
UML before reporting. Unfortunately I don't have sufficient UML
internals knowledge to mimic its threads creation, ptracing, file
locking and reboot which should lead to the same behavior.

> After this I gave up and rewrote this part to use flock instead of
> fcntl for locking. Seems to work much better except that locks are
> only local and does not protect from multiple stations accessing the
> same NFS mounted image..
> 
> Patch attached.
> 
>
> Index: arch/um/os-Linux/file.c
> ===================================================================
> RCS file: /cvsroot/user-mode-linux/linux/arch/um/os-Linux/file.c,v
> retrieving revision 1.29
> diff -u -r1.29 file.c
> --- arch/um/os-Linux/file.c	7 Apr 2004 20:44:49 -0000	1.29
> +++ arch/um/os-Linux/file.c	14 Apr 2004 00:41:22 -0000
> @@ -688,6 +688,7 @@
>  
>  int os_lock_file(int fd, int excl)
>  {
> +#if USE_FCNTL_LOCK
>  	int type = excl ? F_WRLCK : F_RDLCK;
>  	struct flock lock = ((struct flock) { .l_type	= type,
>  					      .l_whence	= SEEK_SET,
> @@ -710,6 +711,21 @@
>  	err = save;
>   out:
>  	return(err);
> +#else
> +	int type = excl ? LOCK_EX : LOCK_SH;

I don't understand this. IMO excl should be F_RDLCK or F_WRLCK. F_RDLCK
is 0, F_WRLCK is 1 and LOCK_EX is 2 so you will always use LOCK_SH.
Anyway I tried the patch on 2.4.24 with uml-patch-2.4.24-2 and it breaks
UML. It is unable to halt or restart with some of its processes left.
I don't know why, maybe because of mixed flock/fcntl calls.

Regards,

-- 
Marcin Pawlik

--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename="uml-kill-io-thread.patch"

diff -urN kernel-source-2.4.24/arch/um/drivers/ubd_kern.c kernel-source-2.4.24.mp/arch/um/drivers/ubd_kern.c
--- kernel-source-2.4.24/arch/um/drivers/ubd_kern.c	2004-04-14 14:38:21.000000000 +0200
+++ kernel-source-2.4.24.mp/arch/um/drivers/ubd_kern.c	2004-04-14 14:42:55.000000000 +0200
@@ -495,6 +495,16 @@
 
 void kill_io_thread(void)
 {
+	int i;
+	struct ubd * ubd_devp = ubd_dev;
+
+	for(i = 0; i < MAX_DEV; i++, ubd_devp++) {
+		if(ubd_devp) {
+			os_close_file(ubd_devp->fd);
+			close(ubd_devp->cow.fd);	
+		}
+	}
+
 	if(io_pid != -1)
 		os_kill_process(io_pid, 1);
 }

--UugvWAfsgieZRqgk--


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
