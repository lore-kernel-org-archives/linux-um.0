Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D9nja-0001JS-Oa for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 11 Mar 2005 09:15:34 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1D9njZ-00010e-SH
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 11 Mar 2005 09:15:34 -0800
Received: from knoppix (grelber.thyrsus.com [192.168.1.31])
	by grelber.thyrsus.com (8.13.1/8.13.1) with ESMTP id j2BIScil015463
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 11 Mar 2005 13:28:38 -0500
From: Rob Landley <rob@landley.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200503111112.50698.rob@landley.net>
Subject: [uml-devel] Debugging stdout console stuttering.
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
Date: Fri, 11 Mar 2005 11:12:50 -0500
To: user-mode-linux-devel@lists.sourceforge.net

Okay, UML repeats its output when the pipe it's writing into fills up
until it returns -EAGAIN.  I can reproduce this even on a fast machine
by repeatedly suspending the xterm that UML is running under with a dumb
little script ala:

while /bin/true
do
	kill -STOP $PID
	sleep 1
	kill -CONT $PID
	sleep 1
done

And then running UML ala:
./linux rootfstype=hostfs rootflags=/ init=/home/landley/extract.sh rw mem=64M

Where extract.sh just cd's to the appropriate directory and extracts the
linux kernel tarball, verbosely.

I instrumented arch/um/chan_kern.c to write data to a file (writing to stdout
or stderr is discarded if the output pipe is full) and got one of the hiccups
to tell me the following:

--- snip ---
[gen=10 1 1 1 2][chan->output=1 0xa0335800 46 
0xa08a8320]linux-2.6.11.2/drivers/
video/kyro/STG4000Reg.h[gen=108 1 46 46 2][chan->output=1 0xa08efa7f 1 
0xa08a832
0]^M[gen=13 1 1 -11 2][Woot-11!][chan->output=1 0xa3dac000 2 0xa08a8320]
[gen=13 1 2 -11 2][Woot-11!][chan->output=1 0xa3dac000 51 0xa08a8320]
linux-2.6.11.2/drivers/video/kyro/STG4000Ramdac.c[gen=13 1 51 -11 2][Woot-11!]
[c
han->output=1 0xa3dac000 52 0xa08a8320]
linux-2.6.11.2/drivers/video/kyro/STG4000Ramdac.cl[gen=13 1 52 -11 2]
[Woot-11!][
chan->output=1 0xa3dac000 100 0xa08a8320]
linux-2.6.11.2/drivers/video/kyro/STG4000Ramdac.clinux-2.6.11.2/drivers/video/ky
ro/STG4000Ramdac.c[gen=13 1 100 -11 2][Woot-11!][chan->output=1 0xa3dac000 101 
0
xa08a8320]
linux-2.6.11.2/drivers/video/kyro/STG4000Ramdac.clinux-2.6.11.2/drivers/video/ky
ro/STG4000Ramdac.ci[gen=13 1 101 -11 2][Woot-11!][chan->output=1 0xa3dac000 
148
0xa08a8320]
--- snip ---

The logging added to write_chan looks like:
dprintf(crapfile,"[chan->output=%d %p %d %p]",chan->fd,buf,len,chan->data);

The logging lines added to generic_write are:
write(crapfile,buf,n);
dprintf(crapfile,"[gen=%d %d %d %d %d]",buf[0], fd,n,woo,errno);

(where "woo" is the return value of os_write_file).

Here's a translation of what's happening above:
[gen=108 1 46 46 2]: generic_write gets 46 bytes and manages to write 46
bytes to stdout.  Life is good.

[chan->output=1 0xa08efa7f 1 0xa08a8320]: The next call to write_chan wants
to write one byte (ctrl-M, you can see the mnemonic there from the cut and
paste, I was using less to view the output).  This gets passed on to 
generic_write.

