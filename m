Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ba4Dk-0003AR-GP for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 14 Jun 2004 20:02:44 -0700
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1Ba4Dj-00075a-Lt for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 14 Jun 2004 20:02:43 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_JrezAk9L/cI/Kkg"
Message-Id: <200406142013.29047.blaisorblade_spam@yahoo.it>
Subject: [uml-devel] [SYSEMU] New benchmarks results
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
Date: Mon, 14 Jun 2004 20:13:28 +0200
To: user-mode-linux-devel@lists.sourceforge.net



--Boundary-00=_JrezAk9L/cI/Kkg
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I've decided to do benchmarks to check how much SYSEMU saves in benchmark 
which also access memory (memLoop.c) and how much could save the 0 context 
switch idea (provided that segmentation has low cost).

First, about the benchmark on the Laurent Vivier page: I think that the "60 %" 
number is meaningless - I guess it is that calculated with "real time", which 
is not very meaningful IMHO - that is the time from when the process start to 
when it ends, and counts even time spent by executing other processes. A more 
meaningful difference is done with the sum of user+system time:

average time (user+system):
- without SYSEMU 
64.910
- with SYSEMU
51.321

SYSEMU saves (64.910 - 51.321) / 64.910 * 100 % = 20,9 % of the time without 
SYSEMU, in this benchmark.

I've re-benchmarked UML with SYSEMU using memLoop.c which tries to measure the 
effects of accessing memory: it access one byte per page, thus causing the 
CPU to reload in the TLB the page table entry (PTE) for that page. IMHO, this 
benchmark shows that most of the gap vs the host is in the 2 remaining CS per 
syscall: the 2 we save with SYSEMU account for about 25% of the getpid 
execution, most of the gap is still there.

In the attached files NPAGES = 64 (see source), but I also posted results with 
NPAGES = 512. Also, please, don't look at the "elapsed" time: it's 
meaningless.

In fact getpidLoop measures only the cost of TLB flushes, while memLoop also 
measures the cost of TLB misses after the TLB flush, which can be compared 
against memLoopPure, which runs no syscall and thus never flushes the TLBs.

To see this, I must be sure that memLoopPure has no TLB fault, i.e. that the 
PTEs for all pages fit in the TLB; this happen when NPAGES = 64, not when 
NPAGES=512. In the two cases, we have working sets of 64 * PAGE_SIZE = 128k 
and of 512 * PAGE_SIZE = 2 M.

On the host, memLoop and memLoopPure have similar user time, since there is 
never a TLB flush. When NPAGES = 512, each page access causes a TLB miss, so 
the user time is always similar, both on the host and the guest, and both 
with and without syscalls.

But when NPAGES = 64, on the host the TLB is never flushed (except when 
another process is executing): it is filled only once and then used.

On the guest, instead, with NPAGES = 64 the user time of memLoop is double 
than the memLoopPure one. And since 0.40 s are for the getpid() calls, 
touch_mem() uses 0.40 s in memLoopPure and 1.20 s in memLoop: 3 times the old 
time.
--------
HOST:

host $ time ./getpidLoop 1000000

0.27user 0.21system 0:00.55elapsed 87%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (70major+11minor)pagefaults 0swaps
--------
With NPAGES = 64:

host $ time ./memLoop 1000000

1.11user 0.23system 0:01.46elapsed 91%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (79major+75minor)pagefaults 0swaps
----
host $ time ./memLoopPure 1000000
0.88user 0.00system 0:00.97elapsed 90%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (78major+75minor)pagefaults 0swaps
--------
With NPAGES = 512

host $ time ./memLoop 1000000

8.93user 0.24system 0:09.84elapsed 93%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (79major+523minor)pagefaults 0swaps
----
host $ time ./memLoopPure 1000000

8.71user 0.01system 0:09.43elapsed 92%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (78major+523minor)pagefaults 0swaps

------------
On the guest, with SYSEMU:

guest # /usr/bin/time 
/mnt/host/home/paolo/Dati/Sorgenti/Varie/C-C++/getpidLoop 1000000

0.42user 3.87system 0:16.09elapsed 26%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+76minor)pagefaults 0swaps
--------
With NPAGES = 64:
----
guest # /usr/bin/time /mnt/host/home/paolo/Dati/Sorgenti/Varie/C-C++/memLoop 
1000000

