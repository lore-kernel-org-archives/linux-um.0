Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CaT9c-0000j8-QL for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 03 Dec 2004 22:12:24 -0800
Received: from rimuhosting.com ([69.90.33.248])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1CaT9b-0004zF-6v
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 03 Dec 2004 22:12:24 -0800
Message-ID: <41B15594.5030405@rimuhosting.com>
From: Peter <peter.repliesignored@rimuhosting.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] Kernel panic: Kernel stack overflow
References: <20041130193047.3370F8D743@zion.localdomain>
	<41AE92A0.4020401@rimuhosting.com>
	<200412022019.iB2KJPbp003943@ccure.user-mode-linux.org>
In-Reply-To: <200412022019.iB2KJPbp003943@ccure.user-mode-linux.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
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
Date: Sat, 04 Dec 2004 19:13:40 +1300
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

For the record: I switched from skas3-v1 to -v7 and the problem seems to 
have gone away.

Cheers, Peter

Jeff Dike wrote:
> peter.repliesignored@rimuhosting.com said:
> 
>>Hi.  I get a "Kernel panic: Kernel stack overflow" error message on
>>the  UML instance console.  Then the UML instance exits. 
> 
> 
> Can you get a stack trace from it?



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
