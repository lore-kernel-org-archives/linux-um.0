Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Colm3-0004Lf-7P for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 Jan 2005 08:55:11 -0800
Received: from pike.sandelman.ca ([205.150.200.164])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41) id 1Colm0-0002Sb-Eu
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 Jan 2005 08:55:11 -0800
Subject: Re: [uml-devel] How stable is hostfs (and UML in general)? 
In-Reply-To: Message from Blaisorblade <blaisorblade@yahoo.it> of "Wed,
	12 Jan 2005 00:23:05 +0100." <200501120023.05580.blaisorblade@yahoo.it>
References: <200501082106.38306.rob@landley.net>
	<200501110135.55716.rob@landley.net>
	<11049.1105479264@marajade.sandelman.ottawa.on.ca>
	<200501120023.05580.blaisorblade@yahoo.it> 
Message-ID: <23435.1105548900@marajade.sandelman.ottawa.on.ca>
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
Date: Wed, 12 Jan 2005 11:55:00 -0500
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Rob Landley <rob@landley.net>

-----BEGIN PGP SIGNED MESSAGE-----


>>>>> "Blaisorblade" == Blaisorblade  <blaisorblade@yahoo.it> writes:
    Rob> Chapter 5 of current variants of LFS uses the host system to
    Rob> create a toolchain you can chroot into and build the final
    Rob> system with.  Then in chapter 6, you build the final system in

    >> I think the use of chroot is a cop-out.

    Rob> This requires root access (as does creating device nodes,
    Rob> mounting /proc or loopback devices...  A rather large number of

    >> I use "fakeroot" to do all of that for embedded work that I do...

    Blaisorblade> What's this?

  A tool which LD_PRELOAD's a library that intercepts all calls that
require root, and "emulates" them.
  I.e. if a program does "chown(2)", it just remembers that this
occured, and when a stat() is made, it returns the "right" answer.  
  (so tar/mkjffs, etc. get the right answer)

  Used in debian a lot.
  http://packages.debian.org/testing/utils/fakeroot

    Blaisorblade> Yes, that's because it turns the console to raw mode (don't ask me why).
 
  Because, you'd like to have ^C get passed to the program being run
under the UML :-)

- -- 
] Michael Richardson          Xelerance Corporation, Ottawa, ON |  firewalls  [
] mcr @ xelerance.com           Now doing IPsec training, see   |net architect[
] http://www.sandelman.ca/mcr/    www.xelerance.com/training/   |device driver[
] panic("Just another Debian GNU/Linux using, kernel hacking, security guy"); [
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Finger me for keys

iQCVAwUBQeVWY4qHRg3pndX9AQEH/wQA1Hkp7/41q61Oh4razESw6WHAmLMiXseB
I8TGHI10/o55F8iqN0ePZHOzKFnOxw75/8J10RiPdTWWGnqn3wUh3Fx4LXyzG0Hy
/T/YWIErJwc8G7Y5aJrltehTHdtudEKei0Wei99EiCo65JPczSVBY8ZHFYae/wLR
2ueRvZlyZzs=
=VIrB
-----END PGP SIGNATURE-----


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
