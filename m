Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Message-ID: <41140ABD.7020806@enterasys.com>
From: "D. Bahi" <dbahi@enterasys.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] Re: Expedted SIGSTOP,
	got status = <blah> (UML 2.4.24-1um)
References: <410806FE.1000209@enterasys.com> <4113D92B.5040602@enterasys.com>
	<200408062246.i76Mk9QW004489@ccure.user-mode-linux.org>
In-Reply-To: <200408062246.i76Mk9QW004489@ccure.user-mode-linux.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC5F617C9E79F2F87D6963EBF"
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
Date: Fri, 06 Aug 2004 18:48:29 -0400
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC5F617C9E79F2F87D6963EBF
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

reboot-signals is only listed in the 2.6 series patches;
i didn't think to try it.

hey, THANKS! _it applies_ and almost solves the problem completely!!!

of my 20 simultaneous UMLs only one failed to launch:

    Checking for the skas3 patch in the host...found

is all it does - and it just sits there....

also on reboot - do you expect the deactivate_all_fds to fail?

umount: /dev: device is busy
Please stand by while rebooting the system.
Restarting system.

deactivate_all_fds failed, errno = 9
Checking for the skas3 patch in the host...found
Checking for /proc/mm...found


Jeff Dike wrote:

> dbahi@enterasys.com said:
> 
>>ok - i have skas hosts - and i'm tired of this occasional hang. 
> 
> 
> Have you tried the reboot-signals patch?
> 
> 				Jeff
> 

-- 
There are two kinds of people in this world: Those that enter a room and 
turn the television set on, and those that enter a room and turn the 
television set off. -- Raymond Shaw, The Manchurian Candidate (1962).

--------------enigC5F617C9E79F2F87D6963EBF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (MingW32)

iD8DBQFBFAq93XQ4zakZ3z4RAr4HAJ4wKgR9kboD5b5cOZGrw9K2vleRNACfTGQE
T24bpzsvW+YlqRZsVPGkd50=
=xc3Q
-----END PGP SIGNATURE-----

--------------enigC5F617C9E79F2F87D6963EBF--


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
