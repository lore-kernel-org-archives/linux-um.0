Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Message-ID: <411232F4.5030007@enterasys.com>
From: "D. Bahi" <dbahi@enterasys.com>
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
	<200408031931.i73JVkvv003367@ccure.user-mode-linux.org>
	<yek3c33tk5o.fsf@audi.uk.cyberscience.com>
	<20040804153541.GA7237@ccure.user-mode-linux.org>
	<yekacxbrlvi.fsf@audi.uk.cyberscience.com>
	<200408041800.i74I0Nvv007667@ccure.user-mode-linux.org>
	<2b464bd94c.work@loxley.compton.nu>
	<200408042102.i74L2Pvv008609@ccure.user-mode-linux.org>
	<Pine.LNX.4.60.0408051026120.21344@hermes-1.csi.cam.ac.uk>
In-Reply-To: <Pine.LNX.4.60.0408051026120.21344@hermes-1.csi.cam.ac.uk>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig334BC408615A16DBCEA2CF3A"
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
Date: Thu, 05 Aug 2004 09:15:32 -0400
To: Nicholas Nethercote <njn25@cam.ac.uk>
Cc: Jeff Dike <jdike@addtoit.com>, Tom Hughes <thh@cyberscience.com>, user-mode-linux-devel@lists.sourceforge.net, valgrind-users@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig334BC408615A16DBCEA2CF3A
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

ok, great.

now where do i put this snippet - because it doesn't
belong in the file mentioned in the earliest post...
(or if it does - i don't see how). is there someone
willing to 'modernize' this patch for the clueless
user (me ;)

thanks very much.

Nicholas Nethercote wrote:

> On Wed, 4 Aug 2004, Jeff Dike wrote:
> 
>> It feels to me more like the valgrind thread runs a system call with no
>> perceptible effect, and there's this new thread all of a sudden which 
>> runs
>> happily in this address space because it can't tell that valgrind is 
>> there.
> 
> 
> To summarise:  you seem to be confident there won't be any problems, and 
> Tom's not so sure.  I'm not sure either, but the 
> threads/signals/syscalls stuff is the part of Valgrind I understand the 
> least.  I would say, just don't be shocked if you do this and weird 
> things start happening :)
> 
> N


--------------enig334BC408615A16DBCEA2CF3A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (MingW32)

iD8DBQFBEjL03XQ4zakZ3z4RAuzBAJoC4lLZBTpxXO5uFg9OfOsusaFMNgCfYI9N
YYxa6oIvDM+u06EA0GbQj+A=
=t5gG
-----END PGP SIGNATURE-----

--------------enig334BC408615A16DBCEA2CF3A--


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
