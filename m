Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EgX0v-0001Ox-Dv for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 27 Nov 2005 16:37:01 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1EgX0v-0001qz-0e
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 27 Nov 2005 16:37:01 -0800
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] When /tmp is not tmpfs.
References: <200511240611.02613.rob@landley.net>
	<200511271837.14625.blaisorblade@yahoo.it>
	<873bli7xbp.fsf@amaterasu.srvr.nix>
In-Reply-To: <873bli7xbp.fsf@amaterasu.srvr.nix>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511271521.34771.rob@landley.net>
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
Date: Sun, 27 Nov 2005 15:21:34 -0600
To: Nix <nix@esperi.org.uk>
Cc: Blaisorblade <blaisorblade@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net, Chris Lightfoot <chris@ex-parrot.com>

On Sunday 27 November 2005 12:35, Nix wrote:
> On Sun, 27 Nov 2005, blaisorblade@yahoo.it whispered secretively:
> > It's not a file, it's a AF_UNIX socket bound there - and bind() fails if
> > the file exists. So it's a different story (I was puzzled by a missing
> > bind(O_EXCL), but I learned with trial there's no need).
>
> There's an (optional) abstract namespace for AF_UNIX sockets now. It's
> Linux-only, but UML isn't going to care about that :)

I dunno if that's any less susceptible to attack, but it's probably "the right 
thing" anyway...

> > Don't know for shared mounts...
>
> /etc/mtab assumes *one single* canonical filesystem view, so shared or
> private mounts or anything smacking of them will break it completely.
>
> (Indeed in my experience breathing heavily near it will break it
> completely...)

I once asked a couple of lute players what would put a lute out of tune.  
"Large flowers" and "brightly colored wallpaper" were the immediate answers.  
(Very delicate instrument your average lute; thin wood, lightly strung, so 
it's basically out of tune by the end of any given song...)

It came to mind thinking about the reliability of mtab, for some reason...

> >> Just symlink it to /proc/mounts and recognize
> >> that any tool that can't handle that is a buggy tool that needs to be
> >> fixed.
> >
> > No - the kernel doesn't allow storing the full set of infos which are
> > added by mount there. And frankly I don't want the kernel to do that.
>
> Why not? It should. Only root can call mount(), so there's no real
> danger that some attacker will stick megabytes of stuff in there.

And only the kernel really knows what's mounted.  Userspace can try to keep 
track, assuming every program that calls the mount or umount syscall (mount, 
autofs, nfsmount, smbmount) remembers to update /etc/mtab, agrees on how, 
never has a race condition with any other instance.  But kernel is still the 
ultimate authority here.  If the _kernel_ doesn't know something's mounted, 
then it's not mounted.  Period.

Rob
-- 
Steve Ballmer: Innovation!  Inigo Montoya: You keep using that word.
I do not think it means what you think it means.


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
