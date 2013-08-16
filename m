Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <rjones@redhat.com>) id 1VAEsC-0007ht-I6
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 16 Aug 2013 07:55:04 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VAEs5-0005uI-Nv for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 16 Aug 2013 07:55:04 +0000
Date: Fri, 16 Aug 2013 08:54:47 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20130816075447.GR5918@redhat.com>
References: <20130809204355.GA10864@redhat.com>
	<20130814175911.GG10864@redhat.com>
	<CAFLxGvyNWbMiDjXREb8AbKHEyGvYBr4WhVAGsg6DfKYc8bfOjA@mail.gmail.com>
	<20130815175945.GO5918@redhat.com>
	<CAFLxGvzaJOtW-evuHvh9Ue+wcYO7BnoGg4dNWp7mYygo4t6gUg@mail.gmail.com>
	<20130815185910.GQ5918@redhat.com>
	<CAFLxGvyJ1EEjBVwXee=175YFBB=WOQg6VcCOBq5qHTG2nKg6Bw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAFLxGvyJ1EEjBVwXee=175YFBB=WOQg6VcCOBq5qHTG2nKg6Bw@mail.gmail.com>
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
Subject: Re: [uml-devel] Performance tests (was: Using UML in libguestfs)
To: richard -rw- weinberger <richard.weinberger@gmail.com>
Cc: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

On Thu, Aug 15, 2013 at 10:31:54PM +0200, richard -rw- weinberger wrote:
> On Thu, Aug 15, 2013 at 8:59 PM, Richard W.M. Jones <rjones@redhat.com> wrote:
> > On Thu, Aug 15, 2013 at 08:41:53PM +0200, richard -rw- weinberger wrote:
> >> Meant regarding fsync()...
> >
> > Ah right, see what you mean :-)
> >
> > It calls sync(2).  Then it opens each /dev/ubdX device and calls fsync
> > on the file descriptor:
> >
> > https://github.com/libguestfs/libguestfs/blob/master/daemon/sync.c#L54
> >
> > The reason for this is a bit complicated, but has to do with write
> > barriers.  I believe this has been fixed since then.
> >
> > https://github.com/libguestfs/libguestfs/commit/c0a3c9ce70b98171e737e49e6dccc4457963f2ec
> >
> > In any case, we're calling sync & fsync in the guest, and that ain't
> > causing the host cache to be flushed.
> 
> Hmm, AFAIK a fsync() after sync() is pointless.

That's definitely what you'd expect, but Linux was buggy until last
year: it only synched mounted filesystems, not devices in general.

This was fixed:

  commit a8c7176b6ded413d5044a00f1d05477b95a6d7ad
  Author: Jan Kara <jack@suse.cz>
  Date:   Tue Jul 3 16:45:32 2012 +0200

    vfs: Make sys_sync writeout also block device inodes

but in libguestfs we can't rely on people using a new enough kernel so
we do the safe thing.

> > It's pretty easy to show this with libguestfs:
> >
> > LIBGUESTFS_BACKEND=uml LIBGUESTFS_HV=~/d/linux-um/linux \
> > time ./run ./fish/guestfish -N fs:ext2:1G -m /dev/sda1 fallocate64 /data 800M
> > time sync
> >
> > The first command finishes in 8 seconds, with barely any disk
> > activity.  The sync afterwards takes 9 seconds with the disk light on
> > the whole time, while it actually writes the whole 800 MB of data.
> 
> I think you don't see the desired effect because UML does not open
> the backing file with O_SYNC.
> But you can tell UML to do so.
> e.g. write ubdas=/foo instead of ubda=/foo.

I didn't know about these flags.

I modified libguestfs to use the 's' flag, and reran the test above:

  UML (with O_SYNC):           598 seconds
  UML (unsafe):                  9 seconds
  UML + explicit host sync:     20 seconds
  KVM:                          20 seconds

However using O_SYNC is not the same as properly handling write
barriers.  UML is buggy in this respect because a user in the guest
who does 'sync' (and the sync returns to the prompt) wouldn't expect
that if the power failed immediately afterwards they would lose all
their data.  If they are using a journaled filesystem they'd also risk
unrecoverable data corruption during general usage.

KVM and LVM have both been here a few years ago and have fixed these
issues (mind you, KVM only does the right thing if you use the right
cache=... option).

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming blog: http://rwmj.wordpress.com
Fedora now supports 80 OCaml packages (the OPEN alternative to F#)

------------------------------------------------------------------------------
Get 100% visibility into Java/.NET code with AppDynamics Lite!
It's a free troubleshooting tool designed for production.
Get down to code-level detail for bottlenecks, with <2% overhead. 
Download for free and get started troubleshooting in minutes. 
http://pubads.g.doubleclick.net/gampad/clk?id=48897031&iu=/4140/ostg.clktrk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

