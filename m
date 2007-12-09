Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1J1Dip-0000wC-6x for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 08 Dec 2007 20:24:55 -0800
Received: from ruby.spiritone.com ([216.99.193.130])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1J1Din-0005Od-RW
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 08 Dec 2007 20:24:55 -0800
Received: from [192.168.0.4] (216-99-213-225.dsl.aracnet.com [216.99.213.225])
	(authenticated bits=0)
	by ruby.spiritone.com (8.13.6/8.13.4) with ESMTP id lB94Oq0X023130
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 8 Dec 2007 20:24:52 -0800
Message-ID: <475B6E19.6040200@BitWagon.com>
Date: Sat, 08 Dec 2007 20:24:57 -0800
From: John Reiser <jreiser@BitWagon.com>
MIME-Version: 1.0
Subject: [uml-devel] should there be os_clone() analogous to os_getpid() ?
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: uml-devel <user-mode-linux-devel@lists.sourceforge.net>

In source file arch/um/os-Linux/process.c there is a warning:
-----
/* Don't use the glibc version, which caches the result in TLS. It misses some
 * syscalls, and also breaks with clone(), which does not unshare the TLS.
 */

int os_getpid(void)
-----

I see no os_clone(), yet the glibc clone() does the same caching of pid in
ThreadLocalStorage [TLS], and the TLS still may be shared.  If nobody reads
glibc's shared TLS slot for PID then an actual bug will be avoided.  However,
it is unsafe to leave such a tempting pitfall.  Also, if you are ptrace()ing
through a glibc clone(), then in many cases you will see syscall(__NR_getpid)
*from glibc* immediately following!  There is an "extra" getpid()
that the tracking logic might not expect.  So it seems to me that
there should be an os_clone() that refrains from fiddling with getpid.
[Unfortunately os_clone() is not so simple as os_getpid().]


The clone() we're talking about here is _not_ the bare syscall:
-----
	_syscall5(int, clone, int, flags, void *, child_stack,
            int *, parent_tidptr, struct user_desc *, newtls,
            int *, child_tidptr)
-----
but rather the C-language interface:
-----
       int clone(int (*fn)(void *), void *child_stack,
                 int flags, void *arg, ...
                 /* pid_t *pid, struct user_desc *tls, pid_t *ctid */ );
-----
which is declared in arch/um/include/kern.h and referenced in
   arch/um/drivers/ubd_user.c
   arch/um/kernel/tt/tracer.c
   arch/um/os/tt.c
   arch/um/os/start_up.c
   arch/um/os/skas/process.c
This clone() is implemented by glibc, and at runtime lives in the shared
library /lib/libc.so.6.

Not only that, but some versions of glibc for x86 use "int $0x80" directly
only for the __NR_clone call.  They use "ENTER_KERNEL" for the getpid(),
which in some cases (such as Fedora 7 and 8, but not Ubuntu 7.04) expands to
"call *%gs:nnnnn" which points at "sysenter; ret".

-- 
John Reiser, jreiser@BitWagon.com

-------------------------------------------------------------------------
SF.Net email is sponsored by: 
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
