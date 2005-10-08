Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EOMk4-0006uc-CD	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 08 Oct 2005 15:00:32 -0700
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)	id 1EOMk2-0003dC-LQ
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 08 Oct 2005 15:00:32 -0700
Received: from localhost.localdomain (grelber.thyrsus.com [192.168.1.31])
	by grelber.thyrsus.com (8.13.1/8.13.1) with ESMTP id j98NUrY6003943
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 8 Oct 2005 19:30:53 -0400
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] Help?  (Filesystem race condition in 2.6.13.2 in
	-skas0 and -tt mode.)
References: <200509201524.41199.rob@landley.net>
In-Reply-To: <200509201524.41199.rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510081700.18120.rob@landley.net>
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
Date: Sat, 8 Oct 2005 17:00:18 -0500
To: user-mode-linux-devel@lists.sourceforge.net

On Tuesday 20 September 2005 15:24, Rob Landley wrote:
> I have a system build that happens under UML.  The build is a series of
> bash scripts that compile and run a heavily modified Linux From Scratch
> system. The previous version was working fine under 2.6.11 UML in -tt mode
> (with one patch applied, the one to fix the permissions on block devices in
> hostfs).
>
> I just upgraded the build to use the 2.6.13.2, and now I'm getting the
> build breaking with random file not found errors.  I've tried both -tt mode
> and -skas0 mode, and it doesn't like either one.
>
> It seems to be a filesystem problem. 

Update: it seems to be that a filesystem is returning true for S_ISDIR() on 
something that isn't a directory.  Looking closer at the failure cases I 
posted:

>  /tools/bin/install -c -m 644 ./sdiff.1 /tools/man/man1/sdiff.1
> install: unable to open `/tools/man/man1/sdiff.1/sdiff.1': No such file or
> directory
> install: cannot change permissions of /tools/man/man1/sdiff.1/sdiff.1: No
> such file or directory
> install: cannot change ownership of /tools/man/man1/sdiff.1/sdiff.1: No
> such file or directory

Note how the last argument, "/tools/man/man1/sdiff.1" is having an extra 
"/sdiff.1" appended to the end?

and

>   /tools/bin/install -c sdiff /tools/bin/sdiff
> install: unable to open `/tools/bin/sdiff/sdiff': No such file or directory
> install: cannot change permissions of /tools/bin/sdiff/sdiff: No such file
> or directory
> install: cannot change ownership of /tools/bin/sdiff/sdiff: No such file or
> directory

Again, the string "/tools/bin/sdiff" is turning into  
"/tools/bin/sdiff/sdiff"...

The busybox source code in question can be viewed out of our source control 
here:
http://www.busybox.net/cgi-bin/viewcvs.cgi/*checkout*/trunk/busybox/coreutils/install.c?content-type=text%2Fplain&rev=11515

And the relevant snippet is:

 cp_mv_stat2(argv[argc - 1], &statbuf, lstat);
 for (i = optind; i < argc - 1; i++) {
  unsigned char *dest;

  if (S_ISDIR(statbuf.st_mode)) {
   dest = concat_path_file(argv[argc - 1], basename(argv[i]));
  } else {
   dest = argv[argc - 1];
  }
  ret |= copy_file(argv[i], dest, copy_flags);

  /* Set the file mode */
  if (chmod(dest, mode) == -1) {
   bb_perror_msg("cannot change permissions of %s", dest);
   ret = EXIT_FAILURE;
  }

  /* Set the user and group id */
  if (lchown(dest, uid, gid) == -1) {
   bb_perror_msg("cannot change ownership of %s", dest);
   ret = EXIT_FAILURE;
  }

and cp_mv_stat2 is:

extern int cp_mv_stat2(const char *fn, struct stat *fn_stat, stat_func sf)
{
    if (sf(fn, fn_stat) < 0) {
        if (errno != ENOENT) {
            bb_perror_msg("unable to stat `%s'", fn);
            return -1;
        }
        return 0;
    } else if (S_ISDIR(fn_stat->st_mode)) {
        return 3;
    }
    return 1;
}


(Yeah, it needs a cleanup, I know...)

So the uclibc lstat() is getting true from S_ISDIR() on a freshly created 
normal file.  It's definitely an intermittent problem, it _seems_ like the 
lstat structure is not zeroed out or something.

This is linked against uClibc 0.9.27, compiled with "long file support" and 
thus using the following implementation for lstat:

int lstat64(const char *file_name, struct stat64 *buf)
{
    int result;
    struct kernel_stat64 kbuf;

    result = __syscall_lstat64(file_name, &kbuf);
    if (result == 0) {
        __xstat64_conv(&kbuf, buf);
    }
    return result;
}

And the opaque bit of the above is:

void __xstat64_conv(struct kernel_stat64 *kbuf, struct stat64 *buf)
{
    /* Convert to current kernel version of `struct stat64'.  */
    buf->st_dev = kbuf->st_dev;
    buf->st_ino = kbuf->st_ino;
#ifdef _HAVE_STAT64___ST_INO
    buf->__st_ino = kbuf->__st_ino;
#endif
    buf->st_mode = kbuf->st_mode;
    buf->st_nlink = kbuf->st_nlink;
    buf->st_uid = kbuf->st_uid;
    buf->st_gid = kbuf->st_gid;
    buf->st_rdev = kbuf->st_rdev;
    buf->st_size = kbuf->st_size;
    buf->st_blksize = kbuf->st_blksize;
    buf->st_blocks = kbuf->st_blocks;
    buf->st_atime = kbuf->st_atime;
    buf->st_mtime = kbuf->st_mtime;
    buf->st_ctime = kbuf->st_ctime;
}

Um, this might be relevant too:

#define __NR___syscall_lstat64 __NR_lstat64
_syscall2(int, __syscall_lstat64, const char *, file_name, struct stat64 *, 
buf)
;

Now: given all that, do any of you guys have the foggiest idea what's going 
on?  (This is running install on an ext2 formatted file loopback mounted and 
living in a hostfs partition, so the stack of things getting exercised is 
ext2 living in /dev/loop0 attached to hostfs file which is exporting an ext3 
partition from the host system (ubuntu "hoary hedgehog").

By the way, I've cherry-picked out all the binaries and libraries involved in 
this, and got it down to a 650k tarball.  Anybody want that?

Rob


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
