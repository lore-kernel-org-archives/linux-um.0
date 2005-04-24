Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DPqPY-00010P-Hg for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 24 Apr 2005 16:21:12 -0700
Received: from marasystems.com ([83.241.133.2] helo=filer.marasystems.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DPqPW-0005Tp-N3 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 24 Apr 2005 16:21:12 -0700
From: Henrik Nordstrom <uml@hno.marasystems.com>
Subject: Re: [uml-devel] The source to that firmware-uml thing is now up...
In-Reply-To: <200504200606.06828.rob@landley.net>
Message-ID: <Pine.LNX.4.61.0504250115250.28792@filer.marasystems.com>
References: <200504200606.06828.rob@landley.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
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
Date: Mon, 25 Apr 2005 01:20:54 +0200 (CEST)
To: Rob Landley <rob@landley.net>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Wed, 20 Apr 2005, Rob Landley wrote:

> By the way, I've toyed with the idea of running this sucker in an otherwise
> empty chroot environment (/proc/self/fd is likely to exist and have fairly
> uninteresting contents.  As a chroot environment, it just has symlinks that
> point to nothing), but to chroot the UML kernel process from inside the
> initramfs, I need to come up with a new syscall.

Not neccesarily. All you need is a way of making the UML execute the 
chroot syscall. This can be easily be done by loading a module, or even 
linking a dummy object file with just a kernel init function making the 
chroot call if it is not sensitive when in the kernel boot process this 
takes place.

> Can't do it before running the UML kernel because A) it needs to make 
> its memory file, 2) it needs to access /proc/self/exe, III) it needs to 
> loopback mount its executable file to pull the trick I just did.

Ok, then the module approach is the simplest.

> Does a new "chroot UML" syscall sound like a worthwhile idea?

IMHO a syscall is overkill for this.

Regards
Henrik



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
