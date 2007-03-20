Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HTfM2-0007Ed-3o for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 20 Mar 2007 07:30:26 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HTfM0-0002xO-Hm
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 20 Mar 2007 07:30:26 -0700
Date: Tue, 20 Mar 2007 10:28:02 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070320142802.GA5448@c2.user-mode-linux.org>
References: <45FE5141.3030007@cea.fr>
	<20070319174857.GE11790@c2.user-mode-linux.org>
	<45FF977C.7050605@cea.fr>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <45FF977C.7050605@cea.fr>
Subject: Re: [uml-devel] 2.6.18 UML machine on FC6 host
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
To: Jacques-Charles Lafoucriere <jc.lafoucriere@cea.fr>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Tue, Mar 20, 2007 at 09:12:44AM +0100, Jacques-Charles Lafoucriere wrote:
> I applied the patch to a 2.6.20 kernel and tried the 2.6.21-rc4 and 
> still have the issue
> 
> The UML machine is in an infinite loop
> 
> Do I have to change things on my host machine ? (I use 2.6.18-1.2798 
> with no skas3 patch)

No.

What is the host?

Can you send me the -rc4 binary so I can see if I get the same
behavior here?  If it works for me, is it possible for me to debug on
your host?

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
