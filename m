Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HU1IX-0003zH-R0 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 21 Mar 2007 06:56:18 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HU1IW-00028j-AK
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 21 Mar 2007 06:56:17 -0700
Date: Wed, 21 Mar 2007 09:53:59 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070321135359.GB5398@c2.user-mode-linux.org>
References: <0A01463223B8164194908CAC85B66A1201B0EFE5@ZMY16EXM67.ds.mot.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0A01463223B8164194908CAC85B66A1201B0EFE5@ZMY16EXM67.ds.mot.com>
Subject: Re: [uml-devel] Regarding VM in UML
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
To: Krishnappa Abhijith-A21204 <abhijith@motorola.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Wed, Mar 21, 2007 at 07:23:28PM +0800, Krishnappa Abhijith-A21204 wrote:
> Hi,
>         Regarding VM in UML (tracing thread mode).
> Why we need a seprate VM for UML as we create a new process in host for
> every process that created in UML and the new HOST address space is
> provided by Host kernel itself ?

What does "VM" mean?  You're using it in a way which doesn't
correspond to any of the meanings I'm familiar with.

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
