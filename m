Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DE0cm-0003JW-Nw for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 22 Mar 2005 23:49:56 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1DE0ci-0000Q3-4S
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 22 Mar 2005 23:49:56 -0800
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] [patch 05/12] uml: extend cmd line limits
References: <20050322162129.2A53297669@zion>
In-Reply-To: <20050322162129.2A53297669@zion>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200503230052.50068.rob@landley.net>
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
Date: Wed, 23 Mar 2005 00:52:50 -0500
To: user-mode-linux-devel@lists.sourceforge.net
Cc: blaisorblade@yahoo.it

On Tuesday 22 March 2005 11:21 am, blaisorblade@yahoo.it wrote:
> From: "Catalin(ux aka Dino) BOIE" <util@deuroconsult.ro>, Paolo
> 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>, Jeff Dike
> <jdike@addtoit.com> Increase UML command line size. And fix a crash from
> passing an overly-long command line to UML.
>
> XXX: check that init can handle 128 params and 128 env. var. The original
> patch set this limit to 256, but it seems me too much. Think!
>
> Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
> ---

Called via xargs, I don't believe there's any limit on the command line 
arguments.

Rob


-------------------------------------------------------
This SF.net email is sponsored by: 2005 Windows Mobile Application Contest
Submit applications for Windows Mobile(tm)-based Pocket PCs or Smartphones
for the chance to win $25,000 and application distribution. Enter today at
http://ads.osdn.com/?ad_id=6882&alloc_id=15148&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
