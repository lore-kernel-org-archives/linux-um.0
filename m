Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DUGYo-00023A-U8	for User-mode-linux-devel@lists.sourceforge.net;
	Fri, 06 May 2005 21:05:02 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DUGYn-00067G-Cg	for User-mode-linux-devel@lists.sourceforge.net;
	Fri, 06 May 2005 21:05:02 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Using SKAS, any examples?
Message-ID: <20050507031144.GD14445@ccure.user-mode-linux.org>
References: <427895BC.2050201@manchester.ac.uk>
	<20050504132701.GA3755@ccure.user-mode-linux.org>
	<427A51F9.2060208@manchester.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <427A51F9.2060208@manchester.ac.uk>
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
Date: Fri, 6 May 2005 23:11:44 -0400
To: Ian Rogers <ian.rogers@manchester.ac.uk>
Cc: User-mode-linux-devel@lists.sourceforge.net

On Thu, May 05, 2005 at 06:03:53PM +0100, Ian Rogers wrote:
> I've attached the test/example I'm working on to create and manipulate 
> address spaces uses skas - as I want to allow an emulator to. There are 
> a few missing functions (that can be pretty much cloned from mem_user.c) 
> and I've not worked out how to calculate the descriptor value yet. 
> Please could you have a look and suggest how to create the descriptor 
> value and why when I look in /proc/<pid>/maps I can't see the asid_mmap 
> that's being done as part of the test.

Just one little point that would seem to indicate a lack of understanding.

You seem to be interested in manipulating many address spaces, but you
have a global mm_fd which you open ones, and on which all operations happen.

Opening /proc/mm gives you a handle to an address space.  If you want two
new address spaces, you open it twice.  You close one when you don't need
the address space any more.

Why are you fixated on descriptor values?  At this level, that's something
you just don't care about.

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
