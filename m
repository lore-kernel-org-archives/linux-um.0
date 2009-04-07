Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <inguin@gmx.de>) id 1LrFP9-0003Cj-Ro
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 07 Apr 2009 17:48:11 +0000
Received: from mail.gmx.net ([213.165.64.20])
	by 29vjzd1.ch3.sourceforge.com with smtp (Exim 4.69)
	id 1LrFP0-00079y-Jf for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 07 Apr 2009 17:48:11 +0000
Message-ID: <49DB91C6.7030005@gmx.de>
Date: Tue, 07 Apr 2009 19:47:50 +0200
From: Ingo van Lil <inguin@gmx.de>
MIME-Version: 1.0
Subject: [uml-devel] Multi-threaded applications and floating point registers
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
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net

Hello there,

I'm experiencing some weird problems with a multi-threaded application 
I'm working on: A function which uses nothing but a single input value, 
a few constants and a couple of floating point operations returns wrong 
results from time to time. The application uses multiple threads, and 
we're suspecting that the FPU state isn't properly saved and restored 
when switching between threads within a process.

I've written a trivial test program which can be used to reproduce the 
issue (see below). In theory the program should run forever, but in UML 
it aborts after just a few seconds.

I have observed the issue both with kernel 2.6.28.8 and Busybox/uclibc 
and with the demo kernel 2.6.24-rc7 and the Fedora10 image from the UML 
home page. The problem does not happen with kernel 2.6.23.1. We're 
suspecting that the problem has been introduced by the patch [1] to stop 
saving the process FP state which has been applied just before 2.6.24-rc1.

Regards,
Ingo

[1] 
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=42daba316557e597a90a730f61c762602b7f0e0c

======================================================================

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <pthread.h>

static double my_abs(double d)
{
     return (d >= 0) ? d : -d;
}

static void *fp_test_thread_func(void *arg)
{
     volatile double value1 = *(double *)arg;
     volatile double value2 = *(double *)arg;
     while (1) {
         if (my_abs(value1 - value2) > 0.0001) {
             fprintf(stderr, "Inconsistent values: %lf, %lf\n", value1, 
value2);
             abort();
         }
     }
     return NULL;
}

#define NUM_THREADS 2

int main(void)
{
     pthread_t threads[NUM_THREADS];

     int i;
     for (i = 0; i < NUM_THREADS; i++) {
         double startval = i;
         pthread_create(&threads[i], NULL, fp_test_thread_func, &startval);
     }

     while (1) pause();
     return 0;
}

------------------------------------------------------------------------------
This SF.net email is sponsored by:
High Quality Requirements in a Collaborative Environment.
Download a free trial of Rational Requirements Composer Now!
http://p.sf.net/sfu/www-ibm-com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

