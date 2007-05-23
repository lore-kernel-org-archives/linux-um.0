Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Hr0fM-0006JU-OK for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 23 May 2007 16:54:52 -0700
Received: from mailout2-6.pacific.net.au ([61.8.2.229]
	helo=mailout2.pacific.net.au)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Hr0fL-0006xw-5L
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 23 May 2007 16:54:52 -0700
Content-class: urn:content-classes:message
MIME-Version: 1.0
Date: Thu, 24 May 2007 09:54:04 +1000
Message-ID: <7EDC24AB1ED682439657D3B7790609D395B82D@deepthought.Elpro.local>
In-Reply-To: <465391F1.1070403@nagafix.co.uk>
References: <7EDC24AB1ED682439657D3B7790609D395B358@deepthought.Elpro.local>	<464D9713.3090904@nagafix.co.uk><loom.20070522T200258-554@post.gmane.org>
	<465391F1.1070403@nagafix.co.uk>
From: "Andrew Sinclair" <Andrew.Sinclair@elprotech.com>
Subject: Re: [uml-devel] 2.6.18 UML machine on FC6 host
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
Cc: user-mode-linux-devel@lists.sourceforge.net

Thanks Antoine. Upgrading kernel to 2.6.21 has resolved the problem.

Kind Regards

Andrew Sinclair

-----Original Message-----
From: user-mode-linux-devel-bounces@lists.sourceforge.net
[mailto:user-mode-linux-devel-bounces@lists.sourceforge.net] On Behalf
Of Antoine Martin
Sent: Wednesday, 23 May 2007 10:59 AM
To: Ryan Angilly
Cc: user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] 2.6.18 UML machine on FC6 host

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Ryan Angilly wrote:
> Do you know why exactly the kernel needs to be upgraded?  Just
curious.
Some bugs that were fixed in the host code.
circa 2.6.20.2

> 
> Antoine Martin <antoine <at> nagafix.co.uk> writes:
>>> I've been trying to run UML on FC6 (kernel 2.6.20-1.2933.fc6) and 
>>> appear to have encountered the same issue as described in the 
>>> following
>>> threads:
>> You need to upgrade your host kernel.
>> Try 2.6.21 or >= 2.6.20.8
>>
>> Antoine
> 
> 
> ----------------------------------------------------------------------
> --- This SF.net email is sponsored by DB2 Express Download DB2 Express

> C - the FREE version of DB2 express and take control of your XML. No 
> limits. Just data. Click to get it now.
> http://sourceforge.net/powerbar/db2/
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
> 

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGU5HxGK2zHPGK1rsRClekAJ0SbywS6SoVqqU1qrdz6WMd1JpuTQCfVLcP
s1+7Uy6i1YCKyhkJUBSrXzE=
=dO3v
-----END PGP SIGNATURE-----

------------------------------------------------------------------------
-
This SF.net email is sponsored by DB2 Express Download DB2 Express C -
the FREE version of DB2 express and take control of your XML. No limits.
Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel




-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
