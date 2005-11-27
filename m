Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EgRNk-0000oU-3e for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 27 Nov 2005 10:36:12 -0800
Received: from 41-052.adsl.zetnet.co.uk
	([194.247.41.52] helo=mail.esperi.org.uk ident=user88658)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1EgRNg-0001mw-Ul
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 27 Nov 2005 10:36:12 -0800
Subject: Re: [uml-devel] When /tmp is not tmpfs.
References: <200511240611.02613.rob@landley.net>
	<87sltk9my7.fsf@amaterasu.srvr.nix>
	<200511260547.10683.rob@landley.net>
	<200511271837.14625.blaisorblade@yahoo.it>
From: Nix <nix@esperi.org.uk>
In-Reply-To: <200511271837.14625.blaisorblade@yahoo.it>
	(blaisorblade@yahoo.it's
	message of "Sun, 27 Nov 2005 18:37:13 +0100")
Message-ID: <873bli7xbp.fsf@amaterasu.srvr.nix>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
Date: Sun, 27 Nov 2005 18:35:54 +0000
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Rob Landley <rob@landley.net>, Chris Lightfoot <chris@ex-parrot.com>

On Sun, 27 Nov 2005, blaisorblade@yahoo.it whispered secretively:
> It's not a file, it's a AF_UNIX socket bound there - and bind() fails if the 
> file exists. So it's a different story (I was puzzled by a missing 
> bind(O_EXCL), but I learned with trial there's no need).

There's an (optional) abstract namespace for AF_UNIX sockets now. It's
Linux-only, but UML isn't going to care about that :)

>> > Oh. I do it all the time. I prefer not to work under the assumption that
>> > I'm more brilliant than thirty years of Unix hackers and spotted
>> > something none of them did, but so be it...
> 
> I recently realized that even the mktemp(1) utility works - it creates the 
> file and returns the pathname. I kept wondering "but what if an attacker 
> alters the file afterward", but I forgot the sticky bit - nobody else can 
> delete my file.

If that utility exists :( an *awful* lot of Linux systems don't have it,
and of course in the howling wilderness that is proprietary Unix, nobody
has it at all.

>> And the reason they duplicated /bin
>> and /sbin and /lib under /usr is that they ran out of space on the root
>> disk and had to leak the OS into the second disk pack which had previously
>> held all the user home directories.
> 
> Seen this argumentation for Hurd systems... However until LVM2
> (and-all-the-rest)-on-root works out of the box, I'll call anything else 
> crap.

That's one of the jobs of the initramfs :) and it's even kept up to date
for you with new versions of the tools whenever you rebuild the kernel.

>> I agree initrd is kinda pointless, but initramfs isn't.  The kernel guys
>> are moving towards initramfs being required someday.  These are still
>> nebulous future plans with no actual deadline, but they include moving to
>> dynamically assigned major/minor numbers (so you need something like udev
>> to
>> populate /dev),
> 
> Nice move to disable init=/bin/sh. Really. Next one is moving kdelibs into the 
> kernel?

Nah, AIUI the initramfs runs *first*; it's its job to parse those parts
of the kernel parameters. (I just hope it gets it right. A lot of initrd
scripts I've seen just ignore init=, leading to much pain later on.)

> Don't know for shared mounts...

/etc/mtab assumes *one single* canonical filesystem view, so shared or
private mounts or anything smacking of them will break it completely.

(Indeed in my experience breathing heavily near it will break it
completely...)

>> Just symlink it to /proc/mounts and recognize 
>> that any tool that can't handle that is a buggy tool that needs to be
>> fixed.
> 
> No - the kernel doesn't allow storing the full set of infos which are added by 
> mount there. And frankly I don't want the kernel to do that.

Why not? It should. Only root can call mount(), so there's no real
danger that some attacker will stick megabytes of stuff in there.

-- 
`Y'know, London's nice at this time of year. If you like your cities
 freezing cold and full of surly gits.' --- David Damerell



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
