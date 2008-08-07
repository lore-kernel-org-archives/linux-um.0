Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KR4Ne-0003HW-Sr for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Aug 2008 05:14:10 -0700
Received: from ip-212-081-022-089.static.nextra.sk ([212.81.22.89]
	helo=meduna.org) by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1KR4Nc-0003wU-Kw for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Aug 2008 05:14:10 -0700
Message-ID: <489AE6DD.2000200@meduna.org>
Date: Thu, 07 Aug 2008 14:13:17 +0200
From: Stanislav Meduna <stano@meduna.org>
MIME-Version: 1.0
References: <4896F8A1.6020203@meduna.org><20080804164246.GA14805@c2.user-mode-linux.org>	<4898AC10.3010602@meduna.org>	<7B4268E5ACB878429B58D4BE5B780E8301A303A5@NWS-EXCH2.nws.oregonstate.edu>	<48995D1A.6030203@meduna.org>
	<489AC525.3060305@meduna.org>
In-Reply-To: <489AC525.3060305@meduna.org>
Subject: Re: [uml-devel] /dev/random problems .. or FP registers corruption?!
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
To: user-mode-linux-devel@lists.sourceforge.net
Cc: openssl-dev@openssl.org

Stanislav Meduna wrote:

> Am I seeing ghosts? Anyone got other mysterious
> problems with current UML kernel? Could it be that
> some state-saving method is corrupting fp registers
> or something like that? Was there some change in the
> UML / vanilla kernel recently?

Confirmed: I can reproduce openssl changing a double
value in unrelated process. I was not able to come
up with a code not relying on external software yet:

===
#include <stdlib.h>
#include <unistd.h>
#include <stdio.h>
#include <time.h>
#include <signal.h>

testdblchg()
{
   volatile double x0 = 2.0;
   volatile double x1;
   int iter = 0;

   fprintf(stderr, "Starting loop, pid=%d\n", getpid());

   while(1)
   {
     ++iter;
     x1 = x0;
     x0 += 1.0;
     if (x0 != x1 + 1)
     {
       kill(getppid(), SIGTERM);
       fprintf(stderr, "Double variable changed! pid=%d, iteration=%d, should=%g, 
is=%g\n", getpid(), iter, x1+1, x0);
       exit(1);
     }
     sleep(1);
   }
}

testcrypto()
{
   while(1)
   {
     system("openssl genrsa -out /dev/null 4096");
     sleep(1);
   }
}

main()
{
   if (fork() == 0)
     testdblchg();

   testcrypto();
}
===

Output:
$ ./a.out
Starting loop, pid=16920
Generating RSA private key, 4096 bit long modulus
......++
.......................................................................................................................................................................++
e is 65537 (0x10001)
Generating RSA private key, 4096 bit long modulus
...................................Double variable changed! pid=16920, iteration=15, 
should=nan, is=nan
Terminated

$ uname -a
Linux dirk 2.6.26 #1 Wed Jul 30 10:56:10 CEST 2008 i686 GNU/Linux

$ cat /proc/cpuinfo
processor       : 0
vendor_id       : User Mode Linux
model name      : UML
mode            : skas
host            : Linux seldon-base 2.6.23.17 #2 SMP Sat Jun 21 15:04:22 CEST 2008 i686
bogomips        : 4771.02

$ gcc -v
Using built-in specs.
Target: i486-linux-gnu
Configured with: ../src/configure -v --with-pkgversion='Debian 4.3.1-2' 
--with-bugurl=file:///usr/share/doc/gcc-4.3/README.Bugs 
--enable-languages=c,c++,fortran,objc,obj-c++ --prefix=/usr --enable-shared 
--with-system-zlib --libexecdir=/usr/lib --without-included-gettext --enable-threads=posix 
--enable-nls --with-gxx-include-dir=/usr/include/c++/4.3 --program-suffix=-4.3 
--enable-clocale=gnu --enable-libstdcxx-debug --enable-objc-gc --enable-mpfr 
--enable-targets=all --enable-cld --enable-checking=release --build=i486-linux-gnu 
--host=i486-linux-gnu --target=i486-linux-gnu
Thread model: posix
gcc version 4.3.1 (Debian 4.3.1-2)

$ dpkg -l libc6
Desired=Unknown/Install/Remove/Purge/Hold
| Status=Not/Inst/Cfg-files/Unpacked/Failed-cfg/Half-inst/trig-aWait/Trig-pend
|/ Err?=(none)/Hold/Reinst-required/X=both-problems (Status,Err: uppercase=bad)
||/ Name           Version        Description
+++-==============-==============-============================================
ii  libc6          2.7-10         GNU C Library: Shared libraries


Regards
-- 
                                            Stano

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
