Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CtXML-0003AX-KF for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 25 Jan 2005 12:32:21 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1CtXMK-0002BE-Uy
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 25 Jan 2005 12:32:21 -0800
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] SIGSEGV and SA_NODEFER
References: <200501182128.j0ILSgxi013966@ccure.user-mode-linux.org>
	<200501251230.04080.rob@landley.net>
	<200501252034.25668.blaisorblade@yahoo.it>
In-Reply-To: <200501252034.25668.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200501251430.26927.rob@landley.net>
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
Date: Tue, 25 Jan 2005 14:30:26 -0500
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Gerd Knorr <kraxel@bytesex.org>

On Tuesday 25 January 2005 02:34 pm, Blaisorblade wrote:
> > Once I get /dev on ramfs managed by udev?  Not really, no.  I need the
> > permissions to be right, but just about everything else should belong to
> > root.  (Yeah, there are a couple fun tricks where files change their
> > ownership to some variant of "nobody" to do chroot jails and stuff, but
> > they do that at runtime...)
>
> I don't expect chown to work at all - i.e. it's not "it forgets it at
> reboot", it's "it forgets it immediately"... If you see it working, maybe
> you are seeing the more precise behaviour "it forgets it As Soon as the
> file is closed".

Actually, I don't think I've tried to do a chown on UML at all.  As I said, 
the files I care about the ownership of being right (the /dev directory) are 
all in a ramfs.  Everything else should belong to root, I just care that the 
permissions are right.  (A user can set the suid bit on their own files, 
right?)

And what I meant to say earlier is that some programs chuser (like bind and 
httpd and such), which they do at runtime

Still, good point.  I'm doing a rebuild without UML and I'll run "find . -not 
-uid 0" on the result to see what comes up...

> > I've probably missed one or two instances, but I expect I can work around
> > 'em...
> >
> > > I'm not at all happy with this, but I don't want someone using hostfs
> > > over its possibilities. NFS is much better, anyway.
> >
> > NFS gives me hives
>
> ?? What's hives?

An NFS server can't be exposed to the internet securely.  (To add insult to 
injury, for _years_ Red Hat exposed portmap and such to the outside world and 
there was absolutely no way to tell it not to install/run that crud, and you 
had to go in by hand and rip them out of each new install if you wanted it on 
the net.)

NFS was designed to be a stateless protocol, yet the point of a filesystem is 
to maintain state.  It DIDN'T just do a TCP/IP connection to a client, 
instead it did weird UDP stuff so the server doesn't have to know which files 
the client has open and 8 gazillion other strange corner cases that I stopped 
trying to pay attention to more than 5 years ago.

I'm told the most recent version of NFS has been redesigned to work like 
Samba: a client that mounts one of these things opens a TCP/IP session, and 
if it gets closed the client re-opens it.  I should look into that, but the 
last time I did support for the new way of doing it it wasn't in the kernel 
yet.

> > > And somebody says it's also
> > > faster (and since hostfs does limited caching, it makes sense - hostfs
> > > must avoid having any inode cache, since it closes the host fd only
> > > when the inode is evicted from the cache; I don't think it's possible
> > > to cache data without an inode to link to, so it's clear it's slow).
> >
> > Since the host is cacheing the data for us, not having a redundant cache
> > sounds like a good idea to me.  Admittedly, it's more syscalls, but less
> > memory consumption...
>
> The problem is that its slower than NFS!

Okay, remember how my build process is designed to be packaged up, exported to 
some random Linux system out there, and run as a normal user without root 
access?  HostFS is exactly what I need.  Even assuming an NFS server is 
installed on the target system, a normal user can't run nfsd if it isn't 
already running on the system, and can't control what it exports if it is. 

Maybe I'll profile it and look at speeding it up later, but not anytime 
soon...

Rob


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
