Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BLVdy-00035c-Q6 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 05 May 2004 16:17:38 -0700
Received: from mail.gmx.net ([213.165.64.20])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1BLVdy-0004oX-7D for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 05 May 2004 16:17:38 -0700
Message-ID: <070c01c432f8$1a423000$2000000a@schlepptopp>
From: "roland" <for_spam@gmx.de>
References: <4098FC64.3000607@enterasys.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Re: [uml-user] LTT in UML ?
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
Date: Thu, 6 May 2004 01:24:23 +0200
To: David Bahi <dbahi@enterasys.com>
Cc: uml-user <user-mode-linux-user@lists.sourceforge.net>, user-mode-linux-devel@lists.sourceforge.net, info@opersys.com

wow! interesting piece of software! :)

on a first view, this project seems a little bit outdated - newspage stops at 17/10/2002.

what about asking the LTT people (post to LTT Mailinglist), if they would like to add support 
for "just another ARCH" (ARCH=um) in LTT ?

maybe thats not too hard to do for them. 

i`m no kernel hacker, but for me it looks like the biggest part of LTT is a kernel module and 
non-arch-dependent stuff. maybe i`m wrong - perhaps someone more experienced could take a look?
http://www.opersys.com/ftp/pub/LTT/TraceToolkit-0.9.5a.tgz -> 
TraceToolkit-0.9.5/Patches/patch-ltt-linux-2.4.16-vanilla-020415-1.14

probably, having an LTT option for the uml-kernel could give some benefit (performance optimization?)
for the uml project ?

regards
roland



----- Original Message ----- 
From: "David Bahi" <dbahi@enterasys.com>
To: <user-mode-linux-user@lists.sourceforge.net>
Sent: Wednesday, May 05, 2004 4:38 PM
Subject: [uml-user] LTT in UML ?


> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> i was wondering if some other talented soul has
> done this and would make the patches available?
> the only message in the archives related to this
> is (in 2001) here:
> 
> ~  http://marc.theaimsgroup.com/?l=user-mode-linux-user&m=99601814424122&w=2
> 
> and there's no reply....
> 
> the patches here http://www.opersys.com/LTT/ apply
> to many archs, including i386. but the arch/um differs
> significantly from arch/i386 so applying the changes
> isn't something i have great hope of doing successfully
> myself...
> 
> here's a blurb from the LTT site:
> 
> ~    The following are some of LTT's main features:
> 
> ~        * Linux kernel tracing capabilities with 48 unique trace points
> ~          <http://www.opersys.com/LTT/dox/trace-points.html>.
> ~        * Variable-length events minimizing overall trace size.
> ~        * Micro-second event time-stamps.
> ~        * Minimal performance overhead (< 2.5 %).
> ~        * Completely configurable trace option during kernel build.
> ~        * Multi-platform support: i386, PowerPC, S/390, SuperH, ARM, and MIPS.
> ~        * Fully-featured graphical user interface
> ~          <http://www.opersys.com/LTT/screenshots.html>
> ~          with event graph, system and per-process analysis, and raw event descriptions.
> ~        * Cross-platform trace reading capabilities.
> ~        * Single copy of traces between kernel-space and permanent storage.
> ~        * User-selectable and dynamically configurable event trace mask.
> ~        * Dynamic creation and logging of custom events both in kernel and in user space.
> ~        * Support for custom formatting of custom events.
> ~        * Dynamic probe integration with IBM's DProbes
> ~          <http://oss.software.ibm.com/developer/opensource/linux/projects/dprobes/>.
> ~        * Support for the Real-Time Application Interface
> ~          <http://www.aero.polimi.it/projects/rtai/> (aka RTAI).
> ~        * General hooking interface available within kernel trace facility.
> 
> ~    Many of these features hide many sub-features which contribute
> ~    to the completeness of the  toolset provided. We invite you to
> ~    read through the website and, if need be, ask questions on the
> ~    LTT mailing list.
> 
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.2.4 (MingW32)
> Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org
> 
> iD8DBQFAmPxk3XQ4zakZ3z4RAhFuAJ9gmTvPV7iEIdK8dVlMpydvM4P9RACeN+ki
> rVKGcIu2H9D6lW/EikInUvA=
> =57iq
> -----END PGP SIGNATURE-----
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by: Oracle 10g
> Get certified on the hottest thing ever to hit the market... Oracle 10g. 
> Take an Oracle 10g class now, and we'll give you the exam FREE. 
> http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
> _______________________________________________
> User-mode-linux-user mailing list
> User-mode-linux-user@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-user
> 


-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to 
deliver higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
