Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DEPz7-0001mX-Lq for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 24 Mar 2005 02:54:41 -0800
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1DEPz4-0003Pq-94 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 24 Mar 2005 02:54:41 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Hostfs permission checks are all wonky.
References: <200503201417.59739.rob@landley.net>
	<200503222019.10709.blaisorblade@yahoo.it>
	<200503230109.06359.rob@landley.net>
In-Reply-To: <200503230109.06359.rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503241153.56262.blaisorblade@yahoo.it>
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
Date: Thu, 24 Mar 2005 11:53:56 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Rob Landley <rob@landley.net>

On Wednesday 23 March 2005 07:09, Rob Landley wrote:
> On Tuesday 22 March 2005 02:19 pm, Blaisorblade wrote:
> > On Sunday 20 March 2005 20:17, Rob Landley wrote:


> A side effect of this is that I have to chown console to belong to the user
> running UML in order to run "./linux rootfstype=hostfs rw init=/bin/sh",
> because otherwise it can't open /dev/console to get the initial console.
> (This is with the stdio console.)  /dev/console has permissions 600.
>

> > > If /dev/console doesn't belong to the current user, the
> > > system can't even open the initial console, despite the fact the output
> > > does NOT go to TTY1 if I'm running it an xterm.
> >
> > /dev/console and /dev/tty1 are entirely different. If you open a getty
> > on /dev/console, Ctrl-C won't work there.
>
> I'm booting with init=/bin/sh (or a shellscript).  It opens /dev/console
> for me behind the scenes, I don't make any special arrangements.  You're
> right, ctrl-c doesn't work.  It would be nice if it did...
>
> What I meant by not going to /dev/tty1 is that's where console output goes
> by default in the parent system, so if the thing were managing to write to
> the parent's /dev/console that's where all the output would wind up.  But
> it's not, it's going to stdout like it's supposed to.  Minus the wonky
> permissions check you noticed above...
>
> > 1) Which version of UML are you using? If you are using the incrementals,
> > they contain the hostfs rewrite which has all these problems... (with
> > that, you can't even do a stat on a device you don't own, wrongly).
>
> 2.6.11 from kernel.org.
>
> > 2) Which command line? I recall you run with hostfs as root fs, but I'm
> > not really sure of this.
>
> Try it, it's easy.
>
> ./linux rootfstype=hostfs rootflags=/ rw init=/bin/sh
>
> If you run it from an xterm, that should work.  If you run it from an ssh
> session, it probably won't because of the permissions on /dev/console
> discussed above.
I'm not understanding the difference at the moment...

> You mean like this darn bug I've been seeing for weeks?

> io scheduler noop registered
> loop: loaded (max 8 devices)
> Initialized stdio console driver
> Console initialized on /dev/tty0
> VFS: Mounted root (hostfs filesystem).
> idr_remove called for id=3 which is not allocated.
> Call Trace:
> a01fba48:  [<a007cbec>]
> a01fba84:  [<a007cc13>]
> a01fba9c:  [<a0085eaa>]
> a01fbb04:  [<a0085697>]
> a01fbb4c:  [<a00860a4>]
> a01fbb68:  [<a007d09d>]
> a01fbb74:  [<a004cc5e>]
> a01fbb7c:  [<a004cdb6>]
> a01fbb80:  [<a008e193>]
> a01fbba8:  [<a004cd31>]
> a01fbbc8:  [<a004526c>]
> a01fbbe4:  [<a00451bf>]
> a01fbc24:  [<a0045365>]
> a01fbc38:  [<a0045445>]
> a01fbc54:  [<a0011de9>]
> a01fbcc0:  [<a0011e30>]
> a01fbce4:  [<a0012d18>]
> a01fbd14:  [<a0017887>]
> a01fbd20:  [<a0097808>]
>
> sh-2.05b#
>
> It does that all the time.  (The id=? bit changes with each run.) 
> Somewhere around here I've got a trace from when I built it with debug
> symbols, I can get that for you at the same time I try out your patch...
I'd like that a lot, and also your .config - I've never seen that message nor 
I know the users of that kernel internal API (but probably UML itself isn't 
using that).

-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade




-------------------------------------------------------
This SF.net email is sponsored by Microsoft Mobile & Embedded DevCon 2005
Attend MEDC 2005 May 9-12 in Vegas. Learn more about the latest Windows
Embedded(r) & Windows Mobile(tm) platforms, applications & content.  Register
by 3/29 & save $300 http://ads.osdn.com/?ad_id=6883&alloc_id=15149&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
