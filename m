Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DQcGk-0005Em-MX for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 26 Apr 2005 19:27:18 -0700
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1DQcGi-0007ZL-Ja
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 26 Apr 2005 19:27:18 -0700
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] The source to that firmware-uml thing is now up...
References: <200504200606.06828.rob@landley.net>
	<200504231457.19798.blaisorblade@yahoo.it>
In-Reply-To: <200504231457.19798.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200504262123.44365.rob@landley.net>
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
Date: Tue, 26 Apr 2005 21:23:44 -0400
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Saturday 23 April 2005 08:57 am, Blaisorblade wrote:

> > By the way, I've toyed with the idea of running this sucker in an
> > otherwise empty chroot environment (/proc/self/fd is likely to exist and
> > have fairly uninteresting contents.  As a chroot environment, it just has
> > symlinks that point to nothing), but to chroot the UML kernel process
> > from inside the initramfs, I need to come up with a new syscall.
>
> Ok, I now understand... chrooting it on the host!

Yup.

> > Can't do it before
> > running the UML kernel because A) it needs to make its memory file, 2) it
> > needs to access /proc/self/exe, III) it needs to loopback mount its
> > executable file to pull the trick I just did.
>
> Not sure about this... you'll need to be root anyway to chroot, so you can
> also (bind)mount what you need inside the chroot and unmount it later.

Hmmm.  You're right, that's sucks.

I've also been thinking about some kind of wrapper that would be root, set up 
the environment, and run UML as a non-priviledged child process.  Working out 
the details is a bit tough, though...

> You 
> still need to ask UML to do this, yes, but it's different (also you could
> even provide a simple module to load to do this, if the other ideas are
> rejected at any level).

Hmmm...  I suppose I could always have a wrapper script that runs UML as a 
non-root process in the chroot environment and opens a named pipe that we can 
write into via hostfs when we want the chroot environment depopulated.  (I 
vaguely recall there's a way to tell UML where to drop its memory file...)

Better not to modify UML at all, if possible...

Rob


-------------------------------------------------------
SF.Net email is sponsored by: Tell us your software development plans!
Take this survey and enter to win a one-year sub to SourceForge.net
Plus IDC's 2005 look-ahead and a copy of this survey
Click here to start!  http://www.idcswdc.com/cgi-bin/survey?id=105hix
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
