Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cyjbx-00073W-9Q for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 08 Feb 2005 20:37:57 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1Cyjbv-000571-NZ
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 08 Feb 2005 20:37:57 -0800
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] Why is UML built static all the time?
References: <200502080203.53596.rob@landley.net>
	<200502081746.j18Hkds0002747@ccure.user-mode-linux.org>
In-Reply-To: <200502081746.j18Hkds0002747@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200502082235.36838.rob@landley.net>
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
Date: Tue, 8 Feb 2005 22:35:36 -0500
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Tuesday 08 February 2005 12:46 pm, Jeff Dike wrote:
> rob@landley.net said:
> > Is there any easy way to get UML to do a dynamic build?  I tried
> > removing  -static from the makefile, but the build broke.
>
> Turn off CONFIG_MODE_TT.  The build will make a dynamic binary.
>
> With tt mode enabled, UML must be a static binary.
>
> 				Jeff

Gotcha, but skas mode is useless to me until SKAS0 comes out...

Rob


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
