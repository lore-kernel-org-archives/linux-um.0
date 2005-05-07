Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DUVxw-0006ao-Gh	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 07 May 2005 13:32:00 -0700
Received: from smtpout17.mailhost.ntl.com ([212.250.162.17]
	helo=mta09-winn.mailhost.ntl.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DUVxu-00022f-Rv	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 07 May 2005 13:32:00 -0700
Message-ID: <427D259D.3050306@manchester.ac.uk>
From: Ian Rogers <ian.rogers@manchester.ac.uk>
MIME-Version: 1.0
Subject: Re: [uml-devel] Using SKAS, any examples?
References: <427895BC.2050201@manchester.ac.uk>
	<20050504132701.GA3755@ccure.user-mode-linux.org>
	<427A51F9.2060208@manchester.ac.uk>
	<20050507031144.GD14445@ccure.user-mode-linux.org>
In-Reply-To: <20050507031144.GD14445@ccure.user-mode-linux.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
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
Date: Sat, 07 May 2005 21:31:25 +0100
To: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net

Jeff Dike wrote:

> Just one little point that would seem to indicate a lack of understanding.
>
>You seem to be interested in manipulating many address spaces, but you
>have a global mm_fd which you open ones, and on which all operations happen.
>
>Opening /proc/mm gives you a handle to an address space.  If you want two
>new address spaces, you open it twice.  You close one when you don't need
>the address space any more.
>  
>
Thanks, there's a lack of documentation so the purpose of the example is 
to try to determine this kind of information.

>Why are you fixated on descriptor values?  At this level, that's something
>you just don't care about.
>  
>
In an emulator the peek and poke routines will be inlined into the 
dynamically generated code. I'm essentially after a multi-segment model. 
I want CS/DS/ES to be in the same flat address space. This means the 
generated code and any spill/fill of register value code will be in the 
controlling address space, I want to then address the second address 
space/segment by just using a segment over-ride.

Thanks for the help,

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
