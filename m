Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DXkng-0003xv-4a	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 16 May 2005 11:58:48 -0700
Received: from www.tuxrocks.com ([64.62.190.123] helo=tuxrocks.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)	id 1DXkne-0004Rl-II
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 16 May 2005 11:58:48 -0700
Message-ID: <4288ED62.8070007@tuxrocks.com>
From: Frank Sorenson <frank@tuxrocks.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] Uploaded new version of the test program and x86-64
 SKAS patch working with it
References: <200505162020.19993.blaisorblade@yahoo.it>
In-Reply-To: <200505162020.19993.blaisorblade@yahoo.it>
Content-Type: text/plain; charset=ISO-8859-1
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
Date: Mon, 16 May 2005 12:58:42 -0600
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Blaisorblade wrote:
> First: the new SKAS patch does not yet support UML. However, it should support 
> both modes for the test program. Jeff, I guess you might want to take a look 
> at it (I'm working on this too).

Blaisorblade,

Thanks for working on the SKAS patch.

Question.  Are you saying that skas-2.6.12-rc4-v9-pre4 doesn't work yet,
or just doesn't work on x86-64?  For x86, should we stick with -pre2 for
now, or should -pre4 be stable?

Thanks,

Frank
- --
Frank Sorenson - KD7TZK
Systems Manager, Computer Science Department
Brigham Young University
frank@tuxrocks.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCiO1iaI0dwg4A47wRAp8vAKDoSSl1a2S8Q016FF457SXljmUangCdGnYG
a+CyEc/y24DXqTkXz5H/jRk=
=XPw4
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
