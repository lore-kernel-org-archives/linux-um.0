Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CtOea-0006tr-7P for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 25 Jan 2005 03:14:36 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1CtOeY-0001f0-Ka
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 25 Jan 2005 03:14:36 -0800
From: Rob Landley <rob@landley.net>
Subject: Re: Fwd: Re: [uml-devel] SIGSEGV and SA_NODEFER
References: <200501251115.01565.blaisorblade@yahoo.it>
In-Reply-To: <200501251115.01565.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200501250512.56761.rob@landley.net>
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
Date: Tue, 25 Jan 2005 05:12:56 -0500
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Tuesday 25 January 2005 05:15 am, Blaisorblade wrote:

> > > I'm using stdin/stdout as the console.  (And even though you put it
> > > into raw mode, I still can't ctrl-c out of the processs I'm running,
> > > either.)
>
> Hmm, ^C works perfectly fine for me.  Usually I work with a virtual
> serial line as console ("console=ttyS0 ssl0=fd:0,fd:1 con=pts"), works
> better than the uml console as applications don't expect the linux vt
> ioctls work on these devices ;)

Actually, if I thump on this one anytime soon I'll just make it _not_ go into 
raw mode, and let ctrl-c kill the UML vm.  Since I'm running running my 
script as init anyway, both have about the same effect.

(I should probably suppress the "panic: tried to kill init" if there's a clean 
way to do that, too...)

> I'm still at 2.6.10 + patches though, not yet at 2.6.11-rc2.
>
> > However, I'm not sure that patch is at fault... there is a locking
> > problem which *could* maybe be responsible of this...; I actually wonder
> > about why this locking problem has never shown up in reports or in
> > testing (it exists, only it's a race condition)... there is a situation
> > where it shows up with a side effect, indeed, so the problem exists...
>
> Heavy swapping (see other mail) and thus some stuff running _very_ slow
> might open such race windows wide enougth that one actually hits them.

Heh heh heh... :)

It's not actually a major slowdown that does it, though.  It's just the fairly 
standard half-second hiccup (well, standard for me) and then it blasts out 
all those repeats at once...

> The uml-terminal-cleanup patch doesn't touch how the uml terminal lines
> output (xterm, pty, ...) works, it's more the input side which has been
> reworked a bit, especially the console handling (console meaning the
> device the kernel sends the printk messages to, not the linux vt
> subsystem).

Dunno.  It's possible it happened under 2.6.9-bb4 and I just never saw it.  I 
have a to-do item to go back and check, but I also have work in four hours...

By the way, these aren't printk that's stuttering.  This is the output of my 
script, presumably going to /dev/console.

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
