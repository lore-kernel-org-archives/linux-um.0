Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DgQbq-0004Xk-Ct	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 09 Jun 2005 10:14:26 -0700
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1DgQbk-0008BQ-1k	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 09 Jun 2005 10:14:25 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] 2.6.12-rc6-mm1 patches testing
References: <1118280325.10107.124.camel@localhost>
	<1118334683.10190.66.camel@localhost> <1118336009.10190.74.camel@localhost>
In-Reply-To: <1118336009.10190.74.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506091917.48234.blaisorblade@yahoo.it>
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
Date: Thu, 9 Jun 2005 19:17:48 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: antoine <antoine@nagafix.co.uk>

On Thursday 09 June 2005 18:53, antoine wrote:
> On Thu, 2005-06-09 at 17:31 +0100, antoine wrote:
> > > > Now, if someone could have a look at hppfs I could resurect my
> > > > honeypots.
> > >
> > > I've not the time, however test the attached patches. The first one
> > > fixes the basical bugs; the second one could be needed to fix a fd
> > > leak... but I don't think it's needed at all, so test with only the
> > > first and let me know if the 2nd is needed, or if there are any
> > > problems (in that case, a ready-to-use hppfs configuration +
> > > explaination would be happily accepted, I've really little time now).
> >
> > Works fine with just the first patch. Thank you very much!
>
> Small correction: local file override works fine (files in the host's
> fake proc appear in the guest's /proc)
That is allowed, too? The daemon uses normal files only to forcibly "remove" 
entries, while it uses sockets for the rest.
> but I can't get the honeypot.pl 
> script to interact with it.
Ok, let's see... that script supplies the needed values and uses the libraries 
in separate perl modules...
> So for now, I'll have to hardcode all the values I want to hide and hope
> that no software is going to rely on them.

> I've used the one that was previously working:
This is based on the one from the uml_utilities tarball.

Have you tested that his libraries are found / that the script works with a 
2.4 UML, first?

Also, have you tested if it's the chroot and/or SELinux interacting? The 
daemon communicates through a Unix domain socket when host contents are 
supplied ... the base path is $ARGV[0], i.e. the first parameter...

> #
> # Copyright (C) 2002, 2003 Jeff Dike (jdike@karaya.com)
> # Licensed under the GPL
> #
>
> use hppfs;
> use hppfslib;
> use strict;
>
> my $dir;
>
> @ARGV and $dir = $ARGV[0];
>
> my $hppfs = hppfs->new($dir);
>
> my $remove_filesystems = remove_lines("hppfs", "hostfs");
> my $remove_mtd_nbd_ubd = remove_lines("mtd", "nbd", "ubd");
>
> # Need to be able to add directories, i.e. driver, bus/pci
> # partitions needs work
> # slabinfo if UML ever uses the slab cache for anything
>
> $hppfs->add("dma" => proc("dma"),
>             "devices" => remove_lines("ubd"),
>             "exitcode" => "remove",
>             "diskstats" => "remove",
>             "devices" => $remove_mtd_nbd_ubd,
>             "filesystems" => $remove_filesystems,
>             "interrupts" => "remove",
>             "iomem" => proc("iomem"),
>             "mm" => "remove",
>             "ioports" => proc("ioports"),
>             "kcore" => "remove",
>             "mounts" => $remove_filesystems,
>             "misc" => "remove",
>             "pid/mounts" => $remove_filesystems,
>             "partitions" => "remove",
>             "stat" => proc("stat"),
>             "uptime" => proc("uptime"),
>             dup_proc_dir("bus", $dir) );
>
> $hppfs->handler();


-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
