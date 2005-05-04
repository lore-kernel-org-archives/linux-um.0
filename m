Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DTG9d-0007HX-JO	for User-mode-linux-devel@lists.sourceforge.net;
	Wed, 04 May 2005 02:26:53 -0700
Received: from mailhost.cs.man.ac.uk ([130.88.192.14])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DTG9c-0003cf-3o	for User-mode-linux-devel@lists.sourceforge.net;
	Wed, 04 May 2005 02:26:53 -0700
Received: from trinidad ([130.88.195.238])
	by mailhost with esmtp (Exim 4.14)	id 1DTG9O-0000jN-NO
	for User-mode-linux-devel@lists.sourceforge.net;
	Wed, 04 May 2005 10:26:38 +0100
Message-ID: <427895BC.2050201@manchester.ac.uk>
From: Ian Rogers <ian.rogers@manchester.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Using SKAS, any examples?
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
Date: Wed, 04 May 2005 10:28:28 +0100
To: User-mode-linux-devel@lists.sourceforge.net

Hi,

I'm relatively new to this but I've not found any information in the 
FAQ... What I'm hoping to do is to use SKAS to create a second address 
space I can, map, unmap, peek and poke from the first. The reason for 
this is to allow an emulator to live in the first address space and the 
emulated data... to live in the second. I hope to be able to access the 
second by altering the i386 selector value. If I am successful in this I 
will put the information available to all on my website or the uml 
wiki... I was wondering if anyone already had some code to do this or if 
someone has an strace of the calls involved or failing that any 
advice/suggestions/...

Many thanks,

Ian Rogers


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
