Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BDA0m-00069v-DV for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 12 Apr 2004 15:34:40 -0700
Received: from noxmail.sandelman.ottawa.on.ca ([205.150.200.166])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1BDA0l-0004yf-Kt
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 12 Apr 2004 15:34:39 -0700
Subject: Re: [uml-devel] A quick humfs HOWTO 
In-Reply-To: Message from Nuno Silva <nuno.silva@vgertech.com> 
	of "Thu, 08 Apr 2004 07:25:22 BST." <4074F052.20603@vgertech.com> 
References: <200404080207.i3827rbe009294@ccure.user-mode-linux.org>
	<4074F052.20603@vgertech.com> 
Message-ID: <7394.1081782300@marajade.sandelman.ottawa.on.ca>
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
Date: Mon, 12 Apr 2004 11:05:00 -0400
To: Nuno Silva <nuno.silva@vgertech.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----


>>>>> "Nuno" == Nuno Silva <nuno.silva@vgertech.com> writes:
    Nuno> In the meanwhile I'm thinking about this system and it seems
    Nuno> that this will eat lots of inodes because every file will be
    Nuno> present twice in the [host] filesystem with the metadata
    Nuno> version using only a few bytes. Also every "ls -la" (if it's
    Nuno> not cached) in UML will generate a read in the file's metafile
    Nuno> file (say this 3 times quickly! eheheh). With 1000 files in a
    Nuno> directory thats lot's of fopen()s.

  Yes, this concerned me too.

    Nuno> Wouldn't it be better to add support for a simple DB, like
    Nuno> sleepycat or CMU cyrus' project skiplist or even something
    Nuno> lighter? This way we can have only 2 files in the humfs
    Nuno> "root", the superblock and the metadataDB.

  Yes, we should the option of doing that, also of having a .db file
per directory. There should *ALSO* be a default. 
  If we can store the information on the plain host, then don't put any
metadata there. A directory should be able to say, "everything below is 
mode X" - this might also be useful for adding more detailed
restrictions.

    Nuno> This can save inodes and improve performance because you have
    Nuno> only one file that's indexed! :-)

    Nuno> The downsides: - - another linker requirement at build time; -
    Nuno> - can't inspect and/or easily modify permissions with
    Nuno> emacs. :-)

  Yes/no.
  If we do it right, the file can be created with "makemap" or some
such. Last I looked .db files have poor locking semantics.

  I'm trying to think about the situation where hostfs stuff is shared
by multiple UMLs. (For instance, I share all of /usr/share...)

- --
]       ON HUMILITY: to err is human. To moo, bovine.           |  firewalls  [
]   Michael Richardson,    Xelerance Corporation, Ottawa, ON    |net architect[
] mcr@xelerance.com      http://www.sandelman.ottawa.on.ca/mcr/ |device driver[
] panic("Just another Debian GNU/Linux using, kernel hacking, security guy"); [

  

  
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Finger me for keys

iQCVAwUBQHqwGoqHRg3pndX9AQFA1AQA0l52UOBFkCC3MvrnNLXBEXMs4gFsXmiq
B6WLaUWOayX7Z7zmscARbPmRyBdKXpjcSHjuTMPHwnoYmVVC6RGiBSNOHeUGEhfZ
4wHSwJwRFbhlM/KYTsTmmVRirGwROpVSAOrHJY+3SyQ8Z9vMLkxnucEe60nF05GS
STH551mEpAs=
=AYWh
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
