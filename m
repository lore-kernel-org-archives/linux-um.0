Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CjiaW-0002je-2J for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 29 Dec 2004 10:30:24 -0800
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CjiaV-0002Hj-6E for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 29 Dec 2004 10:30:23 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [patch 01/13] delete unused file
References: <20041225175720.0DC7E1ED41@trashy.coderock.org>
In-Reply-To: <20041225175720.0DC7E1ED41@trashy.coderock.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412291918.23156.blaisorblade@yahoo.it>
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
Date: Wed, 29 Dec 2004 19:18:23 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: domen@coderock.org, jdike@karaya.com

On Saturday 25 December 2004 18:57, domen@coderock.org wrote:
> Remove nowhere referenced file. (egrep "filename\." didn't find anything)
>
> Signed-off-by: Domen Puncer <domen@coderock.org>
> ---
>
>
>  kj/arch/um/include/umn.h |   27 ---------------------------
>  1 files changed, 27 deletions(-)
This one could be correct (I think yes, but I haven't checked), but the other 
ones aren't.

In fact, they are referenced by way of symlinks (i.e. archparam-i386.h is 
symlinked as archparam.h, for instance from your patch #3).

Bye
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
