Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DShtE-0002Dc-1f	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 02 May 2005 13:51:40 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DShtC-0008Vr-F5	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 02 May 2005 13:51:39 -0700
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20050502203036.GA13721@ccure.user-mode-linux.org>
References: <20050501163818.142A3400F1@zion>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050501163818.142A3400F1@zion>
Subject: [uml-devel] Re: [patch 1/1] uml: remove jail mode + other leftovers
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
Date: Mon, 2 May 2005 16:30:36 -0400
To: blaisorblade@yahoo.it
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Sun, May 01, 2005 at 06:38:15PM +0200, blaisorblade@yahoo.it wrote:
> 
> This var is currently useless, as it's apparent from reading the code. Until
> 2.6.11 it was used in some code related to jail mode, in the same proc.:
> 
>         if(jail){
> 		while(!reading) sched_yield();
> 	}
> 
> jail mode has been dropped, together with that use, so let's finish dropping
> this.
> 
> Also, remove some other useless definitions I met.
> 
> Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Acked-by: Jeff Dike <jdike@addtoit.com>


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
