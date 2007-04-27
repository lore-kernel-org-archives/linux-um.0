Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HhSN5-0003ae-4O for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 27 Apr 2007 08:28:31 -0700
Received: from mail.nagafix.co.uk ([194.145.196.85])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HhSN4-0003tX-OK
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 27 Apr 2007 08:28:31 -0700
Message-ID: <46321695.3060206@nagafix.co.uk>
Date: Fri, 27 Apr 2007 16:28:21 +0100
From: Antoine Martin <antoine@nagafix.co.uk>
MIME-Version: 1.0
References: <462BACC9.7010303@nagafix.co.uk>
	<20070425204849.GA9505@c2.user-mode-linux.org>
	<462FC142.1010907@nagafix.co.uk>
	<200704261612.40356.blaisorblade@yahoo.it>
	<20070427151051.GB6019@c2.user-mode-linux.org>
	<463214E7.5080605@nagafix.co.uk>
In-Reply-To: <463214E7.5080605@nagafix.co.uk>
Subject: Re: [uml-devel] regression: pcap broken in 2.6.20.x
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Antoine Martin <antoine@nagafix.co.uk>
Cc: Jeff Dike <jdike@addtoit.com>, Blaisorblade <blaisorblade@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

>> The easiest way to work around this is to provide a MAC on the UML
>> command line.
> Except, pcap doesn't have the option.
> I am looking at pcap_user.c and pcap_kern.c trying to figure out where I
> can add parsing for that.
in: check_transport(struct transport *transport, char *eth, int n,
                           void **init_out, char **mac_out)

There is a:
	if(!transport->setup(eth, mac_out, *init_out)){


So I guess that I should be looking in pcap_setup(char *str, char
**mac_out, void *data) in pcap_kern.c?
To populate mac_out.
Right?
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGMhaVGK2zHPGK1rsRCmiTAJ96Pqxr/ioaDz5ngEfHU4EVHGCgYACfRS4M
iT62rIGq6yJ3LiOZOz6WtKM=
=Oxzw
-----END PGP SIGNATURE-----

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
