Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ChE7p-0001Aw-Rt for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 22 Dec 2004 13:34:29 -0800
Received: from dgate2.fujitsu-siemens.com ([217.115.66.36])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1ChE7o-0001ad-KG for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 22 Dec 2004 13:34:29 -0800
Message-ID: <41C9E847.2060405@fujitsu-siemens.com>
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] Memory corruption/errors?
References: <63806.222.152.52.159.1103583370.squirrel@222.152.52.159>
	<41C963DC.8060401@fujitsu-siemens.com>
	<41C9D1F0.4000605@rimuhosting.com>
In-Reply-To: <41C9D1F0.4000605@rimuhosting.com>
Content-Type: multipart/mixed; boundary="------------030100010704050802000208"
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
Date: Wed, 22 Dec 2004 22:33:59 +0100
To: Peter <peter.repliesignored@rimuhosting.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>

This is a multi-part message in MIME format.
--------------030100010704050802000208
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Peter wrote:
> I don't recall seeing an error where the obs and exp were equal.  I saw 
> plenty where they were not equal.
> 
> The code is pretty simple:
> double observed = a[i];
> double expected = (double) i;
> if (observed != expected) {
>           printf ("failed at i=%u, k=%u (obs %.18g vs exp %.18g)\n",i, 
> k,observed, expected);
> };
> 
> Maybe it is just some unexpected handling on the != operator with doubles?
> 
> Are you seeing cases where obs!=exp?  And difference if you run it on a 
> uni-proc server vs. a smp server?
No. I just found a problem in SKAS sigcontext handling.
The fp-registers are not restored correctly. Then, I remembered the problems
with memtest, which uses floatpoint.
I modified the test to have sighandlers being started evey 10ms, using
the fpu in the sighandler. Then, *many* error occured in my "memtest2".
Without the modification, I couldn't reproduce the problems.

Two questions:
1) are you able to reproduce the problems in TT-mode?
2) do you have any idea, why a signal handler using floatpoint should be started,
    while running the original memtest?

Have attached my memtest2.c

Regards
Bodo

P.S.: Mail with full description of the problem I've found will follow soon.
> 
> Regards, Peter
> 
> Bodo Stroesser wrote:
> 
>> Carl wrote:
>>
>>> Hi,
>>>
>>> Running the piece of code from the URL below is generating errors on
>>> various UML kernels:
>>>
>>> http://downloads.rimuhosting.com/memtest.c
>>>
>>> Kernels tested are: 2.4.27, 2.4.27-bs1, 2.6.9-bb4.
>>>
>>> Different UML host servers have been tried too, and only UMLs running on
>>> SMP (dual Xeon) servers seem to have the problem (P4s with HT are fine).
>>>
>>> Can anyone else reproduce the errors? Any ideas?
>>>
>>> Thanks, Carl
> 
> Do you see messages like this one
> 
>     "failed at i=17240, k=85 (obs 17240 vs exp 17240)"
> 
> with obs and exp being equal?


--------------030100010704050802000208
Content-Type: text/plain;
 name="memtest2.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="memtest2.c"

#include <stdio.h>
#include <stdlib.h>
#include <signal.h>
#include <sys/time.h>

#define N (20*1024)

void sighdlr(int sig)
{
    double a;

    a = 256;

    double observed = a;
    double expected = 257;

    if ( observed == expected )
	printf("Error in sighdlr()\n");
}

int
main (void)
{
    size_t i, k;
    struct itimerval itimer = { { 0, 10000}, { 0, 10000} };

    signal(SIGALRM, sighdlr);
    setitimer( ITIMER_REAL, &itimer, NULL);

    for (k = 1; k < 1000; k++) {
	double *a = malloc (N * sizeof (double));
	if (a == 0) {
	    printf ("malloc failed at k=%u\n", k);
	    exit (1);
	}

	for (i = 0; i < N; i++) {
	    a[i] = (double) i;
	    double observed = a[i];
	    double expected = (double) i;
	    if (observed != expected) {
		printf ("failed at i=%u, k=%u (obs %.18g vs exp %.18g)\n", i, k,
		        observed, expected);
	    }
	}

	for (i = 0; i < N; i++) {
	    double observed = a[i];
	    double expected = (double) i;
	    if (observed != expected) {
		printf ("failed at i=%u, k=%u (obs %.18g vs exp %.18g)\n", i, k,
		        observed, expected);
//		exit (1);
	    }
	}
	free (a);
    }
    exit (0);
}

--------------030100010704050802000208--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
