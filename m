Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cjrjc-0001Ne-LY for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 29 Dec 2004 20:16:24 -0800
Received: from pike.sandelman.ca ([205.150.200.164])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41) id 1Cjrjb-0004yc-L9
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 29 Dec 2004 20:16:24 -0800
Subject: Re: [uml-devel] synchronous hostfs 
In-Reply-To: Message from Blaisorblade <blaisorblade@yahoo.it> of "Wed,
	29 Dec 2004 19:06:08 +0100." <200412291906.08122.blaisorblade@yahoo.it>
References: <27776.1104084973@marajade.sandelman.ottawa.on.ca>
	<200412291906.08122.blaisorblade@yahoo.it> 
Message-ID: <23369.1104380180@marajade.sandelman.ottawa.on.ca>
From: Michael Richardson <mcr@sandelman.ottawa.on.ca>
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
Date: Wed, 29 Dec 2004 23:16:20 -0500
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----


>>>>> "Blaisorblade" == Blaisorblade  <blaisorblade@yahoo.it> writes:
    >> I'm running 2.4.26-um3.  I happen to be running hostfs with NFS
    >> underneath.  I get core dumps from my application, and I want to
    >> gdb them outside of the UML.

    >> I had to switch from core dump to NFS (which seems to fail now)
    >> to putting them in /tmp (which is ramdisk), and then move them to
    >> /var/tmp, which is hostfs.

    Blaisorblade> Hmm - were you putting the core dumps inside a hostfs
    Blaisorblade> mount, right? This has been reported to fail badly

  Yes, previously.

    Blaisorblade> with 2.4.26-3um... the hostfs contained in 2.4.24-1um
    Blaisorblade> and 2.4.27-1bs (this tree is from me, on my homepage)
    Blaisorblade> is stable, while the one in 2.4.24-2um and subsequent
    Blaisorblade> releases isn't.

  I'll try it on my next compile.

    >> Is there some way to defeat the caching that is occuring?  or
    >> even to just flush it? (other than umount)

    Blaisorblade> Hmmm, I don't know this... probably giving "sync"
    Blaisorblade> inside UML should work.  I remember that Jeff said
    Blaisorblade> that he made hostfs asynchronous in those releases on
    Blaisorblade> purpose (for performance, IIRC), and this is not bad.

  I actually wonder if there is really any advantage.
  I'd like to be convinced.

  It seems that for executables, mapping hostfs files straight into the
guest address space wouldn't care. I'd have thought that for stdio
things, that any buffering done by guest kernel would be really just
wasted. glibc has already buffered pretty much everything...

  However, I'd like to be able to turn it off.

- -- 
]       ON HUMILITY: to err is human. To moo, bovine.           |  firewalls  [
]   Michael Richardson,    Xelerance Corporation, Ottawa, ON    |net architect[
] mcr@xelerance.com      http://www.sandelman.ottawa.on.ca/mcr/ |device driver[
] panic("Just another Debian GNU/Linux using, kernel hacking, security guy"); [
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Finger me for keys

iQCVAwUBQdOBE4qHRg3pndX9AQH1dgQA6/oZIVgXnHeGVzfe607Lm5+FRfne0Sw7
OuNd3+mgbEpZMxExMI1bMPv0mvDD7SCoHjy3Fn7nR61n5iOLeAOOxIIuPxvzmzsO
Hc1jh8NQQARsBrIqpJKW+5UO5Y7Vr0BE6V990QPa/Yhv0T4vSQOucP5IZfvV6yAN
Q8gwgs6zd34=
=9+kS
-----END PGP SIGNATURE-----


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
