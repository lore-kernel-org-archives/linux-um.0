Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DE0cl-0003JR-7o for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 22 Mar 2005 23:49:55 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1DE0ck-0004xL-58
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 22 Mar 2005 23:49:54 -0800
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] Hostfs permission checks are all wonky.
References: <200503201417.59739.rob@landley.net>
	<200503222019.10709.blaisorblade@yahoo.it>
In-Reply-To: <200503222019.10709.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200503230109.06359.rob@landley.net>
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
Date: Wed, 23 Mar 2005 01:09:06 -0500
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Tuesday 22 March 2005 02:19 pm, Blaisorblade wrote:
> On Sunday 20 March 2005 20:17, Rob Landley wrote:
> > If I open a device like /dev/loop0 or /dev/console from a hostfs mount,
> > I'll get the UML device, not the host device, right?
>
> Obviously right.
>
> > So why are the permissions checks on hostfs devices done relative to the
> > _host_ user?
>
> What is the result from ls -l <that device>? Does it look readable for
> root?

Yes.

sh-2.05b# ls -l /dev/loop0
brw-rw----    1 root     disk       7,   0 Sep 15  2003 /dev/loop0
sh-2.05b#

A side effect of this is that I have to chown console to belong to the user 
running UML in order to run "./linux rootfstype=hostfs rw init=/bin/sh", 
because otherwise it can't open /dev/console to get the initial console.  
(This is with the stdio console.)  /dev/console has permissions 600.

> I'm not sure, however you could try the attached patch (there is also some
> whitespace cleanup, sorry), and if that does not work, then again I've not
> understood your scenario and you might answer the other questions in the
> email (I've first wrote the generic questions, then understood what is
> probably going on).
>
> Ok, I'm now seeing that UML uses access() (inside access_file()) to check
> permissions.
>
> See hostfs_permission -> access_file -> access. hostfs_permission (not
> access_file) should skip the "access_file" call in case its type is
> OS_TYPE_CHARDEV / OS_TYPE_BLOCKDEV / OS_TYPE_FIFO / OS_TYPE_SOCK.
>
> Look at init_inode() about how to see the file's type, but even better look
> at the cached information, i.e. inode->i_mode and the S_* access macro
> (look at init_special_inode about this).

Yeah, that'd do it.

I might not get to this tonight, but I'll try the patch tomorrow at the 
latest.

> > If /dev/console doesn't belong to the current user, the
> > system can't even open the initial console, despite the fact the output
> > does NOT go to TTY1 if I'm running it an xterm.
>
> /dev/console and /dev/tty1 are entirely different. If you open a getty
> on /dev/console, Ctrl-C won't work there.

I'm booting with init=/bin/sh (or a shellscript).  It opens /dev/console for 
me behind the scenes, I don't make any special arrangements.  You're right, 
ctrl-c doesn't work.  It would be nice if it did...

What I meant by not going to /dev/tty1 is that's where console output goes by 
default in the parent system, so if the thing were managing to write to the 
parent's /dev/console that's where all the output would wind up.  But it's 
not, it's going to stdout like it's supposed to.  Minus the wonky permissions 
check you noticed above...

> 1) Which version of UML are you using? If you are using the incrementals,
> they contain the hostfs rewrite which has all these problems... (with that,
> you can't even do a stat on a device you don't own, wrongly).

2.6.11 from kernel.org.

> 2) Which command line? I recall you run with hostfs as root fs, but I'm not
> really sure of this.

Try it, it's easy.

./linux rootfstype=hostfs rootflags=/ rw init=/bin/sh

If you run it from an xterm, that should work.  If you run it from an ssh 
session, it probably won't because of the permissions on /dev/console 
discussed above.

> 3) When you have hostfs as your root fs, there is some special code to
> handle this which may be reconsidered. I.e., when you have a file on the
> host owned by the user running UML, that is seen as owned by root inside
> UML. Actually it's not related to your current problem, but if ever you
> notice any bugs, please let us know.

You mean like this darn bug I've been seeing for weeks?

io scheduler noop registered
loop: loaded (max 8 devices)
Initialized stdio console driver
Console initialized on /dev/tty0
VFS: Mounted root (hostfs filesystem).
idr_remove called for id=3 which is not allocated.
Call Trace:
a01fba48:  [<a007cbec>]
a01fba84:  [<a007cc13>]
a01fba9c:  [<a0085eaa>]
a01fbb04:  [<a0085697>]
a01fbb4c:  [<a00860a4>]
a01fbb68:  [<a007d09d>]
a01fbb74:  [<a004cc5e>]
a01fbb7c:  [<a004cdb6>]
a01fbb80:  [<a008e193>]
a01fbba8:  [<a004cd31>]
a01fbbc8:  [<a004526c>]
a01fbbe4:  [<a00451bf>]
a01fbc24:  [<a0045365>]
a01fbc38:  [<a0045445>]
a01fbc54:  [<a0011de9>]
a01fbcc0:  [<a0011e30>]
a01fbce4:  [<a0012d18>]
a01fbd14:  [<a0017887>]
a01fbd20:  [<a0097808>]

sh-2.05b#

It does that all the time.  (The id=? bit changes with each run.)  Somewhere 
around here I've got a trace from when I built it with debug symbols, I can 
get that for you at the same time I try out your patch...

> > Similarly, if /dev/loop0 is chmod 600 and I run UML as a normal user and
> > try to do a mount -o loop, it says it can't find a loop device.
> >
> > Yet if I
> > run UML as root, it doesn't allocate one of the parent's loop devices,
> > UML does it internally...
> >
> > I'm told there's a major rewrite of hostfs underway.  Is it worth me
> > trying to patch the existing hostfs code, or should I go try to track
> > down the new stuff and try it out?
>
> Well, the "rewrite" (currently in the incrementals) is waiting for more
> urgent work since a lot of time (it was started by the 2.4.24-2um release),
> and it has a lot of problems right now. We are going to keep the old hostfs
> available for a lot...
>
> So you'd better go debugging the current code, IMHO (and even simply
> testing the patch); we will subsequently port those changes to the new
> code.

Cool.  Will do...

Rob


-------------------------------------------------------
This SF.net email is sponsored by: 2005 Windows Mobile Application Contest
Submit applications for Windows Mobile(tm)-based Pocket PCs or Smartphones
for the chance to win $25,000 and application distribution. Enter today at
http://ads.osdn.com/?ad_id=6882&alloc_id=15148&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
