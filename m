Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CtXf2-0004Cx-Im for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 25 Jan 2005 12:51:40 -0800
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CtXey-0007wY-RU for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 25 Jan 2005 12:51:40 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] SIGSEGV and SA_NODEFER
References: <200501182128.j0ILSgxi013966@ccure.user-mode-linux.org>
	<200501252034.25668.blaisorblade@yahoo.it>
	<200501251430.26927.rob@landley.net>
In-Reply-To: <200501251430.26927.rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501252150.56501.blaisorblade@yahoo.it>
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
Date: Tue, 25 Jan 2005 21:50:56 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Rob Landley <rob@landley.net>, Gerd Knorr <kraxel@bytesex.org>

On Tuesday 25 January 2005 20:30, Rob Landley wrote:
> On Tuesday 25 January 2005 02:34 pm, Blaisorblade wrote:
> > > Once I get /dev on ramfs managed by udev?  Not really, no.  I need the
> > > permissions to be right, but just about everything else should belong
> > > to root.  (Yeah, there are a couple fun tricks where files change their
> > > ownership to some variant of "nobody" to do chroot jails and stuff, but
> > > they do that at runtime...)

> > I don't expect chown to work at all - i.e. it's not "it forgets it at
> > reboot", it's "it forgets it immediately"... If you see it working, maybe
> > you are seeing the more precise behaviour "it forgets it As Soon as the
> > file is closed".

> Actually, I don't think I've tried to do a chown on UML at all.  As I said,
> the files I care about the ownership of being right (the /dev directory)
> are all in a ramfs.  Everything else should belong to root, I just care
> that the permissions are right.  (A user can set the suid bit on their own
> files, right?)
Theoretically yes... however, sadly, chmod 4777 /mnt/host/bin/dash works and 
is a suitable exploit... with other shells, it depends (bash refuses to work 
as setuid)...
> And what I meant to say earlier is that some programs chuser (like bind and
> httpd and such), which they do at runtime
You mean they call setuid() / setgid() or such, which should be ok... but you 
get 
> Still, good point.  I'm doing a rebuild without UML and I'll run "find .
> -not -uid 0" on the result to see what comes up...

> > > > I'm not at all happy with this, but I don't want someone using hostfs
> > > > over its possibilities. NFS is much better, anyway.
> > >
> > > NFS gives me hives
> >
> > ?? What's hives?
I've searched for it - is not "hive" the place for bees? I understand you mean 
something like "issues"...
> An NFS server can't be exposed to the internet securely.
Agreed... you cannot rely on root access on the host, otherwise what you would 
do likely is to add some firewall rules (and to ask it to listen on the "lo" 
interface only, if possible).

> (To add insult to 
> injury, for _years_ Red Hat exposed portmap and such to the outside world
> and there was absolutely no way to tell it not to install/run that crud,
> and you had to go in by hand and rip them out of each new install if you
> wanted it on the net.)

> NFS was designed to be a stateless protocol, yet the point of a filesystem
> is to maintain state.  It DIDN'T just do a TCP/IP connection to a client,
> instead it did weird UDP stuff so the server doesn't have to know which
> files the client has open and 8 gazillion other strange corner cases that I
> stopped trying to pay attention to more than 5 years ago.

> I'm told the most recent version of NFS has been redesigned to work like
> Samba: a client that mounts one of these things opens a TCP/IP session, and
> if it gets closed the client re-opens it.  I should look into that, but the
> last time I did support for the new way of doing it it wasn't in the kernel
> yet.
Well, IIRC NFS over TCP/IP exists and works also for NFSv3 (maybe 
EXPERIMENTAL, but it's included since some time, even in 2.4 I think, and 
probably is more reliable than hostfs). NFSv4 is the only real secure-thought 
protocol, and it's experimental like you say.

> > > > And somebody says it's also
> > > > faster (and since hostfs does limited caching, it makes sense -
> > > > hostfs must avoid having any inode cache, since it closes the host fd
> > > > only when the inode is evicted from the cache; I don't think it's
> > > > possible to cache data without an inode to link to, so it's clear
> > > > it's slow).

> > > Since the host is cacheing the data for us, not having a redundant
> > > cache sounds like a good idea to me.  Admittedly, it's more syscalls,
> > > but less memory consumption...
> >
> > The problem is that its slower than NFS!
>
> Okay, remember how my build process is designed to be packaged up, exported
> to some random Linux system out there, and run as a normal user without
> root access?  HostFS is exactly what I need.  Even assuming an NFS server
> is installed on the target system, a normal user can't run nfsd if it isn't
> already running on the system, and can't control what it exports if it is.
>
> Maybe I'll profile it and look at speeding it up later, but not anytime
> soon...
In that case, you could maybe see humfs ready (which is a hostfs with an added 
support for storing metadatas on the host filesystem). I guess it won't be 
before 2.6.13.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
