Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DRJa8-0008NU-8I	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 28 Apr 2005 17:42:12 -0700
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)	id 1DRJa4-0002A1-6A
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 28 Apr 2005 17:42:12 -0700
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] The source to that firmware-uml thing is now up...
References: <200504200606.06828.rob@landley.net>
	<200504262123.44365.rob@landley.net>
	<200504292116.30483.blaisorblade@yahoo.it>
In-Reply-To: <200504292116.30483.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200504281938.45043.rob@landley.net>
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
Date: Thu, 28 Apr 2005 19:38:44 -0400
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Friday 29 April 2005 03:16 pm, Blaisorblade wrote:

> > Hmmm...  I suppose I could always have a wrapper script
>
> which can't be setuid if in bash, could if in Perl and perlsuid is
> installed.

Actually you can run bash setuid with the -p option.  From bash's "flags.c":

/* Non-zero means that this shell is running in `privileged' mode.  This
   is required if the shell is to run setuid.  If the `-p' option is
   not supplied at startup, and the real and effective uids or gids
   differ, disable_priv_mode is called to relinquish setuid status. */
int privileged_mode = 0;

(That said, if you do use -p to get get a setuid bash, there's several other 
things you should do to make this marginally less dangerous.  And I wouldn't 
trust myself to remember them all off the top of my head...)

That said, I wasn't thinking of using bash for the wrapper but either python 
or C.  It's just easier to secure them...

> > that runs UML as a
> > non-root process in the chroot environment and opens a named pipe that we
> > can write into via hostfs when we want the chroot environment
> > depopulated.
>
> No, that must be a regular file... Linux does not pass requests to work on
> device nodes, named pipes, sockets down to the filesystem, so none of them
> can pass datas between the machines. You'd need a real IP socket
> (TCP/UDP),, or maybe something mconsole-based.

Okay, the disgusting way to do this:

Mount a ramfs somewhere.  CD into it, make subdirectories and bind mount in 
enough of the parent environment to run UML and open the memory file.  Run 
UML.  Have UML create a new file in the ramfs to signal when it's up enough 
that the host filesystem can go away.  The parent program detects the file's 
creation, unmounts all the directories, deletes the empty directories, 
remounts the ramfs read-only, and then does a lazy unmount of the ramfs.

I can come up with a _more_ disgusting way to do this if necessary. :)

> You can pass the location through a normal assignment on the cmd.line
> (which will become a env.var, or you might parse /proc/cmdline).

Creating a temporary file in the ramfs is good enough...

> > (I vaguely recall there's a way to tell UML where to drop its memory
> > file...)
>
> Setting TMPDIR.

Cool.

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
