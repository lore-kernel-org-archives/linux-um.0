Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HRVFi-00069z-JD for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 14 Mar 2007 08:18:58 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HRVFf-00012o-0q
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 14 Mar 2007 08:18:58 -0700
Date: Wed, 14 Mar 2007 10:10:04 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070314141004.GA5116@ccure.user-mode-linux.org>
References: <0A01463223B8164194908CAC85B66A1201A96CFF@ZMY16EXM67.ds.mot.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0A01463223B8164194908CAC85B66A1201A96CFF@ZMY16EXM67.ds.mot.com>
Subject: Re: [uml-devel] Regarding Address space in UML
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

On Wed, Mar 14, 2007 at 09:57:33PM +0800, Krishnappa Abhijith-A21204 wrote:
> I had a question on Process address space in UML.
> Will there be a tracing thread for each process created in UML ? which
> is responsible for system call tracking ?

No.  There is one per virtual CPU which traces the process running on
that CPU and runs the kernel for that CPU.

> Also will the address space of a process in UML also consists of the
> corresponding Tracing thread ?

No, the address space is nearly identical to what it would be on the
host.

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
