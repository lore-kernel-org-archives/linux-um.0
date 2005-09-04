Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EBzkD-0002b5-FE	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 04 Sep 2005 12:01:33 -0700
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1EBzkA-00018s-Fc
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 04 Sep 2005 12:01:33 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] weak check of access_ok may lead hang!
References: <20050822040705.26215.qmail@mail35-142.sinamail.sina.com.cn>
In-Reply-To: <20050822040705.26215.qmail@mail35-142.sinamail.sina.com.cn>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_4cwGD1EbqrhL1z3"
Message-Id: <200509041639.52622.blaisorblade@yahoo.it>
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
Date: Sun, 4 Sep 2005 16:39:52 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: luothing@sina.com

--Boundary-00=_4cwGD1EbqrhL1z3
Content-Type: text/plain;
  charset="gb2312"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Monday 22 August 2005 06:07, luothing@sina.com wrote:
> I use LTP to test uml,
Which UML release, sorry? I've tried to reproduce it (yes, in TT mode) lightly 
and I failed, so I've thought to ask you first.

I've tested a very recent 2.6 kernel with chmod() and chown() (custom 
testprogram, very light) in TT mode, and it gave this (at beginning, the 
content of /proc/self/maps to verify the pointer is invalid):

#  ./copy_user_test
08048000-08049000 r-xp 00000000 00:0d 
1526299    /mnt/host/home/paolo/Dati/Backup/Uml-testprogs/copy_user_test
08049000-0804a000 rw-p 00000000 00:0d 
1526299    /mnt/host/home/paolo/Dati/Backup/Uml-testprogs/copy_user_test
40000000-40016000 r-xp 00000000 62:00 18540      /lib/ld-2.3.2.so
40016000-40017000 rw-p 00015000 62:00 18540      /lib/ld-2.3.2.so
40017000-40018000 rw-p 40017000 00:00 0
4001c000-40144000 r-xp 00000000 62:00 18544      /lib/libc-2.3.2.so
40144000-4014c000 rw-p 00127000 62:00 18544      /lib/libc-2.3.2.so
4014c000-4014f000 rw-p 4014c000 00:00 0
9fbd9000-9fbee000 rw-p 9fbd9000 00:00 0          [stack]
ffffe000-fffff000 ---p 00000000 00:00 0          [vdso]
chmod failed: Bad address
chown failed: Bad address

I've attached the test program, and 
> and found many failed(about 36), many of 
> this failed lead tt mode uml to hang,
Sorry for answering a week later but I've been busy.
> these failed is calling 
> system call(such as chown) with a out of range pointer, and in
> function strncpy_from_user_*, access_ok just give an weak check,
That's what it's supposed to do, indeed.

Here's the i386 definition (include/asm-i386/uaccess.h):

#define access_ok(type,addr,size) (likely(__range_ok(addr,size) == 0))

And an excerpt from the comment:

 * Note that, depending on architecture, this function probably just
 * checks that the pointer is in the user space range - after calling
 * this function, memory access functions may still return -EFAULT.

access_ok just checks that the pointer doesn't point to kernel memory.

The real checking is done by performing the operation, and using an exception 
handler, both in TT and i386 mode (even if i386 uses the standard exception 
framework, while UML uses a custom one built with sigjmp).

> then lead the test to failed in skas mode,

Failed means "expected failure" (as I guess) or that there is something wrong 
with SKAS too?
> and hang in tt mode, 
That's bad, and yes, it's a problem.
> I think it may be a problem.

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

--Boundary-00=_4cwGD1EbqrhL1z3
Content-Type: text/x-csrc;
  charset="gb2312";
  name="copy_user_test.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="copy_user_test.c"

#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <errno.h>

int main(void)
{
	int ret;
	pid_t pid = getpid();
	char buf[] = "cat /proc/XXXXXX/maps";
	sprintf(buf, "cat /proc/%d/maps", pid);
	system(buf);
	ret = chmod((const char*)(0x2000 * 0x1000), 0);
	if (ret) {
		perror("chmod failed");
	}
	ret = chown((const char*)(0x2000 * 0x1000), 0, 0);
	if (ret) {
		perror("chown failed");
	}
	return ret;
}

--Boundary-00=_4cwGD1EbqrhL1z3--


		
___________________________________ 
Yahoo! Messenger: chiamate gratuite in tutto il mondo 
http://it.beta.messenger.yahoo.com



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
