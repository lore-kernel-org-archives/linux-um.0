Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CtaMs-0006Pz-6P for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 25 Jan 2005 15:45:06 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1CtaMq-0004fT-8P
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 25 Jan 2005 15:45:06 -0800
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] SIGSEGV and SA_NODEFER
References: <200501182128.j0ILSgxi013966@ccure.user-mode-linux.org>
	<200501251430.26927.rob@landley.net>
	<200501252150.56501.blaisorblade@yahoo.it>
In-Reply-To: <200501252150.56501.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200501251743.16020.rob@landley.net>
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
Date: Tue, 25 Jan 2005 17:43:16 -0500
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Gerd Knorr <kraxel@bytesex.org>

On Tuesday 25 January 2005 03:50 pm, Blaisorblade wrote:

> > Actually, I don't think I've tried to do a chown on UML at all.  As I
> > said, the files I care about the ownership of being right (the /dev
> > directory) are all in a ramfs.  Everything else should belong to root, I
> > just care that the permissions are right.  (A user can set the suid bit
> > on their own files, right?)
>
> Theoretically yes... however, sadly, chmod 4777 /mnt/host/bin/dash works
> and is a suitable exploit... with other shells, it depends (bash refuses to
> work as setuid)...

I was thinking more along the lines of installing the "su" binary and such 
correctly and having the permissions retained long enough to make the 
squashfs image out of it.

I'm not worried about security within the UML instance.  It's running as a 
normal user, and it's running a build script.  When the script exits, the VM 
exits.  It's not a server or anything, it's basically an runtime for a batch 
file.

> > And what I meant to say earlier is that some programs chuser (like bind
> > and httpd and such), which they do at runtime
>
> You mean they call setuid() / setgid() or such, which should be ok... but
> you get
>
> > Still, good point.  I'm doing a rebuild without UML and I'll run "find .
> > -not -uid 0" on the result to see what comes up...

Speaking of which, I did this and there wasn't anything that didn't belong to 
root.  (Okay, /proc and /dev/pts showed plenty of stuff, but that's because I 
forgot and left them mounted after the build.  And several group ids were 
nonzero in /dev, but I expected that...)

> > > > > I'm not at all happy with this, but I don't want someone using
> > > > > hostfs over its possibilities. NFS is much better, anyway.
> > > >
> > > > NFS gives me hives
> > >
> > > ?? What's hives?
>
> I've searched for it - is not "hive" the place for bees? I understand you
> mean something like "issues"...

American colloquialism.  "gives me hives" also means it makes you break out in 
a rash, and the meaning's wandered a bit towards "makes my skin crawl"...

> > An NFS server can't be exposed to the internet securely.
>
> Agreed... you cannot rely on root access on the host, otherwise what you
> would do likely is to add some firewall rules (and to ask it to listen on
> the "lo" interface only, if possible).

I could beat it into submission, but it's not worth the performance boost or 
the conceptual complexity.  One advantage of UML is that I have to build the 
linux kernel _anyway_, so it's not an extra package I need to include in the 
build process and make sure I keep up to date.  I'll happily milk that for 
all it's worth.

> > I'm told the most recent version of NFS has been redesigned to work like
> > Samba: a client that mounts one of these things opens a TCP/IP session,
> > and if it gets closed the client re-opens it.  I should look into that,
> > but the last time I did support for the new way of doing it it wasn't in
> > the kernel yet.
>
> Well, IIRC NFS over TCP/IP exists and works also for NFSv3 (maybe
> EXPERIMENTAL, but it's included since some time, even in 2.4 I think, and
> probably is more reliable than hostfs). NFSv4 is the only real
> secure-thought protocol, and it's experimental like you say.

I think v3 was the one I looked at, and it didn't do what I was looking for, 
and the NFS guys I talked to told me that how I _wanted_ it to work was 
pretty close to a description of NVSv4.

> > > The problem is that its slower than NFS!
> >
> > Okay, remember how my build process is designed to be packaged up,
> > exported to some random Linux system out there, and run as a normal user
> > without root access?  HostFS is exactly what I need.  Even assuming an
> > NFS server is installed on the target system, a normal user can't run
> > nfsd if it isn't already running on the system, and can't control what it
> > exports if it is.
> >
> > Maybe I'll profile it and look at speeding it up later, but not anytime
> > soon...
>
> In that case, you could maybe see humfs ready (which is a hostfs with an
> added support for storing metadatas on the host filesystem). I guess it
> won't be before 2.6.13.

Sounds like fun.  When you've got something for me to test, I'll be here. :)

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
