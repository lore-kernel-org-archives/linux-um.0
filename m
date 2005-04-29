Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DRDR8-0001Op-H9	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 28 Apr 2005 11:08:30 -0700
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1DRDR6-0004Wi-S6	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 28 Apr 2005 11:08:30 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] The source to that firmware-uml thing is now up...
References: <200504200606.06828.rob@landley.net>
	<200504231457.19798.blaisorblade@yahoo.it>
	<200504262123.44365.rob@landley.net>
In-Reply-To: <200504262123.44365.rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504292116.30483.blaisorblade@yahoo.it>
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
Date: Fri, 29 Apr 2005 21:16:29 +0200
To: Rob Landley <rob@landley.net>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Wednesday 27 April 2005 03:23, Rob Landley wrote:
> On Saturday 23 April 2005 08:57 am, Blaisorblade wrote:

> > > Can't do it before
> > > running the UML kernel because A) it needs to make its memory file, 2)
> > > it needs to access /proc/self/exe, III) it needs to loopback mount its
> > > executable file to pull the trick I just did.
> >
> > Not sure about this... you'll need to be root anyway to chroot, so you
> > can also (bind)mount what you need inside the chroot and unmount it
> > later.

> Hmmm.  You're right, that's sucks.

> I've also been thinking about some kind of wrapper that would be root, set
> up the environment, and run UML as a non-priviledged child process. 
> Working out the details is a bit tough, though...
>
> > You
> > still need to ask UML to do this, yes, but it's different (also you could
> > even provide a simple module to load to do this, if the other ideas are
> > rejected at any level).
>
> Hmmm...  I suppose I could always have a wrapper script
which can't be setuid if in bash, could if in Perl and perlsuid is installed.
> that runs UML as a 
> non-root process in the chroot environment and opens a named pipe that we
> can write into via hostfs when we want the chroot environment depopulated. 

No, that must be a regular file... Linux does not pass requests to work on 
device nodes, named pipes, sockets down to the filesystem, so none of them 
can pass datas between the machines. You'd need a real IP socket (TCP/UDP),, 
or maybe something mconsole-based.

You can pass the location through a normal assignment on the cmd.line (which 
will become a env.var, or you might parse /proc/cmdline).
> (I vaguely recall there's a way to tell UML where to drop its memory
> file...)
Setting TMPDIR.
> Better not to modify UML at all, if possible...
>
> Rob

-- 
Paolo Giarrusso, aka Blaisorblade
Skype user "PaoloGiarrusso"
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade




-------------------------------------------------------
SF.Net email is sponsored by: Tell us your software development plans!
Take this survey and enter to win a one-year sub to SourceForge.net
Plus IDC's 2005 look-ahead and a copy of this survey
Click here to start!  http://www.idcswdc.com/cgi-bin/survey?id=105hix
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
