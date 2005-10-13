Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EQ61N-0003B8-9d	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 13 Oct 2005 09:33:33 -0700
Received: from externalmx-1.sourceforge.net ([12.152.184.25])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)	id 1EQ61F-0006d0-SM
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 13 Oct 2005 09:33:30 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by externalmx-1.sourceforge.net with esmtp (Exim 4.41)
	id 1EQ61D-0004ZP-O5	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 13 Oct 2005 09:33:25 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Getting garbage in ps, as expected...
Message-ID: <20051013162111.GB5352@ccure.user-mode-linux.org>
References: <200510112252.51849.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510112252.51849.rob@landley.net>
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
Date: Thu, 13 Oct 2005 12:21:11 -0400
To: Rob Landley <rob@landley.net>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Tue, Oct 11, 2005 at 10:52:51PM -0500, Rob Landley wrote:
> Great fun.  So I'm using UML in -skas0 mode built from 2.6.13.2, and it's 
> putting fun garbage in the ps display:
> 
>  7284 ?        S      0:00 [pdflush]
> 10480 pts/3    R      0:06 ?@???            ?   ?   ?    ???s   F?! @???{
> 12783 ?        S      0:00 [pdflush]
>  8454 pts/3    R      0:03  @???{        " ? ???

The garbage is irrelevant.

UML is supposed to clean up after itself.  How reproducable is this, and how
do you do it?

				Jeff


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