[gen=13 1 1 -11 2]: Failure: the return from os_write_file in generic_write 
went "-EAGAIN", because the xterm it's writing to is suspended and the pipe 
is full.  (Actually I'm blasting out debug output to stdout too, and that 
debug printf filled up the output pipe and got truncated, so I can see in the 
other window that the pipe is indeed full.  The "Woot!" bit right after is 
another debug line I put it when the if(EAGAIN) test in write_chan trips, 
it's just printing out ret again.)

[chan->output=1 0xa3dac000 2 0xa08a8320]: The next call to write_chan
prints two bytes, which get passed to generic_write...

[gen=13 1 2 -11 2]: Printed right before this is a newline, so we can deduce
that an ascii 10 was probably added to the ascii 13, and less smoothed it 
over.  Note that the original data is still being resent on the retry, with 
the new data appended, so there's internal buffering upstream of us.  And in 
any case, the output buffer is still full, so it fails again.

[chan->output=1 0xa3dac000 51 0xa08a8320]: write_chan is now trying to write
51 bytes.  The generic_write instrumentation prints the snippet out right
after this (still starting with a newline, plus some tar -v output):

linux-2.6.11.2/drivers/video/kyro/STG4000Ramdac.c

[gen=13 1 51 -11 2]: Yeah, you tried 51 bytes and it's still -EAGAIN.

[chan->output=1 0xa3dac000 52 0xa08a8320]: Now trying to write 52 bytes...

linux-2.6.11.2/drivers/video/kyro/STG4000Ramdac.cl

[gen=13 1 52 -11 2]: What the?  There's an "l" at the end of that.  Why is
there an 'l' at the end of it?  The one extra byte should be a _newline_, not
an l.  (output buffer still full, it still fails, but the data being queued to 
us just hiccuped slightly.)

[chan->output=1 0xa3dac000 100 0xa08a8320]: We're now up to 100 bytes of 
output constipation being retried...

linux-2.6.11.2/drivers/video/kyro/STG4000Ramdac.clinux-2.6.11.2/drivers/video/ky
ro/STG4000Ramdac.c

[gen=13 1 100 -11 2]: And stuttering!  We have achieved stuttering!  This
isn't actually going out yet (the output buffer is still full, 0 bytes are
getting written each time), but the data that's backing up in the buffer is
the _WRONG_DATA_.  Whoever is queueing this crap to us is getting it wrong.  
Copies of the _existing buffer contents_ are being appended to the buffer, 
_not_ the new data that's supposed to be appended.  Somebody somewhere, 
upstream of this, is using the wrong pointer on a retry.

It goes on like this, until the buffer finally unblocks and dumps 4k of
stutter to the output.  (Data after 4k seems to be discarded or something.
Eventually the 4k buffer we're appending to fills up and it goes:

[chan->output=1 0xa3dac000 4095 0xa08a8320]
[gen=13 1 4095 -11 2]
[chan->output=1 0xa3dac000 4095 0xa08a8320]
[gen=13 1 4095 4051 2]
[chan->output=1 0xa3dacfd3 44 0xa08a8320]
[gen=118 1 44 44 2]

At which point we're back to normal until the next stutter.  But notice the
first three lines of that: either it's looping endlessly on retry, or data got
discarded.

Now the bit I'm currently blocked on is: Who is calling write_chan?  I've
tried to put a call to dump_stack() in there, but it just goes endlessly
recursive since dump_stack goes through printk, which gets us back here.
(Even putting in a global variable and a counter to make the recursive
calls not trigger dump stack doesn't help, it just hangs on the locking...)

Also, I have no idea what to do about more than 4k of data accumulating.  Is 
it getting discarded, is the upstream retry logic getting it right, should 
something be blocking at that point...?  (Yeah, having a write to the console 
block in D state would be icky, but in this case I think it's the right thing 
to have happen inside UML when the host filesystem isn't consuming your data 
fast enough...)

Any clues?  I can try tracing from the other end (down through a write syscall 
down into the guts of this thing) this weekend, but it'd be really nice to 
know where to look...

Rob


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
