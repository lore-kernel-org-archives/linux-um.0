Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CoAUd-00044w-3T for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 10 Jan 2005 17:06:43 -0800
Received: from www.tuxrocks.com ([64.62.190.123] helo=tuxrocks.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1CoAUc-0007vu-OZ
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 10 Jan 2005 17:06:43 -0800
Message-ID: <41E3269C.80706@tuxrocks.com>
From: Frank Sorenson <frank@tuxrocks.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] [PATCH] Put the check for NULL before the use of
	a potentially-null value
References: <41E2F90C.4020707@tuxrocks.com>
	<200501110128.38523.blaisorblade@yahoo.it>
In-Reply-To: <200501110128.38523.blaisorblade@yahoo.it>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
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
Date: Mon, 10 Jan 2005 18:06:36 -0700
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Gerd Knorr <kraxel@bytesex.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Blaisorblade wrote:
| On Monday 10 January 2005 22:52, Frank Sorenson wrote:
|
|>This patch reorders two lines to check a variable for NULL before using
|>the variable.

| Ok, correct and thanks a lot.
|
| Sorry, a little question: against what tree does it apply?
|
| I cannot apply it locally, but I see that it should apply on top of Gerd
| Knorr's terminal cleanup patch, which introduces the bug.
|
| I hope I'll not forget it...

It should apply against 2.6.10-mm2 (uml-terminal-cleanup went into -mm2)
or anything after (looks like I did the diff from after Jeff Dike's
recent slew of patches).

Frank
- --
Frank Sorenson - KD7TZK
Systems Manager, Computer Science Department
Brigham Young University
frank@tuxrocks.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB4yacaI0dwg4A47wRAhVGAJsFq+onMrDEOI/1CGPFN6UJNxgi7wCfUT33
FoV3BzZkwxG9h8himxPZ+sw=
=I+np
-----END PGP SIGNATURE-----


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
