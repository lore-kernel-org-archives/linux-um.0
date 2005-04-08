Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DJnIi-0000OU-4d for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Apr 2005 23:49:08 -0700
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1DJnIg-0005id-1l
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Apr 2005 23:49:07 -0700
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] Broken compiling under 2.6.12-rc2 on my machine
References: <cbec11ac050405205173f18157@mail.gmail.com>
	<200504072022.47474.blaisorblade@yahoo.it>
	<200504080059.44620.rob@landley.net>
In-Reply-To: <200504080059.44620.rob@landley.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200504080146.19437.rob@landley.net>
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
Date: Fri, 8 Apr 2005 01:46:19 -0400
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Blaisorblade <blaisorblade@yahoo.it>, Ian McDonald <imcdnzl@gmail.com>

On Friday 08 April 2005 12:59 am, Rob Landley wrote:

> If you can get the sed "r" command to read from a pipe, by my guest.  (I
> mentioned originally that there was probably a cleaner way to do it, but I
> wasn't seeing it at the time...)

P.S.  I terms of mentioning my obligatory "really disgusting solution to an 
otherwise seemingly impossible problem", I'd like to point to the existence 
of "/proc/self/fd/0".

But in comparison, the temp file doesn't really look all that bad... :)

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