1.60user 4.00system 0:18.02elapsed 31%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+146minor)pagefaults 0swaps
----
guest # /usr/bin/time 
/mnt/host/home/paolo/Dati/Sorgenti/Varie/C-C++/memLoopPure 1000000

0.85user 0.05system 0:01.01elapsed 88%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+146minor)pagefaults 0swaps
--------
With NPAGES = 512:

guest # /usr/bin/time /mnt/host/home/paolo/Dati/Sorgenti/Varie/C-C++/memLoop 
1000000

9.09user 4.18system 0:28.37elapsed 46%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+594minor)pagefaults 0swaps
----
guest # /usr/bin/time 
/mnt/host/home/paolo/Dati/Sorgenti/Varie/C-C++/memLoopPure 1000000

8.76user 0.07system 0:11.57elapsed 76%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+594minor)pagefaults 0swaps

----------------
On the guest, without SYSEMU:
(we always about 25% increase for system time vs SYSEMU, except for 
memLoopPure, but equal user time: we don't save the TLB misses)

# /usr/bin/time /mnt/host/home/paolo/Dati/Sorgenti/Varie/C-C++/getpidLoop 
1000000
0.42user 5.01system 0:21.08elapsed 25%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+76minor)pagefaults 0swaps
----
With NPAGES = 64:

guest # /usr/bin/time 
/mnt/host/home/paolo/Dati/Sorgenti/Varie/C-C++/memLoopPure 1000000
(about the same, as expected)

0.86user 0.02system 0:00.94elapsed 92%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+146minor)pagefaults 0swaps
----
guest # /usr/bin/time /mnt/host/home/paolo/Dati/Sorgenti/Varie/C-C++/memLoop 
1000000
(about 25% increase for system time, equal user time: we don't save the TLB 
misses)
1.62user 5.00system 0:26.73elapsed 24%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+146minor)pagefaults 0swaps

--------

With NPAGES = 512

guest # /usr/bin/time 
/mnt/host/home/paolo/Dati/Sorgenti/Varie/C-C++/memLoopPure 1000000

8.84user 0.02system 0:10.86elapsed 81%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+594minor)pagefaults 0swaps

----

guest # /usr/bin/time /mnt/host/home/paolo/Dati/Sorgenti/Varie/C-C++/memLoop 
1000000
9.15user 5.06system 0:36.66elapsed 38%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+594minor)pagefaults 0swaps

-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729





--Boundary-00=_JrezAk9L/cI/Kkg
Content-Type: text/x-csrc;
  charset="us-ascii";
  name="getpidLoop.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="getpidLoop.c"

#include <stdio.h>
#include <stdlib.h>
                                                                                
int main(int argc, char** argv)
{
        int i;
        int loop = atol(argv[1]);
                                                                                
        for (i = 0; i < loop; i++)
        {
                getpid();
        }
	return 0;
}

--Boundary-00=_JrezAk9L/cI/Kkg
Content-Type: text/x-csrc;
  charset="us-ascii";
  name="memLoopPure.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="memLoopPure.c"

#include <stdio.h>
#include <stdlib.h>

char * buf;
#define PAGE_SIZE (4 * 1024)
#define NPAGES (64)
#define SIZE (NPAGES * PAGE_SIZE)

void touch_memory(void)
{
	char t;
	int i;
	for (i = 0; i < NPAGES; i++) {
		t = buf[PAGE_SIZE * i];
	}
}

int main(int argc, char** argv)
{
        int i;
        int loop = atol(argv[1]);

	buf = malloc(SIZE + 1);

        for (i = 0; i < loop; i++)
        {
		touch_memory();
        }
	return 0;
}

--Boundary-00=_JrezAk9L/cI/Kkg
Content-Type: text/x-csrc;
  charset="us-ascii";
  name="memLoop.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="memLoop.c"

#include <stdio.h>
#include <stdlib.h>

char * buf;
#define PAGE_SIZE (4 * 1024)
#define NPAGES (64)
#define SIZE (NPAGES * PAGE_SIZE)

void touch_memory(void)
{
	char t;
	int i;
	for (i = 0; i < NPAGES; i++) {
		t = buf[PAGE_SIZE * i];
	}
}

int main(int argc, char** argv)
{
        int i;
        int loop = atol(argv[1]);

	buf = malloc(SIZE + 1);

        for (i = 0; i < loop; i++)
        {
		touch_memory();
                getpid();
        }
	return 0;
}

--Boundary-00=_JrezAk9L/cI/Kkg--




-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
