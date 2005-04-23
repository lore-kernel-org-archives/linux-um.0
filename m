Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DPhqL-0002uO-RC for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 24 Apr 2005 07:12:17 -0700
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1DPhqL-0003wQ-3E for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 24 Apr 2005 07:12:17 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] The source to that firmware-uml thing is now up...
References: <200504200606.06828.rob@landley.net>
In-Reply-To: <200504200606.06828.rob@landley.net>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200504231457.19798.blaisorblade@yahoo.it>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
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
Date: Sat, 23 Apr 2005 14:57:19 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Rob Landley <rob@landley.net>

On Wednesday 20 April 2005 12:06, Rob Landley wrote:
> http://www.landley.net/code/firmware/notes.html
>
> It's a ~80 meg tarball (half of which is the gcc, binutils, and
> linux-2.6.11 source tarballs) on a friend's machine, so don't hit the poor
> server too hard.  I intend to move it to a faster connection after I get
> back from Penguicon...
>
> Yeah, I know the versions of most things are out of date, but the build
> worked when I ran it, and as a proof of concept it shows you what I did.
>
> By the way, I've toyed with the idea of running this sucker in an otherwise
> empty chroot environment (/proc/self/fd is likely to exist and have fairly
> uninteresting contents.  As a chroot environment, it just has symlinks that
> point to nothing), but to chroot the UML kernel process from inside the
> initramfs, I need to come up with a new syscall.
Ok, I now understand... chrooting it on the host!
> Can't do it before 
> running the UML kernel because A) it needs to make its memory file, 2) it
> needs to access /proc/self/exe, III) it needs to loopback mount its
> executable file to pull the trick I just did.
Not sure about this... you'll need to be root anyway to chroot, so you can 
also (bind)mount what you need inside the chroot and unmount it later. You 
still need to ask UML to do this, yes, but it's different (also you could 
even provide a simple module to load to do this, if the other ideas are 
rejected at any level).

> Does a new "chroot UML" syscall sound like a worthwhile idea?
A "chroot UML" thing would not be bad, but doing it as a syscall is not very 
Ok for me*... Better, do it with a /proc entry. Not exactly 
like /proc/sysemu, however - that was (initially) for testing only and it 
pollutes the namespace. However, I don't know a better place where to put it 
(no sysfs please, we don't want to learn kobjects for this :-) ).

Also, you can't read the value ("echo a > /proc/chroot; echo a > /proc/chroot" 
will be equivalent to "echo a/a > /proc/chroot", since you can't chroot 
*outside*; if you want that "echo a > /proc/chroot; echo > /proc/chroot" does 
not mean "chroot inside and then go back outside", that's the only possible 
interpretation).

A sysctl is not ok because it's supposed that the value it's "saved" in the 
entry, while this is not true.

Also, we already have /proc/umid and /proc/exitcode which act on the outside, 
so it would probably be ok.

* A syscall is not ok because the syscall table must match the i386 (and 
whatever arch) one; we can't add "local" entries as we may need to move their 
number to give place for new i386 syscalls. And asking all other archs to 
reserve a slot for a syscall on which at least somebody will seriously object 
won't work.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade





-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
