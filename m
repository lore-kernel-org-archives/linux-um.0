Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AYHNT-0003Tn-1Q
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 21 Dec 2003 20:09:07 -0800
Received: from mta9.adelphia.net ([68.168.78.199])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.24)
	id 1AYHNS-0000bL-Lh
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 21 Dec 2003 20:09:06 -0800
From: Matt Zimmerman <mdz@debian.org>
Subject: Re: [uml-devel] 2.4.22-[67] problems
Message-ID: <20031222040857.GV9354@alcor.net>
References: <20031220011323.GW18100@alcor.net> <20031220171450.GB10692@ccure.user-mode-linux.org> <20031221004742.GE9354@alcor.net> <200312211658.44353.blaisorblade_spam@yahoo.it> <20031221224001.GO9354@alcor.net> <20031221231638.GR9354@alcor.net> <200312220025.hBM0PlFI012918@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200312220025.hBM0PlFI012918@ccure.user-mode-linux.org>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Sun, 21 Dec 2003 20:08:57 -0800
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, 224431@bugs.debian.org, 224502@bugs.debian.org, debian-glibc@lists.debian.org

On Sun, Dec 21, 2003 at 07:25:47PM -0500, Jeff Dike wrote:

> mdz@debian.org said:
> > I have just verified this myself.  Building user-mode-linux
> > 2.4.22-7um-1 on woody works fine (even when running on unstable), but
> > building it on unstable does not.
> 
> Conversely, does a unstable-built UML run on woody?

The unstable-built UML is broken on woody as well.  So far, my most
reproducible test case so far (not 100%, but close) is to start up a netcat
listener, and connect to it with input from /dev/zero, i.e. just push a
bunch of data over a TCP connection.  What happens is this:

rootstrap:~# nc -v -l -p 1234 >/dev/null </dev/null &
[2] 138
rootstrap:~# listening on [any] 1234 ...

rootstrap:~# nc -v -v localhost 1234 </dev/zero
connect to [127.0.0.1] from localhost [127.0.0.1] 1028
localhost [127.0.0.1] 1234 (?) open
select fuxored : Function not implemented
too many output retries : Broken pipe
 sent 27820032, rcvd 0
[2]+  Exit 1                  nc -v -l -p 1234 >/dev/null </dev/null

The relevant netcat source code isn't doing anything unusual:

    rr = select (16, ding2, 0, 0, timer2);      /* here it is, kiddies */
    if (rr < 0) {
        if (errno != EINTR) {           /* might have gotten ^Zed, etc ?*/
          holler ("select fuxored");
          close (fd);
          return (1);
        }
    } /* select fuckup */

so select is returning ENOSYS, but, as can be seen from the transfer
statistics, it succeeds many times before it fails.

Some other times, a program will simply hang (sometimes even stalling the
boot process), or segfault.

> > The one built on unstable randomly sees ENOSYS from certain system
> > calls, such as select, read and mmap.
> 
> Only those, or are there others that you can tell are failing?  Offhand, I
> don't see any commonality between those three, in terms of their interactions
> with the host.

Those are the ones that I have been able to easily identify.

select came from the netcat test you see above.

mmap was evident from the APT HTTP method:

/usr/lib/apt/methods/http: error while loading shared libraries: libc.so.6: cannot map zero-fill pages: Error 38

(that error is from dl-load.c in glibc, and as far as I can tell indicates
that mmap gave ENOSYS).

basename from coreutils seemed to see write(2) failing:

basename: write error: Function not implemented

I also saw unlink do it, in dpkg:

dpkg: error processing /var/cache/apt/archives/debhelper_4.0.2_all.deb (--unpack):
failed to rmdir/unlink `/usr/share/man/man1/dh_compress.1.gz.dpkg-tmp': Function not implemented

apt occasionally blows up read()ing from a socket as well:

(none):~# apt-get update
Get:1 http://debian woody/main Packages [1774kB]
Err http://debian woody/main Packages
  Error reading from server - read (38 Function not implemented)
Get:2 http://debian woody/main Release [95B]
Fetched 95B in 0s (259B/s)
Failed to fetch http://debian/dists/woody/main/binary-i386/Packages  Error reading from server - read (38 Function not implemented)
Reading Package Lists... Done
Building Dependency Tree... Done
E: Some index files failed to download, they have been ignored, or old ones used instead.

> > I would appreciate any suggestions for how to track this problem down
> > further.
> 
> The randomness is strange.  It suggests that somehow interrupts are getting
> in the way.  One possibility would be host system calls returning ENOSYS
> instead of EINTR.  I don't see much possibility that that's what's actually
> happening, but that's the sort of thing I'd think about.

Can you think of any way that userland changes could produce that kind of
effect?  I don't think I would know where to look.  My kernel didn't change,
and the problem seems to occur on different host kernels.

I tried running UML under strace; this produces an impressive amount of
output, but made it much more difficult to reproduce the bug.  I finally got
it to happen under strace, and I have a 226M logfile (7M gzipped) from the
session, if you're interested in taking a look.  I've put it up at
http://people.debian.org/~mdz/temp/uml.strace.gz.  I don't see any host
system calls returning ENOSYS; the only failures are some very
innocuous-looking EINTRs and a few EAGAINs that looks like they're
associated with a terminal device.

-- 
 - mdz


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
