Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard.weinberger@gmail.com>) id 1VA4DC-0002IV-1f
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 15 Aug 2013 20:32:02 +0000
Received: from mail-ve0-f170.google.com ([209.85.128.170])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1VA4DA-0006lA-CS
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 15 Aug 2013 20:32:02 +0000
Received: by mail-ve0-f170.google.com with SMTP id 15so951808vea.29
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 15 Aug 2013 13:31:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20130815185910.GQ5918@redhat.com>
References: <20130809204355.GA10864@redhat.com>
	<20130814175911.GG10864@redhat.com>
	<CAFLxGvyNWbMiDjXREb8AbKHEyGvYBr4WhVAGsg6DfKYc8bfOjA@mail.gmail.com>
	<20130815175945.GO5918@redhat.com>
	<CAFLxGvzaJOtW-evuHvh9Ue+wcYO7BnoGg4dNWp7mYygo4t6gUg@mail.gmail.com>
	<20130815185910.GQ5918@redhat.com>
Date: Thu, 15 Aug 2013 22:31:54 +0200
Message-ID: <CAFLxGvyJ1EEjBVwXee=175YFBB=WOQg6VcCOBq5qHTG2nKg6Bw@mail.gmail.com>
From: richard -rw- weinberger <richard.weinberger@gmail.com>
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
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

On Thu, Aug 15, 2013 at 8:59 PM, Richard W.M. Jones <rjones@redhat.com> wrote:
> On Thu, Aug 15, 2013 at 08:41:53PM +0200, richard -rw- weinberger wrote:
>> Meant regarding fsync()...
>
> Ah right, see what you mean :-)
>
> It calls sync(2).  Then it opens each /dev/ubdX device and calls fsync
> on the file descriptor:
>
> https://github.com/libguestfs/libguestfs/blob/master/daemon/sync.c#L54
>
> The reason for this is a bit complicated, but has to do with write
> barriers.  I believe this has been fixed since then.
>
> https://github.com/libguestfs/libguestfs/commit/c0a3c9ce70b98171e737e49e6dccc4457963f2ec
>
> In any case, we're calling sync & fsync in the guest, and that ain't
> causing the host cache to be flushed.

Hmm, AFAIK a fsync() after sync() is pointless.

> It's pretty easy to show this with libguestfs:
>
> LIBGUESTFS_BACKEND=uml LIBGUESTFS_HV=~/d/linux-um/linux \
> time ./run ./fish/guestfish -N fs:ext2:1G -m /dev/sda1 fallocate64 /data 800M
> time sync
>
> The first command finishes in 8 seconds, with barely any disk
> activity.  The sync afterwards takes 9 seconds with the disk light on
> the whole time, while it actually writes the whole 800 MB of data.

I think you don't see the desired effect because UML does not open
the backing file with O_SYNC.
But you can tell UML to do so.
e.g. write ubdas=/foo instead of ubda=/foo.

See:
ubd<n><flags>=<filename>[(:|,)<filename2>]
    This is used to associate a device with a file in the underlying
    filesystem. When specifying two filenames, the first one is the
    COW name and the second is the backing file name. As separator you can
    use either a ':' or a ',': the first one allows writing things like;
        ubd0=~/Uml/root_cow:~/Uml/root_backing_file
    while with a ',' the shell would not expand the 2nd '~'.
    When using only one filename, UML will detect whether to treat it like
    a COW file or a backing file. To override this detection, add the 'd'
    flag:
        ubd0d=BackingFile
    Usually, there is a filesystem in the file, but
    that's not required. Swap devices containing swap files can be
    specified like this. Also, a file which doesn't contain a
    filesystem can have its contents read in the virtual
    machine by running 'dd' on the device. <n> must be in the range
    0 to 7. Appending an 'r' to the number will cause that device
    to be mounted read-only. For example ubd1r=./ext_fs. Appending
    an 's' will cause data to be written to disk on the host immediately.
    'c' will cause the device to be treated as being shared between multiple
    UMLs and file locking will be turned off - this is appropriate for a
    cluster filesystem and inappropriate at almost all other times.

Please let me know if that helps. :-)

-- 
Thanks,
//richard

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

