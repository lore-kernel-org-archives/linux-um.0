Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CtGcV-0001MG-LO for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 24 Jan 2005 18:39:55 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1CtGcU-0004UJ-TL
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 24 Jan 2005 18:39:55 -0800
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] SIGSEGV and SA_NODEFER
References: <200501182128.j0ILSgxi013966@ccure.user-mode-linux.org>
	<200501221134.44585.rob@landley.net>
	<200501242045.09164.blaisorblade@yahoo.it>
In-Reply-To: <200501242045.09164.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200501242038.06299.rob@landley.net>
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
Date: Mon, 24 Jan 2005 20:38:05 -0500
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Gerd Knorr <kraxel@bytesex.org>

On Monday 24 January 2005 02:45 pm, Blaisorblade wrote:
> On Saturday 22 January 2005 17:34, Rob Landley wrote:
> > On Friday 21 January 2005 02:58 pm, Blaisorblade wrote:
> > > That is -mm1, I've already looked at both... the patches listed below
> > > are minor fixes / improvements...
> > >
> > > The name of the 2.6.11-rc1-mm2 patch which probably fixed your issue
> > > is:
> > >
> > > uml-fix-a-stack-corruption-crash.patch
> >
> > I reverted that patch, rebuilt vmlinux, tried again, and it's happily
> > halfway through the binutils build as I type.  That fix doesn't seem to
> > be it. (Makes a certain amount of sense, since I wasn't seeing a crash, I
> > was seeing a hang.)
>
> Hmm, and so what is fixing your problem? It's difficult to tell in this
> case...

I know.

I can try a binary search, but the work week has returned, and with it the 
dreaded day job...

> > Another interesting point is that with -mm2 (patched or unpatched), I'm
> > seeing output hiccups when the system swaps.
>
> Host or guest? If it's the host system, then my idea about it (a locking
> problem) is a good explaination, but if it's the guest system to swap I
> haven't clear why it works (not investigated well yet, through).

The host system is swapping.  The guest is configured without swap support.

> > I'm
> > using stdin/stdout as the console.  (And even though you put it into raw
> > mode, I still can't ctrl-c out of the processs I'm running, either.)
>
> Does this happen in -bb4 too? Also, does it happen even if you use a xterm
> console?

I didn't see it in -bb4 (doesn't prove it didn't happen, but it's pretty 
noticeable in -rc1-mm2).  I haven't tried an xterm console yet.

By the way, just confirming: file I/O support is now compiled in all the time, 
right?  (I noticed that there's no longer a config option for them, but 
setting console to fd0/fd1 seems to be working.  Well, run as root anyway, 
there's some kind of permissions problem if I fire up hostfs as a normal user 
that makes the console refuse to open.  I'm off completely rewriting busybox 
mount now that UML revealed that --bind and --move mounts don't work with 
busybox mount if /proc/filesystems consists entirely of "nodev" filesystems, 
so it'll take me a bit to come back to thumping on this...)

> > Rob
>
> Well, am I right if I suppose the other version you tested (with success)
> is only 2.6.9-bb4, for this console issue?

I didn't see it on -bb4.  I could try again and stress the system a bit, but I 
suspect it wasn't there.

> There is a patch which was merged in 2.6.10-mm1 (IIRC), which changes
> heavily the I/O core... I'm CC:ing the author for more investigation.
>
> However, I'm not sure that patch is at fault... there is a locking problem
> which *could* maybe be responsible of this...; I actually wonder about why
> this locking problem has never shown up in reports or in testing (it
> exists, only it's a race condition)... there is a situation where it shows
> up with a side effect, indeed, so the problem exists...

Okay, a little about me.

I am the "linux on the desktop" nightmare scenario.  I buy cheap used hardware 
(currently using a thinkpad with 128 megs of ram which I got for $400), and 
then stress it way beyond its limits.

For example, I use Konqueror for my web browsing, which is very nice from a 
user perspective but has a couple of really HORRIBLE internal design issues 
to do with opening lots of windows/tabs at once.  (Which I do.)  It cycles 
through all the open windows/tabs for various things, swapping through memory 
round-robin.  Opening a new window has been known to make the VM sit there 
and swap for 30 seconds, so badly that the mouse cursor doesn't move at all.

Currently, konqueror only has 17 tabs open, in only one window, which is 
actually fairly light for me.  (I'm fairly certain konqueror pins memory 
somehow, and I know it never actually frees any until you exit the darn 
thing.)

On top of that, kmail is up.  I have over 10,000 threaded messages in the 
linux-kernel mailing list alone.  (I have to catch up soon and delete the 
excess, kmail used to corrupt its indexing if you deleted messages from a 
mbox folder with over about 20,000 of them.  And, of course, I have xmms up 
to play mp3's.)

Strangely enough, compiling software in a background window adds negligible 
load, it's all the desktop stuff I'm doing that makes it swap its brains out.

Back under the 2.4.4 kernel or so, it took me about 15 seconds to make the 
system swap so badly I could go to lunch and come back with it still frozen 
and swapping.  Now in the 2.6 series, the swap is _much_ better, it's never 
completely frozen for longer than about 45 seconds.

The early releases of XFree86 4.something had a bug where if an internal wait 
timed out the X server would exit back to text mode.  I used to hit that 
_daily_.

So if there are any weird latency bugs lurking where inserting a second or 
three delay somewhere causes something to hiccup, I bump into them as a 
matter of course. :)

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
