Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Message-ID: <4113D92B.5040602@enterasys.com>
From: "D. Bahi" <dbahi@enterasys.com>
MIME-Version: 1.0
References: <410806FE.1000209@enterasys.com>
In-Reply-To: <410806FE.1000209@enterasys.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig4B6DD660DFBD01CB19E2608A"
Subject: [uml-devel] Re: Expedted SIGSTOP, got status = <blah> (UML 2.4.24-1um)
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
Date: Fri, 06 Aug 2004 15:16:59 -0400
To: user-mode-linux-devel@lists.sourceforge.net
Cc: user-mode-linux-user@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4B6DD660DFBD01CB19E2608A
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

ok - i have skas hosts - and i'm tired of this occasional hang.

BEGIN HACK ALERT -- i have 'can_do_skas()' return 1 -- END HACK ALERT

and now the kernel fails to pass control to init ? why ?
(run_init_process is called with /sbin/init - but it just hangs...)

any ideas?

D. Bahi wrote:

> seems like there is a race condition around this
> sometimes i get this printout - sometimes i don't
> and sometimes it's fine - gets worse with higher
> system load here's the console output:
> 
> Checking for the skas3 patch in the host...found
> Checking for /proc/mm...found
> CONFIG_HIGHMEM not enabled - physical memory shrunk to 499122176 bytes
> Kernel virtual memory size shrunk to 32505856 bytes
> capture_stack : Expected SIGSTOP, got status = 0x1c7f
> 
> best backtrace i could get:
> 
> #4  0xa000a2b0 in main (argc=12, argv=0xbfffdb24, envp=0xbfffdb58) at 
> arch/um/main.c:146
> #3  0xa009c2e2 in linux_main (argc=12, argv=0xbfffdb24) at um_arch.c:351
> #2  0xa0097124 in can_do_skas () at process.c:265
> #1  0xa0097028 in stop_ptraced_child (pid=32285, stack=0x40001000, 
> exitcode=1) at process.c:192
> #0  0xa000f387 in panic (fmt=0xa018db00 "check_ptrace : child exited 
> with status 0x%x") at panic.c:111
> 
> -- 
> db

-- 
There are two kinds of people in this world: Those that enter a room and 
turn the television set on, and those that enter a room and turn the 
television set off. -- Raymond Shaw, The Manchurian Candidate (1962).

--------------enig4B6DD660DFBD01CB19E2608A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (MingW32)

iD8DBQFBE9kr3XQ4zakZ3z4RArUHAJ4zrgulTwAqHDAHZNluCOL/vJmPkACfYmvF
ZdmIwlijhEtz43APFo/xtL4=
=R4FP
-----END PGP SIGNATURE-----

--------------enig4B6DD660DFBD01CB19E2608A--


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
