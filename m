Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EiG0R-0001RI-NA for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 02 Dec 2005 10:51:39 -0800
Received: from main.gmane.org ([80.91.229.2] helo=ciao.gmane.org)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1EiG0R-0003kF-9k
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 02 Dec 2005 10:51:39 -0800
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1EiFzj-0003uy-Kv for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 02 Dec 2005 19:50:55 +0100
Received: from desk.marajade.sandelman.ca ([205.150.200.247])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 02 Dec 2005 19:50:55 +0100
Received: from mcr by desk.marajade.sandelman.ca with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 02 Dec 2005 19:50:55 +0100
From: Michael Richardson <mcr@sandelman.ottawa.on.ca>
Message-ID: <v0u0drbaqh.fsf@marajade.sandelman.ca>
References: <20051202001358.GA12204@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Subject: [uml-devel] Re: Stop the insanity
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
Date: Fri, 02 Dec 2005 13:43:50 -0500
To: user-mode-linux-devel@lists.sourceforge.net

--=-=-=


>>>>> "Jeff" == Jeff Dike <jdike@addtoit.com> writes:
    Jeff> I'm sending this mail out to everyone that I can find who has had
    Jeff> the UML stubs compiled in unexpected ways, resulting in crashing.

    Jeff> I'd like testing of the patch below on as many gcc versions as
    Jeff> possible.  I think this patch avoids the fundamental issue which is
    Jeff> behind this, namely gcc using the stack when we have just replaced
    Jeff> it, behind gcc's back.  The remapping and storage of the return

Linux version 2.6.15-rc3-gefe3e2df (mcr@marajade.sandelman.ca) (gcc version 3.3.5 (Debian 1:3.3.5-13)) #7 Fri Dec 2 13:42:13 EST 2005

boots and runs.

Thank you!


--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iQEVAwUAQ5CV6YCLcPvd0N1lAQLnqggAoekfTgi9i3GlamW0votuI2GAZ9d3KVxI
EBFsff9rZl9U+NHrRv7FUzEwcvuWdjuYVln96xWJ2H4ArD1WIX8GkWJvEqzlh2ZV
Vp8lH3hZ69/sMs4dtIe3MeiR7IAzbv8JY/Rpq2hML3xWwL+Mc1hirmHX2YC4dYeY
93RrJ2haz2GTXMltjrdOMU9t4pue7TTHF5ByhmUCaNc5n+j2F3FlWzt+CT6MxseL
2K7OjXhgC34O1jwlW9/QAITiLLCIY27/QeALxmqd0X6rFJ8c0hgYD8ot09sTqc9M
1D0j3pNx7Qd7XFBHJ/4ELTpRxJj54HUJOfqbGOhhv4Y7MZ+LM4UGDw==
=bu/K
-----END PGP SIGNATURE-----
--=-=-=--



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
