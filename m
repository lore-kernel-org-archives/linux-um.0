Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Message-ID: <4110373D.5010706@vgertech.com>
From: Nuno Silva <nuno.silva@vgertech.com>
MIME-Version: 1.0
Subject: Re: [Valgrind-users] Re: [uml-devel] Re: UML and valgrind
References: <C28780ABC637504896EB86B4FB75FFBFA26E5E@MAANDMBX1.ets.enterasys.com>
	<410EFCDB.8080404@enterasys.com>
	<200408030517.i735HZUE026250@ccure.user-mode-linux.org>
	<Pine.LNX.4.60.0408031028541.22157@hermes-1.csi.cam.ac.uk>
	<200408031450.i73EoEvv002040@ccure.user-mode-linux.org>
	<Pine.LNX.4.60.0408031527320.22157@hermes-1.csi.cam.ac.uk>
	<200408031750.i73HoMvv002966@ccure.user-mode-linux.org>
	<410FCC70.1050902@enterasys.com>
In-Reply-To: <410FCC70.1050902@enterasys.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
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
Date: Wed, 04 Aug 2004 02:09:17 +0100
To: "D. Bahi" <dbahi@enterasys.com>
Cc: Jeff Dike <jdike@addtoit.com>, Nicholas Nethercote <njn25@cam.ac.uk>, user-mode-linux-devel@lists.sourceforge.net, valgrind-users@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi!

D. Bahi wrote:
| fantastic! patch applied. results below.
|
| note that valgrind almost _requires_ dynamic
| linking - so I'll keep mem= below 750M, right?
|
| ugh, so close - it bails - stopped by clone() !?!!?? :

[..]

|
| ==2951== Reading syms from /lib/tls/libc-2.3.2.so (0x42000000)
| ==2951==    object doesn't have any debug info
| ==2951== TRANSLATE: 0x1B8E4C00 redirected to 0x52BFF040
| ==2951== TRANSLATE: 0x42073700 redirected to 0x1B903C90
| ==2951==
| ==2951== Valgrind detected that your program requires
| ==2951== the following unimplemented functionality:
| ==2951==    clone(): not supported by Valgrind.

[..]

You have a NPTL/TLS system. Maybe that's the problem. You could try to:

# mv /lib/tls /lib/tls.off

...and rerun that. Maybe it works better. :-)
Remember to move tls.off again to revert to tls-enabled glibc ;)

HTH,
Nuno Silva
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBEDc9OPig54MP17wRAvMQAKCfBLEKk4jMnDrZtFvfLMYQ9tJvHACfVKlF
fNIUgR/H6gDkE0/VsvUmQNc=
=HEXR
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
