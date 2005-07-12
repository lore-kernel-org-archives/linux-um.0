Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DsDK3-0004HK-Ut	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 11 Jul 2005 22:28:47 -0700
Received: from rproxy.gmail.com ([64.233.170.205])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.44)
	id 1DsDK2-0004A1-QC	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 11 Jul 2005 22:28:48 -0700
Received: by rproxy.gmail.com with SMTP id z35so955049rne
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 11 Jul 2005 22:28:45 -0700 (PDT)
Message-ID: <42D3549D.50308@gmail.com>
From: Victor Condino <un1tz3r0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] host cpu frequency scaling and guest bogomips
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
Date: Tue, 12 Jul 2005 01:26:53 -0400
To: user-mode-linux-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

just noticed something interesting while testing out my gentoo/uml
root-fs generation script on my laptop. my l/t is an thinkpad T42p,
which has a p3 centrino with speedstep. i use cpufreqd to throttle the
cpu when not on ac between 600 and 1800MHz based on load. what i noticed
is that when I fired up UML while the host's core frequency was at
600mhz, /proc/cpuinfo reported ~600 bogomips in the guest, but when i
put some load on the host and cpufreq stepped up the core frequency, UML
still reports ~600 bogomips. likewise, when I fired up UML while the
host was under load and it's core at 1200MHz, UML reports higher
bogomips, but then when the host drops back down to the lower core freq,
UML still reports the same higher bogomips.

Not that this actually affects anything I do or would affect most
people... just thought you guys might want to know =D

- - V. Condino

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFC01SbW5g8mX2/4TYRAjs0AKCKRXwTy6g/UK5w5ioA8WxpgcB/3QCfRZyj
H9HTVRNl0FzeqUiYRxwrTAg=
=VsPI
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP,
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
