Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EOHcR-0000nv-VO	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 08 Oct 2005 09:32:19 -0700
Received: from wumpus.mythic-beasts.com ([212.69.37.9] ident=Debian-exim)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)	id 1EOHcQ-0000Ck-C2
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 08 Oct 2005 09:32:20 -0700
Received: from sphinx.mythic-beasts.com ([212.69.37.6])
	by wumpus.mythic-beasts.com with esmtp (Exim 4.44)
	id 1EOHcI-0002kz-SD	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 08 Oct 2005 17:32:10 +0100
From: Chris Lightfoot <chris@ex-parrot.com>
Message-ID: <z/jPSbKkgHHL.jbObjJNOGZsiVW/jm0lNOg@sphinx.mythic-beasts.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [uml-devel] UBD performance
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
Date: Sat, 8 Oct 2005 17:32:10 +0100
To: user-mode-linux-devel@lists.sourceforge.net

At the moment, the performance of UBD is disappointing.
For instance, here is a trivial benchmark on a quiet and
reasonably modern P4 server with 3Ware 8xxx RAID (this is
linux 2.6.13.3, but I haven't spent any effort on tuning
the IO subsystem; in particular, the below results are for
the default, anticipatory, IO scheduler, but I don't
expect this choice to make much difference in this test
environment):

    # time dd if=/dev/zero of=testfile bs=1M count=32
    32+0 records in
    32+0 records out
    33554432 bytes transferred in 0.118687 seconds (282713683 bytes/sec)

    real    0m0.120s
    user    0m0.000s
    sys     0m0.120s
    # time rm testfile

    real    0m0.027s
    user    0m0.000s
    sys     0m0.028s

... while the same experiment on a 2.6.13.3 UML kernel
(booting with parameters ubd0s=filesystem mem=128M)
running on the same hardware gives the following less
impressive results:

    # time dd if=/dev/zero of=testfile bs=1M count=32
    32+0 records in
    32+0 records out
    33554432 bytes transferred in 0.761825 seconds (44044809 bytes/sec)

    real    0m0.770s
    user    0m0.000s
    sys     0m0.240s
    # time rm testfile
    
    real    1m20.808s
    user    0m0.000s
    sys     0m0.120s

(in this case the filesystem is from Debian `sarge', but
there's no reason this should make a significant
difference). Note that in both cases I've run the test
several times in order until the timings stabilise a bit.

Note that if you mount the host filesystem `sync' the
cost of creating the file rises a bit but the cost of
unlinking it doesn't change that much. Similarly if you
configure the UBD device without O_SYNC, things get a bit
quicker, but ``I like my data and I want to keep it'', so
this isn't an attractive option. (Though see my comment
about write barriers from earlier in the week.)

I should say also at this stage that no benchmark is
meaningful without context and the best benchmarks are
those which are based on a specific application which you
want to use a system to run. Equally I don't think that
the above pair of commands is an unreasonable thing to
expect to run reasonably swiftly on modern hardware, and
it's an interesting test case because the gap between host
and virtual machine performance is so large.

Matters can be improved a bit by rewriting the UBD code to
accept whole requests at once, use scatter/gather IO
(readv/writev) on the host, and allow there to be more
than one outstanding request at once. Here's a patch
against 2.6.12.5 which does this:
    http://ex-parrot.com/~chris/tmp/20051008/ubd-sgio-2.6.12.5.patch
but note that it's very much a work-in-progress (it also
removes support for COW and isn't anywhere near
sufficiently well-tested for real use):

    # time dd if=/dev/zero of=testfile bs=1M count=32
    32+0 records in
    32+0 records out
    33554432 bytes transferred in 0.753967 seconds (44503843 bytes/sec)

    real    0m0.763s
    user    0m0.000s
    sys     0m0.320s
    # time rm testfile

    real    0m1.026s
    user    0m0.000s
    sys     0m0.140s

Note that, while this comes closer to acceptable
performance, the rm is getting on for two orders of
magnitude slower than on the host.

Jeff Dike also has an AIO reimplementation of UBD in the
works, but I haven't had a chance to look at it yet.

I'm not really sure why this simple test is so slow. A
limitation of the existing UBD implementation is that it
issues requests to the host serially; Jeff's AIO
reimplementation will fix this, and I had a go at making
my implementation multithreaded (N threads submitting up
to N simultaneous IO operations to the host). In fact this
doesn't make a lot of difference to the above test, and
the concurrency is a bit messy (it makes the write
barriers case harder, in particular), so I haven't
investigated in detail.

Here is another simple test. The code in,
    http://caesious.beasts.org/~chris/tmp/20051008/ioperformance.tar.gz
will issue random seeks and randomly-sized
reads/writes/synchronous writes against a file or block
device. This gives a measure of the effective seek time
and transfer rate of a block device (with or without an
overlying filesystem). Basic usage as follows:

    # tar xzf ioperformance.tar.gz
    # cd ioperformance
    # make rate
    # dd if=/dev/zero of=300M bs=1M count=300
    # ./rate writesync 300 > results
        [ ... this takes a little while... ]

that gives a text file whose first column is the size of
each IO operation and whose second column is its duration
of that operation. Obviously there will be a distribution
of durations for any given size of (in this case) write
operation, so there are two further scripts in the
distribution, bsmedian and bspercentile, which compute
respectively the median duration of operations of a given
size and the nth percentile points of the distribution for
each size. Here are some sample results, again comparing
the host with 2.6.12.5 UML kernels:
    http://ex-parrot.com/~chris/tmp/20051008/host-vs-uml-io-results.png

Note that while stock UBD in 2.6.12.5 is about an order of
magnitude slower than the host kernel for writes of any
significant size, a more effective implementation can
match the host's performance pretty well, which is as we
expect, since the cost of issuing the writes in UML is
pretty small compared to the actual cost of the disk
operations themselves. (As an aside, I don't really
understand the plateau in the curve above for writes of
smaller than 64KB. This may be an effect of stripe size in
the RAID array, but I'm not sure.)

Thoughts / comments?

-- 
Commitment can be best illustrated by a breakfast of ham and eggs.
The chicken was involved, the pig was committed. (unknown origin)


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
