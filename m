Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HNzaF-0005gz-6H for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 04 Mar 2007 14:53:39 -0800
Received: from mail.nagafix.co.uk ([194.145.196.85])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HNzaC-0008MY-Rt
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 04 Mar 2007 14:53:39 -0800
Message-ID: <45EB4DE7.50608@nagafix.co.uk>
Date: Sun, 04 Mar 2007 22:53:27 +0000
From: Antoine Martin <antoine@nagafix.co.uk>
MIME-Version: 1.0
References: <20070301230442.GA469@localhost.localdomain>
	<200703031932.46323.blaisorblade@yahoo.it>
	<20070304165030.GB6516@localhost.localdomain>
	<200703041950.36776.blaisorblade@yahoo.it>
In-Reply-To: <200703041950.36776.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [uml-user] [PATCH] uml hostfs: fix interaction
	between hostfs=path1 and -o path2 at mount time
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
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: Jeff Dike <jdike@addtoit.com>, Sylvain Beucler <beuc@beuc.net>, user-mode-linux-devel@lists.sourceforge.net, Christopher Aker <caker@theshore.net>

Blaisorblade wrote:
> On Sunday 04 March 2007 17:50, Sylvain Beucler wrote:
>> On Sat, Mar 03, 2007 at 07:32:46PM +0100, Blaisorblade wrote:
>> Hi,
>>
>> I tested and it works.
>>
>> Thanks,
> 
> You'll probably also see that -o .. allows bypassing the 'hostfs jail', and 
> I've just implemented a fix to that. The question is whether this should be 
> merged.
> 
> Indeed, the root user inside UML can bypass that anyway, if he modifies the 
> hostfs module, compiles and loads it.
If security is at stake then the host admin should use non-modular 
kernels to prevent such tampering.

> So the host admin really needs to run 
> UML in a chroot if he needs real security.
chroot isn't totally foolproof (see chroot-again issue), but when 
chrooting + changing user (like compartment does), it should be pretty safe.

Antoine

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
