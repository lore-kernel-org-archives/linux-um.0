Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HcMFU-0003Gn-LA for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 13 Apr 2007 06:55:36 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HcMFT-0006H8-5C
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 13 Apr 2007 06:55:36 -0700
Date: Fri, 13 Apr 2007 09:54:47 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070413135447.GA4975@c2.user-mode-linux.org>
References: <3aab51dc0704122214g6be916fdm148a7ff52d4e369c@mail.gmail.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3aab51dc0704122214g6be916fdm148a7ff52d4e369c@mail.gmail.com>
Subject: Re: [uml-devel] Strange segmentation fault
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Haifeng He <hehaifeng@gmail.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Thu, Apr 12, 2007 at 10:14:32PM -0700, Haifeng He wrote:
> 3. foo is called at many places.
> 
> If not, what could be the cause for such error? The strange thing is,
> if I just read value of "a" from "current", kernel runs fine.

Did you put a call in userspace_tramp?

				Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
