Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DG1Co-0004xT-Ot for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 28 Mar 2005 12:51:26 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1DG1Cm-0008BN-F6
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 28 Mar 2005 12:51:26 -0800
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] Hostfs permission checks are all wonky.
References: <200503201417.59739.rob@landley.net>
	<200503230109.06359.rob@landley.net>
	<200503241153.56262.blaisorblade@yahoo.it>
In-Reply-To: <200503241153.56262.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200503281448.22110.rob@landley.net>
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
Date: Mon, 28 Mar 2005 14:48:21 -0500
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Blaisorblade <blaisorblade@yahoo.it>

On Thursday 24 March 2005 05:53 am, Blaisorblade wrote:
> > You mean like this darn bug I've been seeing for weeks?
> >
> > io scheduler noop registered
> > loop: loaded (max 8 devices)
> > Initialized stdio console driver
> > Console initialized on /dev/tty0
> > VFS: Mounted root (hostfs filesystem).
> > idr_remove called for id=3 which is not allocated.
> > Call Trace:
> > a01fba48:  [<a007cbec>]
> > a01fba84:  [<a007cc13>]
> > a01fba9c:  [<a0085eaa>]
> > a01fbb04:  [<a0085697>]
> > a01fbb4c:  [<a00860a4>]
> > a01fbb68:  [<a007d09d>]
> > a01fbb74:  [<a004cc5e>]
> > a01fbb7c:  [<a004cdb6>]
> > a01fbb80:  [<a008e193>]
> > a01fbba8:  [<a004cd31>]
> > a01fbbc8:  [<a004526c>]
> > a01fbbe4:  [<a00451bf>]
> > a01fbc24:  [<a0045365>]
> > a01fbc38:  [<a0045445>]
> > a01fbc54:  [<a0011de9>]
> > a01fbcc0:  [<a0011e30>]
> > a01fbce4:  [<a0012d18>]
> > a01fbd14:  [<a0017887>]
> > a01fbd20:  [<a0097808>]
> >
> > sh-2.05b#
> >
> > It does that all the time.  (The id=? bit changes with each run.)
> > Somewhere around here I've got a trace from when I built it with debug
> > symbols, I can get that for you at the same time I try out your patch...
>
> I'd like that a lot, and also your .config - I've never seen that message
> nor I know the users of that kernel internal API (but probably UML itself
> isn't using that).

VFS: Mounted root (hostfs filesystem).
idr_remove called for id=1 which is not allocated.
Call Trace:
a086fa1c:  [<a00784c2>] sub_remove+0xe0/0xe9
a086fa58:  [<a00784ea>] idr_remove+0x1f/0x8b
a086fa74:  [<a007f1d0>] release_dev+0x64f/0x665
a086fae0:  [<a007e918>] init_dev+0x37e/0x472
a086fb28:  [<a007f3b7>] tty_open+0x1d1/0x300
a086fb38:  [<a00789cb>] kobject_get+0x14/0x1c
a086fb48:  [<a004d6bb>] cdev_get+0xb/0xe
a086fb54:  [<a004d830>] exact_lock+0xb/0x17
a086fb5c:  [<a0087911>] kobj_lookup+0x90/0xba
a086fb6c:  [<a004d81d>] exact_match+0x0/0x8
a086fb88:  [<a004d79c>] chrdev_open+0xcb/0xe8
a086fbac:  [<a0045b77>] dentry_open+0xa7/0x151
a086fbcc:  [<a0045acb>] filp_open+0x40/0x45
a086fc0c:  [<a0045c76>] get_unused_fd+0x55/0x9d
a086fc24:  [<a0045d5e>] sys_open+0x32/0x6c
a086fc44:  [<a0011f57>] execute_syscall_tt+0xd3/0xe0
a086fcb4:  [<a0011fa2>] syscall_handler_tt+0x3e/0x66
a086fcdc:  [<a0012e8f>] sig_handler_common_tt+0x93/0xe4
a086fd10:  [<a0017a48>] sig_handler+0x18/0x27
a086fd20:  [<a0091728>] __restore+0x0/0x8

sh-2.05b#

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
