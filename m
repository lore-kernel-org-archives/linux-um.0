Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DTJyo-00079M-K3	for User-mode-linux-devel@lists.sourceforge.net;
	Wed, 04 May 2005 06:31:58 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DTJym-0002le-2N	for User-mode-linux-devel@lists.sourceforge.net;
	Wed, 04 May 2005 06:31:58 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Using SKAS, any examples?
Message-ID: <20050504132701.GA3755@ccure.user-mode-linux.org>
References: <427895BC.2050201@manchester.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <427895BC.2050201@manchester.ac.uk>
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
Date: Wed, 4 May 2005 09:27:01 -0400
To: Ian Rogers <ian.rogers@manchester.ac.uk>
Cc: User-mode-linux-devel@lists.sourceforge.net

On Wed, May 04, 2005 at 10:28:28AM +0100, Ian Rogers wrote:
> What I'm hoping to do is to use SKAS to create a second address 
> space I can, map, unmap, peek and poke from the first. The reason for 
> this is to allow an emulator to live in the first address space and the 
> emulated data... to live in the second. 

UML obviously does this.  Look at arch/um/kernel/skas/mem_user.c for the
basic primitives.  The creation and destruction of address spaces is done
in arch/um/kernel/skas/mmu.c.

> I hope to be able to access the 
> second by altering the i386 selector value.

What's the i386 selector value?

				Jeff


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
