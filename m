Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CqMe9-0005P9-2Y for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 16 Jan 2005 18:29:37 -0800
Received: from www.tuxrocks.com ([64.62.190.123] helo=tuxrocks.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1CqMe7-0001bG-Ml
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 16 Jan 2005 18:29:36 -0800
Message-ID: <41EB2308.2050304@tuxrocks.com>
From: Frank Sorenson <frank@tuxrocks.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] Recommended "head" branch?
References: <200501161238.54374.rob@landley.net>
	<200501170400.j0H401kY005548@ccure.user-mode-linux.org>
In-Reply-To: <200501170400.j0H401kY005548@ccure.user-mode-linux.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
Date: Sun, 16 Jan 2005 19:29:28 -0700
To: Rob Landley <rob@landley.net>
Cc: user-mode-linux-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Jeff Dike wrote:
| rob@landley.net said:
|
|>I can't get 2.6.11-rc1 ARCH=um to compile.  (Fixed the first build
|>break to  receive a more elaborate one shortly thereafter, which is
|>not a good sign...)
|>
|>Is there a recommended tree I should be looking at?
|
|
| rc1-mm1 builds and runs fine.
|
| 				Jeff

I've found that I also need the pud_alloc-declaration patch to get
2.6.11-rc1-mm1 to compile:
http://user-mode-linux.sourceforge.net/work/current/2.6/2.6.10-mm3/patches/pud_alloc-declaration

Other than that, 2.6.11-rc1-mm1 has worked very well for me.

Frank
- --
Frank Sorenson - KD7TZK
Systems Manager, Computer Science Department
Brigham Young University
frank@tuxrocks.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB6yMIaI0dwg4A47wRAs3YAKCMjlmMzMtZhPKNf+GRezrSNHuh4QCgzRGw
fTMfbrMkOYkIJhbrznQRp6U=
=4UU2
-----END PGP SIGNATURE-----


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
