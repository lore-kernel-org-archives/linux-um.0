Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BBSye-0000O0-0B for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 07 Apr 2004 23:25:28 -0700
Received: from [82.154.82.56] (helo=puma-vgertech.no-ip.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BBSyc-0001jB-3P for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 07 Apr 2004 23:25:26 -0700
Received: from vgertech.com (localhost [127.0.0.1])
	by puma-vgertech.no-ip.com (Postfix) with ESMTP id D129E5B0080
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu,  8 Apr 2004 07:25:22 +0100 (WEST)
Message-ID: <4074F052.20603@vgertech.com>
From: Nuno Silva <nuno.silva@vgertech.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] A quick humfs HOWTO
References: <200404080207.i3827rbe009294@ccure.user-mode-linux.org>
In-Reply-To: <200404080207.i3827rbe009294@ccure.user-mode-linux.org>
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
Date: Thu, 08 Apr 2004 07:25:22 +0100
To: user-mode-linux-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Jeff Dike wrote:

[..]

|
| The root contains two directories :
| 	data - which contains the files
| 	metadata - which shadows "data" and whose files contain ownership
| 		information
| and one file
| 	superblock - which contains information about the filesystem as a
| 		whole

Great news, compiling right now! :-)

In the meanwhile I'm thinking about this system and it seems that this
will eat lots of inodes because every file will be present twice in the
[host] filesystem with the metadata version using only a few bytes. Also
every "ls -la" (if it's not cached) in UML will generate a read in the
file's metafile file (say this 3 times quickly! eheheh). With 1000 files
in a directory thats lot's of fopen()s.

Wouldn't it be better to add support for a simple DB, like sleepycat or
CMU cyrus' project skiplist or even something lighter? This way we can
have only 2 files in the humfs "root", the superblock and the metadataDB.

This can save inodes and improve performance because you have only one
file that's indexed! :-)

The downsides:
- - another linker requirement at build time;
- - can't inspect and/or easily modify permissions with emacs. :-)

Any thoughts?

Regards,
Nuno Silva
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFAdPBSOPig54MP17wRAp8zAJ0UWKA5QvAdh4DJSzUfpV+Y5JCywwCgmhz/
S6aXJ9hLzCyJBBNlYSkOVSQ=
=EO+m
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
