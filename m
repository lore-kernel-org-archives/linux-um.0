Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DE7q0-0008Bf-In for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 23 Mar 2005 07:32:04 -0800
Received: from main.gmane.org ([80.91.229.2] helo=ciao.gmane.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1DE7px-0004SZ-Nu
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 23 Mar 2005 07:32:04 -0800
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1DE7cD-0000Yw-BE for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 23 Mar 2005 16:17:49 +0100
Received: from naked.iki.fi ([62.142.249.112])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 23 Mar 2005 16:17:49 +0100
Received: from naked by naked.iki.fi with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 23 Mar 2005 16:17:49 +0100
From: Nuutti Kotivuori <naked@iki.fi>
Message-ID: <87sm2m5rjs.fsf@aka.i.naked.iki.fi>
References: <20050322162129.2A53297669@zion>
	<200503230052.50068.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [uml-devel] Re: [patch 05/12] uml: extend cmd line limits
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
Date: Wed, 23 Mar 2005 17:07:51 +0200
To: user-mode-linux-devel@lists.sourceforge.net

Rob Landley wrote:
> On Tuesday 22 March 2005 11:21 am, blaisorblade@yahoo.it wrote:
>> From: "Catalin(ux aka Dino) BOIE" <util@deuroconsult.ro>, Paolo
>> 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>, Jeff Dike
>> <jdike@addtoit.com> Increase UML command line size. And fix a crash
>> from passing an overly-long command line to UML.
>>
>> XXX: check that init can handle 128 params and 128 env. var. The
>> original patch set this limit to 256, but it seems me too
>> much. Think!
>>
>> Signed-off-by: Paolo 'Blaisorblade' Giarrusso
>> <blaisorblade@yahoo.it> ---
>
> Called via xargs, I don't believe there's any limit on the command
> line arguments.

There certainly still is. xargs merely passes as many arguments it can
at once, but if necessary, it will run the command multiple times to
do it. Most of the time it doesn't matter if the command is run
multiple times in things like 'xargs grep', but with UML, it most
certainly would.

-- Naked




-------------------------------------------------------
This SF.net email is sponsored by: 2005 Windows Mobile Application Contest
Submit applications for Windows Mobile(tm)-based Pocket PCs or Smartphones
for the chance to win $25,000 and application distribution. Enter today at
http://ads.osdn.com/?ad_id=6882&alloc_id=15148&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
