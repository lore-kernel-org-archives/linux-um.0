Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CbXPG-0005cs-Ji for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 06 Dec 2004 20:56:58 -0800
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CbXPB-0003Jh-TO for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 06 Dec 2004 20:56:58 -0800
From: Blaisorblade <blaisorblade_spam@yahoo.it>
References: <20041207045546.E43056BA8B@zion.localdomain>
In-Reply-To: <20041207045546.E43056BA8B@zion.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412070600.40137.blaisorblade_spam@yahoo.it>
Subject: [uml-devel] Re: [patch 1/1] uml: fail xterm_open when we have no
	$DISPLAY
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
Date: Tue, 7 Dec 2004 06:00:39 +0100
To: kraxel@bytesex.org
Cc: cw@f00f.org, user-mode-linux-devel@lists.sourceforge.net

On Tuesday 07 December 2004 05:55, blaisorblade_spam@yahoo.it wrote:
> From: Chris Wedgwood <cw@f00f.org>
Gerd, I've sent this to you since you've been working on the terminal-cleanup. 
You might as well get some ideas from this one - and it or some cleaned-up 
version will be merged for 2.6.11.

Bye

P.S.: I've not yet got an answer about your general-protection-fault patch and 
the issues I raised up. What about that?

> If UML wants to open an xterm channel and the xterm does not run properly
> (eg. terminates soon after starting) we will get a hang (a comment added in
> the patch explains why).
>
> This avoids the most common cause for this and adds a comment (which long
> term will go away with a rewrite of that code); the complete fix would be
> to catch the xterm process dying, up(&data->sem), and -EIO all requests
> from that point onwards.
>
> That applies for some of the other channels too, so part of the code should
> probably be abstracted a little and generalized.
>
> Signed-off-by: Chris Wedgwood <cw@f00f.org>
> Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
> (modified) Signed-off-by: Paolo 'Blaisorblade' Giarrusso
> <blaisorblade_spam@yahoo.it> ---


-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
